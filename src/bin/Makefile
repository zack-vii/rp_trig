DATA = rp_trig
SOURCE = rp_trig.c

$(DATA): $(SOURCE)
	gcc -g -O0 -I../include -o $@ $<

.PHONY: clean all

clean:
	@rm $(DATA) 2>/dev/null || :

all: $(DATA)
