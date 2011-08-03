class Player
  
  def initialize(game_window)
    @game_window = game_window
    @icon = Gosu::Image.new(@game_window, "img/player.png", true)
    @x = (@game_window.width / 2) - (@icon.width / 2)
    @y = @game_window.height - @icon.height
  end
  
  def draw
    @icon.draw(@x, @y, 1)
  end
  
  def move_left
    if @x < 0
      @x = 0
    else
      @x = @x - 10
    end
  end
  
  def move_right
    if @x > @game_window.width - @icon.width
      @x = @game_window.width - @icon.width
    else
      @x = @x + 10
    end
  end
  
  def hit_by?(balls)
    balls.any? {|ball| Gosu::distance(@x, @y, ball.x, ball.y) <= 15}
  end
  
  def hit_by_good?(ten_balls)
    ten_balls.any? {|ten_ball| Gosu::distance(@x, @y, ten_ball.x, ten_ball.y) <= 15}
  end
  
  def hit_by_good?(fifty_balls)
    fifty_balls.any? {|fifty_ball| Gosu::distance(@x, @y, fifty_ball.x, fifty_ball.y) <= 15}
  end
  
  def hit_by_good?(hundred_balls)
    hundred_balls.any? {|hundred_ball| Gosu::distance(@x, @y, hundred_ball.x, hundred_ball.y) <= 15}
  end
end