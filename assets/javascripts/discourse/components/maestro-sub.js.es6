export default Ember.Component.extend({
  didReceiveAttrs: function() {
    var layoutString = this.getAttr('maestro-thing');
    this.set('layout', Ember.Handlebars.compile(layoutString));
    this.rerender();
  }
});
