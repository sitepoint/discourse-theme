import { createWidget } from "discourse/widgets/widget";
import { h } from "virtual-dom";

createWidget("sso-sign-up-btn", {
  tagName: "button.btn-primary.btn-small.sign-up-button",

  click() {
    $.cookie("sso_event", "sign_up", {
      path: "/",
      expires: 1
    });
    this.sendWidgetAction("showLogin");
  },

  html() {
    return I18n.t("sign_up");
  }
});
