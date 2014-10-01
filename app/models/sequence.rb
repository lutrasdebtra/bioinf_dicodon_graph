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
		return values.each_slice(60).to_a
	end

	def self.get_graphs(dicodons, values)
		graphs = []
		colours = get_colours(dicodons)
		dicodons = dicodons.each_slice(60).to_a
		values = values.each_slice(60).to_a
		dicodons.each_with_index do |d, i| 
			graph = [['seq_slice', 'CPI', { role: 'style' }]]
			d.each_with_index do |di, j|
				graph << [di + "_#{j+1}", values[i][j].to_f, colours[i][j]]
			end
			if d.length < 60 
				excess = 60 - d.length
				excess.times do |n|
					graph << ["", 0.to_f, 'white']
				end 
			end
			graphs << graph
		end
		return graphs
	end

	def self.get_di_freq(codons, letter, window)
		graphs = []
		dicodons = []
		counts = []
		codons.split("").each_with_index do |s, i|
			j = i + window - 1
			dicodons << codons[i..j]
		end

		dicodons.each do |d|
			counter = 0
			d.split("").each do |n|
				if (n == letter)
					counter += 1
				end
			end
			counts << counter
		end

		dicodons = dicodons.each_slice(180).to_a
		counts = counts.each_slice(180).to_a
		dicodons.each_with_index do |d, i| 
			graph = [['seq_slice', 'Freq']]
			d.each_with_index do |di, j|
				graph << [di + "_#{j+1}", counts[i][j]]
			end
			if d.length < 180 
				excess = 180 - d.length
				excess.times do |n|
					graph << ["", 0]
				end 
			end
			graphs << graph
		end

		return graphs
	end

	def self.formatted_haxis(search)
		search_array = search.chars.to_a.each_slice(180).to_a.map(&:join)
		search_array_last = search_array[-1]
		puts search_array_last
		
		excess = 180 - search_array_last.length
		excess.times do |n|
			search_array_last << "_"
		end 
		search_array[-1] = search_array_last
		return search_array
	end
end
