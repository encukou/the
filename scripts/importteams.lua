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

Offset = 0x0225d760
eOffset = 0x0225dcc0

memory.writebyte(0x0225d75c, 3)  -- player party size
memory.writebyte(0x0225dcbc, 4)  -- opponent party size

for i=1, 3, 1 do
    PKMFile = assert(io.open(PKMFilePath[i], "rb"))
    for j=1, 220, 1 do
        memory.writebyte(Offset, string.byte(PKMFile:read(1)))
        Offset = Offset + 1
    end
    PKMFile:close()
end

for i=1, 4, 1 do
    PKMFile = assert(io.open(ePKMFilePath[i], "rb"))
    for j=1, 220, 1 do
        memory.writebyte(eOffset, string.byte(PKMFile:read(1)))
        eOffset = eOffset + 1
    end
    PKMFile:close()
end
