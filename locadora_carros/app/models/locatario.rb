
require 'csv'
class Locatario < ApplicationRecord
  self.primary_key = 'cpf'

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

  def self.to_csv
    CSV.generate(headers: true, col_sep: ';') do |csv|
      # Cabeçalho do arquivo
      csv << %w{ID Nome CPF Telefone Idade}

      all.each do |locatario|
        csv << [
          locatario.id,
          locatario.nome,
          locatario.cpf,
          locatario.telefone,
          locatario.idade
        ]
      end
    end
  end
end
