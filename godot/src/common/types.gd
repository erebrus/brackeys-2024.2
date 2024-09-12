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
	Kitchen
}

enum GameMusic {CALM, DINING}

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
