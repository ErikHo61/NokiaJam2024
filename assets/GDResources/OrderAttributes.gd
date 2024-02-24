@tool
extends Resource

class_name OrderAttributes

@export var orderName: String
@export var OrderMatters: bool
var ingredientList: Array = []

var CurDessertType = MinigameConstants.DessertType.DEFAULT

var OrderDetails = []

func _get_property_list() -> Array[Dictionary]:
	var ret: Array[Dictionary] = []
	
	ret.append({
		"name": "Dessert Type",
		"type": TYPE_STRING
	})
	
	ret.append({
		"name": "Add New Ingredient",
		"type": TYPE_STRING,
		"usage": PROPERTY_USAGE_DEFAULT,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": ",".join(MinigameConstants.DessertList[CurDessertType].keys())
	})
	
	ret.append({
		"name": "Order Details",
		"type": TYPE_ARRAY
	})
	
	return ret

func _set(prop_name: StringName, val) -> bool:
	var retval: bool = true
	
	match prop_name:
		"Order Details":
			OrderDetails = val
		"Add New Ingredient":
			OrderDetails.append(val)
			notify_property_list_changed()
		_:
			retval = false
	return retval

func _get(prop_name: StringName):
	match prop_name:
		"Dessert Type":
			return MinigameConstants.DessertType.keys()[CurDessertType]
		"Add New Ingredient":
			return ingredientList
		"Order Details":
			return OrderDetails
	return null
