require 'nokogiri'
require 'open-uri'
require_relative "amazon-review/review"

module AmazonReview

  def self.find_reviews(asin)
    reviews = []
    delay = 0.5
    page = 1
    url = "http://www.amazon.co.jp/product-reviews/#{asin}/?ie=UTF8&showViewpoints=0&pageNumber=#{page}&sortBy=bySubmissionDateAscending"
    html = open(url, "r:CP932").read.encode("UTF-8")
    doc = Nokogiri::HTML.parse(html)
    # parse each review
    new_reviews = 0
    doc.css("#productReviews td > a[name]").each do |review_html|
      reviews << Review.new(review_html)
      new_reviews += 1
    end
    reviews
  end

end
