 Build;file;ver;src;t;version;rev;path;root;buildver;date;db
⍝ As part of running isolate.dbuild, tweak the workspace a bit:
⍝    Build cover-functions in # and #.isolate (see function "BuildCovers")
⍝    Insert isolate.Version to include GIT last commit date

 version←'1.2' ⍝ base version
 root←⌽{(⌊/⍵⍳'/\')↓⍵}⌽⎕WSID
 db←⊃⎕RSI ⍝ Ref to DyalogBuild environment

 :If 0≠⍴date←⍕{0::'' ⋄ ⊃⎕CMD'git -C "',⍵,'" log -1 --format=%ci'}root
 :OrIf 0≠⍴date←⍕{0::'' ⋄ ⊃⎕CMD'cd "',⍵,'" && svn info | sed -n "s/^Last Changed Date: \\(.*\\) (.*/\\1/p"'}root
     date←' (',date,')'
 :Else
     :If 2=(1⊃⎕RSI).⎕NC'prod'
     :AndIf (1⊃⎕RSI).prod
         'isolate Build: Unable to get GIT last commit date - isolate. Version not set!'⎕SIGNAL 11
     :Else
         ⎕←'isolate Build: Unable to get GIT last commit date - isolate. Version not set!'   ⍝ MBaas: signalling an error would mean build-failure, that's a bit too extreme...
         date←''
     :EndIf
 :EndIf

 ver←version,date ⍝ Join base version and git last commit date
 isolate.Version←'Version ',ver,' built at ',,'ZI4,<->,ZI2,<->,ZI2,< >,ZI2,<:>,ZI2,<:>,ZI2'⎕FMT 1 6⍴⎕TS
 db.Log'isolate.Version set to: ',isolate.Version
