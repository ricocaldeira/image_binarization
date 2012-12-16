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

class Imagem

	def initialize(nome_da_imagem)
		@nome_do_arquivo = nome_da_imagem.sub(".jpg", "")
		@imagem = ImageList.new("#{nome_da_imagem}")
	end

	def converter_para_escala_de_cinza
		@imagem = @imagem.quantize(256, Magick::GRAYColorspace)
	end

	def mostra_pixels
		@imagem.each_pixel do |pixel|
			puts pixel
		end
	end

	def binarizar_imagem(threshold=1)
		converter_para_escala_de_cinza
		threshold *= 65535
		for x in 0..@imagem.columns-1
			for y in 0..@imagem.rows-1
				if @imagem.pixel_color(x,y).red >= threshold
					@imagem.pixel_color(x,y,"black")
				else
					@imagem.pixel_color(x,y,"white")
				end
			end
		end
		gravar_imagem(@imagem, "#{@nome_do_arquivo}_versao_binarizada.jpg")
	end

	def gravar_imagem(imagem, nome_do_arquivo)
		imagem.write("#{nome_do_arquivo}")
	end

	private :converter_para_escala_de_cinza, :gravar_imagem

end


c = Imagem.new("bridge.jpg")
c.binarizar_imagem 0.5






