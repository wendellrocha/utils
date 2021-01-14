// Reactive publish with observeChanges

// import { _segmentacao } from '../../services/SegmentacaoService';

Meteor.publish('Cupons_App', function (especialidade) {
    if (this.userId) {
        let _query = {
            ativo: true,
            finalizado: false,
            usuarios: { $nin: [this.userId] }
        };

        if (especialidade != null) {
            _query['especialidade'] = { $in: especialidades }
        }

        const handle = Cupom.find(_query).observeChanges({
            added: (id, fields) => {
                const filtro = _segmentacao(fields['id_filtro']);

                if (_.indexOf(filtro, this.userId)) {
                    const _doc = {
                        "_id": id,
                        "titulo": fields["notificacao_titulo"],
                        "texto": fields["notificacao_texto"],
                        "valor": fields["valor"],
                        "tipo_valor": fields["tipo_valor"],
                        "ativo": fields["ativo"],
                        "data_inicio": moment(fields["data_inicio"]).toISOString(),
                        "data_fim": moment(fields["data_fim"]).toISOString()
                    };
                    this.added('Cupons_App', id, _doc);
                }
            },
            changed: (id, fields) => {
                const filtro = _segmentacao(fields['id_filtro']);

                if (_.indexOf(filtro, this.userId)) {
                    const _doc = {
                        "_id": id,
                        "titulo": fields["notificacao_titulo"],
                        "texto": fields["notificacao_texto"],
                        "valor": fields["valor"],
                        "tipo_valor": fields["tipo_valor"],
                        "ativo": fields["ativo"],
                        "data_inicio": moment(fields["data_inicio"]).toISOString(),
                        "data_fim": moment(fields["data_fim"]).toISOString()
                    };
                    this.changed('Cupons_App', id, _doc);
                }
            },
            removed: (id) => {
                this.removed('Cupons_App', id);
            }
        });

        this.ready();

        this.onStop(() => handle.stop());
    }
});