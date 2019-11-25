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
        $lookup: {
            from: 'prestador_disponivel',
            localField: '_id',
            foreignField: 'id_usuario',
            as: 'prestador_disponivel'
        }
    },
    {
        $unwind: '$prestador_disponivel'
    },
    {
        $match: {
            roles: 'prestador',
            'pessoa_usuario.celular': {$exists: true},
            'prestador_usuario.aprovado': true,
            'prestador_disponivel.ativo':true
        }
    },
    {
        $group: {
            _id: 'users',
            'pessoas': {$sum: 1}
        }
    }
])