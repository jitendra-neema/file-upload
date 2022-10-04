class UplodersController < ApplicationController

  def index
    uploders = Uploder.all
  end
  
  def new
    uploder = Uploder.new
  end
  
  def create
    @uploder = Uploder.create(uploder_params)
    if @uploder.save
      render json: @uploder
      # format.json { render :show, status: :created, location: uploder }
    end
  end
  
  def edit
    @uploder = Uploder.find_by(params[:id])
  end
  
  def update
    @uploder = Uploder.find_by_id(params[:id])
    if @uploder.update(uploder_params)
      render json: @uploder
    end
  end
  
  def show
    @uploder = Uploder.find_by_id(params[:id])
    pdf = @uploder.combine_pdf
    send_file("combined.pdf")
    end
  
  def destroy
    uploder=Uploder.find[params[:id]]
    uploder.destroy
  end

  private

  def uploder_params
    params.permit(files: [])
  end

end
