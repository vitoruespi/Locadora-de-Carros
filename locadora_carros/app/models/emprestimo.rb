class Emprestimo < ApplicationRecord
    # Entidade Associativa
  belongs_to :locatario, foreign_key: 'locatario_id', primary_key: 'cpf'
  belongs_to :carro, foreign_key: 'carro_id', primary_key: 'placa'


  # Exige que os dados financeiros e de data sejam obrigatoriamente preenchidos.
  validates :data_inicio, :data_fim, :valor_total, presence: true

  validates :carro_id, uniqueness: {
    scope: [:locatario_id, :data_inicio, :data_fim],
    message: "Já possui um empréstimo idêntico registrado nestas datas."

  }
  validate :carro_precisa_estar_disponivel, on: :create

  after_create :marcar_carro_como_alugado

  enum :status, {
    reservado: "reservado",
    ativo: "ativo",
    finalizado: "finalizado",
    cancelado: "cancelado"
  }


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

  private
  def carro_precisa_estar_disponivel
    if carro.alugado?
      errors.add(:carro_id, "já está alugado no momento.")
    end
  end

  def marcar_carro_como_alugado
    carro.update(status: "alugado")
  end

  def marcar_carro_como_disponivel
    carro.update(status: "disponivel")
  end

  def marcar_emprestimo_como_finalizado
    emprestimos.update(status: "finalizado")
  end

end
