class Strain < ApplicationRecord
    has_many :assemblies
    has_many :wines, through: :assemblies

    validates :name, presence: true
    validates :name, uniqueness: true
    
    def destroy_dependencies
        Assembly.where(strain_id: self.id).each do |asmb|
            asmb.destroy
        end 
    end

end

