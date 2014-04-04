Discourse.CategoryDropComponent.reopen({
  iconClass: function() {
    if (this.get('expanded')) { return "fa fa-caret-down"; }
    return "fa fa-caret-down";
  }.property('expanded')
});
