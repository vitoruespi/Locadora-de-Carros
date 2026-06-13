class LocatariosController < ApplicationController
  before_action :set_locatario, only: %i[ show edit update destroy ]

  # GET /locatarios or /locatarios.json
  def index
    @locatarios = Locatario.all

    respond_to do |format|
      format.html

      # Geração do CSV
      format.csv { send_data Locatario.all.to_csv, filename: "lista_locatarios.csv" }

      # Geração do PDF com Tabela Bonita
      format.pdf do
        pdf = Prawn::Document.new
        pdf.text "Relatório de Locatários", size: 20, style: :bold, align: :center
        pdf.move_down 20

        tabela_dados = [["ID", "Nome", "CPF", "Telefone", "Idade"]]

        @locatarios.each do |loc|
          tabela_dados << [
            loc.id.to_s,
            loc.nome,
            loc.cpf,
            loc.telefone,
            loc.idade.to_s
          ]
        end

        pdf.table(tabela_dados, header: true, width: pdf.bounds.width) do
          row(0).font_style = :bold
          row(0).background_color = "CCCCCC"
        end

        send_data pdf.render, filename: 'relatorio_locatarios.pdf', type: 'application/pdf', disposition: "inline"
      end
    end
  end

  # GET /locatarios/1 or /locatarios/1.json
  def show
  end

  # GET /locatarios/new
  def new
    @locatario = Locatario.new
  end

  # GET /locatarios/1/edit
  def edit
  end

  # POST /locatarios or /locatarios.json
  def create
    @locatario = Locatario.new(locatario_params)

    respond_to do |format|
      if @locatario.save
        format.html { redirect_to @locatario, notice: "Locatario was successfully created." }
        format.json { render :show, status: :created, location: @locatario }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @locatario.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /locatarios/1 or /locatarios/1.json
  def update
    respond_to do |format|
      if @locatario.update(locatario_params)
        format.html { redirect_to @locatario, notice: "Locatario was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @locatario }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @locatario.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /locatarios/1 or /locatarios/1.json
  def destroy
    @locatario.destroy!

    respond_to do |format|
      format.html { redirect_to locatarios_path, notice: "Locatario was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end
  def destroy_all
    Locatario.destroy_all
    respond_to do |format|
      format.html { redirect_to locatarios_url, notice: "Todos os locatários foram apagados e o ID voltou para 1!" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_locatario
      @locatario = Locatario.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def locatario_params
      params.expect(locatario: [ :nome, :cpf, :telefone, :idade ])
    end
end
