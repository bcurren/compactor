class Object
  def blank?; respond_to?(:empty?) ? empty? : !self; end
end

class Date
  def self.parse_to_us_format(date)
    if date.is_a? String
      if date.include?('-')
        date = Date.strptime(date, "%Y-%m-%d")
      else
        date = Date.strptime(date, "%m/%d/%Y")
      end
    end
    date.strftime("%m/%d/%y")
  end
end

module Nokogiri
  class MissingElement < ::StandardError; end

  module XML
    class Node
      def search!(selector)
        result = search(selector)
        if result.blank?
          fail MissingElement.new("No elements for [#{selector}]")
        end
        result
      end
    end
  end
end

class Mechanize::Page
  def_delegator :parser, :search!, :search!
end