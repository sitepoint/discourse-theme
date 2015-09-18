import throttle from './throttle';

function SpHelloBar({
    isEnabled        = true,
    isShown          = false,
    shouldBeShown    = false,
    targetOffset     = 300,
    throttleWait     = 500,
    elSelector       = '.SpHelloBar',
    closeBtnSelector = '.SpHelloBar_close',
    linkSelector     = '.SpHelloBar_container',
    showClassName    = 'SpHelloBar u-show',
    hideClassName    = 'SpHelloBar'
  } = {}){
  this.isEnabled        = isEnabled;
  this.isShown          = isShown;
  this.shouldBeShown    = shouldBeShown;
  this.targetOffset     = targetOffset;
  this.throttleWait     = throttleWait;
  this.elSelector       = elSelector;
  this.closeBtnSelector = closeBtnSelector;
  this.linkSelector     = linkSelector;
  this.showClassName    = showClassName;
  this.hideClassName    = hideClassName;
}

SpHelloBar.prototype = {
  beforeInit: function beforeInit() {
    this.checkForThrottle();
    this.checkForEl();
  },

  onInit: function onInit() {
    this.findCloseBtn();
    this.findLink();
  },

  onScroll: function onScroll() {
    this.checkPosition();
    this.checkForVisChange();
  },

  onToggle: function onToggle() {
    this.isShown = this.shouldBeShown;
    this.toggleClass();
  },

  onClick: function onClick() {
    // noop by default
  },

  onClose: function onClose(e) {
    e.preventDefault();
    this.unBindEvents();
    this.shouldBeShown = false;
    this.onToggle();
  },

  init: function init() {
    this.beforeInit();
    if(!this.isEnabled) return;

    this.onInit();

    this.checkPositionThrottled =  throttle(
      this.onScroll.bind(this),
      this.throttleWait
    );

    this.bindEvents();
  },

  findCloseBtn: function findCloseBtn() {
    this.$closeBtn = this.$el.querySelector(this.closeBtnSelector);
    this.$closeBtn && this.$closeBtn.addEventListener('click', this.onClose.bind(this));
  },

  findLink: function findLink() {
    this.$link = this.$el.querySelector(this.linkSelector);
    this.$link && this.$link.addEventListener('click', this.onClick.bind(this));
  },

  bindEvents: function bindEvents() {
    window.addEventListener('scroll', this.checkPositionThrottled);
    window.addEventListener('resize', this.checkPositionThrottled);
  },

  unBindEvents: function unBindEvents() {
    window.removeEventListener('scroll', this.checkPositionThrottled);
    window.removeEventListener('resize', this.checkPositionThrottled);
  },

  toggleClass: function toggleClass() {
    this.$el.className = (this.isShown) ? this.showClassName : this.hideClassName ;
  },

  checkForVisChange: function checkForVisChange() {
    if(this.shouldBeShown == this.isShown) return;
    this.onToggle();
  },

  checkPosition: function checkPosition() {
    const windowTop = window.pageYOffset || document.documentElement.scrollTop;
    this.shouldBeShown = (windowTop > this.targetOffset);
  },

  checkForThrottle: function checkForThrottle() {
    this.isEnabled = this.isEnabled && !!throttle;
    !this.isEnabled && console.log('umm I need a throttle');
  },

  checkForEl: function checkForEl() {
    this.$el = document.querySelector(this.elSelector);
    this.isEnabled = this.isEnabled && !!this.$el;
    !this.isEnabled && console.log('umm I need some DOM');
  },

  after: function after (method, fn) {
    const oldMethod = this[method];
    this[method] = function() {
      oldMethod.apply(this, arguments);
      fn.apply(this, arguments);
    }
  }
}

export default SpHelloBar;
