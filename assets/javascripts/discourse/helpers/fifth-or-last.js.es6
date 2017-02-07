export function fifthOrLast(index, total, options) {
  return index === 4 || (index < 4 && index + 1 === total);
}

export default Ember.Helper.helper(fifthOrLast);
