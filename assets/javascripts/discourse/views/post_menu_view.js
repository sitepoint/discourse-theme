Discourse.PostMenuView.reopen({
  // Replies Button
  renderReplies: function(post, buffer) {
    if (!post.get('showRepliesBelow')) return;

    var reply_count = post.get('reply_count');
    // SP CUSTOMIZATION BEGIN
    buffer.push("<button class='show-replies btn' data-action='replies'>");
    // SP CUSTOMIZATION END
    buffer.push("<span class='badge-posts'>" + reply_count + "</span>");
    buffer.push(I18n.t("post.has_replies", { count: reply_count }));

    // SP CUSTOMIZATION BEGIN
    var icon = (this.get('post.replies.length') > 0) ? 'fa-caret-up' : 'fa-caret-down';
    // SP CUSTOMIZATION END
    return buffer.push("<i class='fa " + icon + "'></i></button>");
  },

  // Reply button
  renderReply: function(post, buffer) {
    if (!this.get('controller.model.details.can_create_post')) return;
    buffer.push("<button title=\"" +
                 (I18n.t("post.controls.reply")) +
                 // SP CUSTOMIZATION BEGIN
                 "\" class='create btn' data-action=\"reply\"><i class='fa fa-reply'></i><span class='btn-text'>" +
                 // SP CUSTOMIZATION END
                 (I18n.t("topic.reply.title")) + "</span></button>");
  }
});
