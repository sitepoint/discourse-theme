
export default Ember.Component.extend({
  hasRendered: false,

  _initMaestroOutlet: function() {
    const comp = this;
    if (this.hasRendered) return;
    if (!this.templateAlias) return console.log("No templateAlias supplied for maestro outlet", this);

    $.ajax({
      type: "POST",
      url: "/wp-admin/admin-ajax.php",
      data: {
        action: "get_forums_random_template",
        rand: Math.random(),
        forums_template: this.templateAlias
      },
      success: function(data, textStatus, XMLHttpRequest) {
        $(data).filter('script[type="text/x-handlebars"]').each(function() {
          Ember.TEMPLATES[comp.templateAlias] = Ember.Handlebars.compile($(this).html());
          comp.set("templateName", comp.templateAlias);
          comp.set("hasRendered", true);
          comp.rerender();
        });
      }
    });
  }.on("didInsertElement")
});
