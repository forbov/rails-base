# frozen_string_literal: true

module AppHelper
  include CodesHelper

  THUMBNAIL_SIZE = 200
  class DateFormatter
    def initialize(date, user)
      @date = nil
      if date.is_a?(DateTime)
        @date = date.in_time_zone(user.time_zone)
      elsif date.is_a?(Date) || date.is_a?(ActiveSupport::TimeWithZone)
        @date = date
      else
        @date = nil
      end
    end

    def long
      @date.nil? ? "" : @date.strftime("%A, %d %B %Y")
    end

    def short
      @date.nil? ? "" : @date.strftime("%d %b %Y")
    end

    def shorter
      @date.nil? ? "" : @date.strftime("%d %b")
    end

    def time
      @date.nil? ? "" : @date.strftime("%I:%M %p")
    end

    def datetime
      @date.nil? ? "" : @date.to_time.strftime("%d %b %Y %I:%M %p")
    end
  end

  class BootstrapTabs
    def initialize(tabs, current_user, params = {})
      @tab_header = ""
      @tab_body = ""
      @tabs = tabs

      @first_tab = true
      is_active_header_text = " active"
      is_active_body_text = " show active"

      if @tabs.nil?
        @tab_header = nil
        @tab_body = nil
      else
        ac = ActionController::Base.new
        ac.view_context_class.include(ActionView::Helpers, ApplicationHelper)
        @tabs.each do |key, value|
          next if value[:dataset].empty?

          tab_name = key
          tab_label = value[:label]
          tab_render = value[:render]
          tab_dataset = value[:dataset]
          tab_parent = value[:parent]
          tab_source = value[:source]
          tab_content = ac.render_to_string partial: "#{tab_render}/#{tab_render}", locals: { collection: tab_dataset,
                                                                                              source: tab_source,
                                                                                              parent: tab_parent,
                                                                                              params: params,
                                                                                              url: Rails.application.routes.url_helpers,
                                                                                              current_user: current_user }

          @tab_header = "#{@tab_header}    <li class=\"nav-item\" role=\"presentation\"><button class=\"nav-link#{is_active_header_text}\" id=\"#{tab_name}-tab\" data-bs-toggle=\"tab\" data-bs-target=\"##{tab_name}-pane\" type=\"button\" role=\"tab\" aria-controls=\"#{tab_name}-pane\" aria-selected=\"false\">#{tab_label}</button></li>"
          @tab_body = "#{@tab_body}    <div class=\"tab-pane fade#{is_active_body_text}\" id=\"#{tab_name}-pane\" role=\"tabpanel\" aria-labelledby=\"#{tab_name}-tab\" tabindex=\"0\">#{tab_content}</div>"

          next unless @first_tab

          is_active_header_text = ""
          is_active_body_text = ""
          @first_tab = false
        end
      end
    end

    def is_empty?
      @first_tab
    end

    def render_tab_header
      @tab_header
    end

    def render_tab_body
      @tab_body
    end
  end

  class DatasetProcessor
    require "json"
    require "csv"

    def initialize(dataset, header: true, separator: ",")
      @dataset = dataset
      @header = header
      @separator = separator

      if dataset.empty?
        @attributes = []
      else
        @attributes = dataset.as_json.first.keys
      end
    end

    def as_json
      @dataset.as_json
    end

    def as_csv
      options = { col_sep: @separator, encoding: "utf-8" }

      CSV.generate(headers: @header, **options) do |csv|
        csv << @attributes if @header

        @dataset.each do |row|
          csv << @attributes.map { |attribute| row.send(attribute) }
        end
      end
    end
  end
end
