# Erro: Tentativa de run sem executável disponível.
if [[ ! -e $EXEC ]]; then
	bash "$CMD_DIR/errors.sh" 7
	exit 1
fi

# Erro: Permissões insuficientes. (bash "$CMD_DIR/errors.sh" 8)

./$EXEC
