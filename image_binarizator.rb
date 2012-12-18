require 'RMagick'
include Magick

=begin

Menor valor de cor: 0
Maior valor de cor: 65535

threshold deve variar entre 0 e 1

pixel.red   imprime o valor do pixel vermelho
pixel.blue  imprime o valor do pixel azul
pixel.green imprime o valor do pixel

=end

class Imagem < Magick::Image

  def initialize(nome_da_imagem)
    @nome_do_arquivo, @extensao_do_arquivo = nome_da_imagem.split('.')
    @imagem = ImageList.new("#{nome_da_imagem}")
  end

  def converter_imagem_para_tons_de_cinza
    @imagem = @imagem.quantize(256, Magick::GRAYColorspace)
  end

  def aplicar_threshold(valor_do_threshold)
    valor_do_threshold *= 65535
    for x in 0..@imagem.columns-1
      for y in 0..@imagem.rows-1
        (@imagem.pixel_color(x,y).red >= valor_do_threshold ? 
          @imagem.pixel_color(x,y,"black") : @imagem.pixel_color(x,y,"white"))
      end
    end
  end

  def gravar_imagem(imagem, nome_do_arquivo)
    imagem.write("#{nome_do_arquivo}")
  end

  def binarizar_imagem(threshold=1)
    converter_imagem_para_tons_de_cinza
    aplicar_threshold(threshold)
    gravar_imagem(@imagem, 
      "#{@nome_do_arquivo}_versao_binarizada.#{@extensao_do_arquivo}")
  end

  private :converter_imagem_para_tons_de_cinza, :gravar_imagem, :aplicar_threshold

end


c = Imagem.new("bridge.jpg")
c.binarizar_imagem 0.5





