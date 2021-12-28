require 'ruby2d'

set width: 1024
set height: 768
set background: 'black'
set fps_cap: 10

$POPULATION = 500
$VARIANTS = ['blue', 'teal', 'olive', 'green', 'yellow', 'orange', 'red', 'purple', 'white', 'gray']
$SPEED_RANGE = (-15..15)
$SIZE_RANGE = (10..20)
$OPACITY = 0.3

class Agent
    attr_reader :x, :y
    attr_accessor :color, :size, :opacity

    def initialize
        @x = rand(Window.width)
        @y = rand(Window.height)
        @x_speed = $SPEED_RANGE.to_a.sample
        @y_speed = $SPEED_RANGE.to_a.sample
        @color = $VARIANTS.sample
        @size = $SIZE_RANGE.to_a.sample
        @opacity = $OPACITY
    end

    def draw
        Circle.new(x: @x, y: @y, radius: @size, color: @color, opacity: @opacity)
    end

    def move
        @x = (@x + @x_speed) % Window.width
        @y = (@y + @y_speed) % Window.height
    end

    def collision_check
        if collision_detected
            @x_speed = ([true, false].sample)? +@x_speed : -@x_speed 
            @y_speed = ([true, false].sample)? +@y_speed : -@y_speed    
        end
    end

    def collision_detected
        current_agent = self
        ($agents - Array(current_agent)).any? do |other_agent|
            dx = (other_agent.x + other_agent.size) - (current_agent.x + current_agent.size)
            dy = (other_agent.y + other_agent.size) - (current_agent.y + current_agent.size)
            distance = Math.sqrt(dx * dx + dy * dy)
        
            if (distance < other_agent.size + current_agent.size)
                if current_agent.color == other_agent.color
                    # Crescimento
                    current_agent.size = (current_agent.size + other_agent.size/3)
                    current_agent.opacity = (current_agent.opacity + other_agent.opacity) unless current_agent.opacity > 1
                    $agents.delete(other_agent)
                elsif (current_agent.opacity == $OPACITY && other_agent.opacity == $OPACITY) && (current_agent.size == other_agent.size)
                    # Mutação
                    current_agent.color = ($VARIANTS - [current_agent.color, other_agent.color]).sample 
                end
                true
            else
                false
            end
        end
    end

end

$agents = Array.new($POPULATION) { Agent.new }

update do
    clear
 
    Image.new('./bg.jpg', x: 0, y: 0, width: Window.width, height: Window.height, z: -10, opacity: 0.05)  
 
    Rectangle.new( x: 10, y: 10, width: 200, height: 230, color: 'white', z: 2, opacity: 0.3)

    Text.new("Population: #{$agents.count}", color: 'black', x: 20, y: 15, size: 18, z: 5)

    ty = 40
    $VARIANTS.each do |variant|
        cc = 0
        mx = 0
        $agents.each do |agtmp| 
            cc = cc +1 if agtmp.color == variant 
            mx = agtmp.size if agtmp.size > mx && agtmp.color == variant
        end
        Text.new("#{variant}: #{cc} / #{mx}", color: 'black', x: 20, y: ty , size: 18, z: 5)
        ty += 18
    end
 
    $agents.each do |agent|
        agent.draw
        agent.collision_check
        agent.move
    end
end

show