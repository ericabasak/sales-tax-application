class Product < ApplicationRecord
    validates :name, presence: true
    validates :price, presence: true
    # validates :imported, presence: true
    # validates :exempt, presence: true
end
