ActiveAdmin.register Product do
  permit_params :name, :description, :price, :stock_quantity, :category_id, :image

  # Explicitly set the filters (removing image from the filters)
  filter :name
  filter :category
  filter :price
  filter :stock_quantity
  filter :created_at
  filter :updated_at

  # Index view
  index do
    selectable_column
    id_column
    column :name
    column :price
    column :stock_quantity
    column :category
    column :image do |product|
      if product.image.attached?
        image_tag url_for(product.image), size: "50x50"
      end
    end
    actions
  end

  # Form view for creating/updating products
  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      f.input :stock_quantity
      f.input :category
      f.input :image, as: :file
    end
    f.actions
  end
end

