class Picture < ApplicationRecord
  attr_accessor :title, :title_cache

  mount_uploader :title, PhotoUploader
end
