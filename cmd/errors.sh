
# FAZER AINDA 
# Opções inválidas - geral
# Projeto sem arquivos .c - build
# Erros de compilação - build
# Permissões insuficientes - run

erro=$1

case $erro in
	1)
		echo "Erro: Diretório inexistente."
		echo "Uso: ./cbuild <projeto> <comando> [opções]"
		;;
	2) 
		echo "Erro: Ausência de arquivos-fonte."
		;;
	3)
		echo "Erro: Comando inválido."
		echo "Comandos disponíveis: build, run, clean, rebuild, info."
		echo "Uso: ./cbuild <projeto> <comando> [opções]"
		;;
	4)
		echo "Erro: Diretório não possui arquivos .c"
		;;
	5)
		echo "Erro de Compilação: GCC não instalado."
		;;
	7) 
		echo "Erro de Execução: Tentativa de run sem executável disponível."
		;;
	8) 
		echo "Erro de Execução: Permissões insuficientes."
		echo "Sugestão: 'chmod +x ${EXEC}'"
		;;
esac
