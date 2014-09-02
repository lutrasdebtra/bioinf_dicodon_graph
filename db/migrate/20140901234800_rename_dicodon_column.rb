class RenameDicodonColumn < ActiveRecord::Migration
  def change
  	rename_column :dicodons, :aminoAcid_id, :aminoacid_id
  end
end
