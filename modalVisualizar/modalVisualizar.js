import './modalVisualizar.html';

Template.modalVisualizar.onCreated(function () { });

Template.modalVisualizar.helpers({
    FormConteudo: function () {
        if ('data' in this && this.data != null) {
            let result = [];
            let doc = this.data;

            _.each(doc, function (item, key) {
                if (key == 'nome' || key == 'usuario' || key == 'id_usuario' || key == 'motivo' || key == 'acao' || key == 'anterior' || key == 'alteracao' || key == 'modifiedAt' || key == 'createdAt' || key == 'ativo') {
                    if (key == 'ativo') {
                        item = ((item) ? '<span class="badge badge-success">Ativo</span>' : '<span class="badge badge-danger">Inativo</span>');
                        key = 'Status';
                    }

                    if (key == 'id_usuario') {
                        key = 'ID do usuário';
                    }

                    if (key == 'Nome') {
                        key = 'Nome';
                    }

                    if (key == 'usuario') {
                        key = 'Usuário';
                    }

                    if (key == 'modifiedAt') {
                        item = moment(item).fromNow();
                        key = "Modificado em";
                    }

                    if (key == 'createdAt') {
                        item = moment(item).fromNow();
                        key = 'Criado em';
                    }

                    if (key == 'anterior') {
                        item = '<pre>' + item + '</pre>';
                        key = 'Anterior';
                    }

                    if (key == 'alteracao') {
                        item = '<pre>' + item + '</pre>';
                        key = 'Alteração';
                    }

                    result.push({ chave: key, valor: item });
                } else {
                    delete key;
                }
            });

            return { itens: result };
        }
    }
});

Template.modalVisualizar.events({});

Template.modalVisualizar.onRendered(function () { });

Template.modalVisualizar.onDestroyed(function () { });