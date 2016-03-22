class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :song

  validates :user_id, uniqueness: { scope: :song_id }

  # after_create :increase_like_counter, if: :like
  # #before_destroy :decrease_like_counter, if: :like

  # def increase_like_counter
  #   song.likes_counter += 1
  # end

  # def decrease_like_counter
  #   song.likes_counter -= 1
  # end  
end