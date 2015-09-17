# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
  
 Invoice.create!({:floor_id=>"101/2", :name=>"하이베스트대치점", :floor_area=>30, :deposit=>7000, :rent=>4000000, :management_fee=>240000, :electric_fee=>100, :tax_2=>0, :water_fee=>200, :tv_fee=>300, :total=>44664000, :user_id=>2})
