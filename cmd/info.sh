# FAZER AINDA (vou apagar esses comentários feios no final, viu? kkk)
# Nome, Versao do C e do compilador, Quantidade de Headers e .C
# Dependecias usadas, quantidade de linhas, As flags do projeto, tempo medio de build
#
# Flags:
#   --short: da o modo curto mais rapido com poucas infos
#   --visual: gera um html
#   --(informacoes separadas)

DIR="$(pwd)"
echo "$DIR"

dependencies(){
	true
}

flags(){
	true
}

files(){
	true
}

compiler(){
	true
}

short(){
#So chamar algumas
true
}

default(){
#Vai chamar todas as funcoes
	dependencies
	flags
	files
	compiler
	short
}

visual(){
# Visualizar os logs, graficos de files, num de linhas
	default
}

flag=$1

case "$flag" in
	--short)
		short
		;;
	--visual)
		visual
		;;
	*)
		default
		exit 
	;;
esac
