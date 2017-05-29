module LinkAgregator
  class Destroyer
    include Utils

    def initialize(args = {})
      @id = args[:id]
    end

    def call
      link = Link.find_by(id: @id)
      return error_hash(:link) if link.nil?
      tags = link.tags.to_a

      link.destroy
      tags.each { |tag| tag.destroy if tag.should_be_destroyed? }

      success_hash
    end
  end
end
