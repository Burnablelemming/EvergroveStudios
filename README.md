# Legacy

## What it does
So right now, Legacy is a neat little skill tree generator.
The really cool part is that this game utilizes the parent/child structure that nodes use in godot.
Each node in the tree is comprised of an Area2D (the important part), a CollisionShape2D (so the player knows where it is), and a Sprite (for fun).
This structure is critical and any new nodes added to the tree must use this structure.

### The really cool part
The lines on the tree are auto generated with a `_draw` method upon running the game. This is just a visual indicator, but doing this manually would <i>suck</i>
This also means you can add/remove/change the position/change the structure of nodes with ease

## How to use
This is still in testing but heres the basics:
1. You control a little weird looking thing, the red arrow points to where you are headed next.
2. Your target can be changed with the right arrow key (currently this is a snapping motion, I plan to eventually tween this)
3. To navigate to your target press enter

### Adding new nodes
You can add new nodes by copying the test node, I think its called leaf, changing its name and pasting it somewhere into the structure.
You can put it basically anywhere, and while you have to change its position manually, the node will always be connected to its parent with a white line upon running the game
You will also be able to navigate to this node when running the game from its parent node, even if you put it in a position that doesnt make traditional sense

## Final thoughts
I think this is cool.
