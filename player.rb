class Player
  
  def initialize(game_window)
    @game_window = game_window
    @icon = Gosu::Image.new(@game_window, "img/player.png", true)
    @x = (@game_window.width / 2) - (@icon.width / 2)
    @y = 540
  end
  
  def draw
    @icon.draw_rot(@x, @y, 1, 0, 0.5, 0.5)
  end
  
  def move_left
    @x = [@x - 10, 0].max
  end
  
  def move_right
    if @x > 800
      @x = 800
    else
      @x = [@x + 10, 0].max
    end
  end
  
  def hit_by?(balls)
    balls.any? {|ball| Gosu::distance(@x, @y, ball.x, ball.y) <= 55}
  end
  
  def hit_by_good?(ten_balls)
    ten_balls.any? {|ten_ball| Gosu::distance(@x, @y, ten_ball.x, ten_ball.y) <=55}
  end
  
  def hit_by_good?(fifty_balls)
    fifty_balls.any? {|fifty_ball| Gosu::distance(@x, @y, fifty_ball.x, fifty_ball.y) <= 55}
  end
  
  def hit_by_good?(hundred_balls)
    hundred_balls.any? {|hundred_ball| Gosu::distance(@x, @y, hundred_ball.x, hundred_ball.y) <= 55}
  end
end