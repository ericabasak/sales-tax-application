class Product < ApplicationRecord
    validates :name, presence: true
    validates :price, presence: true

    validates :imported, inclusion: [true, false]
    validates :exempt, inclusion: [true, false]

    # validates :imported, presence: true
    # validates :exempt, presence: true
end
