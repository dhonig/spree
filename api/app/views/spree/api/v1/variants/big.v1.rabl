object @variant

cache [I18n.locale, @current_user_roles.include?('admin'), 'big_variant', root_object]

extends "spree/api/v1/variants/small"
<<<<<<< HEAD:api/app/views/spree/api/v1/variants/big.v1.rabl
=======

node :total_on_hand do
  root_object.total_on_hand
end

>>>>>>> Add v1 namespace for API.:api/app/views/spree/api/v1/variants/big.v1.rabl

child(:stock_items => :stock_items) do
  attributes :id, :count_on_hand, :stock_location_id, :backorderable
  attribute :available? => :available

  glue(:stock_location) do
    attribute :name => :stock_location_name
  end
end
