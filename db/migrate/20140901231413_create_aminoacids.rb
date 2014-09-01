class CreateAminoacids < ActiveRecord::Migration
  def change
    create_table :aminoacids do |t|
      t.string :name

      t.timestamps
    end
  end
end
