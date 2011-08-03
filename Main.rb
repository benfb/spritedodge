$: << File.expand_path(File.dirname(__FILE__))  

require 'rubygems'
require 'gosu'
require 'chipmunk'
require 'player'
require 'ball'
require 'ten_ball'
require 'fifty_ball'
require 'hundred_ball'
require 'map'
include Gosu

class SpriteDodge < Gosu::Window
  
  def initialize
    super(800, 600, false)
    @musicnumber = rand(2)
    @music = Gosu::Song.new(self, "sound/#{@musicnumber}.mp3")
    @player1 = Player.new(self)
    @balls = 3.times.map {Ball.new(self)}
    @ten_balls = 2.times.map {Ten_Ball.new(self)}
    @fifty_balls = 1.times.map {Fifty_Ball.new(self)}
    @hundred_balls = 1.times.map {Hundred_Ball.new(self)}
    @running = true
    @pause = false
    @font = Gosu::Font.new(self, "font/ayearwithoutrain.ttf", 43)
    @hit_sound = Gosu::Sample.new(self, "sound/hit.wav")
    @get_sound = Gosu::Sample.new(self, "sound/get.wav")
    @bgnumber = rand(5)
   # @map = Map.new(self, "lvl/1.txt")
    @background_image = Gosu::Image.new(self, "bg/#{@bgnumber}.png", true)
    @score = 0
    @health = 100
  end
  
  def button_down(id)
    if id == Gosu::Button::KbP
      if @pause == false
        @pause = true
      else
        @pause = false
      end
    end
    if id == Gosu::Button::KbQ
      @running = false
      close
    end
  end
  
  def update
    if @running == true and @pause == false
      
      if button_down? Gosu::Button::KbLeft
        @player1.move_left
      end
      if button_down? Gosu::Button::KbRight
        @player1.move_right
      end
      
      @balls.each {|ball| ball.update}
      
      @ten_balls.each {|ten_ball| ten_ball.update}
      
      @fifty_balls.each {|fifty_ball| fifty_ball.update}

      @hundred_balls.each {|hundred_ball| hundred_ball.update}
      
      if @player1.hit_by? @balls
        @health -= 10
        @hit_sound.play(vol=0.5, speed=1, looping=false)
        stop_game
      end
      
      if @player1.hit_by_good? @ten_balls
        @score += 10
        @get_sound.play(vol=0.5, speed=1, looping=false)
        stop_game
      end
      
      if @player1.hit_by_good? @fifty_balls
        @score += 50
        @get_sound.play(vol=0.5, speed=1, looping=false)
        stop_game
      end
      
      if @player1.hit_by_good? @hundred_balls
        @score += 100
        @get_sound.play(vol=0.5, speed=1, looping=false)
        stop_game
      end
      
    else
      # The game is currently stopped
      if button_down? Gosu::Button::KbSpace
        refresh_game
      end
      if button_down? Gosu::Button::KbR
        restart_game
      end
    end
    
  end
  
  def draw
    @music.play(looping = true)
    @background_image.draw(0, 0, 0)
    #@map.draw
    @player1.draw
    @balls.each {|ball| ball.draw} if @running == false
    @balls.each {|ball| ball.draw_rot} if @running == true
    @ten_balls.each {|ten_ball| ten_ball.draw}
    @fifty_balls.each {|fifty_ball| fifty_ball.draw}
    @hundred_balls.each {|hundred_ball| hundred_ball.draw}
    @font.draw_rel("The game is paused.", 400, 300, 10, 0.5, 0.5, factor_x=1, factor_y=1, Gosu::Color::BLACK) if @pause == true
    @font.draw_rel("Score: #{@score}", 40, 10, 10, 0.0, 0.0, factor_x=1, factor_y=1, Gosu::Color::BLACK)
    @font.draw_rel("Health: #{@health}", 650, 10, 10, 0.0, 0.0, factor_x=1, factor_y=1, Gosu::Color::BLACK)
    @font.draw_rel("GAME OVER. Press R to restart!", 400, 300, 13, 0.5, 0.5, factor_x=1, factor_y=1, Gosu::Color::BLACK) if @health <= 0
  end
  
  def stop_game
    @running = false
  end
  
  def refresh_game
    @running = true
    @balls.each {|ball| ball.reset}
    @ten_balls.each {|ten_ball| ten_ball.reset}
    @fifty_balls.each {|fifty_ball| fifty_ball.reset}
    @hundred_balls.each {|hundred_ball| hundred_ball.reset}
  end
  
  def restart_game
    @running = true
    @balls.each {|ball| ball.reset}
    @ten_balls.each {|ten_ball| ten_ball.reset}
    @fifty_balls.each {|fifty_ball| fifty_ball.reset}
    @hundred_balls.each {|hundred_ball| hundred_ball.reset}
    @score = 0
    @health = 100
    @background_image.draw(0, 0, 0)
  end

end

window = SpriteDodge.new
window.show