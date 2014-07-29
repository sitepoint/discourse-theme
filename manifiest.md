# Things that are broken
- [x] Cant get to a categories posts.... wtf?
- [ ] On categories page, rows have half of a colored border on the bottom
- [ ] All Categories dropdown, padding on pills

# Manifest of Theme changes to check on version bump

## assets/stylesheets/common/base/discourse.scss
- [x] 3px Red border on left of blockquote

## assets/stylesheets/common/base/header.scss

> This is the header that is on every page

- [x] Crawler links are there but not displayed
- [x] Dark Header
- [x] Proper padding on header
- [x] Logo is floated left
- [x] Post title (.extra-info-wrapper) sits to the right of logo
- [x] Username is white and is visually centered with links

## assets/stylesheets/common/base/topic-list.scss

> This is on the categories page

- [x] On All Categories dropdown, no border to left of caret
- [x] On All Categories dropdown, caret faces down not right
- [x] the same caret only takes up a little bit of space
- [ ] Categories in dropdown have margin around them
- [x] Categories in dropdown have roudned corners
- [ ] list of categories, there should be a 1px border $grey-lighter-SP on the bottom of each category row
- [x] All Categories dropdown needs a 1px border around it
- [x] All Categories dropdown needs rounded corners to match the menu



## assets/stylesheets/common/base/topic-post.scss

> This is on the actual discourse post

- [x] links in the names row get that tertiary grey color
- [x] Admin names get their special color
- [x] TeamLeaders get their special color
- [x] Advisors get their special color
- [x] Mentors get their special color
