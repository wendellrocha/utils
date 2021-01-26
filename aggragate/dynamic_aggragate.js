Meteor.publish('UsuariosFiltrados', function (id) {
    if (this.userId) {
        if (Roles.userIsInRole(this.userId, ['master'])) {
            var _filtro = NotificacaoFiltro.findOne({ _id: id });

            if (_filtro) {
                var _aggregate = []
                var _group = {
                    $group: {}
                }
                var _project = {
                    $project: {}
                }

                if ('tipo_usuario' in _filtro.filtro) {
                    _aggregate.push(
                        {
                            $match: {
                                roles: _filtro.filtro.tipo_usuario
                            }
                        }
                    )

                    if (_filtro.filtro.tipo_usuario == 'prestador') {
                        _aggregate.push(
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
                                    from: 'prestador_especialidade',
                                    localField: '_id',
                                    foreignField: 'id_usuario',
                                    as: 'prestador_especialidade'
                                }
                            },
                            {
                                $unwind: {
                                    path: '$prestador_especialidade',
                                    preserveNullAndEmptyArrays: true
                                }
                            }
                        )
                    }

                    if (_filtro.filtro.tipo_usuario == 'parceiro') {
                        _aggregate.push(
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
                            }
                        )
                    }
                }

                _aggregate.push(
                    {
                        $lookup: {
                            from: 'pessoa',
                            localField: '_id',
                            foreignField: 'id_usuario',
                            as: 'pessoa_usuario'
                        }
                    },
                    {
                        $unwind: {
                            path: '$pessoa_usuario',
                            preserveNullAndEmptyArrays: true
                        }
                    })

                _group.$group = {
                    '_id': 'user',
                    'usuarios': { $sum: 1 }
                }

                if ('genero' in _filtro.filtro) {
                    var _genero = ((_filtro.filtro.genero == 'Feminino') ? 'Feminino' : 'Masculino');
                    _group.$group['genero'] = {
                        $sum: {
                            $toInt: {
                                $concat: [{
                                    $cond: [{
                                        $eq: ['$pessoa_usuario.genero', _genero]
                                    }, "1", "0"]
                                }]
                            }
                        }
                    }
                }

                if ('faixa_etaria' in _filtro.filtro) {
                    if (_filtro.filtro.faixa_etaria.length > 0) {
                        let _ate = parseInt(moment(new Date()).format("YYYY")) - parseInt(_filtro.faixa_etaria[0]);
                        let _de = parseInt(moment(new Date()).format("YYYY")) - parseInt(_filtro.faixa_etaria[1]);

                        _ate = moment("01/01/" + _ate, 'DD/MM/YYYY').toDate();
                        _ate = moment(_ate).format('DD/MM/YYYY')
                        _de = moment(new Date()).format('DD/MM/' + _de, 'DD/MM/YYYY');

                        _group.$group['faixa_etaria'] = {
                            $sum: {
                                $size: {
                                    $filter: {
                                        input: "$pessoa_usuario",
                                        as: "pes",
                                        cond: {
                                            $and: [
                                                { "$$pes.data_nascimento": { $gte: new Date(_de) } },
                                                { "$$pes.data_nascimento": { $lt: new Date(_ate) } }
                                            ]
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            if ('prestador_foto' in _filtro.filtro) {
                _group.$group['prestador_foto'] = {
                    $sum: {
                        $size: {
                            $filter: {
                                input: "$pessoa_usuario",
                                as: "pes",
                                cond: {
                                    $eq: ["$$pes.avatar", { $not: { $exists: true } }],
                                }
                            }
                        }
                    }
                }
            }

            if ('cliente_foto' in _filtro.filtro) {
                _group.$group['cliente_avatar'] = {
                    $sum: {
                        $size: {
                            $filter: {
                                input: "$pessoa_usuario",
                                as: "pes",
                                cond: {
                                    $eq: ["$$pes.avatar", { $not: { $exists: true } }]
                                }
                            }
                        }
                    }
                }
            }


            if ('uf' in _filtro.filtro) {

                _aggregate.push(
                    {
                        $lookup: {
                            from: 'pessoa_endereco',
                            localField: '_id',
                            foreignField: 'id_usuario',
                            as: 'pessoa_endereco'
                        }
                    }
                )

                var _uf = ((_filtro.filtro.uf != null) ? _filtro.filtro.uf : '')
                _group.$group['estado'] = {
                    $sum: {
                        $size: {
                            $filter: {
                                input: "$pessoa_endereco",
                                as: "end",
                                cond: {
                                    $and: [
                                        { $eq: ["$$end.estado", _uf] },
                                    ]
                                }
                            }
                        }
                    }
                }

                if ('cidade' in _filtro.filtro) {

                    var _cidade = ((_filtro.filtro.cidade != null) ? _filtro.filtro.cidade : '')
                    _group.$group['cidade'] = {
                        $sum: {
                            $size: {
                                $filter: {
                                    input: "$pessoa_endereco",
                                    as: "end",
                                    cond: {
                                        $and: [
                                            { $eq: ["$$end.cidade", _cidade] },
                                        ]
                                    }
                                }
                            }
                        }
                    }
                }
            }

            if ('prestador_conta' in _filtro.filtro) {
                _aggregate.push(
                    {
                        $lookup: {
                            from: 'pessoa_conta_bancaria',
                            localField: '_id',
                            foreignField: 'id_usuario',
                            as: 'pessoa_conta'
                        }
                    }
                )
                _group.$group['prestador_conta'] = {
                    $sum: {
                        $size: {
                            $filter: {
                                input: "$pessoa_usuario",
                                as: "pes",
                                cond: {
                                    $and: [
                                        { "$$pes.id_usuario": { $in: "$pessoa_conta.id_usuario" } }
                                    ]
                                }
                            }
                        }
                    }
                }
            }

            _project.$project = { '_id': 1, 'usuarios': 1, 'genero': 1, 'prestador_conta': 1, 'estado': 1, 'cidade': 1, 'cliente_foto': 1, 'prestador_foto': 1, 'faixa_etaria': 1 }

            _aggregate.push(_group)
            _aggregate.push(_project)

            ReactiveAggregate(this, Meteor.users, _aggregate, {
                clientCollection: 'UsuariosFiltrados',
                observers: [
                    Pessoa.find({}),
                    PrestadorEspecialidade.find({}),
                    Prestador.find({}),
                    Parceiro.find({})
                ]
            })
        }
    }
})

Meteor.publish('PesquisaApp', function (coords, query) {
    ReactiveAggregate(this, Loja, [
        {
            $match: {
                $text: {
                    $search: query,
                    $caseSensitive: false
                },
                ativo: true
            }
        },
        {
            $lookup: {
                from: 'area_atuacao',
                pipeline: [
                    {
                        $match: {
                            geometry: {
                                $geoIntersects: {
                                    $geometry: {
                                        type: "Point",
                                        coordinates: coords
                                    }
                                }
                            }
                        }
                    }
                ],
                as: 'area_atuacao'
            }
        },
        {
            $unwind: '$area_atuacao'
        },
        {
            $lookup: {
                from: 'loja_area_atuacao',
                let: { id: '$area_atuacao._id' },
                pipeline: [
                    {
                        $match: {
                            $expr: {
                                $and: [
                                    { $eq: ['$id_area_atuacao', '$$id'] },
                                    { $eq: ['$ativo', true] }
                                ]
                            }
                        }
                    }
                ],
                as: 'area'
            }
        },
        {
            $unwind: '$area'
        },
        {
            $match: {
                $expr: {
                    $and: [
                        { $eq: ['$_id', '$area.id_loja'] },
                        { $eq: ['$aberta', true] },
                        { $eq: ['$ativo', true] },
                    ]
                }
            }
        },
        {
            $project: {
                _id: '$_id',
                nome: '$nome',
                slogan: '$slogan',
                ativo: '$ativo',
                endereco: '$endereco',
                capa: '$capa',
                logo: '$logo',
                aberta: '$aberta',
                taxa_entrega: '$area.taxa_entrega',
                score: { $meta: "textScore" }
            }
        },
        {
            $match: {
                score: { $gte: 1.0 }
            }
        },
        {
            $sort: {
                score: -1
            }
        },
    ], {
        clientCollection: 'PesquisaApp'
    });
})