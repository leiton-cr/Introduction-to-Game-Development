--[[
    Libreria que permite dibujar el juego a una 
    resolucion virtual sin importar el tamaño de 
    la ventana. 
]] --
push = require 'push'

--[[
    Libreria que facilita la creacion de clases. 
]] --
Class = require 'class'

-- Importacion de objetos
require 'Ball'
require 'Paddle'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- Velocidad de movimiento a multiplicar por el delta time
PADDLE_SPEED = 200

-- Inicializar el juego, corre solo una vez.
function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('PONG!')

    math.randomseed(os.time())

    smallFont = love.graphics.newFont('font.ttf', 8);
    scoreFont = love.graphics.newFont('font.ttf', 32);

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    ballDX = math.random(2) == 1 and 100 or -100    --  Velocidad en X positiva o negativa segun el random.
    ballDY = math.random(-50, 50) * 1.5             --  Velocidad en Y para que se dirija arriba o abajo.

    gameState = 'start'                             -- Estado del juego

    player1 = Paddle(10, 30, 5, 20)
    player2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20)

    ball = Ball(4, 4)
end

-- Actualizar parametros.
function love.update(dt)
    if love.keyboard.isDown('w') then
        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        player1.dy = PADDLE_SPEED
    end

    if love.keyboard.isDown('up') then
        player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        player2.dy = PADDLE_SPEED
    end

    if gameState == 'play' then

        if ball:collides(player1) then
            ball.dx = -ball.dx * 1.03
            ball.x = player1.x + 5

            if ball.dy < 0 then
                ball.dy = -math.random(10,150)
            else
                ball.dy = math.random(10,150)
            end
        end

        if ball:collides(player2) then
            ball.dx = -ball.dx * 1.03
            ball.x = player2.x - 4

            if ball.dy < 0 then
                ball.dy = -math.random(10,150)
            else
                ball.dy = math.random(10,150)
            end
        end

        if ball.y <= 0 or ball.y >= VIRTUAL_HEIGHT - 4 then
            ball.dy = -ball.dy
        end


        ball:update(dt)
    end

    player1:update(dt)
    player2:update(dt)
   
end

function love.keypressed(key)

    if key == 'escape' then
        return love.event.quit()
    end

    if key ~= 'enter' and key ~= 'return' then
        return
    end

    if gameState == 'start' then
        gameState = 'play'
        return
    end

    gameState = 'start'

    ball:reset()
end

-- Renderizado.
function love.draw()

    push:apply('start') -- Starts virtual resolution

    love.graphics.clear(40, 45, 52, 0.3)

    love.graphics.setFont(smallFont);
    love.graphics.printf('PONG!', 0, 10 - 6, VIRTUAL_WIDTH, 'center')
    
    
    -- Paddles
    player1:render()
    player2:render()

    -- Ball
    ball:render()

    -- Score
    displayScore()

    displayFPS()

    push:apply('end') -- Ends virtual resolution
end

function displayScore()
    love.graphics.setFont(scoreFont);
    love.graphics.print(tostring(player1.score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2.score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)
end

function displayFPS()
    love.graphics.setFont(smallFont);
    love.graphics.setColor(0,255,0,255)
    love.graphics.printf(tostring(love.timer.getFPS()) .. 'fps', 0, VIRTUAL_HEIGHT - 10, VIRTUAL_WIDTH, 'center')
end

-- Voy por 1:13