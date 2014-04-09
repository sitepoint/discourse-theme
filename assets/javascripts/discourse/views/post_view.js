Discourse.PostView.reopen({
  toggleQuote: function($aside) {
    $aside.data('expanded',!$aside.data('expanded'));
    if ($aside.data('expanded')) {
      // SP CUSTOMIZATION BEGIN
      this.updateQuoteElements($aside, 'caret-up');
      // SP CUSTOMIZATION END
      // Show expanded quote
      var $blockQuote = $('blockquote', $aside);
      $aside.data('original-contents',$blockQuote.html());

      var originalText = $blockQuote.text().trim();
      $blockQuote.html(I18n.t("loading"));
      var topic_id = this.get('post.topic_id');
      if ($aside.data('topic')) {
        topic_id = $aside.data('topic');
      }
      Discourse.ajax("/posts/by_number/" + topic_id + "/" + $aside.data('post')).then(function (result) {
        var parsed = $(result.cooked);
        parsed.replaceText(originalText, "<span class='highlighted'>" + originalText + "</span>");
        $blockQuote.showHtml(parsed);
      });
    } else {
      // Hide expanded quote
      // SP CUSTOMIZATION BEGIN
      this.updateQuoteElements($aside, 'caret-down');
      // SP CUSTOMIZATION END
      $('blockquote', $aside).showHtml($aside.data('original-contents'));
    }
    return false;
  },

  // Add the quote controls to a post
  insertQuoteControls: function() {
    var self = this;
    return this.$('aside.quote').each(function(i, e) {
      var $aside = $(e);
      // SP CUSTOMIZATION BEGIN
      self.updateQuoteElements($aside, 'caret-down');
      // SP CUSTOMIZATION END
      var $title = $('.title', $aside);

      // Unless it's a full quote, allow click to expand
      if (!($aside.data('full') || $title.data('has-quote-controls'))) {
        $title.on('click', function(e) {
          if ($(e.target).is('a')) return true;
          self.toggleQuote($aside);
        });
        $title.data('has-quote-controls', true);
      }
    });
  }
});
