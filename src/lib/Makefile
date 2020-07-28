DATA = librp_trig.so
SOURCE = rp_trig.c

$(DATA): $(SOURCE)
	gcc -O3 --shared -fPIC -I../include -o $@ $<

.PHONY: clean all

clean:
	@rm $(DATA) 2>/dev/null || :

all: $(DATA)
