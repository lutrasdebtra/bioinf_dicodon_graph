seq = 'aaabbbcccdddeeefffggghhhiiijjjkkk12'
seq_a = []
i = 0
while (i < seq.length - 5) 
	seq_a << seq[i..i+5]
	i += 3
	puts i 
end

print seq_a