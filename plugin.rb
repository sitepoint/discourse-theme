# Upstream version that this theme is based (change this with each update):
# 49dbb992adf5d5d8f4b625e1788b85e5c3cfcd6b
# 26 March 2014 1:22:04 pm AEDT

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

# TODO: this file needs to be loaded instead of app/assets/stylesheets/common/foundation/variables.scss
# register_asset "stylesheets/common/foundation/variables.scss"

# register_asset "javascripts/admin/templates/site_settings.js.handlebars" # doesn't work, but probably not needed (Admin section)
register_asset "javascripts/discourse/components/categorydrop_component.js" # ok
register_asset "javascripts/discourse/components/sortable_heading_component.js" # ok
register_asset "javascripts/discourse/templates/discovery/topics.js.handlebars" # ok
register_asset "javascripts/discourse/templates/group.js.handlebars" # not tested
register_asset "javascripts/discourse/templates/header.js.handlebars" # ok
register_asset "javascripts/discourse/templates/post.js.handlebars" # ok
register_asset "javascripts/discourse/templates/list/topic_list_item.js.handlebars" # ok
register_asset "javascripts/discourse/templates/navigation/categories.js.handlebars" # ok
register_asset "javascripts/discourse/templates/navigation/category.js.handlebars" # ok
register_asset "javascripts/discourse/templates/navigation/default.js.handlebars" # not tested (where is it?)
register_asset "javascripts/discourse/templates/topic.js.handlebars" # ok
register_asset "javascripts/discourse/templates/user/user.js.handlebars" # ok
register_asset "javascripts/discourse/views/post_menu_view.js" # ok
register_asset "javascripts/discourse/views/post_view.js" # ok
register_asset "javascripts/discourse/views/activity_filter_view.js" # ok

register_asset "stylesheets/common/components/badges.css.scss"
register_asset "stylesheets/common/components/buttons.scss"
register_asset "stylesheets/common/components/navs.scss"
register_asset "stylesheets/desktop/compose.scss"
register_asset "stylesheets/desktop/discourse.scss"
register_asset "stylesheets/desktop/header.scss" # e.g. this is being loaded too early, causing header color to be overridden by default header.scss
register_asset "stylesheets/desktop/topic-list.scss"
register_asset "stylesheets/desktop/topic-post.scss"
register_asset "stylesheets/desktop/topic.scss"
register_asset "stylesheets/desktop/user.scss"

register_asset "stylesheets/sitepoint/typography.scss"



# // $base-font-family: "Times", "Helvetica Neue", Helvetica, Arial, sans-serif;

# // // OUR VARS ONLY:

# // SP-specific uncategorized vars
# $border-radius-default-SP: 3px;
# $font-weight-medium-bold-SP: 500;


# // Primary color variables

# $gray-lighter-SP: #d9d9d9; // used also for borders
# $gray-light-SP: #929292;
# $gray-sitepoint-header-bg-SP: #3A3A3A;
# $gray-sitepoint-header-SP: #ADADAD;
# $gray-text-SP: #6d6d6d;
# $gray-bg-SP: #f5f5f5; // used for gray backgrounds

# $blue-SP: #0582b6; // hex from Pete (used for links etc.)

# $red-SP: #ec5645;

# $green-SP: #25c65e;


# // Primary button
# $btn-primary-border-color: $red-SP !default;
# $btn-primary-background-color: $red-SP !default;
# $btn-primary-background-color-dark: darken($red-SP, 10%) !default;
# $btn-primary-background-color-light: lighten($red-SP, 10%) !default;

# // Pill nav

# $nav-pills-color: $gray-text-SP;

# $nav-pills-background-color-active: $red-SP;

# // Stacked nav

# $nav-stacked-color: $gray-text-SP;

# $nav-stacked-background-color-active: $red-SP;



# // Broad general variables

# $primary_border_color: $gray-lighter-SP;

# $link_color:  $blue-SP;

# $link-color-visited: darken($blue-SP, 10%);
# $link-color-hover: darken($blue-SP, 10%);
# $link-color-active: darken($blue-SP, 10%);


# @import "desktop";


# body {
#     // background-color: #00aff0;
# }
