json.extract! carro, :id, :modelo, :marca, :placa, :ano, :cor, :created_at, :updated_at
json.url carro_url(carro, format: :json)
