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

  class_option :use_mongoid,
               default: true,
               type: :boolean,
               desc: "Will your project use mongoid?"

  class_option :has_factory_bot,
               default: false,
               type: :boolean,
               desc: "Does your project have FactoryBot?"

  default_command(:generate_templates)
  def self.source_root
    File.dirname(__FILE__)
  end

  desc :generate_templates, "Generate quality workbench templates for your project."
  def generate_templates
    directory("templates", "output")
  end

  def self.destination_root
    File.join(File.dirname(__FILE__), "..", "output")
  end

  no_commands do
    def use_mongoid
      self.options["use_mongoid"]
    end

    def has_factory_bot
      self.options["has_factory_bot"]
    end

    def project_documentation_title
      self.options["project_documentation_title"]
    end
  end
end

TemplateBuilder.start