class Oenologist < ApplicationRecord
    has_many :grades
    has_many :wines, through: :grades

    validates :name, presence: true
    validates :age, presence: true
    validates :nacionality, presence: true
    validates :magazine, presence: true

    def roles
        "#{if self.editor
            "Editor "
        end}
        #{if self.writer
            "Escritor "
        end}
        #{if self.reviewer
            "Revisor"
        end}"
    end
    
end
