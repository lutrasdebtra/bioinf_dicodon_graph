class Aminoacid < ActiveRecord::Base
	belongs_to :sequence
	has_many :dicodon, :dependent => :destroy
	accepts_nested_attributes_for :dicodon, :allow_destroy => true
end
