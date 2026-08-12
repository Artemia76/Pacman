Global Quit = 0
Global anim_offset=0
Global anim_step = 2
Global anim_skip = 10
Global anim_wait=0
Global playerX = 1
Global playerY = 1
Global anim=0
Global Target_FPS = 50
Global cpu_skip = 0
Global Curr_Time.q = ElapsedMilliseconds()
Global Last_Time.q = Curr_Time
Global Frame_Time.q = 0
Global First_Frame = 1

Enumeration Sprites
  #SPRITE_SET = 0
  #PACMAN = 10
  #GHOST_RED = 20
EndEnumeration

Global Sprite_Size = 48