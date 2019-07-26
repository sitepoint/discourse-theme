import { ajax } from "discourse/lib/ajax";

export default Ember.Component.extend({
  children: null,

  init() {
    this._super(...arguments);

    this.set("children", Ember.A());

    ajax("/wp-admin/admin-ajax.php", {
      type: "POST",
      data: {
        action: "get_forums_random_template",
        rand: Math.random(),
        forums_template: this.templateAlias
      }
    }).then(data => {
      $(data)
        .filter('script[type="text/x-handlebars"]')
        .each((index, node) => this.children.insertAt(0, $(node).html()));
    });
  }
});
