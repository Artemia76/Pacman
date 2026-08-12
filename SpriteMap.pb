XIncludeFile "Globals.pb"

Procedure LoadAnimatedSprite ()
  ;On charge la Map des sprites
  LoadSprite(#SPRITE_SET,"assets/sprites.png",#PB_Sprite_AlphaBlending)
  FlipBuffers()
  FlipBuffers()
  ClearScreen(#Black)
  DisplayTransparentSprite(#SPRITE_SET,0,0)
  ;On charge les sprites d'animation du fantome
  For y=0 To 7
    GrabSprite(#GHOST_RED + y, 4 + (y*16), 64, 16, 16, #PB_Sprite_AlphaBlending)
    ZoomSprite(#GHOST_RED + y, Sprite_Size, Sprite_Size)
  Next y
  FlipBuffers()
EndProcedure
; IDE Options = PureBasic 6.40 (Linux - x64)
; CursorPosition = 21
; Folding = -
; EnableXP
; DPIAware