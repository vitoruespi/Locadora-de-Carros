class CreateCarros < ActiveRecord::Migration[8.1]
  def change
    create_table :carros do |t|
      t.string :modelo
      t.string :marca
      t.string :placa
      t.integer :ano
      t.string :cor

      t.timestamps
    end
  end
end
