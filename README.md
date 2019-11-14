# Quality Workbench for Rails Projects - Without Angular

This document will walk you through the task of setting up and configuring the quality workbench in your new project.

1. [Quality Workbench for Rails Projects - Without Angular](#quality-workbench-for-rails-projects---without-angular)
2. [Workbench Installation](#workbench-installation)
   1. [Update Docker and Git Ignore Files](#update-docker-and-git-ignore-files)
   2. [Gemfile Additions](#gemfile-additions)
   3. [Generate and Install Files](#generate-and-install-files)
      1. [Run the Generator](#run-the-generator)
      2. [Copy Over the Files](#copy-over-the-files)
3. [Test the Workbench](#test-the-workbench)

# Workbench Installation

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
test_reports/cucumber_formatter/junit/*.xml
```

## Gemfile Additions

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

**NOTE** If you have mongoid, you will want to also add:
```!ruby
  gem 'database_cleaner'
```

## Generate and Install Files

In this step, we're going to run the generator to create a set of files we will add to your project.

As normal, please run your bundle install in this project to make sure everything is in place.

Then, to get a sense of what arguments you will need to be providing to the generator and how it works, run:
```
ruby build_template.rb help
```

This will enumerate all the arguments and what you need to provide.

### Run the Generator

After reviewing the arguments and what you need to provide from the usage, run the template generator:
```
ruby build_template.rb <your arguments>
```

An example would be, for a project named EDI Journal Database:
```
ruby build_template.rb --project-documentation-title="EDI Journal Database" --project-database-name="edi_journal_database" --use-factory-bot
```

### Copy Over the Files

This will create and place a number of files into the 'output' directory.  Copy these files over to your project carefully reviewing any conflicts.

Remember that we also generate "dot" files, so we need to be more verbose with our copying. This means you will most likely need to run with the special no target directory option:
```
cp -Rf output/ <your project directory (INCLUDE THE TRAILING SLASH)>
```

# Test the Workbench

Now that your project is configured, you should be able to test the run of the docker testing command:
```
docker-compose -f ./docker-compose.test.yml build && docker-compose -f ./docker-compose.test.yml up
```

The output of this should be a bunch of test output, and you should be  getting a file in your root directory called `report.zip`.  Pop open  that file and look at `doc/index.html` and browse around.

Once it works, don't forget to add the new files to git!
**Make double sure to add all the .gitkeep files, even if they are in ignored directories**