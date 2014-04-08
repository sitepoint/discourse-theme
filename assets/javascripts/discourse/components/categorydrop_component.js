Discourse.CategoryDropComponent.reopen({
  iconClass: function() {
    if (this.get('expanded')) { return "fa fa-caret-down"; }
    // SP CUSTOMIZATION BEGIN
    return "fa fa-caret-down";
    // SP CUSTOMIZATION END
  }.property('expanded')
});
