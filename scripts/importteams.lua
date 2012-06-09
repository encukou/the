-- Script by KazoWAR

--[[
it imports a team for you and the opponent
the pkm files should be in same directory as the script.
1.pkm - 6.pkm for your team, e1.pkm - e6.pkm for opponent.
save as 220 byte party encrypted pokemon.
run the script during the start of a battle animation scene (like mug shot, plazma symbol, pretty much as the music is playing for the battle in the overworld) before a battle.
--]]

PKMFilePath = {"1.pkm", "2.pkm", "3.pkm", "4.pkm", "5.pkm", "6.pkm"}
ePKMFilePath = {"e1.pkm", "e2.pkm", "e3.pkm", "e4.pkm", "e5.pkm", "e6.pkm"}

if memory.readword(0x0224FFB8) == 0x7665 or memory.readword(0x0224FFD8) == 0x7665 then
    if memory.readword(0x0224FFB8) == 0x7665 then
        Offset = 0x0225D1A8
        eOffset = 0x0225D708
    elseif memory.readword(0x0224FFD8) == 0x7665 then
        Offset = 0x0225D1C8
        eOffset = 0x0225D728
    end

    for i=1, 6, 1 do
        PKMFile = assert(io.open(ePKMFilePath[i], "rb"))
        for j=1, 220, 1 do
            memory.writebyte(eOffset, string.byte(PKMFile:read(1)))
            eOffset = eOffset + 1
        end
        PKMFile:close()
    end

    for i=1, 6, 1 do
        PKMFile = assert(io.open(PKMFilePath[i], "rb"))
        for j=1, 220, 1 do
            memory.writebyte(Offset, string.byte(PKMFile:read(1)))
            Offset = Offset + 1
        end
        PKMFile:close()
    end
end
