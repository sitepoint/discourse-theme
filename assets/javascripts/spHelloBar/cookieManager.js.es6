const EXPIRE_DAYS = 14;

export function checkForCookie () {
  // if jQuery Cookie is available, we may have disabled ourselves for the number of days set in EXPIRE_DAYS if user manually closed the bar
  if (typeof($)!='undefined' && $.cookie && $.cookie('SpHelloBarDisabled')) {
    this.isEnabled = false;
  }
}

export function setCookie () {
  typeof($)!='undefined' && $.cookie && $.cookie('SpHelloBarDisabled', 'truthy', {
    path: '/',
    expires: EXPIRE_DAYS
  });
}
