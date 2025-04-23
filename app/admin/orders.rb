ActiveAdmin.register Order do
  # Permit necessary parameters
  permit_params :customer_id, :total_price, :gst, :pst, :hst

  # Preload associations for performance
  includes :customer, order_items: :product

  # Displayed columns on the index page
  index do
    selectable_column
    id_column

    column "Customer", sortable: 'customer_id' do |order|
      order.customer.email
    end

    column "Address" do |order|
      order.customer.address
    end

    column "Province" do |order|
      order.customer.province.name rescue "N/A"
    end

    column "Products Ordered" do |order|
      order.order_items.map do |item|
        "#{item.product.name} (x#{item.quantity})"
      end.join(", ").html_safe
    end

    column :gst
    column :pst
    column :hst
    column :total_price
    column :created_at

    actions
  end

  # Filters for searching
  filter :customer_email, as: :string
  filter :total_price
  filter :created_at

  # Detailed view
  show do
    attributes_table do
      row :id
      row("Customer") { |order| order.customer.email }
      row("Address") { order.customer.address }
      row("Province") { order.customer.province.name rescue "N/A" }
      row :gst
      row :pst
      row :hst
      row :total_price
      row :created_at
      row :updated_at
    end

    panel "Ordered Products" do
      table_for order.order_items do
        column("Product") { |item| item.product.name }
        column :quantity
        column :price
        column("Subtotal") { |item| number_to_currency(item.quantity * item.price) }
      end
    end
  end
end

