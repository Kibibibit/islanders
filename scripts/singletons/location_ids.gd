extends Object
class_name LocationIDs

const ISLANDER_APARTMENT_MASK = 0x1_0000
const ISLANDER_HOUSE_MASK = 0x2_0000
const ISLANDER_ID_MASK = 0x0_FFFF
const ISLANDER_HOME_MASK = 0x3_0000



static func is_islander_apartment(loc_id: int) -> bool:
	return loc_id & ISLANDER_APARTMENT_MASK > 0

static func is_islander_house(loc_id: int) -> bool:
	return loc_id & ISLANDER_HOUSE_MASK > 0

static func is_islanders_home(islander_id: int, loc_id: int):
	return ISLANDER_HOME_MASK & loc_id > 0 and ISLANDER_ID_MASK & loc_id == islander_id
