Meteor.publish('Historico', function (id) {
    if (this.userId && id) {
        ReactiveAggregate(this, Pessoa, [
            {
                $match: {
                    'id_usuario': id
                }
            },
            {
                $lookup: {
                    from: 'pessoa.vermongo',
                    localField: '_id',
                    foreignField: 'ref',
                    as: 'versoes'
                }
            },
            {
                $unwind: '$versoes'
            },
            {
                $project: {
                    _id: '$versoes._id',
                    id_usuario: '$versoes.id_usuario',
                    email: '$versoes.email',
                    nome: '$versoes.nome',
                    sobrenome: '$versoes.sobrenome',
                    cod_ref: '$versoes.cod_ref',
                    ativo: '$versoes.ativo',
                    avatar: '$versoes.avatar',
                    cod_amigo: '$versoes.cod_amigo',
                    createdAt: '$versoes.createdAt',
                    modifiedAt: '$versoes.modifiedAt',
                    version: '$versoes._version'
                }
            },
            {
                $sort: {
                    version: -1
                }
            }
        ], {
            clientCollection: 'Historico'
        }, { allowDiskUse: true });
    }
});