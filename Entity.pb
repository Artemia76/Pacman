; Entity Class
; Set PNJ or Player object with sprite animation, collision detect, etc

Enumeration Direction
  #DIR_UP
  #DIR_DN
  #DIR_LEFT
  #DIR_RIGHT
EndEnumeration

DeclareModule Entity
  Interface Entity
    getName.s ()
    setName (pName.s)
    getX.i ()
    getY.i ()
    move (X.i,Y.i)
    moveRel (pDir.Direction)
    update ()
  EndInterface
EndDeclareModule
; IDE Options = PureBasic 6.02 LTS (Windows - x64)
; CursorPosition = 20
; Folding = -
; EnableXP
; DPIAware