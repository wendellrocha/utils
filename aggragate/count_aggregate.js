db.users.aggregate([
    {
        $match: {
            roles: 'usuario'
        }
    },
    {
        $lookup: {
            from: 'pessoa',
            localField: '_id',
            foreignField: 'id_usuario',
            as: 'pessoa_usuario'
        }
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
        $unwind: {
            path: '$prestador_usuario',
            preserveNullAndEmptyArrays: true
        }
    },
    {
        $lookup: {
            from: 'parceiro',
            localField: '_id',
            foreignField: 'id_usuario',
            as: 'parceiro_usuario'
        }
    },
    {
        $unwind: {
            path: '$parceiro_usuario',
            preserveNullAndEmptyArrays: true
        }
    },
    {
        $project: {
            'prestadores': {
                $size: {
                    $filter: {
                        input: "$pessoa_usuario",
                        as: "pes",
                        cond: {
                            $and: [
                                { $eq: ["$$pes.id_usuario", '$prestador_usuario.id_usuario'] },
                            ]
                        }
                    }
                }
            },
            'parceiros': {
                $size: {
                    $filter: {
                        input: "$pessoa_usuario",
                        as: "pes",
                        cond: {
                            $and: [
                                { $eq: ["$$pes.id_usuario", '$parceiro_usuario.id_usuario'] },
                            ]
                        }
                    }
                }
            }
        }
    },
    {
        $group: {
            _id: 'user',
            'pessoas': { $sum: 1 },
            'prestadores': { $sum: "$prestadores" },
            'parceiros': { $sum: "$parceiros" }
        }
    }
])
