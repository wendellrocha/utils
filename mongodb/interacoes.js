db.denuncia.aggregate([
    {
        $match: {
            _id: id
        }
    },
    {
        $lookup: {
            from: 'denuncia_interacao',
            localField: '_id',
            foreignField: 'id_denuncia',
            as: 'interacoes'
        }
    },
    {
        $lookup: {
            from: 'pessoa',
            localField: 'interacoes.id_usuario_alteracao',
            foreignField: 'id_usuario',
            as: 'pessoa'
        }
    },
    {
        $unwind: '$pessoa'
    },
    {
        $project: {
            _id: 1,
            interacoes: 1,
            pessoa: {
                nome: { $concat: ['$pessoa.nome', ' ', '$pessoa.sobrenome'] },
                telefone: {
                    $cond: {
                        if: {
                            $or: [
                                { $eq: [{ $ifNull: ['$pessoa.ddd_cel', true] }, true] },
                                { $eq: [{ $ifNull: ['$pessoa.celular', true] }, true] }
                            ]
                        },
                        then: '$$REMOVE',
                        else: { $concat: ['$pessoa.ddd_cel', ' ', '$pessoa.celular'] }
                    }
                },
                email: {
                    $cond: {
                        if: {
                            $eq: [{ $ifNull: ['$pessoa.email', true] }, true],
                        },
                        then: '$$REMOVE',
                        else: '$pessoa.email'
                    }
                },
                avatar: {
                    $cond: {
                        if: { $eq: [{ $ifNull: ['$pessoa.avatar', true] }, true] },
                        then: {
                            $cond: {
                                if: { $eq: ['$pessoa.genero', 'Feminino'] },
                                then: '/assets/img/avatar_female.png',
                                else: '/assets/img/avatar.png'
                            }
                        },
                        else: '$pessoa.avatar'
                    }
                }
            }
        }
    },
    {
        $group: {
            _id: '$_id',
            interacoes: { $last: '$interacoes' },
            pessoa: { $push: '$pessoa' }
        }
    }
])