

after_initialize do
  module SitepointDesign
    class Engine < ::Rails::Engine
      engine_name "sitepoint_design"
      isolate_namespace SitepointDesign
    end


    Rails.application.config.assets.paths.unshift File.expand_path('../assets', __FILE__)
  end

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

register_asset "javascripts/discourse/components/categorydrop_component.js"
register_asset "javascripts/discourse/templates/discovery/topics.js.handlebars"

register_asset "stylesheets/common/foundation/variables.scss"
register_asset "stylesheets/common/components/badges.css.scss"
register_asset "stylesheets/sitepoint/typography.scss"


