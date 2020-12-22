# name: discourse-sitepoint
# about: sitepoint.com/forum theme
# authors: Jude Aakjaer, James Hunter, Kelle-Lee Connolly
# version: 0.1.0

# When styles are not working or are not updating, try:
# - stopping server
# - sitepoint/discourse rm -rf tmp
# - delete sitepoint/discourse/public/uploads/stylesheet-cache
# - restart server
# If styles are still not updating, there is probably a syntax error in the SCSS causing a silent failure and causing the file not being processed.
# To be 100% sure you can also enable Chrome Dev Tools -> Settings -> General -> Disable cache (while DevTools is open), but note it leads to 30s onload times.

after_initialize do

  # Add custom fields to the admin user serializer
  add_to_serializer(:admin_detailed_user, :custom_fields) { object.custom_fields }

  # Track log-out timestamps
  DiscourseEvent.on(:user_logged_out) do |user|
    user.custom_fields["last_logged_out_at"] = Time.now
    user.save
  end

  module SitepointDesign
    class Engine < ::Rails::Engine
      engine_name "sitepoint_design"
      isolate_namespace SitepointDesign
    end

    Rails.application.config.assets.paths.unshift File.expand_path('../assets', __FILE__)
  end

  # app/models/topic_posters_summary.rb
  TopicPostersSummary.class_eval do
    def user_ids_with_descriptions
      user_ids.zip([
        :original_poster,
        :most_recent_poster
      ].map { |description| I18n.t(description) })
    end

    def top_posters
      user_ids.map { |id| user_lookup[id] }.compact.uniq.take(2)
    end
  end
end

register_asset "stylesheets/sitepoint-mobile.scss", :mobile
register_asset "stylesheets/sitepoint-desktop.scss", :desktop
