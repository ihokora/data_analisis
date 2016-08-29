class DatasetsController < ApplicationController

  def analisis
    dataset = Dataset.new(dataset_params)
    data_x = dataset.data_x.split(",").map(&:to_i)
    stats = DescriptiveStatistics::Stats.new(data_x)
    stats = stats.descriptive_statistics
    render json: stats
  end




  private

    # Only allow a trusted parameter "white list" through.
    def dataset_params
      params.permit(:data_x, :data_y)
    end
end
