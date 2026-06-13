class Emprestimo < ApplicationRecord
  # Entidade Associativa
  belongs_to :locatario
  belongs_to :carro

  # Exige que os dados financeiros e de data sejam obrigatoriamente preenchidos.
  validates :data_inicio, :data_fim, :valor_total, presence: true
  def self.to_csv
    CSV.generate(headers: true, col_sep: ';') do |csv|
      # Cabeçalho do arquivo
      csv << %w{ID Cliente Carro Data_Inicio Data_Fim Valor_Total}

      all.each do |emp|
        # Pegando os nomes através da associação em vez de exportar apenas números
        csv << [
          emp.id,
          emp.locatario&.nome,
          emp.carro&.modelo,
          emp.data_inicio,
          emp.data_fim,
          emp.valor_total
        ]
      end
    end
  end
end
