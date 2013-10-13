require 'rack/request'
require 'rack/response'
require 'haml'
  
module RockPaperScissors
  class App 

    def initialize(app = nil)
      @app = app
      @content_type = :html
      # Posibles jugadas
      @defeat = {'rock' => 'scissors', 'paper' => 'rock', 'scissors' => 'paper'}
      # Posibles tiradas
      @throws = @defeat.keys
      
    end

    def haml(template, resultado)
      template_file = File.open(template, 'r')
      Haml::Engine.new(File.read(template_file)).render({},resultado)
    end

    def call(env)
      req = Rack::Request.new(env)

      req.env.keys.sort.each { |x| puts "#{x} => #{req.env[x]}" }

      # El ordenador tira (al azar)
      computer_throw = @throws.sample
      # El Jugador escoge (por medio de botones)
      player_throw = req.GET["choice"] # del path

      anwser = 
        if (player_throw == computer_throw && (player_throw != '' && computer_throw != ''))
          "TIE"
        elsif computer_throw == @defeat[player_throw]
          "WIN"
        else
          "LOSE"
        end
	
  # Hash con info
	resultado = 
		{
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
  

