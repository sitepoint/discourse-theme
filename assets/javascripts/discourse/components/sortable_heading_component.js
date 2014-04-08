Discourse.SortableHeadingComponent.reopen({
  iconSortClass: function() {
    var sortable = this.get('sortable');

    if (sortable && this.get('sortBy') === this.get('sortOrder.order')) {
      // SP CUSTOMIZATION BEGIN
      return this.get('sortOrder.descending') ? 'fa fa-caret-down' : 'fa fa-caret-up';
      // SP CUSTOMIZATION END
    }
  }.property('sortable', 'sortOrder.order', 'sortOrder.descending')
});
