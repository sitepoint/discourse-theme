import { createWidget } from "discourse/widgets/widget";
import hbs from "discourse/widgets/hbs-compiler";

createWidget("header-contents", {
  tagName: "div.contents.clearfix",
  template: hbs`
    {{attach widget="sitepoint-logo" attrs=attrs}}
    {{#if attrs.topic}}
      {{attach widget="header-topic-info" attrs=attrs}}
    {{else}}
      {{attach widget="sitepoint-links" attrs=attrs}}
    {{/if}}
    <div class="panel clearfix">{{yield}}</div>
  `
});
