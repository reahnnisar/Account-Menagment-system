class Entry < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :amount, presence: true
  validates :entry_date, presence: true

  def in?
    self.amount > 0
  end

  def out?
    self.amount < 0
  end
end
