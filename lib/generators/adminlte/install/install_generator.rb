require 'rails/generators'

module Adminlte
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      desc 'Copy AdminLTE Generators default files'
      source_root ::File.expand_path('../templates', __FILE__)

      class_option :template_engine, :default => 'erb'
      class_option :layout_name, :default => 'application'
      class_option :skin, :default => 'blue', desc: 'AdminLTE skin color'
      class_option :skip_turbolinks, :type => :boolean, :default => false, :desc => "Skip Turbolinks on assets"

      def copy_lib
        # directory "lib/templates/#{options[:template_engine]}"
      end

      def copy_form_builder
        # copy_file "form_builders/form_builder/_form.html.#{options[:template_engine]}", "lib/templates/#{options[:template_engine]}/scaffold/_form.html.#{options[:template_engine]}" 
      end

      def create_layout
        template "layouts/dashboard.html.#{options[:template_engine]}", "app/views/layouts/#{options[:layout_name]}.html.#{options[:template_engine]}"
        template "layouts/_header.html.#{options[:template_engine]}", "app/views/layouts/_#{options[:layout_name]}_header.html.#{options[:template_engine]}"
        template "layouts/_sidebar.html.#{options[:template_engine]}", "app/views/layouts/_#{options[:layout_name]}_sidebar.html.#{options[:template_engine]}"
      end

      def inject_adminlte
        application_js_path = "app/assets/javascripts/#{options[:layout_name]}.js"
        application_css_path = "app/assets/javascripts/#{options[:layout_name]}.css"

        if ::File.exists?(::File.join(destination_root, application_js_path))
          inject_into_file application_js_path, before: '//= require_tree' do
            "//= require adminlte/bootstrap\n"+
            "//= require adminlte/app"
          end
        end

        if ::File.exists?(::File.join(destination_root, application_css_path))
          inject_into_file application_css_path, before: '*= require_tree .' do
            " *= require AdminLTE\n"
          end
        end
      end
    end
  end
end
