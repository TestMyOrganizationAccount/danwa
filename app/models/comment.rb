class Comment < ApplicationRecord
  has_many :likes, dependent: :destroy
  belongs_to :user
  belongs_to :micropost
  mount_uploader :picture, PictureUploader
  validates :body , presence: true, length: { maximum: 255 }
  validates :user_id , presence: true
  validate  :picture_size

  def find_like_by(user)
   likes.find_by(user_id: user.id)
  end

  def liked?(comment)
   likes.find_by(comment_id: comment.id)
  end

  def self.sort_by_comment_count
    group(:micropost_id).order('count(micropost_id) desc').pluck(:micropost_id)
  end

  private

    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
