ActiveAdmin.register Order do
  # Permit necessary parameters including customer and status
  permit_params :customer_id, :total_price, :gst, :pst, :hst, :status

  # Preload associations for performance
  includes :customer, order_items: :product

  # Displayed columns on the index page
  index do
    selectable_column
    id_column

    column "Customer", sortable: 'customer_id' do |order|
      order.customer&.email
    end

    column "Address" do |order|
      order.customer&.address
    end

    column "Province" do |order|
      order.customer&.province&.name || "N/A"
    end

    column "Products Ordered" do |order|
      order.order_items.map do |item|
        "#{item.product.name} (x#{item.quantity})"
      end.join(", ").html_safe
    end

    column :status
    column :gst
    column :pst
    column :hst
    column :total_price
    column :created_at

    actions
  end

  # Filters for searching
  filter :status, as: :select, collection: Order::STATUSES
  filter :customer_email, as: :string
  filter :total_price
  filter :created_at

  # Detailed view
  show do
    attributes_table do
      row :id
      row("Customer") { |order| order.customer&.email }
      row("Address") { order.customer&.address }
      row("Province") { order.customer&.province&.name || "N/A" }
      row :status
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

  # Form for creating or editing orders
  form do |f|
    f.inputs do
      f.input :customer, collection: Customer.all.map { |c| [c.email, c.id] }, include_blank: false
      f.input :status, as: :select, collection: Order::STATUSES, include_blank: false
      f.input :gst
      f.input :pst
      f.input :hst
      f.input :total_price
    end
    f.actions
  end
end




