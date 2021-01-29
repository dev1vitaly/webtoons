class CreatePainters < ActiveRecord::Migration[6.1]
  def change
    create_table :painters do |t|
      t.belongs_to :artist, null: false, foreign_key: true, index: {unique: true}
      t.timestamps
    end
  end
end
