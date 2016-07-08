# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Checking and creating streets..."
Street.create(:street_name => "Caylor Circle") unless Street.find_by_street_name("Caylor Circle")
Street.create(:street_name => "Mack Dobbs Road") unless Street.find_by_street_name("Mack Dobbs Road")
Street.create(:street_name => "Standing Peachtree Trail") unless Street.find_by_street_name("Standing Peachtree Trail")
Street.create(:street_name => "Burnham Way") unless Street.find_by_street_name("Burnham Way")
Street.create(:street_name => "Burnham Cove") unless Street.find_by_street_name("Burnham Cove")
Street.create(:street_name => "Caylor Hill Pointe") unless Street.find_by_street_name("Caylor Hill Pointe")
Street.create(:street_name => "Blaydon Pointe") unless Street.find_by_street_name("Blaydon Pointe")
Street.create(:street_name => "Margay Drive") unless Street.find_by_street_name("Margay Drive")
Street.create(:street_name => "Standing Peachtree Court") unless Street.find_by_street_name("Standing Peachtree Court")

puts "Checking and creating board members..."
BoardMember.create(:description => "President", :display_order => 1) unless BoardMember.find_by_description("President")
BoardMember.create(:description => "Vice President", :display_order => 2) unless BoardMember.find_by_description("Vice President")
BoardMember.create(:description => "Treasurer", :display_order => 3) unless BoardMember.find_by_description("Treasurer")
BoardMember.create(:description => "Amenities", :display_order => 4) unless BoardMember.find_by_description("Amenities")
BoardMember.create(:description => "Grounds/Security", :display_order => 5) unless BoardMember.find_by_description("Grounds/Security")
BoardMember.create(:description => "Secretary", :display_order => 6) unless BoardMember.find_by_description("Secretary")
BoardMember.create(:description => "ACC Chairperson", :display_order => 7) unless BoardMember.find_by_description("ACC Chairperson")
BoardMember.create(:description => "Administrator", :display_order => 8) unless BoardMember.find_by_description("Administrator")

puts "Checking and creating block captains..."
BlockCaptain.create(:description => "Caylor Circle and Mack Dobbs Road", :display_order => 1) unless BlockCaptain.find_by_description("Caylor Circle and Mack Dobbs Road");
BlockCaptain.create(:description => "Caylor Hill Pointe", :display_order => 2) unless BlockCaptain.find_by_description("Caylor Hill Pointe");
BlockCaptain.create(:description => "Standing Peachtree Trail to Margay and Blaydon Pointe - even number homes", :display_order => 3) unless BlockCaptain.find_by_description("Standing Peachtree Trail to Margay and Blaydon Pointe - even number homes");
BlockCaptain.create(:description => "Standing Peachtree Trail to Margay and Blaydon Pointe - odd number homes", :display_order => 4) unless BlockCaptain.find_by_description("Standing Peachtree Trail to Margay and Blaydon Pointe - odd number homes");
BlockCaptain.create(:description => "Standing Peachtree Court from Standing Peachtree Trail to 2341", :display_order => 5) unless BlockCaptain.find_by_description("Standing Peachtree Court from Standing Peachtree Trail to 2341");
BlockCaptain.create(:description => "Standing Peachtree Court from 2341 to top", :display_order => 6) unless BlockCaptain.find_by_description("Standing Peachtree Court from 2341 to top");
BlockCaptain.create(:description => "Burnham Way and Burnham Cove", :display_order => 7) unless BlockCaptain.find_by_description("Burnham Way and Burnham Cove");
BlockCaptain.create(:description => "Standing Peachtree Trail from Standing Peachtree Court to cul-de-sac", :display_order => 8) unless BlockCaptain.find_by_description("Standing Peachtree Trail from Standing Peachtree Court to cul-de-sac");
BlockCaptain.create(:description => "Margay and Standing Peachtree Trail to Standing Peachtree Court", :display_order => 9) unless BlockCaptain.find_by_description("Margay and Standing Peachtree Trail to Standing Peachtree Court");
