class ComplimentController < ApplicationController
  def index
    @compliment = ComplimentGenerator.full_compliment
    @background_image = rand_background
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

  def ajax_who
    server = params[:who] || rand_background
    @name = File.basename(server, ".png")
    @what = File.dirname(server).split("/").last
    render :layout => false
  end

  private
  def rand_background
    images = Dir::glob "public/images/backgrounds/**/*.png"
    background_image = images.rand.gsub!(/public\/images\//, "")
  end
end
