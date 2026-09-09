
# FAZER AINDA (vou apagar esses comentários feios no final, viu? kkk)
# Opções inválidas - geral
# Diretório inexistente - geral
# Projeto sem arquivos .c - build
# Ausência de arquivos fonte - build
# Erros de compilação - build
# Tentativa de run sem executável disponível - run
# Permissões insuficientes - run

erro=$1

case $erro in
	1)
		echo "Erro: Comando inválido."
		echo "Comandos disponíveis: build, run, clean, rebuild, info."
		echo "Uso: ./cbuild <comando> [opções]"
		;;
	2)
		echo "Erro: Diretório inexistente."
		;;
	3)
		echo "Erro: Diretório não possui arquivos .c"
		;;
	4)
		echo "Erro de Compilação: GCC não instalado."
		;;
	7) 
		echo "Erro de Execução: Diretório não possui arquivo executável."
		;;
	8) 
		echo "Erro de Execução: Permissões insuficientes."
		echo "Sugestão: 'chmod +x $EXEC.sh'"
		;;
esac
