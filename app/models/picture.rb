require 'csv'
class Picture < ApplicationRecord
  attr_accessor :title, :title_cache

  mount_uploader :title, PhotoUploader

  def self.to_csv
    attributes = %w[picture_title id]
    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |picture|
        csv << picture.attributes.values_at(*attributes)
      end
    end
  end
end
