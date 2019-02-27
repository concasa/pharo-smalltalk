"
# Go Counting

Count the scored points on a Go board.

In the game of go (also known as baduk, igo, cờ vây and wéiqí) points
are gained by completely encircling empty intersections with your
stones. The encircled intersections of a player are known as its
territory.

Write a function that determines the territory of each player. You may
assume that any stones that have been stranded in enemy territory have
already been taken off the board.

Write a function that determines the territory which includes a specified coordinate.

Multiple empty intersections may be encircled at once and for encircling
only horizontal and vertical neighbours count. In the following diagram
the stones which matter are marked ""O"" and the stones that don't are
marked ""I"" (ignored).  Empty spaces represent empty intersections.

```text
+----+
|IOOI|
|O  O|
|O OI|
|IOI |
+----+
```

To be more precise an empty intersection is part of a player's territory
if all of its neighbours are either stones of that player or empty
intersections that are part of that player's territory.

For more information see
[wikipedia](https://en.wikipedia.org/wiki/Go_%28game%29) or [Sensei's
Library](http://senseis.xmp.net/).

## Hint

TBD

"
Class {
	#name : #GoCountingTest,
	#superclass : #ExercismTest,
	#instVars : [
		'goCountingCalculator'
	],
	#category : #'ExercismWIP-GoCounting'
}

{ #category : #config }
GoCountingTest class >> uuid [
	"Answer a unique id for this exercise"
	^'c60b04da-2b3f-0d00-a2de-8bbc09f0590c'
]

{ #category : #config }
GoCountingTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.0.0'
]

{ #category : #setup }
GoCountingTest >> setUp [
	goCountingCalculator := GoCounting new
]

{ #category : #test }
GoCountingTest >> testAStoneAndNotATerritoryOn5x5Board [
	| result |

	result := goCountingCalculator territoryX: 1 y: 1 board: #('  B  ' ' B B ' 'B W B' ' W W ' '  W  ' ) .
	self assert: result equals: ((Dictionary new) add: ('territory'->#()); add: ('owner'->'NONE'); yourself)
]

{ #category : #test }
GoCountingTest >> testBlackCornerTerritoryOn5x5Board [
	| result |

	result := goCountingCalculator territoryX: 0 y: 1 board: #('  B  ' ' B B ' 'B W B' ' W W ' '  W  ' ) .
	self assert: result equals: ((Dictionary new) add: ('territory'->#(#(0 0 ) #(0 1 ) #(1 0 ) )); add: ('owner'->'BLACK'); yourself)
]

{ #category : #test }
GoCountingTest >> testInvalidBecauseXIsTooHighFor5x5Board [
	| result |

	result := goCountingCalculator territoryX: 5 y: 1 board: #('  B  ' ' B B ' 'B W B' ' W W ' '  W  ' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'Invalid coordinate'); yourself)
]

{ #category : #test }
GoCountingTest >> testInvalidBecauseXIsTooLowFor5x5Board [
	| result |

	result := goCountingCalculator territoryX:  -1 y: 1 board: #('  B  ' ' B B ' 'B W B' ' W W ' '  W  ' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'Invalid coordinate'); yourself)
]

{ #category : #test }
GoCountingTest >> testInvalidBecauseYIsTooHighFor5x5Board [
	| result |

	result := goCountingCalculator territoryX: 1 y: 5 board: #('  B  ' ' B B ' 'B W B' ' W W ' '  W  ' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'Invalid coordinate'); yourself)
]

{ #category : #test }
GoCountingTest >> testInvalidBecauseYIsTooLowFor5x5Board [
	| result |

	result := goCountingCalculator territoryX: 1 y:  -1 board: #('  B  ' ' B B ' 'B W B' ' W W ' '  W  ' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'Invalid coordinate'); yourself)
]

{ #category : #test }
GoCountingTest >> testOneTerritoryIsTheWholeBoard [
	| result |

	result := goCountingCalculator territoriesBoard: #(' ' ) .
	self assert: result equals: ((Dictionary new) add: ('territoryWhite'->#()); add: ('territoryBlack'->#()); add: ('territoryNone'->#(#(0 0 ) )); yourself)
]

{ #category : #test }
GoCountingTest >> testOpenCornerTerritoryOn5x5Board [
	| result |

	result := goCountingCalculator territoryX: 1 y: 4 board: #('  B  ' ' B B ' 'B W B' ' W W ' '  W  ' ) .
	self assert: result equals: ((Dictionary new) add: ('territory'->#(#(0 3 ) #(0 4 ) #(1 4 ) )); add: ('owner'->'NONE'); yourself)
]

{ #category : #test }
GoCountingTest >> testTwoRegionRectangularBoard [
	| result |

	result := goCountingCalculator territoriesBoard: #(' B ' ) .
	self assert: result equals: ((Dictionary new) add: ('territoryWhite'->#()); add: ('territoryBlack'->#(#(0 0 ) #(2 0 ) )); add: ('territoryNone'->#()); yourself)
]

{ #category : #test }
GoCountingTest >> testTwoTerritoryRectangularBoard [
	| result |

	result := goCountingCalculator territoriesBoard: #(' BW ' ' BW ' ) .
	self assert: result equals: ((Dictionary new) add: ('territoryWhite'->#(#(3 0 ) #(3 1 ) )); add: ('territoryBlack'->#(#(0 0 ) #(0 1 ) )); add: ('territoryNone'->#()); yourself)
]

{ #category : #test }
GoCountingTest >> testWhiteCenterTerritoryOn5x5Board [
	| result |

	result := goCountingCalculator territoryX: 2 y: 3 board: #('  B  ' ' B B ' 'B W B' ' W W ' '  W  ' ) .
	self assert: result equals: ((Dictionary new) add: ('territory'->#(#(2 3 ) )); add: ('owner'->'WHITE'); yourself)
]