@echo off
rem
rem Script to remake WSUS connection and create new Software Distro folder (if corrupt)
rem

gpupdate /force
net stop CryptSvc
net stop BITS
net stop dosvc
net stop wuauserv

ren C:\Windows\SoftwareDistribution SoftwareDistribution.%date%.old
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v SusClientId /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v SusClientIDValidation /f

net start wuauserv
net start dosvc
net Start BITS
net start CryptSvc

wuauclt /resetauthorization /detectnow
wuauclt /detectnow /reportnow

echo %date% - WSUS commands completed successfully
pause
