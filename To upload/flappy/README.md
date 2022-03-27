### Pause state update

Was added a pause state 

**On enter to pause state**
The table of game variables will be saved on a variable called savedParams
```
function PauseState:enter(params) 
    self.savedParams = params
    paused = true
end
```


**On update the pause state**

The game will wait to press the **P** input, the game will resume after a countdown therefore the saved data is passed to the counter which has been slightly adjusted.

```
function PauseState:update(dt)
    if love.keyboard.wasPressed("p") then
        sounds['pause']:play()
        gStateMachine:change('countdown', self.savedParams)
    end
end
```


**On render the pause state**

Static save values ​​will be rendered to remember where we left the game

```
function PauseState:render()

    for k, pair in pairs(self.savedParams.pipePairs) do
        pair:render()
    end

    love.graphics.setFont(flappyFont)
    love.graphics.print('Score: ' .. tostring(self.savedParams.score), 8, 8)

    self.savedParams.bird:render()

    love.graphics.setFont(hugeFont)
    love.graphics.printf("PAUSE", 0, 120, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(smallFont)
    love.graphics.printf("Press P to continue", 0, 180, VIRTUAL_WIDTH, 'center')
end
```


**Changes in the countdown state**

Added enter function to save parameters while counter has not finished

```
function CountdownState:enter(params) 
    self.savedParams = params
end
```

Added a conditional in the rendering function if there are some static values to print
```
if self.savedParams then
    for k, pair in pairs(self.savedParams.pipePairs) do
        pair:render()
    end
   
    love.graphics.setFont(flappyFont)
    love.graphics.print('Score: ' .. tostring(self.savedParams.score), 8, 8)
    
    self.savedParams.bird:render()
    
end
```

Added a exit function to resume the music if the game was paused
```
function CountdownState:exit() 
    if self.savedParams then
        sounds['music']:play()
    end
end
```


**Changes in the play state**

Added a condition on the update state to capture the press of **P**

```
if love.keyboard.wasPressed("p") then
    sounds['pause']:play()
    return gStateMachine:change('pause', {
        score = self.score,
        bird = self.bird,
        pipePairs = self.pipePairs,
        timer = self.timer,
        lastY = self.lastY
    })

end
```

Added an extra condition if there are saved values when enter to the state

```
function PlayState:enter(params) 
    if params then
      self.score = params.score
      self.bird = params.bird
      self.pipePairs = params.pipePairs
      self.timer = params.timer
      self.lastY = params.lastY
    end
        -- if we're coming from death, restart scrolling
        scrolling = true
end
```

### Medals update

The following medals were selected

GOLD                                    |SILVER                                | BRONZE                              |
:--------------------------------------:|:------------------------------------:|:------------------------------------:
![](https://i.imgur.com/Oie5Ze5.png)    |  ![](https://i.imgur.com/WFQqPoH.png)|  ![](https://i.imgur.com/VOlMYGD.png)
15 points or more                       |10 points or more                     | 5 points or more                    |
![](https://i.imgur.com/m0fM7Uy.png)    |![](https://i.imgur.com/VuPMInh.png)  |![](https://i.imgur.com/wvARXYl.png) |

**Changes in the score state**

Added the medals images

```
local medals = {
    ['bronze'] = love.graphics.newImage('medals/bronze.png'),
    ['silver'] = love.graphics.newImage('medals/silver.png'),
    ['gold'] = love.graphics.newImage('medals/gold.png')
}
```

Changed the input function to assign a medal if the score is enough.

```
function ScoreState:enter(params)
    self.score = params.score
    
    if self.score >= 15 then
        self.medal = medals.gold

    elseif  self.score >= 10  then
        self.medal = medals.silver

    elseif  self.score >= 5 then
        self.medal = medals.bronze

    else
        self.medal = nil        
    end

end
```

Added a condition to render the medal if exists 

```
if self.medal then
    love.graphics.draw(self.medal,(VIRTUAL_WIDTH / 2) - 50, (VIRTUAL_HEIGHT / 2) - 20,0,0.2,0.2)
    love.graphics.printf('Press Enter to Play Again!', 0, VIRTUAL_HEIGHT - 40, VIRTUAL_WIDTH, 'center')
else
    love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')
end
```

### Randomized update

In-game result of the randomization    |
:--------------------------------------:|
![](https://i.imgur.com/vLJ1oWi.png)    |
**Changes in the play state**


*Randomize the horizontal gaps*

Added a variable to randomize the pipes spawn time

```
 self.pipeSpawnTime = 2
```

Update this timer every time a pipe is placed, this will output a floating value between 1.5 and 3.0
```
self.pipeSpawnTime = (math.random() * 1.5) + 1.5
```

**Changes in the pipepair**

*Randomize the vertical gaps*

Modified the gap height randomizing the value.

Before
```
['lower'] = Pipe('bottom', self.y + PIPE_HEIGHT + GAP_HEIGHT) )
```

After
```
['lower'] = Pipe('bottom', self.y + PIPE_HEIGHT + math.random(GAP_HEIGHT - 10, GAP_HEIGHT + 20) )
```

