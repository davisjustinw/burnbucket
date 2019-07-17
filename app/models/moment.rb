class Moment < ActiveRecord::Base

  validates :name, presence: true

  belongs_to :user
  belongs_to :bucket
  belongs_to :unit

  def self.sum_by_unit(unit)
    Moment.where(unit_id: unit).sum('value')
  end

  def self.sum_by_unit_name(unit)
    Moment.where( unit_id: Unit.find_by(name: "dangles") ).sum('value')
  end

end
