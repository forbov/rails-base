# frozen_string_literal: true

def load_roles
  csv_text = File.read(Rails.root.join('lib', '.seeds', 'roles', 'roles.csv'))
  csv = CSV.parse(csv_text, headers: true)

  csv.each do |row|
    next unless Role.find_by(name: row['name']).nil?

    Role.create(
      name: row['name'],
      resource_type: row['resource_type'],
      resource_id: row['resource_id']
    )
  end
  p "Created #{Role.count} Roles"
end
