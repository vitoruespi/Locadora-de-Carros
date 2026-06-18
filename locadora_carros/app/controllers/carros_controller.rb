class CarrosController < ApplicationController
  before_action :set_carro, only: %i[ show edit update destroy ]

  # GET /carros or /carros.json

  def index
    #limita a quantidade de carros que aparece pro página :v
     @carros = Carro.page(params[:page]).per(8)
     @carrosPDF = Carro.all

    #Loop responsavel
     respond_to do |format|
       format.html

       #Gera o CSV
       format.csv { send_data Carro.all.to_csv, filename: "lista_carros.csv" }

       #Gera o PDF com Tabela
       format.pdf do
         pdf = Prawn::Document.new
         pdf.text "Relatório de Carros Cadastrados", size: 20, style: :bold, align: :center
         pdf.move_down 20

         tabela_dados = [["ID", "Modelo", "Marca", "Placa"]]
         @carrosPDF.each do |carro|
           tabela_dados << [carro.id.to_s, carro.modelo, carro.marca, carro.placa]
         end

         pdf.table(tabela_dados, header: true, width: pdf.bounds.width) do
           row(0).font_style = :bold
           row(0).background_color = "CCCCCC"
         end

         send_data pdf.render, filename: 'relatorio_carros.pdf', type: 'application/pdf', disposition: "inline"
       end
     end
  end

  # GET /carros/1 or /carros/1.json
  def show
  end

  # GET /carros/new
  def new
    @carro = Carro.new
  end

  # GET /carros/1/edit
  def edit
  end

  # POST /carros or /carros.json
  def create
    @carro = Carro.new(carro_params)

    respond_to do |format|
      if @carro.save
        format.html { redirect_to @carro, notice: "Carro was successfully created." }
        format.json { render :show, status: :created, location: @carro }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @carro.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /carros/1 or /carros/1.json
  def update
    respond_to do |format|
      if @carro.update(carro_params)
        format.html { redirect_to @carro, notice: "Carro was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @carro }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @carro.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /carros/1 or /carros/1.json
  def destroy
    @carro.destroy!

    respond_to do |format|
      format.html { redirect_to carros_path, notice: "Carro was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def destroy_all
    Carro.destroy_all
    respond_to do |format|
      format.html { redirect_to carros_url, notice: "Todos os carros foram apagados com sucesso!" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_carro
      @carro = Carro.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def carro_params
      params.expect(carro: [ :modelo, :marca, :placa, :ano, :cor ])
    end
end
