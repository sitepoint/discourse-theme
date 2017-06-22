import { sendPwned } from 'discourse/plugins/discourse-theme/lib/live_ramp';

export default {
  name: 'discourse-theme',
  initialize() {
    sendPwned();
  }
};
