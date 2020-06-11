class Product
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  attr_accessor :combo_quantity

  # field <name>, :type => <type>, :default => <value>
  field :title, type: String
  field :description, type: String
  field :genre, type: String
  field :category, type: String
  field :campaign_id, type: Integer
  field :points, type: Integer
  field :quantity, type: Integer
  field :limit_by_seller, type: Integer
  field :price, type: BigDecimal
  field :tax, type: BigDecimal
  field :active, type: Boolean
  field :need_certificate, type: Boolean
  field :start_time, type: DateTime
  field :end_time, type: DateTime
  field :active_channels, type: Array, default: []
  field :permitted_sellers_slugs, type: Array, default: []
  field :subproducts, type: Array, default: []

  validates :title, presence: true
  validates :description, presence: true
  validates :genre, presence: true
  validates :category, presence: true
  validates :campaign_id, presence: true
  validates :points, presence: true
  validates :quantity, presence: true
  validates :price, presence: true
  validates :tax, presence: true
  validates :active, presence: true
  validates :need_certificate, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  validate :subproducts_are_valid
  validate :package_have_subproducts
  validate :combo_have_quantity
  validate :can_have_subproducts
  validate :category_is_permitted
  validate :active_channels_are_permitted

  before_save :set_limit_by_seller_if_blank
  before_save :create_combo_subproducts

  scope :active, -> { where(active: true) }
  scope :not_expired, -> { for_js('this.end_time > param', param: Time.now) }
  # You can define indexes on documents using the index macro:
  # index :field <, :unique => true>

  # You can create a composite key in mongoid to replace the default id using the key macro:
  # key :field <, :another_field, :one_more ....>

  # after_save do |document|
  # end

  private

  def permitted_categories
    %w[individual package combo]
  end

  def permitted_active_channels
    %w[pos event_store seller_app seller_store]
  end

  def set_limit_by_seller_if_blank
    self.limit_by_seller = quantity if limit_by_seller.blank?
  end

  def create_combo_subproducts
    return unless category == 'combo'

    subproduct = {
      title:       title,
      description: description,
      campaign_id: campaign_id
    }

    combo_quantity.to_i.times do
      subproducts << subproduct
    end
  end

  def subproducts_are_valid
    return unless subproducts.present?

    subproducts.each do |subproduct|
      validates_subproduct(subproduct)
    end
  end

  def package_have_subproducts
    return unless category == 'package'

    errors.add(:product, 'category package should have subproducts') if subproducts.blank?
  end

  def validates_subproduct(subproduct)
    %w[campaign_id title description].each do |item|
      errors.add(:subproducts, "should have attribute #{item}") unless subproduct.as_json[item].present?
    end
  end

  def combo_have_quantity
    return unless category == 'combo'

    errors.add(:product, 'category combo should have postive combo_quantity') if combo_quantity.blank? || !combo_quantity.positive?
  end

  def can_have_subproducts
    return if category == 'package'

    errors.add(:product, "category #{category} can't have subproducts") if subproducts.present?
  end

  def category_is_permitted
    return if permitted_categories.include?(category)

    errors.add(:product, "category '#{category}' is invalid, should be in [#{permitted_categories.join(', ')}]")
  end

  def active_channels_are_permitted
    return if active_channels.empty?

    active_channels.each do |channel|
      next if permitted_active_channels.include?(channel)

      errors.add(:product, "active_channel '#{channel}' is invalid, should be in [#{permitted_active_channels.join(', ')}]")
    end
  end
end
