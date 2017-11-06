class Chef < ApplicationRecord
  validates :chefname, presence: true, length: {minimum:3, maximum:35}
  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum:350},
             format: {with: VALID_EMAIL_REGEX},
             uniqueness: {case_sensitive: false}
  


end