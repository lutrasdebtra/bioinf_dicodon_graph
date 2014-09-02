# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'
i = 0
CSV.foreach(Rails.root.join('lib','data','LZ1561_CPI_DetectableOrfs_2.txt'), { :col_sep => "\t" }) do |row|
	i += 1
	puts "#{i}/4096"
	aa = row[0]
	dc = row[1]
	dc_val = row[2]

	if not Aminoacid.exists?(name: aa)
		Aminoacid.create!(:name => aa)
	end
	parent = Aminoacid.find_by_name(aa)
	Dicodon.create!(:name => dc, :freq => dc_val, :aminoacid_id => parent.id)
end