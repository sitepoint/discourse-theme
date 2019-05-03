# name: discourse-theme
# about: sitepoint.com/forum theme
# authors: Jude Aakjaer, James Hunter, Kelle-Lee Connolly

# When styles are not working or are not updating, try:
# - stopping server
# - sitepoint/discourse rm -rf tmp
# - delete sitepoint/discourse/public/uploads/stylesheet-cache
# - restart server
# If styles are still not updating, there is probably a syntax error in the SCSS causing a silent failure and causing the file not being processed.
# To be 100% sure you can also enable Chrome Dev Tools -> Settings -> General -> Disable cache (while DevTools is open), but note it leads to 30s onload times.

after_initialize do

  # Add custom fields to the admin user serializer
  add_to_serializer(:admin_user, :custom_fields) { object.custom_fields }

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
      user_ids.map { |id| avatar_lookup[id] }.compact.uniq.take(2)
    end
  end

 
end

## Adding To Discourse
register_asset "stylesheets/common/foundation/variables.scss", :variables # other things need these variables

## General Changes
register_asset "stylesheets/common/components/banner.css.scss" # Make the banner grey
register_asset "stylesheets/common/components/badges.css.scss" # category dropdown badges
register_asset "stylesheets/common/components/navs.scss"       # Navigation at top of list pages and to the side of profile pages
register_asset "stylesheets/common/components/buttons.scss"    # Button Colors and radius
register_asset "stylesheets/common/components/Button.scss"     # standard SitePoint style Buttons
register_asset "stylesheets/common/base/bsa.scss"              # BSA outlets
register_asset "stylesheets/common/base/header.scss"           # Custom Header
register_asset "stylesheets/common/base/topic-list.scss"       # Category Page Table
register_asset "stylesheets/common/base/discourse.scss"        # Blockquote styles
register_asset "stylesheets/common/base/topic-post.scss"       # Coloring usernames based on role
register_asset "stylesheets/common/base/category.scss"         # Category Styling

## Desktop Only
register_asset "stylesheets/desktop/header.scss", :desktop     # Links in navbar
register_asset "stylesheets/desktop/topic-post.scss", :desktop # General Post styles
register_asset "stylesheets/desktop/topic.scss", :desktop      # Post Progress meter styles
register_asset "stylesheets/common/base/topic-admin-menu.scss" # yeah i dunno why this is needed but...

## Mobile Only
register_asset "stylesheets/mobile/header.scss", :mobile   # Hide Header links on Mobile
register_asset "stylesheets/mobile/topic-list.scss", :mobile   # Hide Tags from Topic List
