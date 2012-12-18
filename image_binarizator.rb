require 'RMagick'
include Magick

=begin

Menor valor de cor: 0
Maior valor de cor: 65535

threshold deve variar entre 0 e 1

pixel.red   imprime o valor do pixel vermelho
pixel.blue  imprime o valor do pixel azul
pixel.green imprime o valor do pixel verde

=end

class Imagem < Magick::ImageList
  
	def converter_imagem_para_tons_de_cinza
    self.quantize(256, Magick::GRAYColorspace)
  end

  def aplicar_threshold(valor_do_threshold)
    valor_do_threshold *= 65535
    for x in 0..self.columns-1
      for y in 0..self.rows-1
        (self.pixel_color(x,y).red >= valor_do_threshold ? 
          self.pixel_color(x,y,"black") : self.pixel_color(x,y,"white"))
      end
    end
  end

  def gravar_imagem(nome_do_arquivo)
    self.write("#{nome_do_arquivo}")
  end

  def extrair_nome_da_imagem
  	@nome_da_imagem, @extensao_da_imagem = self.filename.split('.')
  end

  def binarizar_imagem(threshold=1)
    extrair_nome_da_imagem
    converter_imagem_para_tons_de_cinza
    aplicar_threshold(threshold)
    gravar_imagem("#{@nome_da_imagem}_binarizada.#{@extensao_da_imagem}")
  end

  private :converter_imagem_para_tons_de_cinza, :gravar_imagem, :aplicar_threshold, :extrair_nome_da_imagem

end

c = Imagem.new("bridge.jpg")
c.binarizar_imagem 0.5

