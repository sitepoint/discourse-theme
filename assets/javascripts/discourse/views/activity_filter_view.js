Discourse.ActivityFilterView.reopen({
  render: function(buffer) {
    buffer.push("<a href='" + this.get('url') + "'>");
    var icon = this.get('icon');
    if (icon) {
      buffer.push("<i class='glyph fa fa-" + icon + "'></i> ");
    }

    buffer.push(this.get('description') + " <span class='count'>(" + this.get('activityCount') + ")</span>");
    // SP CUSTOMIZATION BEGIN
    buffer.push("<span class='fa fa-caret-right'></span></a>");
    // SP CUSTOMIZATION END
  }
});
