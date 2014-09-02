class SequencesController < ApplicationController
  before_action :set_sequence, only: [:show, :edit, :update, :destroy]

  # GET /sequences
  # GET /sequences.json
  def index
    @dicodons = []
    @values = []
    if params[:search]
      if (params[:search] =~ /\A[ATCGatcg\W]+\z/ ? true : false)
          params[:search] = params[:search].gsub(/\W/, "").downcase
          @dicodons = Sequence.dicodons(params[:search])
          @values = Sequence.get_values(@dicodons)
      else
        flash.now[:alert] = 'Incorrect search parameters - Seek help'
      end
    end
  end

  # GET /sequences/1
  # GET /sequences/1.json
  def show
  end

  # GET /sequences/new
  def new
    @sequence = Sequence.new
  end

  # GET /sequences/1/edit
  def edit
  end

  # POST /sequences
  # POST /sequences.json
  def create
    @sequence = Sequence.new(sequence_params)

    respond_to do |format|
      if @sequence.save
        format.html { redirect_to @sequence, notice: 'Sequence was successfully created.' }
        format.json { render action: 'show', status: :created, location: @sequence }
      else
        format.html { render action: 'new' }
        format.json { render json: @sequence.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sequences/1
  # PATCH/PUT /sequences/1.json
  def update
    respond_to do |format|
      if @sequence.update(sequence_params)
        format.html { redirect_to @sequence, notice: 'Sequence was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sequence.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sequences/1
  # DELETE /sequences/1.json
  def destroy
    @sequence.destroy
    respond_to do |format|
      format.html { redirect_to sequences_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sequence
      @sequence = Sequence.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sequence_params
      params.require(:sequence).permit(:seq, amnioacid_files_attributes:[:id, :name, dicodon_files_attributes:[:id, :name, :freq, :aminoacid_id]])
    end
end
