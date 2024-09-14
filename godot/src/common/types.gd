extends Node


enum Characters {
	Unknown,
	FamilyHead,
	FamilyHeadsWife, 
	FirstBornSon,
	Daughter, 
	SisterOfWife,
	WifeOfFirstBorn,
	Grandson,
	WidowAfterSecondSon,
	SonFromFirstMariageOfHeadOfFamily,
	FriendOfTheFamily,
	SecondSon,
}

enum Locations {
	Garden,
	LivingRoom,
	DiningRoom,
	Kitchen,
	None,
}

enum GameMusic {CALM, DINING,STORM}

const NAME_MAP:={
	
	"Tom":Characters.FamilyHead,
	"Olivia":Characters.FamilyHeadsWife, 
	"Andrew":Characters.FirstBornSon,
	"Jessica":Characters.Daughter, 
	"Angela":Characters.SisterOfWife,
	"Vanda":Characters.WifeOfFirstBorn,
	"Jason":Characters.Grandson,
	"Samantha":Characters.WidowAfterSecondSon,
	"Stan":Characters.SonFromFirstMariageOfHeadOfFamily,
	"Stanley":Characters.SonFromFirstMariageOfHeadOfFamily,
	"Frank":Characters.FriendOfTheFamily,
	"Henry":Characters.SecondSon,
}

#day, hou - garden+living room+kitchen+dining room
const CLUE_COUNTS={
	Vector2i(1,1):2+4+2+0,
	Vector2i(1,2):1+2+0+1,
	Vector2i(1,3):4+1+0+1,
	Vector2i(2,1):1, # TODO: added 1 so it doesn't autoadvance during cutscenes
	Vector2i(3,1):1,
	Vector2i(4,1):1,
}
