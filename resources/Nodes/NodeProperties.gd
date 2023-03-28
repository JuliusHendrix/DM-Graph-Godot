extends Resource
class_name NodePropertiesResource

var nodeSizes = {
	"S": 0.5,
	"M": 1.0,
	"L": 1.5,
	"XL": 2.0
}

@export var name: String = "Name"
@export var type: Array # (Array, String)
@export var size: String = "M"
@export var position: Vector2 = Vector2(0, 0)
@export var notes: String = ""
