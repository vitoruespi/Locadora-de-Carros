class CreateCarros < ActiveRecord::Migration[8.1]
  def change
    create_table :carros, id: false do |t|
      t.string :modelo
      t.string :marca
      t.string :placa, primary_key: true
      t.integer :ano
      t.string :cor

      t.timestamps
    end
  end
end
