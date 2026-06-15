class AddStatusToEmprestimo < ActiveRecord::Migration[8.1]
  def change
    add_column :emprestimos, :status, :string,default: "ativo"
  end
end
