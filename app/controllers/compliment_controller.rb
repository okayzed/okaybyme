class ComplimentController < ApplicationController
  def index
    @compliment = ComplimentGenerator.full_compliment
    images = Dir::glob "public/images/backgrounds/**/*.png"
    @background_image = images.rand.gsub!(/public\/images\//, "")
  end
end
