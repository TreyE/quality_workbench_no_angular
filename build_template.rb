require 'rubygems'
require 'bundler/setup'
require 'yaml'
require 'thor'

class TemplateBuilder < Thor
  include Thor::Actions

  class_option :project_documentation_title,
               required: true,
               type: :string,
               desc: "The name of your project, as it should appear in documentation"

  class_option :project_database_name,
               required: true,
               type: :string,
               desc: "The name of your project's database, in_snake_case, like 'my_project'"

  class_option :docker_base_test_image,
               default: "treyedocker/ubuntu_node_12_ruby_2_6_3_chromedriver:latest",
               type: :string,
               desc: "The base docker image for your tests"

  class_option :use_mongoid,
               default: true,
               type: :boolean,
               desc: "Will your project use mongoid?"

  class_option :use_factory_bot,
               default: false,
               type: :boolean,
               desc: "Set if you want to use factory bot in your project."

  default_command(:generate_templates)
  def self.source_root
    File.dirname(__FILE__)
  end

  desc :generate_templates, "Generate quality workbench templates for your project."
  def generate_templates
    directory("templates", "output")
    if use_mongoid
      directory("mongoid_templates", "output")
    end
  end

  def self.destination_root
    File.join(File.dirname(__FILE__), "..", "output")
  end

  no_commands do
    def use_mongoid
      self.options["use_mongoid"]
    end

    def use_factory_bot
      self.options["use_factory_bot"]
    end

    def project_documentation_title
      self.options["project_documentation_title"]
    end

    def docker_base_test_image
      self.options["docker_base_test_image"]
    end

    def project_database_name
      self.options["project_database_name"]
    end
  end
end

TemplateBuilder.start