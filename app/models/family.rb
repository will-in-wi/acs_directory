class Family
  def self.all
    Individual.select(:family_id, :family_picture_url).distinct.map do |f|
      i = self.new(f.family_id)
      i.picture_url = f.family_picture_url
      i
    end
  end

  attr_reader :id
  attr_accessor :picture_url

  def initialize(id)
    @id = id
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
end
