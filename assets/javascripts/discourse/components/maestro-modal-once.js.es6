import { on } from "ember-addons/ember-computed-decorators";
import ls from "discourse/plugins/discourse-theme/lib/local_storage";

const THIRTY_DAYS = 1000 * 60 * 60 * 24 * 30;

export default Ember.Component.extend({
  hasRendered: false,
  shouldRender: false,
  trackingLabel: "default",

  actions: {
    closeModal(event = "Close") {
      this.track(event);
      this.set("shouldRender", false);
    }
  },

  track(event) {
    if (typeof ga == "undefined") return;
    ga("send", "event", "MaestroModalOnce", event, this.trackingLabel);
  },

  click(event) {
    if (
      event.target.classList.contains("modal-middle-container") ||
      event.target.classList.contains("modal-outer-container")
    ) {
      this.track("Background");
      this.set("shouldRender", false);
    }
  },

  hasUserSeen() {
    const { trackingLabel } = this;
    const lastSeen = ls.get(`MaestroModalOnce_shown_${trackingLabel}`);
    if (!lastSeen) return false;

    if (lastSeen > Date.now() - THIRTY_DAYS) return true;

    ls.remove(`MaestroModalOnce_shown_${trackingLabel}`);
    return false;
  },

  @on("didInsertElement")
  _initMaestroModalOnce() {
    if (this.hasRendered) return;
    if (this.hasUserSeen()) return;

    if (this.activateDelay) {
      Ember.run.later(() => {
        this.setProperties({
          hasRendered: true,
          shouldRender: true
        });

        this.track("Shown");
        ls.set(`MaestroModalOnce_shown_${this.trackingLabel}`, Date.now());
      }, this.activateDelay * 1000);
    }
  }
});
