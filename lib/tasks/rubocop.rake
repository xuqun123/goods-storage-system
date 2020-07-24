# frozen_string_literal: true

require 'rubocop'

desc 'code styles check using rubocop'
task :rubocop do
  cli = RuboCop::CLI.new
  cli.run(%w[app/ lib/ spec/])
end
