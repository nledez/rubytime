class ActivityCustomPropertyValue
  include DataMapper::Model
  
  property :id, Serial
  property :activity_custom_property_id, Integer, :required => true
  property :activity_id, Integer, :required => true, :index => true
  property :numeric_value, BigDecimal, :scale => 2, :precision => 10
  property :updated_at,  DateTime
  property :created_at,  DateTime
  
  belongs_to :activity_custom_property
  belongs_to :activity
  
  validates_is_unique :activity_custom_property_id, :scope => :activity_id
  validates_present :value
  
  def value=(value)
    self.numeric_value = value.blank? ? nil : value
  end
  
  def value
    return nil if numeric_value.nil?
    numeric_value.to_i == numeric_value ? numeric_value.to_i : numeric_value.to_f
  end
  
  def incorrect_value?
    not valid? and (errors.on(:value) or errors.on(:numeric_value))
  end

end
