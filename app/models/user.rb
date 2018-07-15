# frozen_string_literal: true

class User < ApplicationRecord
  include ActiveModel::AttributeMethods

  has_secure_password

  validates_presence_of :username
  validates_uniqueness_of :username, case_sensitive: false
end
