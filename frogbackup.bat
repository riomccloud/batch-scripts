@echo off
chcp 65001 > nul
setlocal EnableDelayedExpansion
color 1f

:inicio
:: Verificar se é sábado
for /f "skip=1" %%a in ('wmic path win32_localtime get dayofweek') do set dia=%%a
if "!dia!"=="6" (
	goto pendrive
) else (
	goto googledrive
)

:pendrive
echo ==================================================
echo.
echo FROGBACKUP -
echo Etapa 1 de 4: Pen drive
echo.
echo Insira a senha Restic para pen drive e pressione Enter.
echo.
echo ==================================================
echo.
if not defined RESTIC_PASSWORD (
	set /p RESTIC_PASSWORD=Senha: 
	cls
	goto pendrive
) else (
	echo [1/3] Removendo snapshots antigos...
	echo.
	restic forget --keep-last 12 -r W:\Arquivos
	echo.
	echo [2/3] Fazendo backup da pasta Documentos...
	echo.
	restic -r C:\Arquivos --verbose backup W:\Documentos
	echo.
	echo [3/3] Fazendo backup da pasta Imagens...
	echo.
	restic -r C:\Arquivos --verbose backup W:\Imagens
	echo.
	echo ==================================================
	echo.
	echo BACKUP PEN DRIVE CONCLUÍDO!
	echo.
	echo Assegure-se de que não houve nenhum erro nos retornos do utilitário.
	echo.
	echo Para tentar realizar esse backup novamente, pressione 1.
	echo Para continuar para o próximo backup, pressione 9.
	echo.
	echo ==================================================
	echo.
	:pendrive-concluido
	set /p escolha=Selecione uma opção: 
	set "RESTIC_PASSWORD="
	if "!escolha!"=="9" (
		cls
		goto googledrive
	) else if "!escolha!"=="1" (
		cls
		goto pendrive
	) else (
		echo Opção inválida^^! Leia com atenção e tente novamente.
		pause > nul
		echo.
		goto pendrive-concluido
	)
)

:googledrive
echo ==================================================
echo.
echo FROGBACKUP -
echo Etapa 2 de 4: Google Drive
echo.
echo Insira a senha Restic para Google Drive e pressione Enter.
echo.
echo ==================================================
echo.
if not defined RESTIC_PASSWORD (
	set /p RESTIC_PASSWORD=Senha: 
	cls
	goto googledrive
) else (
	echo [1/3] Removendo snapshots antigos...
	echo.
	restic forget --keep-last 12 -r rclone:googledrive:arquivos
	echo.
	echo [2/3] Fazendo backup da pasta Documentos...
	echo.
	restic -r rclone:googledrive:arquivos --verbose backup C:\Documentos
	echo.
	echo [3/3] Fazendo backup da pasta Imagens...
	echo.
	restic -r rclone:googledrive:arquivos --verbose backup C:\Imagens
	echo.
	echo ==================================================
	echo.
	echo BACKUP GOOGLE DRIVE CONCLUÍDO!
	echo.
	echo Assegure-se de que não houve nenhum erro nos retornos do utilitário.
	echo.
	echo Para tentar realizar esse backup novamente, pressione 1.
	echo Para continuar para o próximo backup, pressione 9.
	echo.
	echo ==================================================
	echo.
	:googledrive-concluido
	set /p escolha=Selecione uma opção: 
	set "RESTIC_PASSWORD="
	if "!escolha!"=="9" (
		cls
		goto mega
	) else if "!escolha!"=="1" (
		cls
		goto googledrive
	) else (
		echo Opção inválida^^! Leia com atenção e tente novamente.
		pause > nul
		echo.
		goto googledrive-concluido
	)
)

:mega
echo ==================================================
echo.
echo FROGBACKUP -
echo Etapa 3 de 4: Mega
echo.
echo Quando estiver pronto para iniciar o backup, pressione qualquer tecla.
echo.
echo ==================================================
pause>nul
echo.
echo [1/2] Fazendo backup da pasta Documentos...
echo.
rclone sync C:\Documentos mega:arquivos/documentos --exclude "desktop.ini" -v
echo.
echo [2/2] Fazendo backup da pasta Imagens...
echo.
rclone sync C:\Imagens mega:arquivos/imagens --exclude "desktop.ini" -v
echo.
echo ==================================================
echo.
echo BACKUP MEGA CONCLUÍDO!
echo.
echo Assegure-se de que não houve nenhum erro nos retornos do utilitário.
echo.
echo Para tentar realizar esse backup novamente, pressione 1.
echo Para continuar para o próximo backup, pressione 9.
echo.
echo ==================================================
echo.
:mega-concluido
set /p escolha=Selecione uma opção: 
if "!escolha!"=="9" (
	cls
	goto onedrive
) else if "!escolha!"=="1" (
	cls
	goto mega
) else (
	echo Opção inválida^^! Leia com atenção e tente novamente.
	pause > nul
	echo.
	goto mega-concluido
)

:onedrive
echo ==================================================
echo.
echo FROGBACKUP -
echo Etapa 4 de 4: OneDrive
echo.
echo Insira a senha Restic para OneDrive e pressione Enter.
echo.
echo ==================================================
echo.
if not defined RESTIC_PASSWORD (
	set /p RESTIC_PASSWORD=Senha: 
	cls
	goto onedrive
) else (
	echo [1/3] Removendo snapshots antigos...
	echo.
	restic forget --keep-last 12 -r rclone:onedrive:arquivos
	echo.
	echo [2/3] Fazendo backup da pasta Documentos...
	echo.
	restic -r rclone:onedrive:arquivos --verbose backup C:\Documentos
	echo.
	echo [3/3] Fazendo backup da pasta Imagens...
	echo.
	restic -r rclone:onedrive:arquivos --verbose backup C:\Imagens
	echo.
	echo ==================================================
	echo.
	echo BACKUP ONEDRIVE CONCLUÍDO!
	echo.
	echo Assegure-se de que não houve nenhum erro nos retornos do utilitário.
	echo.
	echo Para tentar realizar esse backup novamente, pressione 1.
	echo Para finalizar o utilitário, pressione 9.
	echo.
	echo ==================================================
	echo.
	:onedrive-concluido
	set /p escolha=Selecione uma opção: 
	if "!escolha!"=="9" (
		exit
	) else if "!escolha!"=="1" (
		set "RESTIC_PASSWORD="
		cls
		goto onedrive
	) else (
		echo Opção inválida^^! Leia com atenção e tente novamente.
		pause > nul
		echo.
		goto onedrive-concluido
	)
)
