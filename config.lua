Config                     = {}

Config.Blips            = true -- Enable Blips
Config.EnableLoafGarage = false -- Enable Loaf_garage

-- Casas
Config.Casas = {
    casa_X  = {
		Identifier = 'STEAMID o Rockstar License',
		Identifier2 = 'STEAMID o Rockstar License',
		Casa = "casa_X",
		Nombre = "X",
        Points = {
            Storage = {
                coords = vector3(-1457.9959716797,-550.40301513672,72.878929138184), -- Marker coords
                recogn = "Armario", -- Do not touch this
                notification = "Pulsa ~y~E~w~ para abrir el ~y~armario~w~.", -- Help notification
            },
            Ropero = {
                coords = vector3(-1449.2918701172,-548.97595214844,72.843757629395), -- Marker coords
                recogn = "Ropero", -- Do not touch this
                notification = "Pulsa ~y~E~w~ para abrir el ~y~ropero~w~.", -- Help notification
            },
			Garage = {
                coords = vector3(-1488.2626953125,-514.22406005859,32.806880950928),
                exitcoords = vector4(-1488.2625732422,-514.22320556641,32.806880950928,303.46701049805),
                recogn = "Garaje", -- Do not touch this
                notificationIN = "Pulsa ~y~E~w~ para abrir el ~y~garaje~w~.", -- Help notification
                notificationOUT = "Pulsa ~y~E~w~ para guardar el ~r~vehiculo~w~.", -- Help notification
            },
        },
        Teleports = {
            {-- Ascensor
                coords = vector3(-1447.2330322266,-537.9453125,34.740253448486), -- Marker coords
                notification = "Pulsa ~y~E~w~ para usar el ~y~ascensor~w~.", -- Help notification
                teleport = vector3(-1452.6226806641,-540.14556884766,74.044326782227), -- Marker coords  
            },
            {-- Ascensor
                coords = vector3(-1452.6226806641,-540.14556884766,74.044326782227), -- Marker coords     
                notification = "Pulsa ~y~E~w~ para usar el ~y~ascensor~w~.", -- Help notification
                teleport = vector3(-1447.2330322266,-537.9453125,34.740253448486), -- Marker coords      
            },
        },
    }
}