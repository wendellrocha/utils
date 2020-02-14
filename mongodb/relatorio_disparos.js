db.notificacao_disparo.aggregate([
    {
        $match: {
            _id: id
        }
    },
    {
        $lookup: {
            from: 'notificacao',
            localField: 'id_notificacao',
            foreignField: '_id',
            as: 'notificacao'
        }
    },
    {
        $unwind: '$notificacao'
    },
    {
        $lookup: {
            from: 'pessoa_segmentacao',
            localField: 'id_filtro',
            foreignField: '_id',
            as: 'filtro'
        }
    },
    {
        $unwind: '$filtro'
    },
    {
        $lookup: {
            from: 'pessoa',
            localField: 'id_usuario_alteracao',
            foreignField: 'id_usuario',
            as: 'usuario'
        }
    },
    {
        $unwind: '$usuario'
    },
    {
        $project: {
            _id: 1,
            disparo: {
                titulo: '$titulo',
                descricao: '$descricao',
                firebase: '$firebase',
                falhas_firebase: '$qnt_falhas_firebase',
                sucesso_firebase: '$qnt_sucesso_firebase',
                total_firebase: '$qnt_total_firebase',
                usuarios: '$qnt_usuarios',
                sucesso: '$sucesso',
                erro: '$erro',
                erro_mensagem: '$erro_mensagem',
                createdAt: '$createdAt',
                data_fim: '$data_fim',
                porcentagem_sucesso: {
                    $toInt: [{
                        $divide: [
                            { $multiply: ['$qnt_sucesso_firebase', 100] },
                            { $sum: ['$qnt_sucesso_firebase', '$qnt_falhas_firebase'] }
                        ]
                    }]
                },
                porcentagem_falha: {
                    $toInt: [{
                        $divide: [
                            { $multiply: ['$qnt_falhas_firebase', 100] },
                            { $sum: ['$qnt_sucesso_firebase', '$qnt_falhas_firebase'] }
                        ]
                    }]
                },
                porcentagem_tokens: {
                    $toInt: [{
                        $divide: [
                            { $multiply: ['$qnt_usuarios', 100] },
                            { $sum: ['$qnt_sucesso_firebase', '$qnt_falhas_firebase'] }
                        ]
                    }]
                }
            },
            notificacao: {
                titulo: '$notificacao.titulo',
                texto: '$notificacao.texto',
                rota: '$notificacao.rota'
            },
            filtro: {
                titulo: '$filtro.titulo',
                descricao: '$filtro.descricao'
            },
            usuario: {
                nome: { $concat: ['$usuario.nome', ' ', '$usuario.sobrenome'] }
            }
        }
    }
])