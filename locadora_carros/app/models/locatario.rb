class Locatario < ApplicationRecord
  # :destroy: Significa que, se eu excluir o cliente do sistema,
  # todos os históricos de empréstimos dele serão apagados automaticamente do banco.
  has_many :emprestimos, dependent: :destroy

  # Um cliente tem muitos Carros "através" da tabela de Empréstimos.
  has_many :carros, through: :emprestimos

  #O nome deve ter pelo menos 3 letras.
  validates :nome, presence: true, length: { minimum: 3 }

  validates :cpf, presence: true, uniqueness: true

  #Indica que é um número que bloqueia o cadastro se o cliente for menor de idade.
  validates :idade, numericality: { greater_than_or_equal_to: 18 }
end
