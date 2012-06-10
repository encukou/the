
copy_file = function(name, offset)
    file = assert(io.open(name, "rb"))
    current = offset
    while true do
        local byte = file:read(1)
        if byte == nil then break end
        memory.writebyte(current, string.byte(byte))
        current = current + 1
    end
    file:close()
end

print("Frame count", emu.framecount())

memory.writebyte(0x0225d75c, 3)  -- player party size
memory.writebyte(0x0225dcbc, 4)  -- opponent party size

copy_file('player.pkms', 0x0225d760)
copy_file('opponent.pkms', 0x0225dcc0)

print("Frame count", emu.framecount())
for i=1, 100, 1 do
    emu.frameadvance()
    print("Frame count", emu.framecount())
end
