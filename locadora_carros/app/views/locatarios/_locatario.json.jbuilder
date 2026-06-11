json.extract! locatario, :id, :nome, :cpf, :telefone, :idade, :created_at, :updated_at
json.url locatario_url(locatario, format: :json)
