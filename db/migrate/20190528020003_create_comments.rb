class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :description
      t.string :attach
      t.references :task, foreign_key: true

      t.timestamps
    end
  end
end
