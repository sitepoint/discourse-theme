# Upstream version that this theme is based (change this with each update):
# 0fc4c47927bb1de722445bc87e322d3f9fdd0425
# 29 April 2014 11:26:51 am AEST

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

# Templates
register_asset "javascripts/discourse/templates/discovery/topics.js.handlebars" # SP customization: category page - topic heading row titles (icons instead of text)

register_asset "javascripts/discourse/templates/header.js.handlebars" # SP customization: custom header

register_asset "javascripts/discourse/templates/navigation/default.js.handlebars" # SP customization: /latest page: add btn-primary class to the "+ Create Topic" button to easily achieve our coloring
register_asset "javascripts/discourse/templates/navigation/categories.js.handlebars" # SP customization: ALL CATEGORIES page: add btn-primary class to the "+ Create Category" button to easily achieve our coloring
register_asset "javascripts/discourse/templates/navigation/category.js.handlebars" # SP customization: STANDARD CATEGORY page: add btn-primary class to the "+ Create Topic" button to easily achieve our coloring


# Views
register_asset "javascripts/discourse/views/post_menu_view.js" # SP customization: post page: add 'btn' class to the Show Replies and Reply buttons


# Stylesheets
register_asset("stylesheets/common/foundation/variables.scss", :variables)
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
