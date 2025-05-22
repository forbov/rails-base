# frozen_string_literal: true

module AppHelper
  APP_NAME = "e-traction"
  SYSTEM_URL = "#{APP_NAME}.com".freeze
  APP_ICON = "TRACTION_workshop_splash_small.png"
  TRUE_IMAGE = "icons8-true-20.png"
  FALSE_IMAGE = "icons8-false-20.png"
  KAMINARI_PER_PAGE = 25

  def app_name
    APP_NAME
  end

  def system_url
    SYSTEM_URL
  end

  def app_icon
    APP_ICON
  end

  def system_mailto
    "mailto:info@#{SYSTEM_URL}"
  end

  def kaminari_per_page
    KAMINARI_PER_PAGE
  end

  def date_long(the_date)
    the_date.nil? ? "" : the_date.strftime("%A, %d %B %Y")
  end

  def date_short(the_date)
    the_date.nil? ? "" : the_date.strftime("%d %b %Y")
  end

  def date_shorter(the_date)
    the_date.nil? ? "" : the_date.strftime("%d %b")
  end

  def time_formatted(the_time)
    the_time.nil? ? "" : the_time.strftime("%I:%M %p")
  end

  def datetime_formatted(the_datetime)
    the_datetime.nil? ? "" : the_datetime.to_time.strftime("%d %b %Y %I:%M %p")
  end

  def boolean_image(field_name)
    if field_name
      TRUE_IMAGE
    else
      FALSE_IMAGE
    end
  end

  def test_tabs
    # user = User.find(4)
    tabs = { manages: { label: "Manages",
                        render: "programs",
                        dataset: user.managed_programs,
                        source: "manager" },
             refers: { label: "Refers",
                       render: "programs",
                       dataset: user.referred_programs,
                       source: "referrer" },
             facilitates: { label: "Facilitates",
                            render: "program_modules",
                            dataset: user.facilitator_modules,
                            source: "facilitator" },
             candidates: { label: "Candidates",
                           render: "candidates",
                           dataset: user.candidates,
                           source: "guardian" } }

    tabs.each do |key, value|
      p "key: #{key}, value: #{value}"
      p "label: #{value[:label]}"
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
        @tabs.each do |key, value|
          next if value[:dataset].empty?

          tab_name = key
          tab_label = value[:label]
          tab_render = value[:render]
          tab_dataset = value[:dataset]
          tab_parent = value[:parent]
          tab_source = value[:source]

          ac = ActionController::Base.new()
          ac.view_context_class.include(ActionView::Helpers, ApplicationHelper)
          tab_content = ac.render_to_string partial: "#{tab_render}/#{tab_render}", locals: { collection: tab_dataset,
                                                                                              source: tab_source,
                                                                                              parent: tab_parent,
                                                                                              params: params,
                                                                                              url: Rails.application.routes.url_helpers,
                                                                                              current_user: current_user }

          @tab_header = "#{@tab_header}    <li class=\"nav-item\" role=\"presentation\"><button class=\"nav-link#{is_active_header_text}\" id=\"#{tab_name}-tab\" data-bs-toggle=\"tab\" data-bs-target=\"##{tab_name}-pane\" type=\"button\" role=\"tab\" aria-controls=\"#{tab_name}-pane\" aria-selected=\"false\">#{tab_label}</button></li>"
          @tab_body = "#{@tab_body}    <div class=\"tab-pane fade#{is_active_body_text}\" id=\"#{tab_name}-pane\" role=\"tabpanel\" aria-labelledby=\"#{tab_name}-tab\" tabindex=\"0\">#{tab_content}</div>"

          if @first_tab
            is_active_header_text = ""
            is_active_body_text = ""
            @first_tab = false
          end
        end
      end
    end

    def is_empty?
      if @first_tabs
        true
      else
        false
      end
    end

    def render_tab_header
      @tab_header
    end

    def render_tab_body
      @tab_body
    end
  end

  def foundation_tabs_builder(tabs)
    first_tab = true
    tab_header = ""
    tab_body = ""
    is_active_text = ""
    aria_text = ""
    tabs.each do |key, value|
      next if value[:dataset].empty?

      tab_name = key
      tab_label = value[:label]
      tab_render = value[:render]
      tab_dataset = value[:dataset]
      tab_parent = value[:parent]
      tab_source = value[:source]

      if first_tab
        is_active_text = " is-active"
        aria_text = ' aria-selected="true"'
        tab_body = "  <div class=\"tabs-content\" data-tabs-content=\"#{tab_name}-tabs\" data-turbo=\"false\">"
        first_tab = false
      end
      tab_header = "#{tab_header}    <li class=\"tabs-title#{is_active_text}\"><a data-tabs-target=\"#{tab_name}-panel\"#{aria_text}>#{tab_label}</a></li>"
      tab_body = "#{tab_body}    <div class=\"tabs-panel#{is_active_text}\" id=\"#{tab_name}-panel\">"
      ac = ActionController::Base.new()
      tab_render_as_string = ac.render_to_string partial: "#{tab_render}/#{tab_render}", locals: { collection: tab_dataset,
                                                                                                   source: tab_source,
                                                                                                   parent: tab_parent }
      tab_body = "#{tab_body}      #{tab_render_as_string}"
      tab_body = "#{tab_body}    </div>"
      is_active_text = ""
      aria_text = ""
    end
    return nil if first_tab

    { header: tab_header, body: "#{tab_body} </div>" }
  end

  def dataset_as_csv(dataset, attributes, header, separator)
    require "csv"

    "," if separator.nil?
    true if header.nil?

    options = { col_sep: separator, encoding: "utf-8" }

    CSV.generate(headers: header, **options) do |csv|
      csv << attributes if header

      dataset.each do |row|
        csv << attributes.map { |attribute| row.send(attribute) }
      end
    end
  end
end
