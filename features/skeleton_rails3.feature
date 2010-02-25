@announce-cmd
Feature: Rails 3
  In order to quickly set up Cucumber
  As a Rails developer
  I want to have the Cucumber skeleton generated automatically

  Scenario: Install
    Given I am using rvm "1.8.7"
    And I am using rvm gemset "cucumber-rails-3.0.0.beta"
    When I successfully run "rails rails-3-app"
    Then it should pass with:
      """
      README
      """
    And I cd to "rails-3-app"
    And I symlink this repo to "vendor/plugins/cucumber-rails"
    When I successfully run "rails generate cucumber:skeleton"
    Then the following files should exist:
      | config/cucumber.yml                    |
      | script/cucumber                        |
      | features/step_definitions/web_steps.rb |
      | features/support/env.rb                |
      | features/support/paths.rb              |
      | lib/tasks/cucumber.rake                |
    And the file "features/support/env.rb" should contain "require 'cucumber/rails/world'"
    And the file "features/support/env.rb" should contain "require 'capybara/rails'"

  Scenario: Run with Capybara
    Given I am using rvm "1.8.7"
    And I am using rvm gemset "cucumber-rails-3.0.0.beta"
    And I successfully run "rails rails-3-app"
    And I cd to "rails-3-app"
    And I symlink this repo to "vendor/plugins/cucumber-rails"
    And I successfully run "rails generate cucumber:skeleton"
    And I successfully run "rails generate cucumber:feature post title:string body:text published:boolean"
    And I successfully run "rails generate scaffold post title:string body:text published:boolean"
    And I append to "Gemfile" with:
      """
      gem 'cucumber'
      gem 'database_cleaner'
      gem 'capybara', :git => 'git://github.com/aslakhellesoy/capybara.git'

      """
    And I run "ruby -S bundle install"
    And I successfully run "rake db:migrate"
    And I run "rake cucumber"
    Then it should pass with:
       """
       3 steps (3 passed)
       """
      