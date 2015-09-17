export default function (cb) {
  const host = (window.location.host == 'discourse.vm') ? 'blog.vm' : 'www.sitepoint.com';

  $.ajax({
    type: 'POST',
    url: `http://${host}/wp-admin/admin-ajax.php`,
    data: {
      action: 'get_forums_random_hello_bar',
      rand: Math.random()
    },
    success: function(data, textStatus, XMLHttpRequest) {
      $("body").prepend(data);
      cb();
    }
  });
}
