test = {}
id = {}
name = {}

name[1] = "sudiv"
name[2] = "supun"
id[1] = 1
id[2] = 2

test[1] = {["name_t"] = name[1] , ["id_t"] = id[1]}
test[2] = {["name_t"] = name[2] , ["id_t"] = id[2]}

print(test[1].name_t)
print(test[1].id_t)
print(test[2].name_t)
print(test[2].id_t)
