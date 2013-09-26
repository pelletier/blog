all: deploy

output:
	git submodule update --init

compile: output
	nanoc compile

deploy: compile
	cd output && git commit -a -m "Deploy `date`"
	cd output && git push
