export default {
  name: 'discourse-theme',
  initialize() {

    Ember.Handlebars.helper('fifthOrLast', function(index, total, options) {
      return index === 4 || (index < 4 && index + 1 === total);
    });

  }
};
