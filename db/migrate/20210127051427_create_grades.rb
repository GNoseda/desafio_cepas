class CreateGrades < ActiveRecord::Migration[5.2]
  def change
    create_table :grades do |t|
      t.integer :grade
      t.references :wine, foreign_key: true
      t.references :oenologist, foreign_key: true

      t.timestamps
    end
  end
end
