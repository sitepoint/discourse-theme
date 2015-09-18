
// taken from
//
// Underscore.js 1.5.2
// http://underscorejs.org
// (c) 2009-2013 Jeremy Ashkenas, DocumentCloud and Investigative Reporters & Editors
// Underscore may be freely distributed under the MIT license.
//
// Returns a function, that, when invoked, will only be triggered at most once
// during a given window of time.
export default function(func, wait) {
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
}
