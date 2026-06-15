class CreateEmprestimos < ActiveRecord::Migration[8.1]
  def change
    create_table :emprestimos do |t|
      t.references :locatario, null: false, type: :string, foreign_key: { primary_key: :cpf }
      t.references :carro, null: false, type: :string, foreign_key: { primary_key: :placa }
      t.date :data_inicio
      t.date :data_fim
      t.decimal :valor_total

      t.timestamps
    end
  end
end
