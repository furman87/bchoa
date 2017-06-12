namespace :fix do
  desc 'Fix Block Captains'
  task block_captains: :environment do
    puts "Fixing block captains..."

    fix_block_captain("Caylor Circle and Mack Dobbs Road", "Donna", "Mereider")
    fix_block_captain("Caylor Hill Pointe", "Victoria", "Simpson")
    fix_block_captain("Standing Peachtree Trail to Margay and Blaydon Pointe - even number homes", "Colette", "Ford")
    fix_block_captain("Standing Peachtree Trail to Margay and Blaydon Pointe - odd number homes", "Laura", "Cervi")
    fix_block_captain("Standing Peachtree Court from Standing Peachtree Trail to 2341", "Jackie", "Streck")
    fix_block_captain("Standing Peachtree Court from 2341 to top", "Gina", "Gasparini")
    fix_block_captain("Burnham Way and Burnham Cove", "Tawnda", "Finkbiner")
    fix_block_captain("Standing Peachtree Trail from Standing Peachtree Court to cul-de-sac", "Yolanda", "White")
    fix_block_captain("Margay and Standing Peachtree Trail to Standing Peachtree Court", "Cindy", "Mantineo")
    puts "Done."
  end

  private

  def fix_block_captain(description, first_name, last_name)
    bc = BlockCaptain.where(description: description).first
    user = User.find_by_first_name_and_last_name(first_name, last_name)
    if (bc && user)
      bc.user = user
      bc.save
    end
  end
end
