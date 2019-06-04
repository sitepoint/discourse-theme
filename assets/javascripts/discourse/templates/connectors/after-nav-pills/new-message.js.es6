import Composer from 'discourse/models/composer';
import { getOwner } from "discourse-common/lib/get-owner";

export default {
  actions: {
    btn_action: function() {
      getOwner(this).lookup('controller:composer').open({action: Composer.PRIVATE_MESSAGE, archetypeId: 'private_message', draftKey: 'new_private_message'});
    }
  }
}
