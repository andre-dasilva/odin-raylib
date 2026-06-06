package main

import "core:strconv"
import "core:strings"
import rl "vendor:raylib"

rectangle_width: i32 = 100
rectangle_height: i32 = 100

drawSquare :: proc(x: i32, y: i32) {
	rl.DrawRectangle(x, y, rectangle_width, rectangle_height, rl.GREEN)
}

main :: proc() {
	width: i32 = 1280
	height: i32 = 720

	rl.InitWindow(width, height, "Odin Playground")
	rl.ToggleBorderlessWindowed()

	defer rl.CloseWindow()

	for !rl.WindowShouldClose() {
		rl.BeginDrawing()

		rl.ClearBackground(rl.BLACK)

		position_x: i32 = 50
		position_y: i32 = 50
		gap: i32 = 20

		for i in 1 ..= 60 {
			drawSquare(x = position_x, y = position_y)

			buf: [20]byte
			text: string = strconv.write_int(buf[:], cast(i64)i, 10)

			rl.DrawText(
				strings.clone_to_cstring(text),
				position_x + rectangle_width / 2 - 16,
				position_y + rectangle_height / 2 - 16,
				32,
				rl.WHITE,
			)
			position_x += rectangle_width + gap

			if i % 12 == 0 {
				position_x = 50
				position_y += rectangle_height + gap
			}
		}
		rl.EndDrawing()
	}
}
