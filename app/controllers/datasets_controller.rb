class DatasetsController < ApplicationController

  def analisis
    dataset = Dataset.new(dataset_params)
    data_x = dataset.data_x.split(",").map(&:to_i)
    stats = DescriptiveStatistics::Stats.new(data_x)
    stats = stats.descriptive_statistics
    q1 = stats[:q1]
    q3 = stats[:q3]
    outliers = outliers_check(data_x, q1, q3 )
    stats[:outliers] = outliers
    stats.except!(:number, :sum, :variance, :standard_deviation,
                 :mode, :range, :q2)
    render json: stats
  end

  def correlation
    dataset = Dataset.new(dataset_params)
    data_x = dataset.data_x.split(",").map(&:to_i)
    data_y = dataset.data_y.split(",").map(&:to_i)
    correlation_coefficient = ruby_pearson(data_x, data_y)
    render json: correlation_coefficient
  end




  private

    # Only allow a trusted parameter "white list" through.
    def dataset_params
      params.permit(:data_x, :data_y)
    end

    # Findind Outliers in Data with the Tukey Method
    def outliers_check(data, q1, q3)
      irq         = q3 - q1
      lower_fence = q1 - (irq * 1.5)
      upper_fence = q3 + (irq * 1.5)
      lower_outliers = data.select { |num| num < lower_fence}
      upper_outliers = data.select { |num| num > upper_fence }
      outliers = lower_outliers + upper_outliers
    end


    def ruby_pearson(x,y)
      n = x.length

      sumx = x.inject(0) {|r,i| r + i}
      sumy = y.inject(0) {|r,i| r + i}

      sumxSq = x.inject(0) {|r,i| r + i**2}
      sumySq = y.inject(0) {|r,i| r + i**2}

      prods = []; x.each_with_index{|this_x,i| prods << this_x*y[i]}
      pSum = prods.inject(0){|r,i| r + i}

      # Calculate Pearson score
      num = pSum -(sumx*sumy/n)
      den = ((sumxSq -(sumx**2)/n)*(sumySq-(sumy**2)/n))**0.5
      if den == 0
        return 0
      end
      r = num/den
      return r
    end
end
