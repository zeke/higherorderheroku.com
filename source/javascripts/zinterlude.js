// This file's name starts with a 'z' because middleman combines JS files in alphabetical order.
// Interlude relies on jQuery, so it must come last.

$(function() {
  $("a[href*='interlude.herokuapp']").map(function() {
    var a = $(this)
    var url = $(this).attr('title')
    var interlude_url = "https://interlude.herokuapp.com/get?url="+url;
    $.getJSON(interlude_url, function(data) {
      a.prepend("<span>" + data.count + "</span>")
    });
  });
});