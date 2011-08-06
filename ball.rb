class Ball
  def initialize(game_window)
    @game_window = game_window
    @icon = Gosu::Image.new(@game_window, "img/ball.png", true)
    @rotation = 0
    @falling_sound = Gosu::Sample.new(@game_window, "sound/fall.wav")
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
    @icon.draw(@x,@y, 2)
  end
  
  def draw_rot
    @icon.draw_rot(@x,@y,2, @rotation += 3, 0.5, 0.5, 1, 1)
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
    @falling_sound.play(vol=0.5, speed=1, looping=false)
  end
  
end