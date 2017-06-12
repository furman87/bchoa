namespace :fix do
  desc 'Fix Board Members'
  task board_members: :environment do
    puts "Fixing board members..."
    BoardMember.where(description: "Grounds/Security").each {|bm| bm.destroy }
    BoardMember.where(description: "Administrator").each {|bm| bm.description = "Web Administrator"; bm.save; }

    fix_board_member("President", "Joe", "Mantineo")
    fix_board_member("Vice President", "Mark", "Ford")
    fix_board_member("Treasurer", "Nichole", "Krouse")
    fix_board_member("Amenities", "Dave", "Doering")
    fix_board_member("Secretary", "Teresa", "Vogel")
    fix_board_member("ACC Chairperson", "Jason", "McMahon")
    fix_board_member("Web Administrator", "Ken", "Watson")
  end

  private

  def fix_board_member(description, first_name, last_name)
    bm = BoardMember.where(description: description).first
    user = User.find_by_first_name_and_last_name(first_name, last_name)
    if (bm && user)
      bm.user = user
      bm.save
    end
  end
end
