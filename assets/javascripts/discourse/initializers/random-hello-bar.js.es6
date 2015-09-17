import SpHelloBar                    from '../../spHelloBar/SpHelloBar';
import getRandomContent              from '../../spHelloBar/getRandomContent';
import { checkForCookie, setCookie } from '../../spHelloBar/cookieManager';
import trackEvent                    from '../../spHelloBar/trackEvent';

export default {
  name: 'random-hello-bar',
  initialize() {
    (function(window, $) {

      if ($('html').hasClass('mobile-device')) return;

      const sph = new SpHelloBar();

      // extend SpHelloBar
      sph.after('beforeInit', function() {
        checkForCookie.call(sph);
      });
      sph.after('onClose', function() {
        setCookie.call(sph);
      });
      sph.after('onClick', function() {
        trackEvent.call(sph, 'Click');
      });
      sph.after('onToggle', function() {
        trackEvent.call(sph, 'Impression');
      });

     getRandomContent(() => sph.init());

    })(window, (typeof jQuery !== "undefined") ? jQuery : Zepto);
  }
};
