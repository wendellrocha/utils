/**
 * Bubble sort para ordenar os submenus dentro de um menu.
 * 
 * A collection menu_client é um array de arrays =)
 * 
 * Lembrando que esse bubble sort está no client, ordenando o objeto que veio da query no minimongo (Meteor)
 * e retornando o objeto modificado.
 * 
 * Como o bubble sort está em um helper, tudo é executado reativamente.
 * 
 * Por default todos os submenus são inseridos ordenados. Mas o cliente pode alterar a ordenação alterando o valor da key ordem
 */

Template.sidebar.helpers({
    menu: function () {
        let _doc = menu_client.find({ ativo: true }, { sort: { ordem: 1 } }).fetch();
        /**
         * Bubble sort para ordenar os submenus
         * Melhor caso O(n) - array já ordenado
         * Pior caso O(n²) - array totalmente desordenado
         * TODO: futuramente substituir por um quick sort (caso aumente a quantidade de submenus)
         */
        for (let i = 0; i < _doc.length; i++) {
            for (let j = 0; j < _doc[i].submenu.length; j++) {
                if (!(_doc[i].submenu.length <= 1)) {
                    for (let k = 0; k < _doc[i].submenu.length - 1; k++) {
                        if (_doc[i].submenu[k].ordem > _doc[i].submenu[k + 1].ordem) {
                            let temp = _doc[i].submenu[k];
                            _doc[i].submenu[k] = _doc[i].submenu[k + 1];
                            _doc[i].submenu[k + 1] = temp;
                        }
                    }
                }
            }
        }
        return _doc;
    }
});