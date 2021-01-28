class Grade < ApplicationRecord
  belongs_to :wine
  belongs_to :oenologist
  
  validates :grade, presence: true

  validates :grade, :inclusion => { :in => 0..100 }
  
  def oenologist_name
    Oenologist.find(self.oenologist_id).name
  end
end
