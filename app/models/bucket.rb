class Bucket < ActiveRecord::Base
  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods

  validates :name, presence: true

  belongs_to :user
  has_many :moments
  has_many :units, -> { distinct }, through: :moments

  def sum_by_unit (id)
    moments.where(unit: id).sum 'value'
  end

  def all_sums_by_unit
    units.collect{|unit| {name: unit.name, value: sum_by_unit(unit.id)} }
  end


end
