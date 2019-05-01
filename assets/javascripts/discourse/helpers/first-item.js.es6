export function firstItem(params, options) {
  const [index, total] = params;
  return index === 0;
}

export default Ember.Helper.helper(firstItem);


