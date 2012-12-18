require_relative '../image_binarizator'
require 'spec_helper'

describe Imagem do
	it { respond_to :binarizar_imagem }

  context "#binarizar_imagem" do
    before :each do
      @img = Imagem.new("bridge.jpg")
      @img.binarizar_imagem 0.5
    end

    it "Image pixels has the same values" do
      @img.each_pixel do |pixel|
        (pixel.red == pixel.blue and pixel.red == pixel.green).should be_true
      end
    end

    it "Image pixels color are black or white" do
      @img.each_pixel do |pixel|
        ([0, 65535].include? pixel.red).should be_true
      end
    end

  end  
end