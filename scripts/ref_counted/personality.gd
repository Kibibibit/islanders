extends RefCounted
class_name Personality

## Affects the overall rate at which a person changes energy
var energetic: float
## Affects energy level spending time alone
var introverted: float
## Affects energy level spending time with others
var extroverted: float

## Affects energy level spending time outdoors
var outdoors_preference: float
## Affects energy level spending time indoors
var indoors_preference: float
## Affects preference for competitive activities
var competitiveness: float

## How positive or negative the person is.
## Will affect how they react to events
## and how well they get along with others.
var outlook: float
## Controls how randomly the person acts
var spontaneity: float

## Affects energy level for physical activities
var athleticism: float
## Affects energy level for creative activities
var creativity: float
## Affects energy level for mental activities
var curiosity: float


func _init() -> void:
	introverted = 0.5
	extroverted = 0.5

	outdoors_preference = 0.5
	indoors_preference = 0.5
	competitiveness = 0.5

	outlook = 0.5
	spontaneity = 0.5

	athleticism = 0.5
	creativity = 0.5
	curiosity = 0.5
