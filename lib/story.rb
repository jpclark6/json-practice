require 'date'

class Story
  attr_reader :section, :subsection, :title, :abstract, :link, :published, :photo

  def initialize(params)
    @section = params[:section]
    @subsection = params[:subsection]
    @title = params[:title]
    @abstract = params[:abstract]
    @link = params[:link]
    @published = params[:published]
    @photo = params[:photo]
  end

  def self.parse_json(json)
    story_array = []
    json["results"].each do |result|
      section = result["section"]
      subsection = result["subsection"]
      title = result["title"]
      abstract = result["abstract"]
      link = result["url"]
      published = parse_date(result["published_date"])
      photo = get_photo(result["multimedia"])
      params = {
        section: section,
        subsection: subsection,
        title: title,
        abstract: abstract,
        link: link,
        published: published,
        photo: photo
      }
      story_array << Story.new(params)
    end
    story_array
  end

  def self.get_photo(result)
    result.each do |photo|
      if photo["format"] == "Normal"
        return photo["url"]
      end
    end
    "No photo available"
  end

  def self.parse_date(date)
    Date.parse(date).strftime('%B %d, %Y')
  end
end


