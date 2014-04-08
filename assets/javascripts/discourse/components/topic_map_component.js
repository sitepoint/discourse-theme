Discourse.TopicMapComponent.reopen({
  toggleMapClass: function() {
    // SP CUSTOMIZATION BEGIN
    return this.get('mapCollapsed') ? 'fa fa-caret-down' : 'fa fa-caret-up';
    // SP CUSTOMIZATION END
  }.property('mapCollapsed')
});
