# frozen_string_literal: true

def load_system_codes
  SystemCode.destroy_all

  csv_text = File.read(Rails.root.join("lib", "seeds", "system_codes", "system_codes.csv"))
  csv = CSV.parse(csv_text, headers: true)

  csv.each do |row|
    SystemCode.create(
      code_type: row["code_type"],
      code: row["code"],
      code_desc: row["code_desc"],
      integer_value: row["integer_value"],
      alt_desc: row["alt_desc"]
    )
  end
  p "Created #{SystemCode.count} System Codes"
end
