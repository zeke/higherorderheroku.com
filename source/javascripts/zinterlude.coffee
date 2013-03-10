# This file's name starts with a 'z' because middleman combines JS files in alphabetical order.
# Interlude relies on jQuery, so it must come last.

class @Interlude

  @base: "https://interlude.herokuapp.com"

  @get: (url, action="redirect", cb) ->
    $.getJSON "#{@base}/get?url=#{url}&action=#{action}", (data) ->
      cb(data)

  @set: (url, action="redirect", cb) ->
    $.getJSON "#{@base}/set?url=#{url}&action=#{action}", (data) ->
      cb(data)

  @hijackLinks : (linkSelector="a") ->
    for link in document.querySelectorAll(linkSelector)
      # Save the original url for later reference
      link.setAttribute("data-original-href", link.getAttribute("href"))
      link.setAttribute("href", @base + "/set?url=" + link.getAttribute("href"))

  @getRedirectCounts: (linkSelector="a", action) ->
    for link in document.querySelectorAll(linkSelector)

      # TODO: default to href if data-original-href is not present

      @get link.getAttribute('data-original-href'), action, (data) ->
        l = document.querySelector("a[data-original-href='#{data.url}']")
        l.setAttribute("data-count", data.count) if l

$ ->
  Interlude.hijackLinks ("h1.link > a")
  Interlude.getRedirectCounts("h1.link > a", "redirect")