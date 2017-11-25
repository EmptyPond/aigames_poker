#resultfile output
The game_hash has 4 keys, `["settings", "score", "winner", "states"]` 
* states hold all the actions in the game. Each state looks something as such
```JavaScript
{"round"=>1,
 "pot"=>[{"chips"=>0}],
 "players"=>
  [{"bet"=>0, "chips"=>1000, "id"=>0, "hand"=>{"cards"=>[]}},
   {"bet"=>0, "chips"=>1000, "id"=>1, "hand"=>{"cards"=>[]}}],
 "table"=>[]}
```
When a player makes a move a move field for that player will be added with the corresponding move
```JavaScript
{"round"=>1,
 "pot"=>[{"chips"=>0}],
 "players"=>
  [{"bet"=>60,
    "move"=>"check",
    "chips"=>940,
    "odds"=>33.4,
    "id"=>0,
    "hand"=>{"cards"=>["8d", "3h"]}},
   {"bet"=>60,
    "move"=>"call",
    "chips"=>940,
    "odds"=>66.6,
    "id"=>1,
    "hand"=>{"cards"=>["4h", "Qc"]}}],
 "table"=>[]}
```
What's a little confusing is that the move will remain for the next player. In the above example the move element for the round before looked almost similar but the first player did not have a move field. One way to understand who is doing what is to look at the previous move and compare the difference. I think that will have to be a module or something. For example look at the two below
```JavaScript
{"round"=>1,
 "pot"=>[{"chips"=>120}],
 "players"=>
  [{"bet"=>0,
    "move"=>"check",
    "chips"=>940,
    "odds"=>23.8,
    "id"=>0,
    "hand"=>{"cards"=>["8d", "3h"]}},
   {"bet"=>0,
    "move"=>"check",
    "chips"=>940,
    "odds"=>76.1,
    "id"=>1,
    "hand"=>{"cards"=>["4h", "Qc"]}}],
 "table"=>["7s", "7c", "Ks"]}
```
```JavaScript
{"round"=>1,
 "pot"=>[{"chips"=>120}],
 "players"=>
  [{"bet"=>0,
    "chips"=>940,
    "odds"=>0,
    "id"=>0,
    "hand"=>{"cards"=>["8d", "3h"]}},
   {"bet"=>0,
    "chips"=>940,
    "odds"=>100,
    "id"=>1,
    "hand"=>{"cards"=>["4h", "Qc"]}}],
 "table"=>["7s", "7c", "Ks", "Qd"]}
```
The first one came first and by comparing you can tell that the next card was added to the board. 

#DB prep
For now I think we want to create a database for the actions and rounds that occur during play. 
So to break it down, 

A round has an ID, preflop, flop, turn and river. Each of those has many actions.

Round 
* has ID (will always have)
* has one preflop (will always have)
* has one flop (not always, action may end with raise and fold)
* has one turn (same as flop)
* has one river (same as flop)
* has two players
* has one pot

Preflop
* has one round ID
* has one pot (the aggregate of all bets in the actions)
* has many actions
* has two player? or can this be derived from the round this is associated with
* A preflop will not have any board cards

Flop (Similar to preflop but will have board cards)
* has one round ID
* has one pot (the aggregate of all bets in the actions)
* has many actions
* has two player? or can this be derived from the round this is associated with
* has board cards, 3 of them

Turn (Similar to preflop but will have board cards)
* has one round ID
* has one pot (the aggregate of all bets in the actions)
* has many actions
* has two player? or can this be derived from the round this is associated with
* has board cards, 1 of them

River (Similar to preflop but will have board cards)
* has one round ID
* has one pot (the aggregate of all bets in the actions)
* has many actions
* has two player? or can this be derived from the round this is associated with
* has board cards, 1 of them

Action
* has deal ID (this can be either preflop, flop, turn or river ID but can be only one)
* has move
* has player ID 
* has bet amount (optional because move might be fold or check)

Player
* Has ID
* has "name" such as player1 and player2 for easy readability?
* has many actions