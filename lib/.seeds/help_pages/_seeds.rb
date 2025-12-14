# frozen_string_literal: true

def load_help_pages
  csv_text = File.read(Rails.root.join('lib', 'seeds', 'help_pages', 'help_pages.csv'))
  csv = CSV.parse(csv_text, headers: true)

  csv.each do |row|
    help_page = HelpPage.find_by(title: row['title'])
    details = File.read(Rails.root.join('lib', 'seeds', 'help_pages', 'content',
                                        "#{row['title'].parameterize(separator: '-')}.html"))

    if help_page.present?
      help_page.update(
        title: row['title'],
        page_order: row['page_order'],
        details:
      )
    else
      HelpPage.create(
        title: row['title'],
        page_order: row['page_order'],
        details:
      )
    end
  end

  p "Created #{HelpPage.count} Help Pages"
end
