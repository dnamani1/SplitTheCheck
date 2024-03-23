class Restaurant < ApplicationRecord
  validates :name, :address, :city, :state, :zip, presence: true
  validates :zip, format: { with: /\A\d{5}\z/, message: "must be a 5-digit number" }
  validates :city, format: { with: /\A[a-zA-Z]+\z/, message: "must only contain letters" }
  validates :name, format: { with: /\A[a-zA-Z]/, message: "must start with a letter" }

  STATES = [
    ['Alabama', 'AL'], ['Alaska', 'AK'], ['Arizona', 'AZ'],
    ['Arkansas', 'AR'], ['California', 'CA'], ['Colorado', 'CO'],
    ['Connecticut', 'CT'], ['Delaware', 'DE'], ['Florida', 'FL'],
    ['Georgia', 'GA'], ['Hawaii', 'HI'], ['Idaho', 'ID'],
    ['Illinois', 'IL'], ['Indiana', 'IN'], ['Iowa', 'IA'],
    ['Kansas', 'KS'], ['Kentucky', 'KY'], ['Louisiana', 'LA'],
    ['Maine', 'ME'], ['Maryland', 'MD'], ['Massachusetts', 'MA'],
    ['Michigan', 'MI'], ['Minnesota', 'MN'], ['Mississippi', 'MS'],
    ['Missouri', 'MO'], ['Montana', 'MT'], ['Nebraska', 'NE'],
    ['Nevada', 'NV'], ['New Hampshire', 'NH'], ['New Jersey', 'NJ'],
    ['New Mexico', 'NM'], ['New York', 'NY'], ['North Carolina', 'NC'],
    ['North Dakota', 'ND'], ['Ohio', 'OH'], ['Oklahoma', 'OK'],
    ['Oregon', 'OR'], ['Pennsylvania', 'PA'], ['Rhode Island', 'RI'],
    ['South Carolina', 'SC'], ['South Dakota', 'SD'], ['Tennessee', 'TN'],
    ['Texas', 'TX'], ['Utah', 'UT'], ['Vermont', 'VT'],
    ['Virginia', 'VA'], ['Washington', 'WA'], ['West Virginia', 'WV'],
    ['Wisconsin', 'WI'], ['Wyoming', 'WY']
  ].freeze

end
