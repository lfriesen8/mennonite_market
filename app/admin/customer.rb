ActiveAdmin.register Customer do
    permit_params :email, :address, :province_id
  
    index do
      selectable_column
      id_column
      column :email
      column :address
      column("Province") { |customer| customer.province.name if customer.province }
      column :created_at
      actions
    end
  
    filter :email
    filter :address
    filter :province
    filter :created_at
  
    show do
      attributes_table do
        row :id
        row :email
        row :address
        row("Province") { |customer| customer.province.name if customer.province }
        row :created_at
        row :updated_at
      end
    end
  
    form do |f|
      f.inputs do
        f.input :email
        f.input :address
        f.input :province, as: :select, collection: Province.all
      end
      f.actions
    end
  end
  