# frozen_string_literal: true

require 'scaffold/version'
require 'logger'
require 'pathname'

module Scaffold # :nodoc:
  # This is singleton which will hold logger object and other default
  # parameters backed by environment variables if needed ( like ENV['VERBOSE'] )
  class << self
    # logger object instance will get stored here
    attr_accessor :logger

    # verbosity managed by env variable
    # @return [Boolean]
    def verbose?
      ENV['VERBOSE'] ? true : false
    end

    # Create instance of logger object according to defined verbosity
    # @params [Boolean] this defines verbosity at runtime
    #                   if not provided then ENV['VERBOSE'] will be read
    #                   default: nil
    # @return [Logger]
    def default_logger(v = nil)
      v = verbose? if v.nil?
      logger = Logger.new(STDOUT)
      logger.level = Logger::INFO
      logger.level = Logger::DEBUG if v
      logger
    end

    # Find top level directory of gem development environment, this comes
    # handy during writing test cases
    # @return [String]
    def source_root
      @source_root ||= Pathname.new(File.expand_path('../../', __FILE__))
    end

    # Is this script attached to tty ?
    # @return [Boolean]
    def tty?
      $stdout.tty?
    end
  end
end

Scaffold.logger = Scaffold.default_logger
