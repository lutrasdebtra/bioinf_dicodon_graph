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

	def self.get_values(dicodons)
		values = []
		dicodons.each do |d|
			values << Dicodon.find_by_name(d).freq
		end
		return values
	end

	def self.get_graphs(dicodons, values)
		graphs = []
		dicodons = dicodons.each_slice(60).to_a
		values = values.each_slice(60).to_a
		dicodons.each_with_index do |d, i| 
			graph = []
			d.each_with_index do |di, j|
				graph << [di + "_#{j}", values[i][j].to_f]
			end
			graphs << graph
		end
		print graphs
		return graphs
	end
end
