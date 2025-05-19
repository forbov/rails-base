class Role < ApplicationRecord
  include CodesHelper
  has_and_belongs_to_many :users, join_table: :users_roles

  belongs_to :resource,
             polymorphic: true,
             optional: true


  validates :resource_type,
            inclusion: { in: Rolify.resource_types },
            allow_nil: true

  scopify

  def description
    user_role_desc(name)
  end

  def priority
    user_role_priority(name)
  end
end
