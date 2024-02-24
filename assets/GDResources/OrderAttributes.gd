@tool
extends Resource

class_name OrderAttributes

@export var orderName: String
@export var ingredientList: Array = []

var DessertType = MinigamConstants.DessertType.DEFAULT

var OrderDetails = []
#
#func _get_property_list() -> Array[Dictionary]:
	#var ret: Array[Dictionary] = []
	#
	#ret.append({
		#"name": "Dessert Type",
		#"type": TYPE_STRING
	#})
	#
	#ret.append({
		#"name": "Order Details",
		#"type": TYPE_ARRAY,
		#"usage": PROPERTY_USAGE_DEFAULT,
		#"hint": PROPERTY_HINT_ENUM,
		#"hint_string": ",".join(MinigameConstants.DessertList[DessertType].keys())
	#})
	#
	#return ret
#
#func _set(prop_name: StringName, val) -> bool:
	#var retval: bool = true
	#
	#match prop_name:
		#"Dessert Type":
			#DessertType = MinigameConstants.DessertType.get(val)
		#"Order Details":
			#OrderDetails = val
		#_:
			#retval = false
	#return retval
#
#func _get(prop_name: StringName):
	#match prop_name:
		#"Dessert Type":
			#return DessertType
		#"Order Details":
			#return OrderDetails
	#return null
