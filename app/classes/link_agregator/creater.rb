module LinkAgregator
  class Creater
    include Utils

    def initialize(args = {})
      @url = args[:url]
      @description = args[:description]
      @tags = args[:tags]
    end

    def call
      [:url, :description, :tags].each { |arg|
        return error_hash(arg) unless valid_arg?(arg)
      }

      ActiveRecord::Base.transaction do
        link = Link.new(description: @description, url: @url)
        split_tags(@tags).each { |tag|
          link.add_tag(Tag.find_or_create_by!(name: tag))
        }
        link.save!
      end

      success_hash
    end

    private

    def valid_arg?(arg)
      arg = instance_variable_get("@#{arg}")
      true unless arg == nil || arg.empty?
    end
  end
end
