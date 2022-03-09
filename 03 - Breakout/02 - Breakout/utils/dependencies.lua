class = require 'lib/class'
push = require 'lib/push'

require 'utils/global'
require 'utils/debug'

require 'classes/StateMachine'
require 'classes/Paddle'
require 'classes/Brick'
require 'classes/Ball'

require 'states/BaseState'
require 'states/TitleState'
require 'states/PaddleSelectState'
require 'states/HighScoreState'
require 'states/PlayState'