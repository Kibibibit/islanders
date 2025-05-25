extends RefCounted
class_name IslanderData

const ISLANDER_ID_BYTES: int = 2



var id: int
var profile: IslanderProfile
var state: IslanderState
var mesh: Mesh

# TODO: Store inventory, relationships, history

func _init() -> void:
	id = GameState.generate_islander_id()

func get_mesh_res_path() -> String:
	match profile.life_stage:
		IslanderProfile.LifeStage.BABY, IslanderProfile.LifeStage.CHILD:
			return MeshData.BODY_BABY_MESH
		IslanderProfile.LifeStage.TEENAGER:
			return MeshData.BODY_YOUNG_MESHES[profile.young_body_type]
		_:
			return MeshData.BODY_MESHES[profile.body_type]

func update_state(delta: float) -> void:
	state.update(profile.personality, delta)


func serialise() -> PackedByteArray:
	var out := PackedByteArray()
	var profile_serialised: PackedByteArray = profile.serialise()
	var state_serialised: PackedByteArray = state.serialise()
	out.resize(ISLANDER_ID_BYTES + profile_serialised.size() + state_serialised.size())
	out.fill(0)
	var ptr: int = 0
	out.encode_u16(ptr, id)
	ptr += ISLANDER_ID_BYTES

	
	out.encode_u16(ptr, profile_serialised.size())
	out.encode_var(ptr, profile.serialise())
	ptr += profile_serialised.size()

	out.encode_u16(ptr, state_serialised.size())
	out.encode_var(ptr, state.serialise())
	ptr += state_serialised.size()

	return out

static func deserialise(data: PackedByteArray) -> IslanderData:
	var ptr: int = 0
	var out := IslanderData.new()
	out.id = data.decode_u16(ptr)
	ptr += ISLANDER_ID_BYTES

	var profile_size: int = data.decode_u16(ptr)
	ptr += 2
	out.profile = IslanderProfile.deserialise(data.slice(ptr, ptr + profile_size))
	ptr += profile_size

	var state_size: int = data.decode_u16(ptr)
	ptr += 2
	out.state = IslanderState.deserialise(data.slice(ptr, ptr + state_size))

	return out
