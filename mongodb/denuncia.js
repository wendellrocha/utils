db.denuncia.aggregate([
    {
        $lookup: {
            from: 'denuncia_tipo',
            localField: 'id_denuncia_tipo',
            foreignField: '_id',
            as: 'tipo_denuncia'
        }
    },
    {
        $unwind: '$tipo_denuncia'
    },
    {
        $lookup: {
            from: 'solicitacao',
            localField: 'id_solicitacao',
            foreignField: '_id',
            as: 'solicitacao'
        }
    },
    {
        $unwind: '$solicitacao'
    },
    {
        $lookup: {
            from: 'solicitacao_proposta',
            let: { id_solicitacao: '$id_solicitacao' },
            pipeline: [
                {
                    $match: {
                        $expr: {
                            $and: [
                                { $eq: ['$id_solicitacao', '$$id_solicitacao'] },
                                { $eq: ['$aceita', true] }
                            ]
                        }
                    }
                }
            ],
            as: 'proposta'
        }
    },
    {
        $unwind: '$proposta'
    },
    {
        $lookup: {
            from: 'solicitacao_convite',
            localField: 'id_solicitacao',
            foreignField: 'id_solicitacao',
            as: 'convite'
        }
    },
    {
        $unwind: '$convite'
    },
    {
        $lookup: {
            from: 'especialidade',
            localField: 'solicitacao.id_especialidade',
            foreignField: '_id',
            as: 'especialidade'
        }
    },
    {
        $unwind: '$especialidade'
    },
    {
        $lookup: {
            from: 'pessoa',
            localField: 'id_usuario',
            foreignField: 'id_usuario',
            as: 'cliente'
        }
    },
    {
        $unwind: '$cliente'
    },
    {
        $lookup: {
            from: 'pessoa',
            let: { convite: '$convite.id_usuario_prestador', proposta: '$proposta.id_usuario_prestador' },
            pipeline: [
                {
                    $match: {
                        $expr: {
                            $or: [
                                { $eq: ['$id_usuario', '$$convite'] },
                                { $eq: ['$id_usuario', '$$proposta'] }
                            ]
                        }
                    }
                }
            ],
            as: 'prestador'
        }
    },
    {
        $unwind: '$prestador'
    },
    {
        $project: {
            _id: 1,
            denuncia: {
                tipo: '$tipo_denuncia.titulo',
                descricao: '$descricao'
            },
            solicitacao: {
                _id: '$solicitacao._id',
                descricao: '$solicitacao.descricao',
                especialidade: '$especialidade.titulo',
                endereco: '$solicitacao.endereco',
                location: '$solicitacao.location',
                pode_contestar: '$solicitacao.pode_contestar',
                andamento: '$solicitacao.andamento',
                finalizado: '$solicitacao.finalizado',
                cancelado: '$solicitacao.cancelado',
                contestada: '$solicitacao.contestada',
                denunciada: '$solicitacao.denunciada',
                ativo: '$solicitacao.ativo',
                salvo: '$solicitacao.salvo',
                createdAt: '$solicitacao.createdAt',
                modifiedAt: '$solicitacao.modifiedAt',
                finalizado_descricao: '$solicitacao.finalizado_descricao'
            },
            proposta: {
                $cond: {
                    if: { $eq: ["", "$proposta"] },
                    then: "$$REMOVE",
                    else: {
                        _id: '$proposta._id',
                        valor: '$proposta.valor',
                        data_realizacao: '$proposta.data_realizacao',
                        prazo: '$proposta.prazo'
                    }
                }
            },
            convite: {
                $cond: {
                    if: { $eq: ["", "$convite"] },
                    then: "$$REMOVE",
                    else: {
                        _id: '$convite._id',
                        urgente: '$convite.urgente',
                        createdAt: '$convite.createtAt'
                    }
                }
            },
            cliente: {
                id_usuario: '$cliente.id_usuario',
                nome: { $concat: ['$cliente.nome', ' ', '$cliente.sobrenome'] },
                email: '$cliente.email',
                celular: { $concat: ['$cliente.ddd_cel', ' ', '$cliente.celular'] },
                genero: '$cliente.genero',
                avatar: '$cliente.avatar'
            },
            prestador: {
                id_usuario: '$prestador.id_usuario',
                nome: { $concat: ['$prestador.nome', ' ', '$prestador.sobrenome'] },
                email: '$prestador.email',
                celular: { $concat: ['$prestador.ddd_cel', ' ', '$prestador.celular'] },
                genero: '$prestador.genero',
                avatar: '$prestador.avatar'
            }
        }
    }
])