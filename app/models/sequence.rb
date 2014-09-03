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

	def self.get_colours(dicodons)
		values = []
		dicodons.each do |d|
			freq = Dicodon.find_by_name(d).freq
			case 
			when freq < 0.1
				values << "#d9534f"
			when freq < 0.4
				values << "#f0ad4e"
			when freq < 0.7 
				values << "#5bc0de"
			when freq < 1.0
				values << '#428bca' 
			else
				values << '#5cb85c'
			end
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
				graph << [di + "_#{j+1}", values[i][j].to_f]
			end
			graphs << graph
		end
		return graphs
	end
end
