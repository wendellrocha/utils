db.pessoa.aggregate([
    {
        $match: {
            id_usuario: id
        }
    },
    {
        $lookup: {
            from: 'pessoa.vermongo',
            localField: 'id_usuario',
            foreignField: 'id_usuario',
            as: 'versoes'
        }
    },
    {
        $unwind: '$versoes'
    },
    {
        $project: {
            ordem: { $dateToString: { format: "%Y%m%d", date: "$versoes.modifiedAt" } },
            alteracoes: {
                email: '$versoes.email',
                nome: '$versoes.nome',
                sobrenome: '$versoes.sobrenome',
                ddd_cel: '$versoes.ddd_cel',
                celular: '$versoes.celular',
                avatar: '$versoes.avatar',
                data_nascimento: { $dateToString: { format: "%d/%m/%Y", date: "$versoes.data_nascimento" } },
                genero: '$versoes.genero',
                ativo: '$versoes.ativo',
                createdAt: { $dateToString: { format: "%d/%m/%Y", date: "$versoes.createdAt" } },
                modifiedAt: { $dateToString: { format: "%d/%m/%Y", date: "$versoes.modifiedAt" } },
            }
        }
    },
    {
        $group: {
            _id: '$alteracoes.modifiedAt',
            ordem: { $last: '$ordem' },
            alteracoes: { $push: '$alteracoes' }
        }
    },
    {
        $sort: {
            'ordem': -1
        }
    }
])