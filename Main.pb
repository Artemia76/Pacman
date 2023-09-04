XIncludeFile "MainWindow.pbf"
XIncludeFile "SpriteMap.pb"

Global Quit = 0
Enumeration Sprites
  #PACMAN = 10
  #GHOST_RED = 20
EndEnumeration

Procedure NewGame (EventType)
  Debug ("NewGame Click")
EndProcedure

Procedure ExitGame (EventType)
  Quit=1
EndProcedure

If InitSprite() = 0 Or InitKeyboard() = 0 Or InitMouse() = 0
  MessageRequester("Error", "Can't open the sprite system", 0)
  End
EndIf

OpenMainWindow()

If OpenWindowedScreen(WindowID(#MainWindow), DesktopScaledX(0), DesktopScaledX(0), DesktopScaledX(WindowWidth(#MainWindow)), DesktopScaledX(WindowHeight(#MainWindow)), 0, 0, 50)
  LoadAnimatedSprite()
  anim_offset=0
  anim_step = 2
  anim_skip = 10
  anim_wait=0
  playerX = 1
  playerY = 1
  anim=0
  Repeat
    Repeat
      Event = WindowEvent()
      If Event <> 0
        Select EventWindow()
          Case MainWindow
            MainWindow_Events(Event) ; Le nom de la procédure est toujours le nom de la fenêtre suivi de '_Events'
        EndSelect
        If Event =  #PB_Event_CloseWindow
          Quit = 1
        EndIf
      EndIf
    Until Event = 0
    
    ExamineKeyboard()
    
    ; do the sprite & screen management at every frame
    If KeyboardPushed(#PB_Key_Up) And playerY > 0
      playerY -3
      anim_offset = 4
    EndIf
    If KeyboardPushed(#PB_Key_Down) And playerY < 600-48-50
      playerY +3
      anim_offset = 6
    EndIf
    If KeyboardPushed(#PB_Key_Left)  And playerX > 0
      playerX -3
      anim_offset = 2
    EndIf
    If KeyboardPushed(#PB_Key_Right) And playerX < 800-48
      playerX +3
      anim_offset = 0
    EndIf
    ClearScreen(RGB(0,0,0))
    DisplaySprite(#GHOST_RED + anim + anim_offset, playerX,PlayerY)
    If (anim_wait < anim_skip)
      anim_wait +1
    Else
      anim_wait = 0
      If (anim < anim_step - 1)
        anim +1
      Else
        anim =0
      EndIf
    EndIf
    FlipBuffers()
  Until Quit 
Else
    MessageRequester("Error", "Can't open windowed screen!", 0)
EndIf
; IDE Options = PureBasic 6.02 LTS (Windows - x64)
; CursorPosition = 14
; FirstLine = 4
; Folding = -
; EnableXP
; DPIAware