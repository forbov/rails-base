# frozen_string_literal: true

class HelpPage < ApplicationRecord
  has_rich_text :details

  validates :title, presence: true, uniqueness: true, on: :create
  validates :page_order, presence: true, uniqueness: true, on: :create
  validates :details, presence: true, on: :create

  def title_no_spaces
    title.parameterize(separator: "-")
  end
end
