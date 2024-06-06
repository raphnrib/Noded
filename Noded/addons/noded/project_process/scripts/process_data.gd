@tool
extends Resource
class_name ProjProcessData

@export var features : Array[FeatureData]


func new_feature_data() -> FeatureData:
	var n_feat := FeatureData.new()
	features.append(n_feat)
	return n_feat
