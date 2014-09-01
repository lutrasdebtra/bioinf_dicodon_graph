class Sequence < ActiveRecord::Base
	has_many :aminoacid, :dependent => :destroy
	accepts_nested_attributes_for :aminoacid, :allow_destroy => true

	has_many :dicodon, :through => :aminoacid

	def self.dicodons(seq)
		seq_a = []
		i = 0
		while (i < seq.length - 5) 
			seq_a << seq[i..i+5]
			i += 3
		end
		return seq_a
	end
end