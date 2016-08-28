class DatasetsController < ApplicationController

  def analisis
    @dataset = Dataset.new(dataset_params)
    render json: @dataset
  end


  private

    # Only allow a trusted parameter "white list" through.
    def dataset_params
      params.permit(:data_x, :data_y)
    end
end
