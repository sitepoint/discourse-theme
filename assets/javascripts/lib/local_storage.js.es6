export var CAN_LOCAL_STORAGE = !!(window && window.localStorage);

export function set(key, value) {
  if (CAN_LOCAL_STORAGE) window.localStorage.setItem(`SP_${ key }`, value);
}

export function get(key) {
  if (CAN_LOCAL_STORAGE) return window.localStorage.getItem(`SP_${ key }`);
  return undefined;
}

export function remove(key) {
  if (CAN_LOCAL_STORAGE) return window.localStorage.removeItem(`SP_${ key }`);
}

export default {
  CAN_LOCAL_STORAGE,
  set,
  get,
  remove
};
