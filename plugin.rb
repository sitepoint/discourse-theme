# Upstream version that this theme is based on (change this with each update):
# tag v0.9.9.10
# e66c7f81a36078606a66c45519e96d5f61ee44d6
# 20 June 2014 12:18:58 am AEST

after_initialize do

  module SitepointDesign
    class Engine < ::Rails::Engine
      engine_name "sitepoint_design"
      isolate_namespace SitepointDesign
    end

    Rails.application.config.assets.paths.unshift File.expand_path('../assets', __FILE__)
  end


  # app/models/topic_posters_summary.rb # ok
  TopicPostersSummary.class_eval do
    def user_ids_with_descriptions
      user_ids.zip([
        :original_poster,
        :most_recent_poster
      ].map { |description| I18n.t(description) })
    end

    def top_posters
      user_ids.map { |id| avatar_lookup[id] }.compact.uniq.take(2)
    end
  end

end


### Models ###

# SP customization: categories list page (http://discourse.vm/): don't display featured_users avatars next to the category name in the table
register_asset "javascripts/discourse/models/category_list.js"


### Templates ###

# SP customization: category page (http://discourse.vm/category/community): topics table heading - use icons instead of text
register_asset "javascripts/discourse/templates/discovery/topics.js.handlebars"

register_asset "javascripts/discourse/templates/header.js.handlebars" # SP customization: custom header

# SP customization: /latest page (http://discourse.vm/latest): add btn-primary class to the "+ Create Topic" button to easily achieve our coloring
register_asset "javascripts/discourse/templates/navigation/default.js.handlebars"

register_asset "javascripts/discourse/templates/navigation/categories.js.handlebars" # SP customization: ALL CATEGORIES page: add btn-primary class to the "+ Create Category" button to easily achieve our coloring

# SP customization: STANDARD CATEGORY page (http://discourse.vm/category/community): add btn-primary class to the "+ Create Topic" button to easily achieve our coloring
register_asset "javascripts/discourse/templates/navigation/category.js.handlebars"



### Templates - admin ###
register_asset "javascripts/admin/templates/users_list.js.handlebars" # SP customization: include IP in user list



### Views ###
register_asset "javascripts/discourse/views/post_menu_view.js" # SP customization: post page: add 'btn' class to the Show Replies and Reply buttons



# Stylesheets
register_asset("stylesheets/common/foundation/variables.scss", :variables)
register_asset "stylesheets/common/base/topic-post.scss"
register_asset "stylesheets/common/components/badges.css.scss"
register_asset "stylesheets/common/components/buttons.scss"
register_asset "stylesheets/common/components/navs.scss"
register_asset "stylesheets/desktop/compose.scss"
register_asset "stylesheets/desktop/discourse.scss"
register_asset "stylesheets/desktop/header.scss"
register_asset "stylesheets/desktop/topic-list.scss"
register_asset "stylesheets/desktop/topic-post.scss"
register_asset "stylesheets/desktop/topic.scss"
register_asset "stylesheets/desktop/user.scss"

register_asset "stylesheets/sitepoint/typography.scss"
