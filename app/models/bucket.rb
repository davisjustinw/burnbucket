class Bucket < ActiveRecord::Base
  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods

  validates :name, presence: true
  #validate two moments?
  belongs_to :user
  has_many :bucket_moments
  has_many :moments, through: :bucket_moments

  has_many :units, -> { distinct }, through: :moments

  def sum_by_unit (id)
    moments.where(unit: id).sum('value') * potential
  end

  def all_sums_by_unit
    units.collect{|unit| {name: unit.name, value: sum_by_unit(unit.id)} }
  end


end
