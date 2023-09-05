Global Quit = 0
Global Sprite_Size = 48
XIncludeFile "MainWindow.pbf"
XIncludeFile "SpriteMap.pb"
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

FirstLoop = #True

If OpenWindowedScreen(WindowID(#MainWindow), DesktopScaledX(10), DesktopScaledX(10), DesktopScaledX(WindowWidth(#MainWindow)-20), DesktopScaledX(WindowHeight(#MainWindow)-70), 0, 0, 0)
  ReleaseMouse(#True)
  anim_offset=0
  anim_step = 2
  anim_skip = 10
  anim_wait=0
  playerX = 1
  playerY = 1
  anim=0
  Last_Time.q = ElapsedMilliseconds()
  Target_FPS = 50
  cpu_skip = 0
  Frame_Time.q = 0
  Repeat
    Counter = 0
    Repeat
      Counter + 1
      Event = WindowEvent()
      Select EventWindow()
        Case #MainWindow
          If MainWindow_Events(Event)=0 ; Le nom de la procédure est toujours le nom de la fenêtre suivi de '_Events'
            Quit=1
          EndIf
      EndSelect
    Until Event = 0
    
    If FirstLoop
      LoadAnimatedSprite()
      FirstLoop = #False
    Else
      Frame_Time = ElapsedMilliseconds() - Last_Time
      If Frame_Time = 0
        Frame_Time + 1
      EndIf
      Last_Time = ElapsedMilliseconds()
      If ( 1000 / Frame_Time) > Target_FPS
        cpu_skip + ( 1000 / Target_FPS ) - Frame_Time
      EndIf
     ;If ( 1000 / Frame_Time) < Target_FPS
     ;   cpu_skip - Frame_Time - (1000 / Target_FPS)
      ;EndIf
      StatusBarText(0, 0, "FPS =" + Str(1000 / Frame_Time) + " cpu_skip = " + cpu_skip )
    EndIf
    
    ExamineKeyboard()
    
    ; do the sprite & screen management at every frame
    If KeyboardPushed(#PB_Key_Up) And playerY > 0
      playerY -3
      anim_offset = 4
    EndIf
    If KeyboardPushed(#PB_Key_Down) And playerY < (WindowHeight(#MainWindow)-70-Sprite_Size)
      playerY +3
      anim_offset = 6
    EndIf
    If KeyboardPushed(#PB_Key_Left)  And playerX > 0
      playerX -3
      anim_offset = 2
    EndIf
    If KeyboardPushed(#PB_Key_Right) And playerX < (WindowWidth(#MainWindow)-20-Sprite_Size)
      playerX +3
      anim_offset = 0
    EndIf
    ClearScreen(#Black)
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
    Delay(cpu_skip)
  Until Quit 
Else
    MessageRequester("Error", "Can't open windowed screen!", 0)
EndIf
; IDE Options = PureBasic 6.02 LTS (Linux - x64)
; Folding = -
; EnableXP
; DPIAware