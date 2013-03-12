class @Increment

  @base: "http://increment.io"

  @get: (url, action="redirect", cb) ->
    $.getJSON "#{@base}/get?url=#{url}&action=#{action}", (data) ->
      cb(data)

  @hijackLinks: (linkSelector="a") ->
    for link in document.querySelectorAll(linkSelector)
      @preserveLinkUrl(link)
      @hijackLink(link)

  @getCounts: (linkSelector="a", action="redirect") ->
    for link in document.querySelectorAll(linkSelector)
      @preserveLinkUrl(link)
      @get link.getAttribute('data-original-href'), action, (data) ->
        # Refind the link because we lost its scope in the asynchronicity..
        l = document.querySelector("a[data-original-href='#{data.url}']")
        l.setAttribute("data-count", data.count) if l

  # Save the link's original URL in a data attribute
  @preserveLinkUrl: (link) ->
    unless link.getAttribute("data-original-href")
      link.setAttribute("data-original-href", link.getAttribute("href"))

  @hijackLink: (link) ->
    link.setAttribute("href", @base + "?url=" + link.getAttribute("href"))

$ ->
  Increment.getCounts "h1.link > a"
  Increment.hijackLinks "h1.link > a"