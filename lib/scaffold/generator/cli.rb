# frozen_string_literal: true

require 'thor'
require 'thor/group'

require 'scaffold'

module Scaffold
  module Generator
    class Cli < Thor::Group
      include Thor::Actions

      namespace :cli

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
          File.join(Scaffold.source_root, 'templates/cli')
        end
      end

      def create_files
        template('gemspec.rb.erb', "#{target_path}/#{snake_name}.gemspec", template_options)

        template('bin/name.erb', "#{target_path}/bin/#{snake_name}", template_options)
        File.chmod(0o755, "#{target_path}/bin/#{snake_name}")

        template('lib/name.rb.erb', "#{target_path}/lib/#{snake_name}.rb", template_options)
        template('lib/version.rb.erb', "#{target_path}/lib/#{snake_name}/version.rb", template_options)
        template('lib/helper.rb.erb', "#{target_path}/lib/#{snake_name}/helper.rb", template_options)
        template('lib/cli.rb.erb', "#{target_path}/lib/#{snake_name}/cli.rb", template_options)
        template('lib/cli/command.rb.erb', "#{target_path}/lib/#{snake_name}/cli/command.rb", template_options)

        template('spec/spec_helper.rb.erb', "#{target_path}/spec/spec_helper.rb", template_options)
        template('spec/sample_spec.rb.erb', "#{target_path}/spec/sample_spec.rb", template_options)
        template('spec/cli/command_spec.rb.erb', "#{target_path}/spec/cli/command_spec.rb", template_options)

        wrap_copy_file('spec/resources/sample.erb')
        wrap_copy_file('Gemfile')
        wrap_copy_file('.gitignore')
        wrap_copy_file('rubocop.yml')
        wrap_copy_file('Rakefile')


        create_file("#{target_path}/.rubocop_todo.yml")
        copy_file("#{Scaffold.source_root}/resources/LICENSE", "#{target_path}/LICENSE")
      end

      private

      def wrap_copy_file(path)
        copy_file("#{Cli.source_root}/#{path}","#{target_path}/#{path}")
      end

      #def wrap_template(path)
      #  template("#{path}.erb", "#{target_path}/#{path}", template_options )
      #end

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
