# frozen_string_literal: true

class Repository
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  field :gitlab_id, type: Integer
  field :description, type: String
  field :name, type: String
  field :web_url, type: String

end
