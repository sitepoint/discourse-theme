// Helper class for rendering a button
var Button = function(action, label, icon, opts) {
  this.action = action;
  this.label = label;

  if (typeof icon === "object") {
    this.opts = icon;
  } else {
    this.icon = icon;
  }
  this.opts = this.opts || opts || {};
};

Button.prototype.render = function(buffer) {
  buffer.push("<button title=\"" + I18n.t(this.label) + "\"");
  if (this.opts.className) { buffer.push(" class=\"" + this.opts.className + "\""); }
  if (this.opts.shareUrl) { buffer.push(" data-share-url=\"" + this.opts.shareUrl + "\""); }
  buffer.push(" data-action=\"" + this.action + "\">");
  if (this.icon) { buffer.push("<i class=\"fa fa-" + this.icon + "\"></i>"); }
  if (this.opts.textLabel) { buffer.push(I18n.t(this.opts.textLabel)); }
  if (this.opts.innerHTML) { buffer.push(this.opts.innerHTML); }
  buffer.push("</button>");
};

// PostMenuView.reopen({
Discourse.PostMenuView.reopen({
  // Replies Button
  renderReplies: function(post, buffer) {
    if (!post.get('showRepliesBelow')) return;

    var reply_count = post.get('reply_count');

    /* SP */ buffer.push("<button class='show-replies btn' data-action='replies'>");

    buffer.push("<span class='badge-posts'>" + reply_count + "</span>");
    buffer.push(I18n.t("post.has_replies", { count: reply_count }));

    /* SP */ var icon = (this.get('post.replies.length') > 0) ? 'fa-caret-up' : 'fa-caret-down';

    return buffer.push("<i class='fa " + icon + "'></i></button>");
  },

  // Reply button
  buttonForReply: function() {
    if (!this.get('controller.model.details.can_create_post')) return;

    /* SP */ var options = {className: 'create btn'};

    if(!Discourse.Mobile.mobileView) {
      options.textLabel = 'topic.reply.title';
    }

    return new Button('reply', 'post.controls.reply', 'reply', options);
  }
});
