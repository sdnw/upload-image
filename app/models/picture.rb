class Picture < ApplicationRecord
  attr_accessible :title, :title_cache

  mount_uploader :title, PhotoUploader
end
