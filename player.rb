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
    balls.any? {|ball| Gosu::distance(@x, @y, ball.x, ball.y) < 30}
  end
  
  def hit_by_good?(good_balls)
    good_balls.any? {|good_ball| Gosu::distance(@x, @y, good_ball.x, good_ball.y) < 30}
  end
end