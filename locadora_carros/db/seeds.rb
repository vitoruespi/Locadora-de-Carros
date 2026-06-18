# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Cadastrando carros de teste..."
30.times do |i|
  Carro.create!(
    modelo: " #{i + 1}",
    marca: "#{%w[Toyota Fiat Ford Honda Volkswagen Chevrolet BYD Hyundai GWM BMW Porsche Land_Rover].sample}",
    placa: "ABC-10#{i < 10 ? "0#{i}" : i}",
    ano: rand(1990..2026),
    cor: %w[Prata Preto Branco Vermelho Amarelo Verde Cinza Azul Escuro Azul Claro Branco Neve Amarelo Banana Prateado"].sample
  )
end

nomes = ["João Silva", "Maria Santos", "Pedro Almeida", "Ana Costa", "Lucas Oliveira"]
telefones = ["11999998888", "21988887777", "31977776666", "41966665555", "51955554444"]

5.times do |i|
  Locatario.create!(
    nome: nomes[i],
    cpf: "1234567890#{i}", # Gera CPFs textuais únicos: 12345678900, 12345678901...
    idade: rand(21..65),
    telefone: telefones[i]
  )
end

sobrenomes = %w[Silva Santos Oliveira Souza Ferreira Alves Pereira Lima Costa Gomes Martins Ribeiro Almeida Carvalho Costa]

30.times do |i|
  Locatario.create!(
    nome: "#{nomes.sample} #{sobrenomes.sample}",

    # O 'format' garante que o i (0, 1, 2) vire sempre dois dígitos (00, 01, 02)
    # Isso gera CPFs únicos de 11 dígitos: "10020030000", "10020030001", etc.
    cpf: "100.200.300-#{format('%02d', i)}",

    # Gera um número de telefone com DDD e formato padrão, ex: (11) 98765-4321
    telefone: "(#{rand(11..99)}) 9#{rand(7000..9999)}-#{rand(1000..9999)}",

    # Sorteia uma idade realista para aluguel de carros (entre 21 e 75 anos)
    idade: rand(21..75)
  )
end

