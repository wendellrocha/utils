db.users.aggregate([
    {
        $match: {
            roles: {
                $nin: ['master', 'vendedor']
            },
            createdAt: {
                $gte: ISODate("2020-01-01T00:00:00.000-03:00"),
                $lt: ISODate("2020-01-31T23:59:00.000-03:00")
            }
        }
    },
    {
        $lookup: {
            from: 'pessoa',
            localField: "_id",
            foreignField: "id_usuario",
            as: "pessoa"
        }
    },
    {
        $unwind: '$pessoa'
    },
    {
        $lookup: {
            from: 'prestador',
            localField: "_id",
            foreignField: "id_usuario",
            as: "prestador"
        }
    },
    {
        $unwind: {
            path: "$prestador",
            preserveNullAndEmptyArrays: true
        }
    },
    {
        $project: {
            _id: 0,
            nome: { $concat: ['$pessoa.nome', ' ', '$pessoa.sobrenome'] },
            celular: { $concat: ['$pessoa.ddd_cel', ' ', '$pessoa.celular']},
            prestador_slogan: '$prestador.slogan',
            prestador_pendente: '$prestador.pp',
            pendente_aprovacao: '$prestador.pa',
            consideracoes: '$prestador.consideracoes'
        }
    }
])