Discourse.CategoryList.reopenClass({

  categoriesFrom: function(result) {
    var categories = Discourse.CategoryList.create(),
        users = Discourse.Model.extractByKey(result.featured_users, Discourse.User),
        list = Discourse.Category.list();

    result.category_list.categories.forEach(function(c) {

      if (c.parent_category_id) {
        c.parentCategory = list.findBy('id', c.parent_category_id);
      }

      if (c.subcategory_ids) {
        c.subcategories = c.subcategory_ids.map(function(scid) { return list.findBy('id', parseInt(scid, 10)); });
      }

      // SP CUSTOMIZATION BEGIN
      // if (c.featured_user_ids) {
      //   c.featured_users = c.featured_user_ids.map(function(u) {
      //     return users[u];
      //   });
      // }
      // SP CUSTOMIZATION END

      if (c.topics) {
        c.topics = c.topics.map(function(t) {
          return Discourse.Topic.create(t);
        });
      }

      categories.pushObject(Discourse.Category.create(c));

    });
    return categories;
  }
});
