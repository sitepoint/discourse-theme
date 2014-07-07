# Upstream version that this theme is based on (change this with each update):
# tag v0.9.9.10
# e66c7f81a36078606a66c45519e96d5f61ee44d6
# 20 June 2014 12:18:58 am AEST

# When styles are not working or are not updating, try:
# - stopping server
# - sitepoint/discourse rm -rf tmp
# - delete sitepoint/discourse/public/uploads/stylesheet-cache
# - restart server
# If styles are still not updating, there is probably a syntax error in the SCSS causing a silent failure and causing the file not being processed.
# To be 100% sure you can also enable Chrome Dev Tools -> Settings -> General -> Disable cache (while DevTools is open), but note it leads to 30s onload times.

after_initialize do

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


# SP customization: add FAQ link to navs
register_custom_html(extraNavItem: "<li id='faq-menu-item'><a href='/faq'>FAQ</a></li>")



### Models ###

# SP customization: categories list page (http://discourse.vm): don't display featured_users avatars next to the category name in the table
register_asset "javascripts/discourse/models/category_list.js"



### Templates ###

# SP customisation: topic list row. put in tags
register_asset "javascripts/discourse/templates/list/topic_list_item.js.handlebars"

# SP customization: category page (http://discourse.vm/category/community): topics table heading - use icons instead of text
register_asset "javascripts/discourse/templates/discovery/topics.js.handlebars"
# DOES NOTHING (attempt 1:1 copy of the default mobile template to re-override the desktop template above for Mobile View)
# register_asset "javascripts/discourse/templates/mobile/discovery/topics.js.handlebars"

# SP customization: custom header
register_asset "javascripts/discourse/templates/header.js.handlebars"

# SP customization: /latest page (http://discourse.vm/latest): add btn-primary class to the "+ Create Topic" button to easily achieve our coloring
register_asset "javascripts/discourse/templates/navigation/default.js.handlebars"

# SP customization: ALL CATEGORIES page (http://discourse.vm): add btn-primary class to the "+ Create Category" button to easily achieve our coloring
register_asset "javascripts/discourse/templates/navigation/categories.js.handlebars"

# SP customization: STANDARD CATEGORY page (http://discourse.vm/category/community): add btn-primary class to the "+ Create Topic" button to easily achieve our coloring
register_asset "javascripts/discourse/templates/navigation/category.js.handlebars"

# SP customization: topic page (http://discourse.vm/t/feedbacks-on-the-imported-data/192): add post number to topic-meta-data
register_asset "javascripts/discourse/templates/post.js.handlebars"

# SP customization: topic page (http://discourse.vm/t/feedbacks-on-the-imported-data/192): reorder topic-map so that headings are at the top like they used to be before 20140530
register_asset "javascripts/discourse/templates/components/topic-map.js.handlebars"

### Templates - admin ###

# SP customization: Admin/Users page (http://discourse.vm/admin/users/list/active) include IP in user list
register_asset "javascripts/admin/templates/users_list.js.handlebars"



### Views ###

# SP customization: topic page (http://discourse.vm/t/feedbacks-on-the-imported-data/192):
# add 'btn' class to the Show Replies and Reply buttons (to achieve e.g. rounded corners), change Show Replies expand/contract icons from chevron to caret
register_asset "javascripts/discourse/views/post_menu.js"
# register_asset "javascripts/discourse/views/post_menu.js.es6"
# ^^^ ES6-style not working yet (Discourse.PostMenuView = require('discourse/plugins//discourse/views/post_menu').default; in transpiled file says cannot read prop default of undefined)



### Stylesheets ###

# SP-specific variables
register_asset("stylesheets/common/foundation/variables.scss", :variables)

# media-queried rules for fontsizes [helps reduce the line count in module stylesheets, helps keep the number of different sizes in check]
register_asset "stylesheets/sitepoint/typography.scss"


# make badges wide by default, change category dropdown caret style, don't display parent category, unread count notification color etc.
register_asset "stylesheets/common/components/badges.css.scss"

# default radius, background color of primary button from blue to red
register_asset "stylesheets/common/components/buttons.scss"

# pill nav (categories page) and stacked nav (user/group profile page) with rounded corners, bordered passive state and red bg borderless active state, custom carets etc.
register_asset "stylesheets/common/components/navs.scss"
# mobile: pill nav - visually ungroup so that pills can wrap to next line in a visually attractive way. AS OF 20140701 THIS FILE HAS NO VENDOR FILE EQUIVALENT
register_asset "stylesheets/mobile/components/navs.scss", :mobile

# reply pane that slides up to compose message on topic page: custom caret symbols
register_asset "stylesheets/desktop/compose.scss", :desktop
# mobile: hot fix compose panel overflow on phones running Chrome until we pull in a Discourse version with https://github.com/discourse/discourse/pull/2515 already integrated
register_asset "stylesheets/mobile/compose.scss", :mobile

# topic page - quoted post - left border color (on mobile, the border next to the name has to be overidden again...)
register_asset "stylesheets/common/base/discourse.scss"
# desktop: hard corners and no default border on avatars
register_asset "stylesheets/desktop/discourse.scss", :desktop

# header: shared styles for item colors and reset of badges back to inline display in hamburger menu
register_asset "stylesheets/common/base/header.scss"
# header: desktop - expand header to full viewport width, styling of custom links and logo
register_asset "stylesheets/desktop/header.scss", :desktop
# header: mobile - reduced paddings and icon widths, SP site links hidden
register_asset "stylesheets/mobile/header.scss", :mobile

# shared-styles for category page and categories page - pill nav style
register_asset "stylesheets/common/base/topic-list.scss"
# desktop: navigation style, category badges, row background colors, carets, latest poster avatar highlight style etc.
register_asset "stylesheets/desktop/topic-list.scss", :desktop
# mobile: remove leaked THEAD from override template, tweak margins
register_asset "stylesheets/mobile/topic-list.scss", :mobile

# in post metadata area, increase font size and change color of poster's username to blue, ensure consistent vertical spacing betweet topic header and contents
register_asset "stylesheets/common/base/topic-post.scss"
# custom styling of a topic page (container sizes, opacities, colors, icon glyphs etc.)
register_asset "stylesheets/desktop/topic-post.scss", :desktop
# mobile - topic page: quoted post top part of left border color
register_asset "stylesheets/mobile/topic-post.scss", :mobile

# topic page title vs badge vert. alignment, progress indicator styling, post gutter ("Reply as new topic" etc. buttons) repositioning,
register_asset "stylesheets/desktop/topic.scss", :desktop

# shared: user profile and group profile pages: font and background colors
register_asset "stylesheets/common/base/user.scss"
# desktop: user profile and group profile pages: custom user info panel two-column layout and posts-list layout
register_asset "stylesheets/desktop/user.scss", :desktop
