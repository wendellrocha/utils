//DBQuery.shellBatchSize = 500;
db.users.aggregate([
    {
        $lookup: {
            from: 'pessoa',
            localField: '_id',
            foreignField: 'id_usuario',
            as: 'pessoa_usuario'
        }
    },
    {
        $unwind: '$pessoa_usuario'
    },
    {
        $lookup: {
            from: 'prestador',
            localField: '_id',
            foreignField: 'id_usuario',
            as: 'prestador_usuario'
        }
    },
    {
        $unwind: '$prestador_usuario'
    },
    {
        $match: {
            roles: 'prestador',
            'pessoa_usuario.celular': {$exists: true},
            'pessoa_usuario.ddd_cel': {$exists: true}
        }
    },
    {
        $project: {
            _id: 0,
            'nome': '$pessoa_usuario.nome',
            'sobrenome': '$pessoa_usuario.sobrenome',
            'ddd': '$pessoa_usuario.ddd_cel',
            'celular': '$pessoa_usuario.celular'
        }
    }
])