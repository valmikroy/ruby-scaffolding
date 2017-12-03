# frozen_string_literal: true

require 'thor'
require 'thor/group'

require 'scaffold'

module Scaffold
  module Generator
    class Simplecli < Thor::Group
      include Thor::Actions

      namespace :simplecli

      argument :name,
               banner: 'NAME',
               desc: 'The name of cli utility',
               type: :string,
               required: true

      class_option :path,
                   banner: 'PATH',
                   aliases: '-p',
                   desc: 'The path to create the Omnibus project',
                   type: :string,
                   default: '.'

      class << self
        def source_root
          File.join(Scaffold.source_root, 'templates/simplecli')
        end
      end

      def create_files
        template('bin/name.rb.erb', "#{target_path}/bin/#{snake_name}.rb", template_options)
        File.chmod(0o755, "#{target_path}/bin/#{snake_name}.rb")

        template('spec/spec_helper.rb.erb', "#{target_path}/spec/spec_helper.rb", template_options)
        template('spec/name_spec.rb.erb', "#{target_path}/spec/#{snake_name}_spec.rb", template_options)

        copy_file("#{Simplecli.source_root}/Gemfile", "#{target_path}/Gemfile")
        copy_file("#{Simplecli.source_root}/gitignore", "#{target_path}/.gitignore")
        copy_file("#{Simplecli.source_root}/rubocop.yml", "#{target_path}/.rubocop.yml")
        create_file("#{target_path}/.rubocop_todo.yml")
        copy_file("#{Simplecli.source_root}/Rakefile", "#{target_path}/Rakefile")

        copy_file("#{Scaffold.source_root}/resources/LICENSE", "#{target_path}/LICENSE")
      end

      private

      def target_path
        @target_path ||= File.join(File.expand_path(@options[:path]), "rubycli-#{name}")
      end

      def template_options
        @template_options ||= { name: name }
      end

      def resource_path(*args)
        Scaffold.source_root.join('resources', *args).to_s
      end

      def name_components
        @_name_components ||= name.scan(/[[:alnum:]]+/)
      end

      def snake_name
        @_snake_name ||= name_components.map(&:downcase).join('_')
      end

      def camel_name
        @_camel_name ||= name_components.map(&:capitalize).join('')
      end
    end
  end
end
