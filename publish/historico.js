Meteor.publish('Historico', function (id) {
    if (this.userId && id) {
        let doc = Mongo.Collection.get('pessoa').aggregate([
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
        ]);
        let subscription = this;

        let aux = [];
        var bucket = false;
        _.each(doc, function (item) {
            let temp;
            let tempArr = [];
            let tempItem = {};

            for (let i = 0; i < item.alteracoes.length; i++) {
                if (typeof item.alteracoes[i + 1] === 'undefined') {
                    if (bucket) {
                        temp = diff(bucket, item.alteracoes[i], (path, key) => path.length === 0 && ~['modifiedAt', 'createdAt'].indexOf(key));
                        tempArr.push(temp);
                    }
                    bucket = item.alteracoes[i];
                } else {
                    if (bucket) {
                        temp = diff(bucket, item.alteracoes[i], (path, key) => path.length === 0 && ~['modifiedAt', 'createdAt'].indexOf(key));
                        tempArr.push(temp);
                        bucket = false;
                    } else {
                        if (typeof item.alteracoes[i + 1] === 'undefined') {
                            bucket = item.alteracoes[i];
                        } else {
                            temp = diff(item.alteracoes[i], item.alteracoes[i + 1], (path, key) => path.length === 0 && ~['modifiedAt', 'createdAt'].indexOf(key));
                            tempArr.push(temp)
                        }
                    }
                }
            }

            tempItem = {
                _id: item._id,
                alteracoes: tempArr
            }

            aux.push(tempItem);
        });

        _.each(aux, function (item) {
            item.alteracoes = _.flatten(item.alteracoes)
        });

        let arr = [];
        _.each(aux, function (item) {
            let tempItem = {};
            let tempArr = [];
            _.each(item.alteracoes, function (a) {
                let hist = {};

                if (a === undefined || a === null) {
                    return;
                }

                if (a.kind == 'E') {
                    hist['acao'] = 'Editou';
                    hist['chave'] = a.path[0];
                    hist['depois'] = a.rhs;
                }

                if (a.kind == 'N') {
                    if ('path' in item) {
                        hist['acao'] = 'Adicionou';
                        hist['chave'] = a.path[0];
                        hist['depois'] = a.rhs;
                    }
                }
                tempArr.push(hist);
            });
            tempItem = {
                _id: item._id,
                alteracoes: tempArr
            }
            arr.push(tempItem)
        });

        _.each(arr, function (item) {
            subscription.added('Historico', item._id, item);
        });

        subscription.ready();
    }
});
