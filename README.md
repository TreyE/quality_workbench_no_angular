# Quality Workbench for Rails Projects - Without Angular

This document will walk you through the task of setting up and configuring the quality workbench in your new project.

# HOW-TO

This section will walk you through the steps needed to get this functionality running in your own project.

## Update Docker and Git Ignore Files

To your `.dockerignore` file you will need to add the following entries:
```
/.yardoc
/_yardoc/
/coverage/
test_reports/cucumber_formatter/node_modules
test_reports/cucumber_formatter/cucumber_results/cucumber.html
test_reports/cucumber_formatter/cucumber_results/cucumber.json
test_reports/cucumber_formatter/junit/*.xml
test_reports/junit_formatter/node_modules
test_reports/junit_formatter/rspec_results/index.html
test_reports/junit_formatter/rspec_results/rspec.xml
```

To your `.gitignore` file you will need to add the following entries:
```
.yardoc
doc
/test_reports/junit_formatter/node_modules
test_reports/junit_formatter/package-lock.json
rubocop
test_reports/junit_formatter/rspec_results
coverage
test_reports/cucumber_formatter/node_modules
test_reports/cucumber_formatter/package-lock.json
test_reports/cucumber_formatter/cucumber_results
test_reports/cucumber_formatter/junit
```

### Gemfile Additions

You will need to add the following gems to both your `development` and  `test`  groups:
```!ruby
group :development, :test do
  gem 'rspec-rails'
  gem 'yard'
  gem 'rubocop'
  gem 'rubocop-rspec'
  gem 'rubocop-git'
end
```

These additional gems will need to be in your `test` group:
```!ruby
group :test do
  gem 'rspec_junit_formatter'
  gem 'simplecov', require: false
  gem 'simplecov-cobertura'
  gem 'cucumber'
  gem 'cucumber-rails', require: false
  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'webdrivers'
end
```

## Install Template Files

