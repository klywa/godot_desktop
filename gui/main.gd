extends Control


var is_playing := true

func _ready():
	pass
	# get_viewport().transparent_bg = true
	
	# 设置窗口大小和位置基于它当前所在的屏幕
	# adjust_window_to_current_screen()
	

func adjust_window_to_current_screen():
	# 获取当前窗口位置
	var current_position = get_window().position
	print("Initial window position: ", current_position)
	
	# 获取屏幕数量
	var screen_count = DisplayServer.get_screen_count()
	print("Total screens detected: ", screen_count)
	
	# 找出窗口当前所在的屏幕
	var current_screen = 0
	for i in range(screen_count):
		var screen_position = DisplayServer.screen_get_position(i)
		var screen_size = DisplayServer.screen_get_size(i)
		print("Screen ", i, " position: ", screen_position, " size: ", screen_size)
		
		# 检查窗口是否在这个屏幕范围内
		if (current_position.x >= screen_position.x and 
			current_position.x < screen_position.x + screen_size.x and
			current_position.y >= screen_position.y and
			current_position.y < screen_position.y + screen_size.y):
			current_screen = i
			break
	
	print("Window is on screen: ", current_screen)
	
	# 获取当前屏幕的大小和位置
	var screen_size = DisplayServer.screen_get_size(current_screen)
	var screen_position = DisplayServer.screen_get_position(current_screen)
	print("Selected screen size: ", screen_size)
	print("Selected screen position: ", screen_position)
	
	# 调整窗口大小为当前屏幕大小
	print("Window size before setting: ", get_window().size)
	get_window().size = screen_size
	print("Window size after setting: ", get_window().size)
	
	# 设置窗口位置为当前屏幕的左上角
	get_window().position = screen_position
	print("Window position after reset: ", get_window().position)
