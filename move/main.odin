package main

import "core:fmt"
import rl "vendor:raylib"

Square :: struct {
	rect:     rl.Rectangle,
	color:    rl.Color,
	go_right: bool,
}

width: i32 = 1280
height: i32 = 720

create_square :: proc(
	x: f32,
	y: f32,
	color: rl.Color = rl.GREEN,
	go_right: bool = true,
) -> Square {
	rect := rl.Rectangle{x, y, 50, 50}
	return Square{rect = rect, color = color, go_right = go_right}
}

move_square :: proc(s: ^Square, dt: f32, speed: f32) {
	if s.go_right && s.rect.x < cast(f32)width - s.rect.width {
		s.rect.x += speed * dt
	} else if s.rect.x > 0 {
		s.go_right = false
		s.rect.x -= speed * dt
	} else {
		s.go_right = true
	}
	rl.DrawRectangleRec(s.rect, s.color)
}

main :: proc() {
	speed: f32 = 1000
	total_squares := 13

	rl.InitWindow(width, height, "Odin Playground")

	defer rl.CloseWindow()

	squares: [dynamic]Square

	for i in 0 ..= total_squares {
		square := create_square(0, cast(f32)i * 50)
		append(&squares, square)
	}

	for i in 0 ..= total_squares {
		square := create_square(
			cast(f32)width - 50,
			cast(f32)i * 50,
			color = rl.RED,
			go_right = false,
		)
		append(&squares, square)
	}

	for i in 0 ..= total_squares {
		square := create_square(
			cast(f32)width / 2,
			cast(f32)i * 50,
			color = rl.BLUE,
			go_right = false,
		)
		append(&squares, square)
	}

	for i in 0 ..= total_squares {
		square := create_square(
			cast(f32)width / 2,
			cast(f32)i * 50,
			color = rl.YELLOW,
			go_right = true,
		)
		append(&squares, square)
	}

	for !rl.WindowShouldClose() {
		dt := rl.GetFrameTime()

		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)
		rl.EndDrawing()

		y := 1
		for &square in squares {
			move_square(&square, dt, cast(f32)y * 20)
			y += 1
		}
	}
}
