XIncludeFile "Globals.pb"
XIncludeFile "MainWindow.pbf"
XIncludeFile "SpriteMap.pb"


Procedure NewGame (EventType)
  Debug ("NewGame Click")
EndProcedure

Procedure ExitGame (EventType)
  Quit=1
EndProcedure

Procedure Init ()
  If InitSprite() = 0 Or InitKeyboard() = 0 Or InitMouse() = 0
    MessageRequester("Error", "Can't open the sprite system", 0)
    End
  EndIf
  UsePNGImageDecoder()
  OpenMainWindow()
  If OpenWindowedScreen(WindowID(#MainWindow), DesktopScaledX(10), DesktopScaledX(10), DesktopScaledX(WindowWidth(#MainWindow)-20), DesktopScaledX(WindowHeight(#MainWindow)-80),0,0,0) = 0
    MessageRequester("Error", "Can't create drawing area", 0)
    End
  EndIf
  ReleaseMouse(#True)
EndProcedure

Procedure MainLoop()
  Repeat
    Repeat
      Event = WindowEvent()
      Select EventWindow()
        Case #MainWindow
          If MainWindow_Events(Event)=0 ; Le nom de la procédure est toujours le nom de la fenêtre suivi de '_Events'
            Quit=1
          EndIf
      EndSelect
    Until Event = 0
    Curr_Time = ElapsedMilliseconds()
    Frame_Time = Curr_Time - Last_Time
    Last_Time = Curr_Time
    If Frame_Time = 0
      Frame_Time + 1
    EndIf
    If ( 1000 / Frame_Time) > (Target_FPS + (Target_FPS*0.1))
      cpu_skip = cpu_skip +1
    EndIf
    If (( 1000 / Frame_Time) < (Target_FPS - (Target_FPS*0.1))) And (cpu_skip > 0)
      cpu_skip = cpu_skip -1 
    EndIf
    StatusBarText(0, 0, "FPS =" + Str(1000 / Frame_Time) + " cpu_skip = " + cpu_skip + " X=" +playerX + " Y=" + playerY + " Anim=" + anim + " cpu_skip=" + cpu_skip)
    
    ExamineKeyboard()
    
    ; do the sprite & screen management at every frame
    If KeyboardPushed(#PB_Key_Up) And playerY > 0
      playerY -3
      anim_offset = 4
    EndIf
    If KeyboardPushed(#PB_Key_Down) And playerY < (WindowHeight(#MainWindow)-80-Sprite_Size)
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
    If First_Frame=1
      LoadAnimatedSprite()
      First_Frame = 0
    Else
      ClearScreen(#Black)
      ;DisplayTransparentSprite(#SPRITE_SET,playerX,PlayerY)
      DisplayTransparentSprite(#GHOST_RED + anim + anim_offset, playerX,PlayerY)
      ;DisplayTransparentSprite(#GHOST_RED, playerX,PlayerY)
      FlipBuffers()
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
    EndIf
    Delay(cpu_skip)
  Until Quit 
EndProcedure

Init ()
MainLoop ()
; IDE Options = PureBasic 6.40 (Linux - x64)
; CursorPosition = 72
; FirstLine = 63
; Folding = -
; EnableXP
; DPIAware