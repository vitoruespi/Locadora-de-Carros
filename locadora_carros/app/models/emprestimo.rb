class Emprestimo < ApplicationRecord
  # Entidade Associativa
  belongs_to :locatario
  belongs_to :carro

  # Exige que os dados financeiros e de data sejam obrigatoriamente preenchidos.
  validates :data_inicio, :data_fim, :valor_total, presence: true
end
