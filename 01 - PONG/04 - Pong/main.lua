--[[
    Libreria que permite dibujar el juego a una 
    resolucion virtual sin importar el tamaño de 
    la ventana. 
]] --
push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- Velocidad de movimiento a multiplicar por el delta time
PADDLE_SPEED = 200

-- Inicializar el juego, corre solo una vez.
function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

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

    score1 = 0;
    score2 = 0;

    ballX = VIRTUAL_WIDTH / 2 - 2                   -- Posicion X de la bola
    ballY = VIRTUAL_HEIGHT / 2 - 2                  -- Posicion Y de la bola

    posPaddle1 = 30;
    posPaddle2 = VIRTUAL_HEIGHT - 50;

end

-- Actualizar parametros.
function love.update(dt)
    if love.keyboard.isDown('w') then
        posPaddle1 = math.max(0, posPaddle1 + -PADDLE_SPEED * dt)                   -- Con math max evita que se salga hacia arriba
    elseif love.keyboard.isDown('s') then
        posPaddle1 = math.min(VIRTUAL_HEIGHT - 20, posPaddle1 + PADDLE_SPEED * dt)  -- Con math min evita que se salga hacia abajo
    end

    if love.keyboard.isDown('up') then
        posPaddle2 = math.max(0, posPaddle2 + -PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('down') then
        posPaddle2 = math.min(VIRTUAL_HEIGHT - 20, posPaddle2 + PADDLE_SPEED * dt)
    end

    if gameState == 'play' then
        ballX = ballX + ballDX * dt
        ballY = ballY + ballDY * dt
    end

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

    ballDX = math.random(2) == 1 and 100 or -100
    ballDY = math.random(-50, 50) * 1.5

    ballX = VIRTUAL_WIDTH / 2 - 2
    ballY = VIRTUAL_HEIGHT / 2 - 2

end

-- Renderizado.
function love.draw()

    push:apply('start') -- Starts virtual resolution

    love.graphics.clear(40, 45, 52, 0.3)

    love.graphics.setFont(smallFont);
    love.graphics.printf('PONG!', 0, 10 - 6, VIRTUAL_WIDTH, 'center')

    -- Paddles
    love.graphics.rectangle('fill', 10, posPaddle1, 5, 20)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, posPaddle2, 5, 20)

    -- Ball

    love.graphics.rectangle('fill', ballX, ballY, 4, 4)

    -- Score
    love.graphics.setFont(scoreFont);
    love.graphics.print(tostring(score1), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(score2), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)

    push:apply('end') -- Ends virtual resolution
end