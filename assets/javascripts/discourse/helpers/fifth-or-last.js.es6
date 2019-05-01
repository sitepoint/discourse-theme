export function fifthOrLast(params, options) {
  const [index, total] = params;
  return index === 4 || (index < 4 && index + 1 === total);
}

export default Ember.Helper.helper(fifthOrLast);
