@echo off
echo ==============================================
echo   Iniciando Pokédex Offline-First en Opera...
echo ==============================================
start "" "C:\Users\Diaurys\AppData\Local\Programs\Opera\opera.exe" "http://localhost:8080"
flutter run -d web-server --web-port=8080 --web-hostname=localhost
