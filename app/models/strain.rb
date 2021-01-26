class Strain < ApplicationRecord
    has_many :assemblies
    has_many :wines, through: :assemblies

    validates :name, presence: true
    
end

