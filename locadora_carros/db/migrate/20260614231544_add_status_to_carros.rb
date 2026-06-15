class AddStatusToCarros < ActiveRecord::Migration[8.1]
  def change
    add_column :carros, :status, :string, default: "disponivel"
  end
end
