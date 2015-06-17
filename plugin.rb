# name: discourse-theme
# about: sitepoint.com/forum theme
# authors: Jude Aakjaer, Jamison Bjorkman, Kelle-Lee Connolly

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

  # SP customisation: add SiteCustomization to add in crawler links
  header = <<-EOS.strip_heredoc.chomp
    <noscript>
      <a href="http://www.sitepoint.com">Articles</a>
      <a href="https://learnable.com/topics/all/book">Books</a>
      <a href="https://learnable.com/topics/all/course">Courses</a>
    </noscript>
    EOS

  head_tag = <<-EOS.strip_heredoc.chomp
    <style>
      ._fancybar {
        margin-top: 63px !important;
        z-index: 900 !important;
      }
    </style>
    <script async type="text/javascript"
      src="//cdn.fancybar.net/ac/fancybar.v2.js"
      id="_fancybar_js"
      data-bsa-format='[["fancybar","C6ADVKE","200"],["flyout","C67IVK3L","800"]]'
      data-bsa-placement="sitepointforums"></script>
    EOS

  if User.exists?
    sitepoint_site_customization = SiteCustomization.find_or_create_by({
      name: "SitePoint Crawler links",
      header: header,
      mobile_header: header,
      enabled: true,
      user_id: User.first.id,
      head_tag: head_tag
    })
    # cleanup old customizations
    SiteCustomization.where(name: sitepoint_site_customization.name).
      where.not(id: sitepoint_site_customization.id).
      delete_all
  end
end


## Styles
#  Variables
register_asset("stylesheets/common/foundation/variables.scss", :variables)
#  Media-queried rules for fontsizes
#  NOTE: Helps reduce the line count in module stylesheets
#        Helps keep number of different sizes in check
register_asset "stylesheets/sitepoint/typography.scss"
#  Make badges wide by default
#  Change category dropdown caret style
#  Don't display parent category
#  Unread count notification color
register_asset "stylesheets/common/components/badges.css.scss"
#  Buttons default radius
#  Background color of primary button from blue to red
register_asset "stylesheets/common/components/buttons.scss"


#### Navigation
#  Add "FAQ" to Main Navigation
register_custom_html(extraNavItem: "<li id='faq-menu-item'><a href='/faq'>FAQ</a></li>")
#  pill nav Styles and stacked nav (user/group profile page)
#  rounded corners
#  bordered passive state
#  red bg borderless active state
#  custom carets etc
register_asset "stylesheets/common/components/navs.scss"
#  Mobile version of ^^^
#  visually ungroup so that pills can wrap to next line in a visually attractive way.
#  NOTE: AS OF 20140701 THIS FILE HAS NO VENDOR FILE EQUIVALENT
register_asset "stylesheets/mobile/components/navs.scss", :mobile


#### Topic Composer
#  Custom caret symbols
register_asset "stylesheets/desktop/compose.scss", :desktop
#  Mobile fix: compose panel overflow on phones running Chrome
#  Only needed until we pull in a Discourse version with https://github.com/discourse/discourse/pull/2515 already integrated
register_asset "stylesheets/mobile/compose.scss", :mobile


#### Custom Header
register_asset "javascripts/discourse/templates/header.hbs"
#  item colors
#  reset of badges back to inline display in hamburger menu
register_asset "stylesheets/common/base/header.scss"
#  expand header to full viewport width
#  styling of custom links and logo
register_asset "stylesheets/desktop/header.scss", :desktop
#  reduced paddings and icon widths
#  SP site links hidden
register_asset "stylesheets/mobile/header.scss", :mobile


#### Categories Page Table [http://discourse.vim]
#  Add "btn-primary class to "Create Topic" button
register_asset "javascripts/discourse/templates/navigation/categories.hbs"
#  pill nav style
#  Table Styles
#  "All Categories" dropdown
register_asset "stylesheets/common/base/topic-list.scss"
#  remove leaked THEAD from override template
#  tweak margins
register_asset "stylesheets/mobile/topic-list.scss", :mobile


#### Category Topics Page Table [http://discourse.vm/category/community]
#  Add "btn-primary" class to "Create Topic" button
register_asset "javascripts/discourse/templates/navigation/category.hbs"
register_asset "javascripts/discourse/templates/navigation/default.hbs"
#  navigation style
#  category badges
#  row background colors
#  carets
#  latest poster avatar highlight style
register_asset "stylesheets/desktop/topic-list.scss", :desktop


#### Search Results
# Move show more links to the top of each search results section [http://community.sitepoint.com/t/search-menu-read-more-link/96632/7]
register_asset "javascripts/discourse/templates/search.hbs"


#### Topic Page [http://discourse.vim/t/feedbacks-on-the-imported-data/192]
#  Add post number to topic-meta-data
register_asset "javascripts/discourse/templates/post.hbs"
#  quoted post - left border color (on mobile, the border next to the name has to be overidden again...)
register_asset "stylesheets/common/base/discourse.scss"
#  Hard corners and no default border on avatars
register_asset "stylesheets/desktop/discourse.scss", :desktop
#  metadata area
#  increase font size
#  change color of poster's username to blue
#  ensure consistent vertical spacing betweet topic header and contents
register_asset "stylesheets/common/base/topic-post.scss"
#  custom styling of a topic page (container sizes, opacities, colors, icon glyphs etc.)
register_asset "stylesheets/desktop/topic-post.scss", :desktop
#  quoted post top part of left border color
register_asset "stylesheets/mobile/topic-post.scss", :mobile
#  title vs badge vert. alignment,
#  progress indicator styling,
#  post gutter ("Reply as new topic" etc. buttons) repositioning,
register_asset "stylesheets/desktop/topic.scss", :desktop

#### User/Group Profile
#  font for staff-counters
register_asset "stylesheets/desktop/user.scss", :desktop


#### Component: PM Button
#  NOTE: [JB] some serious round robin shit going on here. serious wtf...
#  Pull in pm button plugin as the plugin overwrites a template we previously have overwritten as well
register_asset("javascripts/pm_button.js", :client_side)

#### Component: Discourse Banner
#  Banner should not be sticky
register_asset "javascripts/discourse/templates/components/discourse-banner.js.handlebars"
register_asset "stylesheets/common/components/banner.css.scss"


#### ADMIN
#### ADMIN
#### ADMIN

#### Admin/Users
#  Include IP in user list
register_asset "javascripts/admin/templates/users_list.js.handlebars"

#### Topic Page [http://discourse.vm/t/feedbacks-on-the-imported-data/192]
#  Add 'btn' class to the show Replies and Reply buttons (rounded corners)
#  Change "Show Replies" expand/contract icons from chevrons to carets
register_asset "javascripts/discourse/views/post_menu.js"
