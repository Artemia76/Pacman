Enumeration Sprites
  #PACMAN = 10
  #GHOST_RED = 20
EndEnumeration

Procedure LoadAnimatedSprite ( )
  UsePNGImageDecoder()
  ;On charge la Map des sprites
  LoadSprite(0,GetCurrentDirectory() + "assets/sprites.png",#PB_Sprite_AlphaBlending)
  DisplayTransparentSprite(0,0,0)
  ;On charge les sprites d'animation du fantome
  For y=0 To 7
    GrabSprite(#GHOST_RED + y, 4 + (y*16), 65, 16, 16,#PB_Sprite_AlphaBlending)
    ZoomSprite(#GHOST_RED + y, Sprite_Size, Sprite_Size)
  Next y
  ClearScreen(#Black)
EndProcedure
; IDE Options = PureBasic 6.02 LTS (Linux - x64)
; CursorPosition = 13
; Folding = -
; EnableXP
; DPIAware