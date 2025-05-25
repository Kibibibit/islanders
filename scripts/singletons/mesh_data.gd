extends Node
class_name MeshData

const BODY_BABY_MESH: String =  "res://resources/meshes/body_types/Baby.obj"

const BODY_YOUNG_MESHES: Dictionary[IslanderProfile.YoungBodyType, String] = {
	IslanderProfile.YoungBodyType.A: "res://resources/meshes/body_types/ChildA.obj",
	IslanderProfile.YoungBodyType.B: "res://resources/meshes/body_types/ChildB.obj",
	IslanderProfile.YoungBodyType.C: "res://resources/meshes/body_types/ChildC.obj"
}

const BODY_MESHES: Dictionary[IslanderProfile.BodyType, String] = {
	IslanderProfile.BodyType.A: "res://resources/meshes/body_types/A.obj",
	IslanderProfile.BodyType.B: "res://resources/meshes/body_types/B.obj",
	IslanderProfile.BodyType.C: "res://resources/meshes/body_types/C.obj",
	IslanderProfile.BodyType.D: "res://resources/meshes/body_types/D.obj",
	IslanderProfile.BodyType.E: "res://resources/meshes/body_types/E.obj"
}
