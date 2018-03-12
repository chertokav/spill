require('ds3231')
setTime  (3, 17, 21, 7, 26, 03, 16)

s, m, h, d, dt, mn, y = readTime()

print(string.format("Time & Date: %s:%s:%s %s/%s/%s day:%s",
    h, m, s, dt, mn, y, d))