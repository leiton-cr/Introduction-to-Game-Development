
## PONG ##

### CHANGES ###

Added 2 extra game states selectPlayers and selectDificulty both of this game states works with a variable selector named highlighted and can be changed pressing *w*, *s*, *up* or *down*

**Select Players State**

will affect how the game is played

    Player mode 1: Player vs Player
    Player mode 2: Player vs Computer
    Player mode 3: Computer vs Computer

**Select Dificulty State**

The dificulty will affect the **"visibility field"** of the paddles making the game harder or easier, if the dificulty is higher the paddle will move
earlier than when the difficulty is lower.

    -- 1. Nigthmare
    -- 2. Hard
    -- 3. Normal
    -- 4. Easy  


**Serving on computers game**
Two variables were added to control the delay on serve when is computers turn *serveDelay* will control the time in seconds taken to serve for the computer and *delayPass* will count the delta time already passed


```
    if (servingPlayer == 2 and playerMode == 2) or playerMode == 3 then
        if delayPass > serveDelay then
            delayPass = 0
            gameState = 'play'
        end
    end
```

To confirm that it is the computer that performs the serve a conditional was added in the press of enter at serve state

```
    if playerMode == 1 or (servingPlayer == 1 and playerMode == 2)   then
        gameState = 'start'
    end
```



**Alow control**

Was added a conditional acording to the game mode, if player is a computer dont allow the common controls.

*For player 1*
```
  if playerMode < 3 then
        if love.keyboard.isDown('w') then
            player1.dy = -PADDLE_SPEED
        elseif love.keyboard.isDown('s') then
            player1.dy = PADDLE_SPEED
        else
            player1.dy = 0
        end
    else
        -- If the ball comes to the player paddle 
        if ball.dx < 0 and ball.x < player1.visibilityField then
     
            if (player1.y + 3) > (ball.y + ball.height)  then
                player1.dy = -PADDLE_SPEED
            elseif (player1.y + player1.height -3) < (ball.y + ball.height) then
                player1.dy = PADDLE_SPEED 
            else
                player1.dy = 0 
            end
     
        else
            player1.dy = 0
        end
        
    end
```

*For player 2*

```
    if playerMode == 1 then
        if love.keyboard.isDown('up') then
            player2.dy = -PADDLE_SPEED
        elseif love.keyboard.isDown('down') then
            player2.dy = PADDLE_SPEED
        else
            player2.dy = 0
        end
    else
        -- If the ball comes to the player paddle
        if ball.dx > 0 and ball.x > player2.visibilityField then
    
            if (player2.y + 3) > (ball.y + ball.height)  then
                player2.dy = -PADDLE_SPEED
            elseif (player2.y + player2.height -3) < (ball.y + ball.height) then
                player2.dy = PADDLE_SPEED 
            else
                player2.dy = 0 
            end
    
        else
            player2.dy = 0
        end
        
    end
```


Only if the ball comes to the paddle and is in the visibility field the player will move the paddle
and make a simple calculation to hit with the paddle


**In game selector**

Were added two conditionals at the key pressed function if the game state is selectPlayers or if game state is selectDificulty
this will update the highlighted variable to make valid the user selection

```
    if gameState == "selectPlayers" then
        
        if key == 'w' or key == "up" then
            sounds['paddle_hit']:play()
            highlighted = (highlighted - 1) % 3
        end

        if key == 's' or key == "down" then
            sounds['paddle_hit']:play()
            highlighted = (highlighted + 1) % 3
        end

    end

    if gameState == "selectDificulty" then
                
        if key == 'w' or key == "up" then
            sounds['paddle_hit']:play()
            highlighted = (highlighted - 1) % 4 
        end

        if key == 's' or key == "down" then
            sounds['paddle_hit']:play()
            highlighted = (highlighted + 1) % 4 
        end

    end
```

In addition, a condition had to be added to make this selection valid when the user presses enter

```
    elseif gameState == "selectPlayers" then
        playerMode = highlighted + 1
            if playerMode ~= 1 then
                gameState = 'selectDificulty' 
                highlighted = 0  
            else
                gameState = 'serve'
            end
            
    elseif gameState == "selectDificulty" then
            dificulty = highlighted + 1
            gameState = 'serve'
            highlighted = 0
    end
```
And also to make this functionality valid, two methods had to be added to render these two states.



*Select player mode*
![](https://i.imgur.com/3UNwqYB.png)
```
playerModes = { "1. Player vs Player", "2. Player vs Computer", "3. Computer vs Computer" }
function renderPlayerSelect()
    love.graphics.setFont(largeFont)
    love.graphics.printf('Select Player Mode', 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(smallFont)

    for i = 1, #playerModes do
        if highlighted == i-1 then
            love.graphics.setColor(0, 1, 0, 1)
        end
        love.graphics.printf(playerModes[i], 0, (10 * i) + (VIRTUAL_HEIGHT / 3) + 30 , VIRTUAL_WIDTH, 'center')
        love.graphics.setColor(1, 1, 1, 1)
    end
    
end
```
*Select difficulty*
![](https://i.imgur.com/daQj0nd.png)
```
difficulties = {"1. Nightmare", "2. Hard", "3. Normal", "4. Easy"} 
function renderDificultySelect()
    love.graphics.setFont(largeFont)
    love.graphics.printf('Select Dificulty', 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(smallFont)

    for i = 1, #difficulties do
        if highlighted == i-1 then
            love.graphics.setColor(0, 1, 0, 1)
        end
        love.graphics.printf(difficulties[i], 0, (10 * i) + (VIRTUAL_HEIGHT / 3) + 30 , VIRTUAL_WIDTH, 'center')
        love.graphics.setColor(1, 1, 1, 1)
    end
end
```