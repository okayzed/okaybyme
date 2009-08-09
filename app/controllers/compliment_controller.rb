class ComplimentController < ApplicationController
  def index
    @compliment = ComplimentGenerator.full_compliment
    images = Dir::glob "public/images/backgrounds/**/*.png"
    @background_image = images.rand.gsub!(/public\/images\//, "")
  end

  def ajax_compliment
    compliment = ComplimentGenerator.full_compliment.downcase
    render :text => compliment
  end

  def ajax_why
    why_text =
      """
      insincere compliments from sincere robots. but... why? because i need
      cheering up.
      """
    render :text => why_text
  end
end
