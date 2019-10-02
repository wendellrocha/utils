import './range.html';

Template.range.events({
    'input #raioRange': function (event) {
        $(".raio-value").text($("#raioRange").val() + ' km');
    }
});

Template.range.onRendered(function () {
    this.autorun(() => {
        $(".raio-value").text($("#raioRange").val() + ' km');
    });
});