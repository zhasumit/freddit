class Vote < ApplicationRecord
  belongs_to :account
  belongs_to :post

  validates_uniqueness_of :account_id, scope: :post_id

  after_create :increment_votes
  after_destroy :decrement_votes

  private

  def increment_votes
    field = self.upvote ? :upvotes : :downvotes
    Post.find(self.post_id).increment(field).save
  end

  def decrement_votes
    field = self.upvote ? :upvotes : :downvotes
    Post.find(self.post_id).decrement(field).save
  end
end
