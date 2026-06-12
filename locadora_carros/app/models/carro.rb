class Carro < ApplicationRecord
  # Um carro pode ser alugado várias vezes (vários empréstimos), segue a mesma ideia do destroy.
  has_many :emprestimos, dependent: :destroy

  # Um carro pode ter sido dirigido por vários Locatários (clientes) ao longo do tempo
  # por meio de empresitmos.
  has_many :locatarios, through: :emprestimos

  # Exige que na hora de cadastrar o carro, ninguém esqueça de pôr modelo, marca e placa.
  validates :modelo, :marca, :placa, presence: true

  # Garante que não existirão dois carros com a mesma placa no sistema da locadora.
  validates :placa, uniqueness: true
end