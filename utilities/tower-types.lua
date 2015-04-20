local TowerTypes = {
	laser = {
		{
			cost = 150,
			value = 100,
			frame = 1,
			radius = 6,
			damage = 50,
			fireSpeed = 500
		},
		{
			cost = 300,
			value = 200,
			frame = 2,
			radius = 7,
			damage = 60,
			fireSpeed = 400
		},
		{
			cost = 300,
			value = 300,
			frame = 3,
			radius = 8,
			damage = 70,
			fireSpeed = 300
		}
	},
	cannon = {
		{
			cost = 200,
			value = 50,
			frame = 4,
			radius = 5,
			damage = 20,
			fireSpeed = 1000
		},
		{
			cost = 200,
			value = 100,
			frame = 5,
			radius = 6,
			damage = 40,
			fireSpeed = 750
		},
		{
			cost = 400,
			value = 400,
			frame = 6,
			radius = 7,
			damage = 40,
			fireSpeed = 500
		}
	},
	aoe = {
		{
			cost = 350,
			value = 200,
			frame = 1,
			radius = 5,
			damage = 10,
			fireSpeed = 900
		},
		{
			cost = 350,
			value = 300,
			frame = 2,
			radius = 6,
			damage = 20,
			fireSpeed = 800
		},
		{
			cost = 400,
			value = 500,
			frame = 3,
			radius = 6,
			damage = 50,
			fireSpeed = 600
		}
	}
}

return TowerTypes