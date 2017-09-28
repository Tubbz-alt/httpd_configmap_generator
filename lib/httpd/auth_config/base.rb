require 'pathname'

module Httpd
  module AuthConfig
    class Base
      attr_accessor :opts
      attr_accessor :realm
      attr_accessor :domain
      def initialize(opts = {})
        @opts = opts
        @realm = @domain = nil
      end

      def realm
        domain.upcase
      end

      def domain
        opts[:host].gsub(/^([^.]+\.)/, '') if opts[:host].present? && opts[:host].include?('.')
      end

      def template_directory
        @template_directory ||= begin
          Pathname.new(Bundler.locked_gems.specs.select { |g| g.name == "httpd-authconfig" }.first.gem_dir).join("templates")
        end
      end
    end
  end
end