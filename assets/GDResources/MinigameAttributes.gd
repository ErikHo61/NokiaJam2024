@tool
extends Resource
class_name MinigameAttributes

enum MinigameType {FOOD, MAINTENANCE}

@export var title: String = ""
@export var type: MinigameType = MinigameType.FOOD
#@export var orders: Array[OrderAttributes] = []
#@export var ingredients: Array = []

var CurDessertType = MinigameConstants.DessertType.DEFAULT

var OrderList = []

func _get_property_list() -> Array[Dictionary]:
	var ret: Array[Dictionary] = []
	
	ret.append({
		"name": "Dessert Type",
		"type": TYPE_STRING,
		"usage": PROPERTY_USAGE_DEFAULT,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": ",".join(MinigameConstants.DessertType.keys())
	})
	
	if(CurDessertType != MinigameConstants.DessertType.DEFAULT):
		ret.append({
			"name": "Ingredient List",
			"type": TYPE_ARRAY
		})
		
		ret.append({
			"name": "Orders",
			"type": TYPE_ARRAY,
			#"hint": PROPERTY_HINT_RESOURCE_TYPE,
			"hint_string": "24/17:OrderAttributes"
		})
	
	return ret

func _set(prop_name: StringName, val) -> bool:
	var retval: bool = true
	
	match prop_name:
		"Dessert Type":
			CurDessertType = MinigameConstants.DessertType.get(val)
			for i in OrderList.size():
				OrderList[i].ingredientList = get_ingredients()
				OrderList[i].CurDessertType = MinigameConstants.DessertType.get(val)
			notify_property_list_changed()
		"Orders":
			OrderList = val
			for i in OrderList.size():
				OrderList[i].ingredientList = get_ingredients()
				OrderList[i].CurDessertType = CurDessertType
			notify_property_list_changed()
		_:
			retval = false
	return retval

func _get(prop_name: StringName):
	match prop_name:
		"Dessert Type":
			return MinigameConstants.DessertType.keys()[CurDessertType]
		"Ingredient List":
			return get_ingredients()
		"Orders":
			return OrderList
	return null


func get_ingredients():
	if(CurDessertType == MinigameConstants.DessertType.ICECREAMSCOOP):
		return MinigameConstants.IceCreamScoop.keys()
	elif(CurDessertType == MinigameConstants.DessertType.ICECREAMSHAKE):
		return MinigameConstants.IceCreamShake.keys()
	return null
