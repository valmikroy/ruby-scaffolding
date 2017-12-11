# frozen_string_literal: true

require 'thor'
require 'thor/group'

require 'scaffold'

module Scaffold
  module Generator
    class MicroService < Thor::Group
      include Thor::Actions

      namespace :microservice

      argument :name,
               banner: 'NAME',
               desc: 'The name of grape on rack microservice',
               type: :string,
               required: true

      class_option :path,
                   banner: 'PATH',
                   aliases: '-p',
                   desc: 'The path to create the microservice project',
                   type: :string,
                   default: '../'

      class << self
        def source_root
          File.join(Scaffold.source_root, 'templates/microservice')
        end
      end

      def create_files

        wrap_template('app/app.rb')
        wrap_template('app/api.rb')

        wrap_template('config/environment.rb')
        wrap_copy_file('config/application.rb')

        wrap_template('spec/spec_helper.rb')
        wrap_template('spec/api/sample_spec.rb')
        wrap_copy_file('spec/integration/sample_spec.rb')

        wrap_template('api/v1.rb')
        wrap_template('api/v2.rb')
        wrap_template('api/health.rb')
        wrap_template('api/ns1/v1/ns1.rb')
        wrap_template('api/ns1/v1/ns2/ns21.rb')
        wrap_template('api/ns1/v1/ns2/ns22.rb')
        wrap_template('api/ns1/v2/ns1.rb')
        wrap_template('api/ns1/v2/ns2/ns21.rb')
        wrap_template('api/ns1/v2/ns2/ns22.rb')

        wrap_template('Rakefile')
        wrap_template('Dockerfile')
        wrap_template('config.ru')
        wrap_copy_file('Gemfile')

        copy_file("#{Scaffold.source_root}/resources/LICENSE", "#{target_path}/LICENSE")

      end

      private

      def wrap_copy_file(path)
        copy_file("#{MicroService.source_root}/#{path}","#{target_path}/#{path}")
      end

      def wrap_template(path)
        template("#{path}.erb", "#{target_path}/#{path}", template_options )
      end

      def target_path
        @target_path ||= File.join(File.expand_path(@options[:path]), "rubymicroservice-#{name}")
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
