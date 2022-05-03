ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Printea las casas activas
for _,v in pairs(Config.Casas) do
    print("^5[SupremeSystem] ^0Casas Activas: ^2[" .. v.Casa .. "]^0 Propietario: ^2[" .. v.Nombre .. "]^0" )
end

ESX.RegisterServerCallback('esx_sup_casasprivadas:getCasasData', function(source,cb)
  local _src = source
  local xPlayer = ESX.GetPlayerFromId(_src)

  for _,casaID in pairs(Config.Casas) do
      if CheckID(xPlayer,casaID) then
          local Points    = casaID.Points
          local Nombre    = casaID.Nombre
          local Teleports = casaID.Teleports

          cb(Points,Nombre,Teleports)
      end
  end
end)

CheckID = function(xPlayer, casaID) 
  if xPlayer.identifier == nil then
		  return false
	end

  if xPlayer.identifier == casaID.Identifier then
      return true
  end

  if xPlayer.identifier == casaID.Identifier2 then
    return true
  end

  return false
end