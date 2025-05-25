extends RefCounted
class_name Date

# Easier to just store dates as 64 bits
const SIZE: int = 8

enum Keys {
	YEAR,
	MONTH,
	DAY
}


const _SECONDS_IN_A_DAY: int = 86400

const _MONTH_KEY_INDEX: int = 0
const _MONTH_KEY_MONTH: int = 1
const _MONTH_KEY_SHORT_NAME: int = 2
const _MONTH_KEY_LONG_NAME: int = 3
const _MONTH_KEY_MAX_DAYS: int = 4

const _MONTH_DATA: Dictionary[Time.Month, Array] = {
	Time.Month.MONTH_JANUARY: [0, Time.Month.MONTH_JANUARY, "Jan", "January", 31],
	Time.Month.MONTH_FEBRUARY: [1, Time.Month.MONTH_FEBRUARY, "Feb", "February", 29],
	Time.Month.MONTH_MARCH: [2, Time.Month.MONTH_MARCH, "Mar", "March", 31],
	Time.Month.MONTH_APRIL: [3, Time.Month.MONTH_APRIL, "Apr", "April", 30],
	Time.Month.MONTH_MAY: [4, Time.Month.MONTH_MAY, "May", "May", 31],
	Time.Month.MONTH_JUNE: [5, Time.Month.MONTH_JUNE, "Jun", "June", 30],
	Time.Month.MONTH_JULY: [6, Time.Month.MONTH_JULY, "Jul", "July", 31],
	Time.Month.MONTH_AUGUST: [7, Time.Month.MONTH_AUGUST, "Aug", "August", 31],
	Time.Month.MONTH_SEPTEMBER: [8, Time.Month.MONTH_SEPTEMBER, "Sep", "September", 30],
	Time.Month.MONTH_OCTOBER: [9, Time.Month.MONTH_OCTOBER, "Oct", "October", 31],
	Time.Month.MONTH_NOVEMBER: [10, Time.Month.MONTH_NOVEMBER, "Nov", "November", 30],
	Time.Month.MONTH_DECEMBER: [11, Time.Month.MONTH_DECEMBER, "Dec", "December", 31]
}

class MonthData:
	var index: int
	var month: Time.Month = Time.Month.MONTH_JANUARY
	var short_name: String
	var long_name: String
	var max_days: int
	func _init(_index: int, _month: Time.Month, _short_name: String, _long_name: String, _max_days: int):
		index = _index
		month = _month
		short_name = _short_name
		long_name = _long_name
		max_days = _max_days

const _KEY_MAPPINGS: Dictionary[Keys, String] = {
	Keys.YEAR: "year",
	Keys.MONTH: "month",
	Keys.DAY: "day"
}

const _KEY_MAPPINGS_REVERSED: Dictionary[String, Keys] = {
	"year": Keys.YEAR,
	"month": Keys.MONTH,
	"day": Keys.DAY
}


var year: int:
	get:
		return _date.get(Keys.YEAR, 0)
	set(value):
		_date[Keys.YEAR] = value

var month: int:
	get:
		return _date.get(Keys.MONTH, 0)
	set(value):
		_date[Keys.MONTH] = value
var day: int:
	get:
		return _date.get(Keys.DAY, 0)
	set(value):
		_date[Keys.DAY] = value


var _month_data: MonthData = null

var _date: Dictionary[Keys, int]

func _init():
	_date = {
		Keys.YEAR: 0,
		Keys.MONTH: 0,
		Keys.DAY: 0
	}
	var now := Time.get_date_dict_from_system()
	_update_from_dict(now)
	

func _get_key(dict: Dictionary, key: Keys) -> int:
	return dict.get(_KEY_MAPPINGS[key], 0)

func _update_key_from_dict(dict: Dictionary, key: Keys) -> void:
	_date[key] = dict.get(_KEY_MAPPINGS[key], 0)

func _update_from_dict(date_dict: Dictionary) -> void:
	_update_key_from_dict(date_dict, Keys.YEAR)
	_update_key_from_dict(date_dict, Keys.MONTH)
	_update_key_from_dict(date_dict, Keys.DAY)

func get_month_name(long: bool = true) -> String:
	if long:
		return get_month_data().long_name
	else:
		return get_month_data().short_name

func is_leap_year() -> bool:
	return year_is_leap_year(year)

func equals(other: Date) -> bool:
	return self.to_unix_time() == other.to_unix_time()

func _to_date_dict() -> Dictionary:
	# Convert the date to a dictionary.
	var date_dict := {
		_KEY_MAPPINGS[Keys.YEAR]: _date[Keys.YEAR],
		_KEY_MAPPINGS[Keys.MONTH]: _date[Keys.MONTH],
		_KEY_MAPPINGS[Keys.DAY]: _date[Keys.DAY]
	}
	return date_dict

func to_unix_time() -> int:
	# Convert the date to a Unix timestamp.
	var unix_time := Time.get_unix_time_from_datetime_dict(_to_date_dict())
	return unix_time

## Returns -1 if this date is earlier than the other date,
## 0 if they are equal, and 1 if this date is later than the other date.
func compare(other: Date) -> int:
	return sign(self.to_unix_time() - other.to_unix_time())


func add(other: Date) -> Date:
	return Date.from_unix_time(self.to_unix_time() + other.to_unix_time())
func subtract(other: Date) -> Date:
	return Date.from_unix_time(self.to_unix_time() - other.to_unix_time())

func add_days(days: int) -> Date:
	var new_date := Date.from_unix_time(self.to_unix_time() + days * _SECONDS_IN_A_DAY) # 86400 seconds in a day
	return new_date

func years_between(other: Date) -> int:
	# Calculate the number of years between two dates.
	var year_diff := other.year - self.year
	if other.month < self.month or (other.month == self.month and other.day < self.day):
		year_diff -= 1
	return year_diff

func age() -> int:
	# Calculate the age in years from the current date.
	var today := Time.get_date_dict_from_system()
	var current_date := Date.from_dict(today)
	return current_date.years_between(self)


func _to_string() -> String:
	return "%04d-%02d-%02d" % [
		_date[Keys.YEAR],
		_date[Keys.MONTH],
		_date[Keys.DAY]
	]

func get_month_data() -> MonthData:
	if _month_data == null:
		_month_data = get_month_data_from_month(_date[Keys.MONTH])
	return _month_data

static func year_is_leap_year(_year: int) -> bool:
	# Check if a given year is a leap year.
	return _year % 4 == 0 and (_year % 100 != 0 or _year % 400 == 0)

static func get_month_data_from_month(_month: Time.Month) -> MonthData:
	var data : Array = _MONTH_DATA.get(_month, null)
	if data:
		return MonthData.new(
			data[_MONTH_KEY_INDEX], 
			data[_MONTH_KEY_MONTH], 
			data[_MONTH_KEY_SHORT_NAME], 
			data[_MONTH_KEY_LONG_NAME], 
			data[_MONTH_KEY_MAX_DAYS]
		)
	push_error("Invalid month: %s" % _month)
	return null


static func from_dict(date_dict: Dictionary) -> Date:
	var date := Date.new()
	date._update_from_dict(date_dict)
	return date

static func from_year_month_day(_year: int, _month: int, _day: int) -> Date:
	var date := Date.new()
	date._date[Keys.YEAR] = _year
	date._date[Keys.MONTH] = _month
	assert(_day > 0, "Day must be greater than 0")
	assert(_day <= Date.get_month_data_from_month(_month).max_days, "Day exceeds maximum days in month")
	assert(not (_month == Time.Month.MONTH_FEBRUARY as int and _day > 28 and not Date.year_is_leap_year(_year)), "February cannot have more than 28 days in a non-leap year")
	date._date[Keys.DAY] = _day
	return date

static func from_unix_time(unix_time: int) -> Date:
	var date := Date.new()
	var date_dict := Time.get_datetime_dict_from_unix_time(unix_time)
	date._update_from_dict(date_dict)
	return date
