class Review < ApplicationRecord
  belongs_to :user
  belongs_to :reviewable, polymorphic: true

  after_create Proc.new{|review| up_review_count_of_user_owner(review)}
  after_destroy Proc.new{|review| down_review_count_of_user_owner(review)}

  private
  def up_review_count_of_user_owner(review)
    user = review.user
    user.review_count +=1
    user.save
  end

  private
  def down_review_count_of_user_owner(review)
    user = review.user
    user.review_count -=1
    user.save
  end
end
