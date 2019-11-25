import { Meteor } from 'meteor/meteor';

Meteor.methods({
    'envia.notificacao'(note, filtro, disparo, firebase) {
        try {
            check(note, String);
            check(filtro, String);
            check(disparo, String);
            check(firebase, Boolean);

            var _filtro = NotificacaoFiltro.findOne({ _id: filtro }, { fields: { filtro: 1 } });
            var _notificacao = Notificacao.findOne({ _id: note });
            var _disparo = NotificacaoDisparo.findOne({ _id: disparo });

            var _doc = {};
            var endereco;

            if (_filtro && _notificacao) {
                if ('tipo_usuario' in _filtro.filtro) {
                    let doc = Meteor.users.find({ roles: _filtro.filtro.tipo_usuario }).fetch();
                    if (doc) {
                        let arr = _.pluck(doc, '_id');

                        _doc['id_usuario'] = arr;
                        _doc['tipo_usuario'] = _filtro.filtro.tipo_usuario
                    }

                    if ('genero' in _filtro.filtro) {
                        _doc['genero'] = _filtro.filtro.genero;
                    }
                    if ('especialidade' in _filtro.filtro) {
                        _doc['especialidade'] = _filtro.filtro.especialidade;
                    }

                    if ('prestador_foto' in _filtro.filtro) {
                        _doc['prestador_avatar'] = true;
                    }

                    if ('prestador_conta' in _filtro.filtro) {
                        _doc['prestador_conta'] = true;
                    }

                    if ('cliente_foto' in _filtro.filtro) {
                        _doc['cliente_avatar'] = true;
                    }

                    if ('cidade' in _filtro.filtro) {
                        _doc['cidade'] = _filtro.filtro.cidade;
                    }

                    if ('uf' in _filtro.filtro) {
                        _doc['estado'] = _filtro.filtro.uf;
                    }

                    if ('faixa_etaria' in _filtro.filtro) {
                        if (_filtro.filtro.faixa_etaria.length > 0) {
                            let _ate = parseInt(moment(new Date()).format("YYYY")) - parseInt(_filtro.faixa_etaria[0]);
                            let _de = parseInt(moment(new Date()).format("YYYY")) - parseInt(_filtro.faixa_etaria[1]);

                            _ate = moment("01/01/" + _ate, 'DD/MM/YYYY').toDate();
                            _ate = moment(_ate).format('DD/MM/YYYY')
                            _de = moment(new Date()).format('DD/MM/' + _de, 'DD/MM/YYYY');

                            _doc['data_nascimento'] = {
                                $gte: new Date(_de), $lt: new Date(_ate)
                            }
                        }
                    }
                }

                var query = {};
                var _pessoa;
                var pessoas;
                var pessoas_espec;
                var ids
                var endereco;

                if ('genero' in _doc) {
                    query['genero'] = _doc.genero;
                }

                if ('data_nascimento' in _doc) {
                    query['data_nascimento'] = _doc.data_nascimento;
                }

                if (_doc.tipo_usuario == 'prestador') {
                    query['id_usuario'] = { $in: _doc.id_usuario };
                    _pessoa = Pessoa.find(query).fetch();
                    pessoas = _.pluck(_pessoa, 'id_usuario');

                    if ('especialidade' in _doc) {
                        var espec;

                        query['id_usuario'] = { $in: _doc.id_usuario };
                        _pessoa = Pessoa.find(query).fetch();
                        pessoas = _.pluck(_pessoa, 'id_usuario');

                        if (pessoas.length > 0) {
                            query['id_usuario'] = { $in: pessoas };
                            query['id_especialidade'] = { $in: _doc.especialidade };

                            delete query['genero']

                            espec = PrestadorEspecialidade.find(query).fetch();

                            if (espec.length > 0) {
                                pessoas_espec = _.pluck(espec, 'id_usuario');
                                query['id_usuario'] = { $in: pessoas_espec };

                                if ('estado' in _doc) {
                                    if ('cidade' in _doc) {
                                        query['cidade'] = _doc.cidade;
                                    }

                                    query['estado'] = _doc.estado;
                                    endereco = PessoaEndereco.find(query).fetch();

                                    if (endereco.length > 0) {
                                        if ('prestador_avatar' in _doc) {
                                            let _query = {
                                                id_usuario: query.id_usuario,
                                                estado: query.estado,
                                                avatar: { $exists: false }
                                            }

                                            if ('cidade' in query) {
                                                _query['cidade'] = query.cidade;
                                            }

                                            let _avatar = Pessoa.find(_query).fetch();
                                            if (_avatar) {
                                                ids = _.pluck(_avatar, 'id_usuario');
                                                ids = _.uniq(ids);

                                                Meteor.call('pessoa_notificacao.insert', ids, _notificacao._id, function (error, result) {
                                                    if (error) {
                                                        console.log(error)
                                                    } else {
                                                        let doc = {
                                                            qnt_usuarios: ids.length
                                                        }

                                                        Meteor.call('notificacao_disparo.update', doc, disparo);
                                                    }
                                                });

                                                if (firebase) {
                                                    Meteor.call('envia.firebase', ids, _notificacao._id, _disparo._id);
                                                }
                                            } else if ('prestador_conta' in _doc) {
                                                let contas_doc = PessoaContaBancaria.find({}).fetch();
                                                let contas = _.pluck(contas_doc, 'id_usuario');

                                                let _query = {
                                                    id_usuario: { $not: { $in: contas } },
                                                    estado: query.estado,
                                                }

                                                if ('cidade' in query) {
                                                    _query['cidade'] = query.cidade;
                                                }

                                                let pessoa_conta = Pessoa.find(_query).fetch();

                                                ids = _.pluck(pessoa_conta, 'id_usuario');
                                                ids = _.uniq(ids);

                                                Meteor.call('pessoa_notificacao.insert', ids, _notificacao._id, function (error, result) {
                                                    if (error) {
                                                        console.log(error)
                                                    } else {
                                                        let doc = {
                                                            qnt_usuarios: ids.length
                                                        }

                                                        Meteor.call('notificacao_disparo.update', doc, disparo);
                                                    }
                                                });

                                                if (firebase) {
                                                    Meteor.call('envia.firebase', ids, _notificacao._id, _disparo._id);
                                                }
                                            } else {
                                                ids = _.pluck(endereco, 'id_usuario');
                                                ids = _.uniq(ids);

                                                Meteor.call('pessoa_notificacao.insert', ids, _notificacao._id, function (error, result) {
                                                    if (error) {
                                                        console.log(error)
                                                    } else {
                                                        let doc = {
                                                            qnt_usuarios: ids.length
                                                        }

                                                        Meteor.call('notificacao_disparo.update', doc, disparo);
                                                    }
                                                });

                                                if (firebase) {
                                                    Meteor.call('envia.firebase', ids, _notificacao._id, _disparo._id);
                                                }
                                            }
                                        }
                                    } else {
                                        if ('prestador_avatar' in doc) {
                                            let _avatar = Pessoa.find({ id_usuario: { $in: pessoas_espec }, avatar: { $exists: false } });

                                            if (_avatar) {
                                                ids = _.pluck(_avatar, 'id_usuario');
                                                ids = _.uniq(ids);

                                                Meteor.call('pessoa_notificacao.insert', ids, _notificacao._id, function (error, result) {
                                                    if (error) {
                                                        console.log(error)
                                                    } else {
                                                        let doc = {
                                                            qnt_usuarios: ids.length
                                                        }

                                                        Meteor.call('notificacao_disparo.update', doc, disparo);
                                                    }
                                                });

                                                if (firebase) {
                                                    Meteor.call('envia.firebase', ids, _notificacao._id, _disparo._id);
                                                }
                                            }
                                        }
                                    }
                                } else {
                                    if ('prestador_avatar' in _doc) {
                                        let _avatar = Pessoa.find({ id_usuario: { $in: pessoas_espec }, avatar: { $exists: false } });

                                        if (_avatar) {
                                            ids = _.pluck(_avatar, 'id_usuario');
                                            ids = _.uniq(ids);

                                            Meteor.call('pessoa_notificacao.insert', ids, _notificacao._id, function (error, result) {
                                                if (error) {
                                                    console.log(error)
                                                } else {
                                                    let doc = {
                                                        qnt_usuarios: ids.length
                                                    }

                                                    Meteor.call('notificacao_disparo.update', doc, disparo);
                                                }
                                            });

                                            if (firebase) {
                                                Meteor.call('envia.firebase', ids, _notificacao._id, _disparo._id);
                                            }
                                        }
                                    } else {
                                        Meteor.call('pessoa_notificacao.insert', pessoas_espec, _notificacao._id, function (error, result) {
                                            if (error) {
                                                console.log(error)
                                            } else {
                                                let doc = {
                                                    qnt_usuarios: pessoas_espec.length
                                                }

                                                Meteor.call('notificacao_disparo.update', doc, disparo);
                                            }
                                        });

                                        if (firebase) {
                                            Meteor.call('envia.firebase', pessoas_espec, _notificacao._id, _disparo._id);
                                        }
                                    }
                                }
                            }
                        }

                    } else {
                        if ('estado' in _doc) {
                            query['id_usuario'] = { $in: pessoas };
                            query['estado'] = _doc.estado;

                            if ('cidade' in _doc) {
                                query['cidade'] = _doc.cidade;
                            }

                            endereco = PessoaEndereco.find(query).fetch();

                            if (endereco.length > 0) {
                                ids = _.pluck(endereco, 'id_usuario');
                                ids = _.uniq(ids);

                                Meteor.call('pessoa_notificacao.insert', ids, _notificacao._id, function (error, result) {
                                    if (error) {
                                        console.log(error)
                                    } else {
                                        let doc = {
                                            qnt_usuarios: ids.length
                                        }

                                        Meteor.call('notificacao_disparo.update', doc, disparo);
                                    }
                                });

                                if (firebase) {
                                    Meteor.call('envia.firebase', ids, _notificacao._id, _disparo._id);
                                }
                            }
                        } else {
                            Meteor.call('pessoa_notificacao.insert', pessoas_espec, _notificacao._id, _disparo._id, function (error, result) {
                                if (error) {
                                    console.log(error)
                                } else {
                                    let doc = {
                                        qnt_usuarios: pessoas_espec.length
                                    }

                                    Meteor.call('notificacao_disparo.update', doc, disparo);
                                }
                            });

                            if (firebase) {
                                Meteor.call('envia.firebase', pessoas_espec, _notificacao._id, _disparo._id);
                            }
                        }
                        Meteor.call('pessoa_notificacao.insert', pessoas, _notificacao._id, _disparo._id, function (error, result) {
                            if (error) {
                                console.log(error)
                            } else {
                                let doc = {
                                    qnt_usuarios: pessoas.length
                                }

                                Meteor.call('notificacao_disparo.update', doc, disparo);
                            }
                        });

                        if (firebase) {
                            Meteor.call('envia.firebase', pessoas, _notificacao._id, _disparo._id);
                        }
                    }
                } else {
                    _pessoa = Pessoa.find(query).fetch();
                    pessoas = _.pluck(_pessoa, 'id_usuario');
                    pessoas = _.uniq(pessoas);

                    if (pessoas.length > 0) {
                        if ('estado' in _doc) {

                            query['id_usuario'] = { $in: pessoas };
                            query['estado'] = _doc.estado;

                            if ('cidade' in _doc) {
                                query['cidade'] = _doc.cidade;
                            }

                            endereco = PessoaEndereco.find(query).fetch();

                            if (endereco.length > 0) {
                                if ('avatar_cliente' in _doc) {
                                    let _query = {
                                        id_usuario: query.id_usuario,
                                        estado: query.estado,
                                        avatar: null,
                                    }

                                    if ('cidade' in query) {
                                        _query['cidade'] = query.cidade;
                                    }

                                    let _avatar = pessoa.find(_query).fetch();
                                    if (_avatar) {
                                        ids = _.pluck(_avatar, 'id_usuario');
                                        ids = _.uniq(ids);

                                        Meteor.call('pessoa_notificacao.insert', ids, _notificacao._id, function (error, result) {
                                            if (error) {
                                                console.log(error)
                                            } else {
                                                let doc = {
                                                    qnt_usuarios: ids.length
                                                }

                                                Meteor.call('notificacao_disparo.update', doc, disparo);
                                            }
                                        });

                                        if (firebase) {
                                            Meteor.call('envia.firebase', ids, _notificacao._id, _disparo._id);
                                        }
                                    }
                                }
                                ids = _.pluck(endereco, 'id_usuario');
                                ids = _.uniq(ids);

                                Meteor.call('pessoa_notificacao.insert', ids, _notificacao._id, function (error, result) {
                                    if (error) {
                                        console.log(error)
                                    } else {
                                        let doc = {
                                            qnt_usuarios: ids.length
                                        }

                                        Meteor.call('notificacao_disparo.update', doc, disparo);
                                    }
                                });

                                if (firebase) {
                                    Meteor.call('envia.firebase', ids, _notificacao._id, _disparo._id);
                                }
                            }
                        } else {
                            Meteor.call('pessoa_notificacao.insert', pessoas, _notificacao._id, function (error, result) {
                                if (error) {
                                    console.log(error)
                                } else {
                                    let doc = {
                                        qnt_usuarios: pessoas.length
                                    }

                                    Meteor.call('notificacao_disparo.update', doc, disparo);
                                }
                            });

                            if (firebase) {
                                Meteor.call('envia.firebase', pessoas, _notificacao._id, _disparo._id);
                            }
                        }
                    }
                }
            }
        } catch (error) {
            throw new Meteor.Error(400, 'Algo deu errado, tente novamente.');
        }
    }
});