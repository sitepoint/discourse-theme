(function() {
// Private Message Button

Discourse.NavigationDefaultController.reopen({
  actions: {
    composePrivateMessage: function() {
      return this.controllerFor('composer').open({
        action: Discourse.Composer.PRIVATE_MESSAGE,
        usernames: "",
        archetypeId: 'private_message',
        draftKey: 'new_private_message'
      });
    }
  }
});

})();
