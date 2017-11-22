# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core'
require 'rspec/core/rake_task'
require 'rubygems'
require 'bundler/setup'

require 'rake'

RSpec::Core::RakeTask.new(:spec)

require 'rubocop/rake_task'
RuboCop::RakeTask.new(:rubocop) do |t|
  t.options = ['--auto-correct', '--display-cop-names', '--config=.rubocop.yml']
  t.fail_on_error = false
end

task default: %i[rubocop spec]
