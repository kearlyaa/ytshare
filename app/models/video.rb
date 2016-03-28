class Video < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 140, minimum: 3 }
  validates :url, presence: true, length: { maximum: 50, minimum: 3 }

  def previous
    Video.where('video.id < ?', self.id).first
  end

  def next
    Video.where('video.id > ?', self.id).last
  end
end
