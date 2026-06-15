class Carro < ApplicationRecord
  self.primary_key = 'placa'
  # Um carro pode ser alugado várias vezes (vários empréstimos), segue a mesma ideia do destroy.
  has_many :emprestimos, dependent: :destroy

  # Um carro pode ter sido dirigido por vários Locatários (clientes) ao longo do tempo
  # por meio de empresitmos.
  has_many :locatarios, through: :emprestimos

  # Exige que na hora de cadastrar o carro, ninguém esqueça de pôr modelo, marca e placa.
  validates :modelo, :marca, :placa, presence: true

  # Garante que não existirão dois carros com a mesma placa no sistema da locadora.
  validates :placa, uniqueness: true

  # Mapeia os status que o carro pode ter
  enum :status, { disponivel: "disponivel", alugado: "alugado", manutencao: "manutencao" }
  def self.to_csv
    CSV.generate(headers: true, col_sep: ';') do |csv|
      csv << %w{id Modelo Placa}
      all.each do |carro|
        csv << [carro.id, carro.modelo, carro.placa]
      end
    end
  end
end