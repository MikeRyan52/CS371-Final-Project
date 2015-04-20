local TowerTypes = {
	laser = {
		{
			cost = 300,
			value = 100,
			frame = 1,
			radius = 4,
			damage = 50,
			fireSpeed = 350
		},
		{
			cost = 300,
			value = 200,
			frame = 2,
			radius = 5,
			damage = 60,
			fireSpeed = 300
		},
		{
			cost = 300,
			value = 300,
			frame = 3,
			radius = 6,
			damage = 70,
			fireSpeed = 250
		}
	},
	cannon = {
		{
			cost = 200,
			value = 50,
			frame = 4,
			radius = 3,
			damage = 20,
			fireSpeed = 500
		},
		{
			cost = 200,
			value = 100,
			frame = 5,
			radius = 4,
			damage = 40,
			fireSpeed = 350
		},
		{
			cost = 400,
			value = 400,
			frame = 6,
			radius = 5,
			damage = 40,
			fireSpeed = 200
		}
	},
	aoe = {
		{
			cost = 400,
			value = 200,
			frame = 1,
			radius = 3,
			damage = 5,
			fireSpeed = 300
		},
		{
			cost = 350,
			value = 300,
			frame = 2,
			radius = 4,
			damage = 20,
			fireSpeed = 400
		},
		{
			cost = 400,
			value = 500,
			frame = 3,
			radius = 4,
			damage = 50,
			fireSpeed = 500
		}
	}
}

return TowerTypes