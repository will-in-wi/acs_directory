class Family
  def self.all
    Individual.select(:family_id).distinct.map { |f| self.new(f.family_id) }
  end

  attr_reader :id

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
    elsif head.last_name == spouse.last_name
      "#{head.first_name} and #{spouse.first_name} #{head.last_name}"
    else
      "#{head.first_name} #{head.last_name} and #{spouse.first_name} #{spouse.last_name}"
    end
  end
end
