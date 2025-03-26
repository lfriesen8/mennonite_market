ActiveAdmin.register Page do
    permit_params :title, :content, :slug
  
    index do
      selectable_column
      id_column
      column :title
      column :slug
      actions
    end
  
    form do |f|
      f.inputs do
        f.input :title
        f.input :slug
        f.input :content, as: :text
      end
      f.actions
    end
  end
  