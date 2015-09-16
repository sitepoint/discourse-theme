export default {
  name: 'random-hello-bar',
  initialize() {


    (function(window, $) {
      "use strict";

      var EXPIRE_DAYS = 14;

      var RandomHelloBar = function() {

        var isEnabled = true;

        // if jQuery Cookie is available, we may have disabled ourselves for the number of days set in EXPIRE_DAYS if user manually closed the bar
        if ($.cookie) {
          if ($.cookie('awesomeBarDisabled')) {
            isEnabled = false;
          }
        }

        if ($('html').hasClass('mobile-device')) isEnabled = false;

        isEnabled && this.getAd();
      };

      RandomHelloBar.prototype = {

        init: function() {
          var className = '.awesome-bar';
          if(!$(className).length) return;

          this.$el               = $(className);
          this.$closeBtn         = this.$el.find('.awesome-bar_close');
          this.isShown           = false;
          this.targetOffset      = 300;
          this.impressionTracked = false;

          this.checkPosition   = this._throttle($.proxy(this.checkPosition, this), 500);
          this.closeBtnHandler = $.proxy(this.closeBtnHandler, this);

          this.$el.addClass('js');
          this.bindEvents();
        },

        bindEvents: function() {
          var that = this;

          $(window).on('scroll', this.checkPosition);

          this.$el.on('click', 'a', function() {
            that.trackEvent('Click');
          });

          this.$closeBtn.on('click', this.closeBtnHandler);
        },

        unBindEvents: function () {
          $(window).off('scroll', this.checkPosition);
        },

        checkPosition: function() {
          var windowTop = window.pageYOffset || document.documentElement.scrollTop;

          if( !this.isShown && (windowTop > this.targetOffset) ) {
            this.showBar(true);
          } else if (this.isShown && (windowTop < this.targetOffset)) {
            this.showBar(false);
          }
        },

        showBar: function( shouldBeShown ) {
          this.$el.toggleClass('show', shouldBeShown);
          if( shouldBeShown && !this.impressionTracked ) {
            this.impressionTracked = true;
            this.trackEvent('Impression');
          }
          this.isShown = shouldBeShown;
        },

        trackEvent: function(label) {
          if(typeof(ga)=='undefined') return;
          var campaignName = this.$el.attr('data-campaign') || 'unnamed_campaign';
          ga('send', 'event', 'Awesome Bar', campaignName, label, {'nonInteraction': true});
        },

        closeBtnHandler: function (evt) {
          this.showBar(false);
          this.unBindEvents();
          $.cookie && $.cookie('awesomeBarDisabled', 'truthy', { path: '/', expires: EXPIRE_DAYS } );
        },

        // taken from
        //
        // Underscore.js 1.5.2
        // http://underscorejs.org
        // (c) 2009-2013 Jeremy Ashkenas, DocumentCloud and Investigative Reporters & Editors
        // Underscore may be freely distributed under the MIT license.
        //
        // Returns a function, that, when invoked, will only be triggered at most once
        // during a given window of time.
        _throttle: function(func, wait) {
          var context, args, timeout, result;
          var previous = 0;
          var later = function() {
            previous = new Date();
            timeout  = null;
            result   = func.apply(context, args);
          };
          return function() {
            var now       = new Date();
            var remaining = wait - (now - previous);
            context       = this;
            args          = arguments;
            if (remaining <= 0) {
              clearTimeout(timeout);
              timeout  = null;
              previous = now;
              result   = func.apply(context, args);
            } else if (!timeout) {
              timeout = setTimeout(later, remaining);
            }
            return result;
          };
        },

        getAd: function() {
          var that = this;
          jQuery.ajax({
            type: 'POST',
            url: 'http://sitepoint.com/wp-admin/admin-ajax.php',
            data: {
              action: 'get_forums_random_hello_bar',
              rand: Math.random()
            },
            success: function(data, textStatus, XMLHttpRequest) {
              $("body").prepend(data);
              that.init();
            }
          });
        }

      };

      // FIXME: hack: waiting for $/foundation.cookie to become ready for some time before going cookieless
      var iterations = 0,
          instantiate = function () {
            if (($ && $.cookie) || iterations > 10) {
              window.RandomHelloBar = new RandomHelloBar();
            } else {
              iterations++;
              setTimeout(instantiate, 500);
            }
          };

      instantiate();

    })(window, (typeof jQuery !== "undefined") ? jQuery : Zepto);


  }
};
