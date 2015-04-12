# Software Design

Our application architecture is heavily object oriented, with a focus on a declarative programming style that separates configuration from implementation. The game will be supported by a unified game loop that handles communication across various components.

## Core Concepts

#### Object Oriented Programming in Lua
Lua does not have a true class feature. However, because it is a prototypical language classes can be easily fudged:

Class declaration:
```lua
local class = {}
local classMetaTable = { __index = class }
 
function class.new( name )
		
	local newObj = {
		name = name
	}
	
	return setmetatable( newObj, classMetaTable )
end
 
function class:hello()
	print( "Hello " .. self.name )
end
 
return class
```

Using the class:
```lua
local class = require('class')

local mike = class.new('Mike')
local billy = class.new('Billy')

mike.hello() -- prints 'Hello Mike'
billy.hello() -- prints 'Hello Billy'
```

#### JSON
In our goal to achieve a declarative game engine for our tower defense game, we'll store much of our configuration in JSON files. JSON stands for JavaScript Object Notation. Due to the similarities in Lua tables and JavaScript objects, this particular data serialization format seems most appropriate for describing the properties of many assets in our application. 

By separating our configuration from the internals of the game engine, we can build out both the content of our game and the mechanics separately. This drastically reduces the risk of breaking old content with new mechanical changes. Additionally, creating new content becomes a very straightforward task. This would theoretically increase the longevity of our users' interest in the game.


## Classes

#### Level

The Level object describes the base health of your base, how many waves are in that level, the enemies in each wave, when the enemy should spawn in the wave, the available paths for the enemies to travel on, and the nodes where players can construct towers. Besides data storage, the Level object has the primary responsibility of rendering the level's scene and sending the 'start' signal to the game engine.

#### LevelLoader

The LevelLoader creates a Level object from a JSON file. A level's configuration file may look something like this:

````json

{
    "levelName" : "My Level",
    "background" : "path/to/background/image.jpg",
    "base" : "Base Name",
    "baseHealth" : 100,
    "paths" : [
        "path-name-1",
        "path-name-2",
        "path-name-3",
        "path-name-4"
    ],
    "nodes" : [
        { "x" : 120, "y" : 65 },
        { "x" : 30, "y" : 200 }
    ],
    "waves" : [
        {
            "duration" : 50000,
            "enemies" : {
                "5%" : [
                    {
                        "name" : "enemy-a",
                        "path" : "path-name-2",
                        "count" : 5
                    }
                ],
            }
        }
    ]
}

````

#### Enemy
This base class for enemies is considered to be an 'abstract' class, though Lua does not provide mechanisms for declaring abstract classes. This object is responsible for basic path movements, taking damage, and dealing damage to the player's base. Additionally, enemies can morph over time so basic logic will be included in this class to easily support morphing enemy types.  

#### Tower
This is another abstract class that provides core functionality for all towers in the game. It creates a watch radius that detects enemy movements and can select either the lead enemy or all enemies in its range. Once enemies are affected, towers can deal damange to them or reduce their speed.

#### Path
The Path class describes a series of lines that connect a spawn point to the enemy base. Enemies use Path objectsto handle their movement.

#### TowerNode
The TowerNode class provides UI constructs for building towers on the map 

#### Game
The Game class creates the main game loop when a player plays through a level. It also tracks the player's currency, kills, and progress. Enemies, towers, and nodes communicate with the game through events. The Game class also handles pausing and resuming the game.

## Composer Views

#### Main Menu
Provides the users with a list of levels to play as well as developer and assets credits.

#### Tutorial Views
Our game will come with a few views describing how to play the game. These views will also provide the player with detailed information about the towers, enemies, and possibly location that make up our game.

#### Game
Creates a new Game object. Data passed to this view is the name of the level file to load. 

#### Game Over
Gives the player a game over screen if they lose. Lets users either replay the level or go back to the main menu.

#### Victory
Gives the player a breakdown of the performance after winning a game. Loops back to Main Menu


