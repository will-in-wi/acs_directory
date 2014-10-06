class Family
  def self.all
    # Get a basic list of families.
    individuals = Individual.select(:family_id, :family_picture_url).distinct.where(member_status: Rails.configuration.acs_config['member_statuses'])

    # Turn this into family objects.
    individuals.map { |f| self.new(f.family_id, f.family_picture_url) }
  end

  attr_reader :id
  attr_accessor :picture_url

  def initialize(id, picture_url=nil)
    @id = id
    if picture_url
      @picture_url = picture_url
    else
      pic_indv = Individual.select(:family_picture_url).where(family_id: id).limit(1).first
      if pic_indv
        @picture_url = pic_indv.family_picture_url
      end
    end
  end

  def children
    @children ||= Individual.where(family_id: @id, family_position: 'Child')
  end

  def head
    @head ||= Individual.where(family_id: @id, family_position: 'Head').first
  end

  def spouse
    @spouse ||= Individual.where(family_id: @id, family_position: 'Spouse').first
  end

  def primary
    head || spouse
  end

  def name
    if spouse.nil?
      "#{head.first_name} #{head.last_name}"
    elsif head.nil?
      "#{spouse.first_name} #{spouse.last_name}"
    elsif head.last_name == spouse.last_name
      "#{head.first_name} and #{spouse.first_name} #{head.last_name}"
    else
      "#{head.first_name} #{head.last_name} and #{spouse.first_name} #{spouse.last_name}"
    end
  end

  def addresses
    primary.addresses.family
  end

  def phone_numbers
    primary.phone_numbers.family
  end
end
