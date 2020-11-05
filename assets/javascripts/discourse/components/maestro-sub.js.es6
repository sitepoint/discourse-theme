export default Ember.Component.extend({
  didReceiveAttrs() {
    this._super(...arguments);

    const layoutString = this.getAttr("maestro-thing");
    this.set("layout", Ember.HTMLBars.compile(layoutString));
    this.rerender();
  }
});
