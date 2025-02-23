extends OmniLight3D

var time_passed = 0.0
var texture 

func _ready():
	texture = NoiseTexture2D.new()
	texture.bump_strength = 0.7
	texture.noise = FastNoiseLite.new()
	texture.noise.set_seed( randi())
	texture.noise.frequency = 0.05
	await texture.changed

func _process(delta):
	time_passed += delta

	var sampled_noise = texture.noise.get_noise_1d(time_passed)
	sampled_noise = abs(sampled_noise)
	light_energy = sampled_noise*200+1
	
