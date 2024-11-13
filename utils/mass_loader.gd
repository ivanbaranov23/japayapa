class_name Mass_loader


static func load(dir_name : String, ext : String)->Dictionary:
	var dir : DirAccess = DirAccess.open(dir_name)
	var dict = {}
	#print(dir_name)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir() and file_name.ends_with(ext):
				dict[file_name] = load(dir_name + file_name)
				#print("Found file: " + dir_name + file_name)
			file_name = dir.get_next()
	
	
	return dict
