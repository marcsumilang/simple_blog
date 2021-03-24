# frozen_string_literal: true

# Template file for rails project

# Info and inspiration from 
# https://github.com/dao42/rails-template/blob/master/composer.rb
# https://github.com/excid3/jumpstart/blob/master/template.rb
# 
# https://guides.rubyonrails.org/v4.0/rails_application_templates.html

################################################
####             helper methods             ####
################################################
def remove_gem(*names)
    names.each do |name|
      gsub_file 'Gemfile', /gem '#{name}'.*\n/, ''
    end
  end
  
  def add_users
    # Install Devise
    generate 'devise:install'
  
    # Configure Devise
    environment "config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }",
                env: 'development'
    route "root to: 'home#index'"
  
    generate 'devise:views'
  
    # Create Devise User
    generate :devise, 'User',
             'name',
             'image'
  end
  
  def add_gems
    # Apply good development and test defaults:
    gem_group :development, :test do
      gem 'capybara'
      gem 'pry-byebug'
      gem 'rails-controller-testing'
      gem 'rspec-rails', '~> 4.0.0.beta2'
      gem 'rubocop'
    end
  
    gem_group :test do
      gem 'shoulda-matchers'
      gem 'simplecov'
    end
  
    # Add in other good default project gems
    gem 'devise'
  end
  
  def add_home_page
    puts "create a home controller and view"
    generate(:controller, 'home index')
  end
  
  def stop_spring
    run "spring stop"
  end
  
  def add_rspec
    generate 'rspec:install'
  end
  
  
  #################################
  ###  Template runs from here  ###
  #################################
  
  add_gems
  
  #################################
  
  after_bundle do
    # add_rspec
    # is causing some problems
    # run rails g rspec:install from terminal
  
    add_users # devise
  
    add_home_page
  
    # Migrate
    rails_command 'db:create'
    rails_command 'db:migrate'
  
    say
    say 'app is created', :green
    say
    say 'cd in to the app folder and run the following commands', :green
    say 'rails g rspec:install', :red
  end
  