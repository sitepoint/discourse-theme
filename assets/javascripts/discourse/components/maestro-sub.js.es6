export default Ember.Component.extend({
  didReceiveAttrs: function() {
    var layoutString = this.getAttr('maestro-thing');
    this.set('layout', Ember.HTMLBars.compile(layoutString));
    this.rerender();
  }
});
