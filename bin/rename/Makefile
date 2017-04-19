
rn: rn_readline.c
	gcc -O0 -g -Wall $^ -o $@ -lreadline

clean:
	rm -f rn

install: rn
	cp rn ~/bin/

#rn: rn_editline.c
#	gcc -O0 -g -Wall $^ -o $@ -ledit
