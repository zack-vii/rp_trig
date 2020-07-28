DATA = librp_trig.so

$(DATA): rp_trig.c
	gcc --shared -fPIC -I../include -o $@ $<

.PHONY: clean all

clean:
	@rm $(DATA) 2>/dev/null || :

all: $(DATA)
