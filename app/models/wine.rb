class Wine < ApplicationRecord
    has_many :assemblies
    has_many :strains, through: :assemblies
    
    validates :name, presence: true
    validates :assemblies, presence: true
    
    accepts_nested_attributes_for :assemblies

    def destroy_dependencies
        Assembly.where(wine_id: self.id).each do |asmb|
            asmb.destroy
        end 
    end

    def simplify_assembly
        strain_count = {}
        Strain.all.each do |strn|
            strain_count[strn.id] = 0
        end
        
        Assembly.where(wine_id: self.id) do |asmb|
            strain_count[asmb.strain_id] += 1
            if strain_count[asmb.strain_id] = 1
                asmb.portion = Assembly.where(wine_id: self.id, strain_id: asmb.strain_id ).map {|asmbly| asmbly.portion}.inject(:+)    
            elsif strain_count[asmb.strain_id] > 1
                asmb.destroy
            end
        end
    end
end
