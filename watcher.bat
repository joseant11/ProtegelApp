@echo off
:loop
flutter run
echo Waiting for changes...
flutter attach --pid-idletime=1 --device-idletime=5 --debug-port=8888 || goto loop
