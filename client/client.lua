local Points, Propietario, Teleports, blipsCasas = nil, nil, nil, {}

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end

	while ESX.GetPlayerData().identifier == nil do
		Wait(10)
	end

	getPoints()

	ESX.PlayerData = ESX.GetPlayerData()
end)

getPoints = function()
	Points, Propietario, Teleports, blipsCasas = nil, nil, nil, {}
    Wait(1500)
    ESX.TriggerServerCallback('esx_sup_casasprivadas:getCasasData', function(points,nombre,teleports)
        if points then
            Points      = points
            Propietario = nombre
            Teleports   = teleports

            VerPuntos()
        end
    end)
end

-- Funcion Permisos
TienePermisos = function(casaID)
	if ESX.PlayerData.identifier == nil then
		return false
	end
    if casaID.Identifier ~= nil then
        if ESX.PlayerData.identifier == casaID.Identifier then
            return true
        end
    end
	if casaID.Identifier2 ~= nil then
        if ESX.PlayerData.identifier == casaID.Identifier2 then
            return true
        end
    end	

	return false
end

-- Funcion Puntos
VerPuntos = function ()
	Citizen.CreateThread(function()
    	while true do
        	Wait(0)

        	local ped = PlayerPedId()
        	local sleep = true

			if Config.Blips then
				VerBlips()
			end

        	for _,v in pairs(Points) do
        	    local coords = GetDistanceBetweenCoords(GetEntityCoords(ped), v.coords.x, v.coords.y, v.coords.z, true) 
            	if (coords < 3) then
					sleep = false
					if Config.EnableLoafGarage then
						if v.recogn == "Garaje" then
							local vehicle = GetVehiclePedIsUsing(ped)

				        	if DoesEntityExist(vehicle) then
								if Notify(v.coords, v.notificationOUT) then
					      	        TriggerEvent("loaf_garage:store", "~w~Privado ~y~"..Propietario.."~w~")
								end
				       		else
								if Notify(v.coords, v.notificationIN) then
									local viewing = true

									TriggerEvent("loaf_garage:viewVehicles", "~w~Privado ~y~"..Propietario.."~w~", v.exitcoords.xyz, v.exitcoords.w, function()
										viewing = false
									end, v.coords)
		
									while viewing do 
										Wait(250)
									end
								end
			            	end
						end
					else
						if v.recogn == "Garaje" then
							local vehicle = GetVehiclePedIsUsing(ped)
				        	if DoesEntityExist(vehicle) then
								if Notify(v.coords, v.notificationOUT) then
									TriggerEvent('renzu_garage:property',Propietario, v.coords)
								end
				       		else
								if Notify(v.coords, v.notificationIN) then
									TriggerEvent('renzu_garage:property',Propietario, v.coords)
								end
			            	end
						end
					end
                	if v.recogn == "Ropero" then
						if Notify(v.coords, v.notification) then
							TriggerEvent("esx_sup_funciones:OutfitMenu")
						end
                	elseif v.recogn == "Armario" then
						if Notify(v.coords, v.notification) then
							TriggerEvent('esx_sup_funciones:OpenStorage', Propietario)
						end
					end
            	end
        	end
			for i=1, #Teleports do
				local coords = GetDistanceBetweenCoords(GetEntityCoords(ped), Teleports[i].coords, true) 
				if (coords < 3) then
					sleep = false
					if not MenuOn then
						ESX.Supreme3DText( Teleports[i].coords, Teleports[i].notification)
					end
					if IsControlJustPressed(1,38) then
						TriggerEvent('esx_sup_casasprivadas:teleportMarkers', Teleports[i].teleport)
					end
				end
			end      
        	if sleep then Wait(2000) end
    	end
	end)
end

VerBlips = function ()
    -- Refresh all blips
    for k, existingBlip in pairs(blipsCasas) do
	    RemoveBlip(existingBlip)
    end	

	-- Clean the blip table
	blipsCasas = {}

	for k,v in pairs(Points) do
		if v.recogn == "Armario" then
			local blip = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)

			SetBlipSprite (blip, 40)
			SetBlipDisplay(blip, 2)
			SetBlipScale  (blip, 0.5)
			SetBlipColour (blip, 27)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName('STRING')
			AddTextComponentString("Casa de "..Propietario)
			EndTextCommandSetBlipName(blip)
			table.insert(blipsCasas, blip) -- add blip to array so we can remove it later
		end
	end
end

AddEventHandler('esx_sup_casasprivadas:teleportMarkers', function(position)
	SetEntityCoords(GetPlayerPed(-1), position.x, position.y, position.z)
end)

-- Notificacion
Notify = function(position, text)
	local playerPed = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPed)
	
	if #(playerCoords - position) < 1.0 then
		TriggerEvent("esx_sup_funciones:SupremeNotify", text, true, position)
	    	if IsControlJustReleased(0, 38) then
				TriggerEvent("esx_sup_funciones:SupremeNotify", text, false, position)
			    return true
			end
	elseif #(GetEntityCoords(PlayerPedId()) - position) > 1.0 then
		TriggerEvent("esx_sup_funciones:SupremeNotify", text, false, position)
	end
end