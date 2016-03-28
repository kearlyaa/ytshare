class Video < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 140, minimum: 3 }
  validates :url, presence: true, length: { maximum: 50, minimum: 3 }

  def previous
    @previous = Video.where('videos.id < ?', self.id).last
  end

  def next
    @next = Video.where('videos.id > ?', self.id).first
  end

  def last
    Video.last
  end
end
