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
	Vector2i(1,1):3+5+2+0,
	Vector2i(1,2):1+3+0+1,
	Vector2i(1,3):4+1+0+1, #something needs to be fixed here
	Vector2i(2,1):0+15+11+12, 
	Vector2i(3,1):10+12+0+12,
	Vector2i(4,1):0+10+20+13,
}
