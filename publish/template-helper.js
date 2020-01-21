Template.historico.helpers({
    Historico: function () {
        let historico = Historico.find({}).fetch();
        let obj = [];

        _.each(historico, function (item) {
            obj.push(_.omit(item, '_id', 'id_usuario', 'version', 'modifiedAt'));
        });

        let doc = [];
        for (let i = obj.length; i >= 0; i--) {
            doc.push(diff(obj[i], obj[i - 1]))
        }

        delete doc[doc.length - 1];
        doc = _.flatten(doc);

        let arr = [];
        let hist;

        _.each(doc, function (item) {
            hist = {};

            if (item === undefined) {
                return;
            }

            if (item.kind == 'E') {
                hist['acao'] = 'Editou';
                hist['chave'] = item.path[0];
                hist['antes'] = item.lhs;
                hist['depois'] = item.rhs;
            }

            if (item.kind == 'N') {
                if ('path' in item) {
                    hist['acao'] = 'Adicionou';
                    hist['chave'] = item.path[0];
                    hist['depois'] = item.rhs;
                } else {
                    hist['acao'] = 'Cadastro';
                    hist['depois'] = item.rhs;
                }

            }

            arr.push(hist)
        });

        _.each(arr, function (item) {
            if ('chave' in item) {
                if (item.chave == 'avatar') {
                    let exists = Historico.findOne({ avatar: item.depois });
                    if (exists) {
                        item['modifiedAt'] = moment(exists.modifiedAt).format('DD/MM/YYYY [às] HH:mm');
                    }
                }
            }
        });

        return arr;
    }
});