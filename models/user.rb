# frozen_string_literal: true

class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  field :gitlab_id, type: Integer
  field :username, type: String
  field :email, type: String
  field :name, type: String

  field :avatar_url, type: String
  field :token, type: String

  validates :username, presence: true, length: { minimum: 3, maximum: 15 }, uniqueness: { case_sensitive: false }, format: { with: /\A[a-zA-Z0-9_\.]+\z/ }
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
end
