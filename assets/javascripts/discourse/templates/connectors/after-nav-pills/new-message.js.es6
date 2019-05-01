import Composer from 'discourse/models/composer';

export default {
  actions: {
    btn_action: function() {
      this.container.lookup('controller:composer').open({action: Composer.PRIVATE_MESSAGE, archetypeId: 'private_message', draftKey: 'new_private_message'});
    }
  }
}
