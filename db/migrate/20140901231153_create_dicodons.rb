class CreateDicodons < ActiveRecord::Migration
  def change
    create_table :dicodons do |t|
      t.string :name
      t.integer :aminoAcid_id
      t.decimal :freq

      t.timestamps
    end
  end
end
