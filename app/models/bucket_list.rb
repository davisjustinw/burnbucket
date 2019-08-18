class BucketList < ActiveRecord::Base

  validates :name, presence: true

  belongs_to :user

  has_many :buckets
  has_many :moments, through: :buckets
  has_many :units, -> { distinct }, through: :buckets

  def sum
    buckets.inject(0) { |sum, bucket| sum += bucket.sum }
  end

  def sum_by_unit (id)
    buckets.where(unit: id).inject(0) { |sum, bucket| sum += bucket.sum }
  end

  def all_sums_by_unit
    units.collect{|unit| {name: unit.name, value: sum_by_unit(unit.id)} }
  end

  def ratio
    all_sums = all_sums_by_unit
    #binding.pry
    if !all_sums.empty?

      max = all_sums.max {|a,b| a[:value] <=> b[:value]}
      min = all_sums.min {|a,b| a[:value] <=> b[:value]}
      if max != min
        max[:ratio] = min[:value] == 0 ? max[:value] : (max[:value] + 0.0) / min[:value]
        min[:ratio] = max[:value] == 0 ? min[:value] : (min[:value] + 0.0) / max[:value]
        ratio_hash = {max: max, min: min}
        #binding.pry
      end
    end

    ratio_hash
  end

  def unit
    if units.size > 1
      units.first.name
    end
  end

end
