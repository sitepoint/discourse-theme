export default Ember.Component.extend({
  children: null,

  init: function() {
    const comp = this;
    this._super(...arguments);
    this.set('children', Ember.A());

    $.post("/wp-admin/admin-ajax.php", {
      action: "get_forums_random_template",
      rand: Math.random(),
      forums_template: this.templateAlias
    }, function(data) {
      $(data).filter('script[type="text/x-handlebars"]').each(function() {
        comp.children.insertAt(0, $(this).html());
      });
    });
  }

});
