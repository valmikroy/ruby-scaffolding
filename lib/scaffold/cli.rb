# frozen_string_literal: true

require 'thor'
require 'scaffold'
require 'scaffold/generator/cli'
require 'scaffold/generator/simplecli'
require 'scaffold/generator/microservice'
require 'scaffold/version'

module Scaffold
  class CLI < Thor
    check_unknown_options!
    class_option 'verbose', type: :boolean, default: false

    def self.exit_on_failure?
      true
    end

    desc 'version', 'Display version'
    map %w[-v --version] => :version

    def version
      say "Scaffold #{Scaffold::VERSION}"
    end

    register(Generator::Cli, 'cli', 'cli NAME', 'Initialize a new CLI project')
    CLI.tasks['cli'].options = Generator::Cli.class_options

    register(Generator::Simplecli, 'simplecli', 'simplecli NAME', 'Initialize a new Simple CLI skeleton')
    CLI.tasks['simplecli'].options = Generator::Simplecli.class_options

    register(Generator::MicroService, 'microservice', 'microservice NAME', 'Initialize a new microservice skeleton based on rack + grape')
    CLI.tasks['microservice'].options = Generator::MicroService.class_options
  end
end
