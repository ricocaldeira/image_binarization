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

  def gravar(nome_do_arquivo)
    self.write("#{nome_do_arquivo}")
  end

  def extrair_nome
    @nome_da_imagem, @extensao_da_imagem = self.filename.split('.')
  end

  def binarizar(threshold=1)
    extrair_nome
    converter_imagem_para_tons_de_cinza
    aplicar_threshold(threshold)
    gravar("#{@nome_da_imagem}_binarizada.#{@extensao_da_imagem}")
  end

  private :converter_imagem_para_tons_de_cinza, :gravar, :aplicar_threshold, :extrair_nome

end

module Menu

  def self.mostrar_menu
    definir_imagem_a_ser_binarizada
    definir_nivel_de_threshold
    @imagem = Imagem.new("#{@nome_do_arquivo}")
    @imagem.binarizar @threshold
  end

  private

  def self.definir_imagem_a_ser_binarizada
    print "Digite o nome completo do arquivo de imagem: "
    @nome_do_arquivo = gets.chomp
  end

  def self.definir_nivel_de_threshold
    print "Digite o nivel de threshold desejado (de 0 a 1): "
    @threshold = gets.to_f
    unless @threshold > 0 and @threshold < 1
      puts "Nivel de threshold invalido!"
      definir_nivel_de_threshold
    end
  end

end

Menu.mostrar_menu

