namespace :migrate do
  desc 'Creates residences from existing users'
  task residences: :environment do
    User.find_each do |user|
      residence = Residence.create(
        street_number: user.street_number,
        street_id: user.street_id,
        lot: user.lot,
        block: user.block
      )

      ResidenceUser.create(
        user: user,
        residence: residence,
        is_owner: true,
        is_resident: true,
        year: user.purchase_year
      )

      unless user.spouse_name.blank?
        puts "Trying to find User(#{user.spouse_name} #{user.last_name})"
        # Create new user for the spouse
        spouse_user = User.find_by_first_name_and_last_name(user.spouse_name, user.last_name)
        if spouse_user.nil?
          puts "Didn't find User, creating #{user.spouse_name} #{user.last_name}"
          spouse_user = User.create(
            last_name: user.last_name,
            first_name: user.spouse_name,
            email: user.spouse_email ||= user.spouse_name.downcase + user.last_name.downcase + "@butlercreek.org",
            phone: user.spouse_phone,
            password: "changeme"
          )
          puts "Created User #{user.spouse_name} #{user.last_name}"
        end

        puts "Trying to find ResidenceUser(#{spouse_user.id}, #{residence.id})..."
        # Link the new spouse user to the newly created residence
        resident = ResidenceUser.find_by_user_id_and_residence_id(spouse_user.id, residence.id)
        if resident.nil?
          puts "Didn't find ResidenceUser, creating #{spouse_user.id}, #{residence.id}"
          ResidenceUser.create(
            user: spouse_user,
            residence: residence,
            is_owner: true,
            is_resident: true,
            year: user.purchase_year
          )
          puts "Created ResidenceUser #{spouse_user.id}, #{residence.id}"
        end
      end
    end
  end
end
