
ELM_INSTALLATION=node_modules/elm/binwrappers/

install:
	npm install
	make elm-packages

elm-packages:
	${ELM_INSTALLATION}elm-package install --yes


build: install
	${ELM_INSTALLATION}elm-make

test: install
	node_modules/elm-test/bin/elm-test
