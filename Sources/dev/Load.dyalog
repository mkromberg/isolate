﻿ Load;path;file
 'isolate'⎕NS''
 BuildCovers
 :For file :In 'isolate.ynys.dyalog' 'APLProcess' 'RPCServer'
     ⎕←⎕SE.SALT.Load'⍵\Sources\',file,' -target=isolate'
 :EndFor
 ⎕←⎕SE.SALT.Load'⍵\Sources\TestIso.dyalog'
 path←(1-⌊/(⌽⎕WSID)⍳'\/')↓⎕WSID
 ⎕LX←'#.isolate.ynys.isoStart ⍬'
 ⎕←'      )WSID ',⎕WSID←path,'isolate.dws'