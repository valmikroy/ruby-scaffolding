# frozen_string_literal: true

require 'thor'
require 'scaffold'
require 'scaffold/generator/cli'
require 'scaffold/generator/simplecli'
require 'scaffold/version'

module Scaffold
  class Cli < Thor
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
    Cli.tasks['cli'].options = Generator::Cli.class_options

    register(Generator::Cli, 'simplecli', 'simplecli NAME', 'Initialize a new Simple CLI skeleton')
    Cli.tasks['simplecli'].options = Generator::Cli.class_options

  end

end
