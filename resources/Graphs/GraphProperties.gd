extends Resource
class_name GraphPropertiesResource

@export var name: String = "Name"
@export var type: Array # (Array, String)
@export var directed : bool = false
@export var adjacencyMatrix: Array

# for saving
@export var nodePaths: Array # (Array, String)
@export var edgePaths: Array # (Array, String)

