class Wine < ApplicationRecord
    has_many :assemblies
    has_many :strains, through: :assemblies
    accepts_nested_attributes_for :assemblies
    
    has_many :grades
    has_many :oenologists, through: :grades
    accepts_nested_attributes_for :grades


    validates :name, presence: true
    validates :assemblies, presence: true

    def destroy_dependencies
        Assembly.where(wine_id: self.id).each do |asmb|
            asmb.destroy
        end 
    end

    def avarage_grade
        arr = Grade.where(wine_id: self.id).map{ |grd| grd.grade  }
        (arr.inject(:+).to_f/arr.count.to_f).round(2)
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
