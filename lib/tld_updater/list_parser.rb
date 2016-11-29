module DomainExtractor
  module TLDUpdater
    class ListParser
      CLEANERS =         [
        :split_lines,
        :remove_comments,
        :remove_empty_lines,
        :clean_stars,
        :rejoin
      ]
      def call(list)
        CLEANERS.inject(list) { |parsed_list, cleaner| self.send(cleaner, parsed_list) }
    end

      private

      def split_lines(list)
        list.split("\n")
      end

      def remove_comments(list)
        list.reject {|line| line.start_with?("//")}
      end

      def remove_empty_lines(list)
        list.reject(&:empty?)
      end

      def clean_stars(list)
        list.map {|line| line.gsub(/^\*\./,'')}
      end

      def rejoin(list)
        list.join("\n")
      end
    end
  end
end
