source 'https://rubygems.org'
ruby '2.2.2'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5'
# Adding bootstrap styling
gem 'bootstrap-sass', '~> 3.3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Add fontawesome icons
gem 'font-awesome-rails', '~> 4.3'
# Use simple form
gem 'simple_form', '~> 3.1.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'  
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# Use device to manage users
gem 'devise', '~> 3.4.1'
# Access control
gem 'pundit', '~> 0.3.0'
# Use state machine - worflow
gem 'workflow'
# Upload files
gem 'carrierwave'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :test do
  gem 'capybara', '~> 2.4'
  gem 'factory_girl_rails', '~> 4.5'
  gem 'selenium-webdriver', '~> 2.45'
  gem 'database_cleaner', '~> 1.4'
  gem 'email_spec', '~> 1.6.0'
end

group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # Add bdd rspec gem
  gem 'rspec-rails', '~> 3.2.1'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :production do
  # Use Postgres as the database for Active Record
  gem 'pg'
  # Configuration settings
  gem 'rails_12factor'
  # Use puma web server
  gem 'puma'
end

