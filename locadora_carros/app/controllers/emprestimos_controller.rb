class EmprestimosController < ApplicationController
  before_action :set_emprestimo, only: %i[ show edit update destroy ]

  # GET /emprestimos or /emprestimos.json
  def index
    @emprestimos = Emprestimo.page(params[:page]).per(5)
    @emprestimoPDF = Emprestimo.all

    respond_to do |format|
      format.html

      # Geração do CSV
      format.csv { send_data Emprestimo.all.to_csv, filename: "historico_emprestimos.csv" }

      # Geração do PDF com Tabela Bonita
      format.pdf do
        pdf = Prawn::Document.new
        pdf.text "Relatório de Empréstimos", size: 20, style: :bold, align: :center
        pdf.move_down 20

        tabela_dados = [["ID", "Cliente", "Carro", "Data Início", "Data Fim", "Valor Total"]]

        @emprestimoPDF.each do |emp|
          tabela_dados << [
            emp.id.to_s,
            emp.locatario&.nome.to_s,
            emp.carro&.modelo.to_s,
            emp.data_inicio.strftime("%d/%m/%Y"), # Formata a data para o padrão BR
            emp.data_fim.strftime("%d/%m/%Y"),
            "R$ #{emp.valor_total}"
          ]
        end

        pdf.table(tabela_dados, header: true, width: pdf.bounds.width) do
          row(0).font_style = :bold
          row(0).background_color = "CCCCCC"
        end

        send_data pdf.render, filename: 'relatorio_emprestimos.pdf', type: 'application/pdf', disposition: "inline"
      end
    end
  end

  # GET /emprestimos/1 or /emprestimos/1.json
  def show
  end

  # GET /emprestimos/new
  def new
    @emprestimo = Emprestimo.new
  end

  # GET /emprestimos/1/edit
  def edit
  end

  # POST /emprestimos or /emprestimos.json
  def create
    @emprestimo = Emprestimo.new(emprestimo_params)

    respond_to do |format|
      if @emprestimo.save
        format.html { redirect_to @emprestimo, notice: "Emprestimo was successfully created." }
        format.json { render :show, status: :created, location: @emprestimo }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @emprestimo.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /emprestimos/1 or /emprestimos/1.json
  def update
    respond_to do |format|
      if @emprestimo.update(emprestimo_params)
        format.html { redirect_to @emprestimo, notice: "Emprestimo was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @emprestimo }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @emprestimo.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /emprestimos/1 or /emprestimos/1.json
  def destroy
    @emprestimo.destroy!

    respond_to do |format|
      format.html { redirect_to emprestimos_path, notice: "Emprestimo was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def destroy_all
    Emprestimo.destroy_all
    respond_to do |format|
      format.html { redirect_to emprestimos_url, notice: "Todos os empréstimos foram apagados e o ID voltou para 1!" }
    end
  end
  def marcar_emprestimo_como_finalizado
    @emprestimo = Emprestimo.find(params[:id])
    @emprestimo.update(status: "finalizado")
    @emprestimo.carro.update(status: "disponivel")
    redirect_to emprestimos_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_emprestimo
      @emprestimo = Emprestimo.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def emprestimo_params
      params.expect(emprestimo: [ :locatario_id, :carro_id, :data_inicio, :data_fim, :valor_total ])
    end
end
