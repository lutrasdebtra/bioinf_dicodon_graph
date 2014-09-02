seq = 'aaabbbcccdddeeefffggghhhiiijjjkkk12'

def dicodons(seq)
	seq_a = []
	i = 0
	while (i < seq.length - 5) 
		seq_a << seq[i..i+5]
		i += 3
	end
	return seq_a
end

def get_values(dicodons)
	values = []
	dicodons.each do |d|
		values << Dicodon.find_by_name(d).freq
	end
	return values
end

def get_graphs(dicodons, values)
	graphs = []
	dicodons = dicodons.each_slice(60).to_a
	values = values.each_slice(60).to_a
	dicodons.each_with_index do |d, i| 
		graph = []
		d.each_with_index do |di, j|
			graph << [di, values[i][j]]
		end
		graphs << graph
	end
	return graphs
end

di = dicodons(seq)
puts di
val = get_values(di)
puts val
graphs = get_graphs(di, val)
puts graphs