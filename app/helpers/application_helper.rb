module ApplicationHelper
  def board_name(member)
    (member.spouse ? member.user.spouse_name : member.user.first_name) + " " + member.user.last_name
  end

  def board_email(member)
    member.spouse && member.user.spouse_email ? member.user.spouse_email : member.user.email
  end

  def board_phone(member)
    member.spouse && member.user.spouse_phone ? member.user.spouse_phone : member.user.phone
  end
end
