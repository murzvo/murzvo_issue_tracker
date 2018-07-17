# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates_presence_of :username
  validates_uniqueness_of :username, case_sensitive: false

  enum role: %i[regular manager]
end
