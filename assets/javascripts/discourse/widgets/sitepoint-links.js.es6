import { createWidget } from 'discourse/widgets/widget';
import { h } from 'virtual-dom';

createWidget('sitepoint-links', {
  tagName: 'div.header-links-wrapper.clearfix',

  html(attrs) {
    const links = [];

    links.push(h('a.header-link', {
      target: '_blank',
      href: '/?utm_source=community&utm_medium=top-nav'
    },
    'Articles'
    ));

    links.push(h('a.header-link.u-button', {
      target: '_blank',
      href: '/premium/topics/all?utm_source=community&utm_medium=top-nav'
    },
    'Premium'
    ));

    return links;
  }
});
