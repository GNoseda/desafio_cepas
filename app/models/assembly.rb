class Assembly < ApplicationRecord
  belongs_to :wine
  belongs_to :strain

  validates :portion, presence: true

  def strain_name
    Strain.find(self.strain_id).name
  end

  def strain_percent
    var = (self.portion.to_f/self.total_amount.to_f)*100
    "(#{var.round(1)}%)"
  end

  def total_amount
    Assembly.where(wine_id: self.wine_id).map {|asmb| asmb.portion}.inject(:+)
  end

  
    
end
