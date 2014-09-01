class CreateSequences < ActiveRecord::Migration
  def change
    create_table :sequences do |t|
      t.string :seq

      t.timestamps
    end
  end
end
