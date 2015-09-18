export default function trackEvent (label) {
  if (!this.impressionTracked && this.isShown && label == 'Impression') {
    this.impressionTracked = true;
  } else if(this.isShown && label == 'Impression') {
    return;
  }

  if (typeof(ga) == 'undefined') return;

  const campaignName = this.$el.getAttribute('data-campaign') || 'unnamed_campaign';
  ga('send', 'event', 'SP Hello Bar', campaignName, label, {
    'nonInteraction': true
  });
}
