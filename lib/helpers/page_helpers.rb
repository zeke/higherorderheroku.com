require "uri"

module PageHelpers

  INDEX_LIMIT = 100

  def articles(limit = INDEX_LIMIT)
    @articles ||= date_sort(sitemap.resources.select { |r| r.path.start_with?('articles/') })[0..limit]
  end

  def links(limit = INDEX_LIMIT)
    @links ||= date_sort(data.links)[0..limit]
  end

  def coalesce(col1, col2, limit = INDEX_LIMIT)
    date_sort(col1 + col2)[0..limit]
  end

  def date_sort(col)
    col.sort { |a, b| Date.parse(b.data['date']) <=> Date.parse(a.data['date'])}
  end

  def link_entry?(article_or_link)
    article_or_link.data.key?('url')
  end

end