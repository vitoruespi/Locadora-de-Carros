json.extract! emprestimo, :id, :locatario_id, :carro_id, :data_inicio, :data_fim, :valor_total, :created_at, :updated_at
json.url emprestimo_url(emprestimo, format: :json)
