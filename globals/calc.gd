extends Node

func get_files_in_folder(path: String, include_file_type := false) -> Array[String]:
	var files: Array[String] = []
	var dir := DirAccess.open(path)

	if dir == null:
		push_error("Could not open directory: " + path)
		return files

	dir.list_dir_begin()
	var file_name := dir.get_next()

	while file_name != "":
		if not dir.current_is_dir():
			if not include_file_type:
				file_name = file_name.split(".")[0]
			files.append(file_name)
		file_name = dir.get_next()

	dir.list_dir_end()
	return files
