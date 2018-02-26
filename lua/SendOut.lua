print("send")
write_reg(0x21, 0x01, bit.band(bit.bnot(Outputs), 255))
write_reg(0x20, 0x01, Outputs)

