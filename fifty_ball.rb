class Fifty_Ball
  def initialize(game_window)
    @game_window = game_window
    @icon = Gosu::Image.new(@game_window, "img/fifty_ball.png", true)
    @rotation = 0
    @get_sound = Gosu::Sample.new(@game_window, "sound/get.wav")
    reset
  end
  
  def update
    if @y > @game_window.height
      reset
    else
      @y = @y + 6
    end
  end
  
  def draw
    @icon.draw(@x,@y,3)
  end
  
  def x
    @x
  end
  
  def y
    @y
  end
  
  def reset
    @y = 0
    @x = rand(@game_window.width)
  end
  
end