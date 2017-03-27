namespace :migrate do
  desc 'Creates residences from existing users'
  task residences: :environment do
    User.find_each do |user|
      residence = Residence.create!(
        street_number: user.street_number,
        street_id: user.street_id,
        lot: user.lot,
        block: user.block,
        purchase_year: user.purchase_year
      )

      ResidenceUser.create!(
        user: user,
        residence: residence,
        is_owner: true,
        is_resident: true,
        display_order: 1
      )

      unless user.spouse_name.blank?
        puts "Trying to find User(#{user.spouse_name} #{user.last_name})"
        # Create new user for the spouse
        spouse_user = User.find_by_first_name_and_last_name(user.spouse_name, user.last_name)
        if spouse_user.nil?
          spouse_email = user.spouse_email ||= user.spouse_name.downcase.sub(' ', '') + user.last_name.downcase.sub(' ', '') + "@butlercreek.org"
          puts "Didn't find User, creating #{user.spouse_name} #{user.last_name} #{spouse_email}"
          spouse_user = User.create!(
            last_name: user.last_name,
            first_name: user.spouse_name,
            email: spouse_email,
            phone: user.spouse_phone,
            password: "changeme"
          )
          puts "Created User #{user.spouse_name} #{user.last_name}"
        end

        puts "Trying to find ResidenceUser (#{spouse_user.id}, #{residence.id})..."
        # Link the new spouse user to the newly created residence
        resident = ResidenceUser.find_by_user_id_and_residence_id(spouse_user.id, residence.id)
        if resident.nil?
          puts "Didn't find ResidenceUser, creating #{spouse_user.id}, #{residence.id}"
          ResidenceUser.create!(
            user: spouse_user,
            residence: residence,
            is_owner: true,
            is_resident: true,
            display_order: 2
          )
          puts "Created ResidenceUser #{spouse_user.id}, #{residence.id} (#{spouse_user.first_name} #{spouse_user.last_name})"
          puts "--------------"
        end
      end
    end
  end
end
