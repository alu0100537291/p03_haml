require 'rack/request'
require 'rack/response'
require 'haml'
  
module RockPaperScissors

  class App 

    def initialize(app = nil)
      @app = app
      @content_type = :html
      @defeat = {'rock' => 'scissors', 'paper' => 'rock', 'scissors' => 'paper'} # Jugadas posibles
      @throws = @defeat.keys # Posibles tiradas
      
    end

    def haml(template, resultado)
      template_file = File.open(template, 'r')
      Haml::Engine.new(File.read(template_file)).render({},resultado)
    end

    def call(env)
      req = Rack::Request.new(env)

      req.env.keys.sort.each { |x| puts "#{x} => #{req.env[x]}" }

      computer_throw = @throws.sample # La tirada del PC es aleatoria

      player_throw = req.GET["choice"] # Jugada escogida por el Jugador

      anwser = if !@throws.include?(player_throw)
          "Escoja una jugada:"
        elsif player_throw == computer_throw
          "EMPATE"
        elsif computer_throw == @defeat[player_throw]
          "¡BIEN HECHO!; #{player_throw} GANA A #{computer_throw}"
        else
          "¡OUCH!; #{computer_throw} GANA #{player_throw}"
        end
	
	resultado = {
		:choose => @choose,
		:anwser => anwser,
		:throws => @throws,
		:computer_throw => computer_throw,
		:player_throw => player_throw 
    }
    
    res = Rack::Response.new(haml("views/index.html.haml", resultado))
     
    end # call
  end   # App
end     # RockPaperScissors