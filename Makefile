MAN2!=ls /usr/share/man/man2/*.2
MAN3!=ls /usr/share/man/man3/*.3
MAN4!=ls /usr/share/man/man4/*.4
MAN5!=ls /usr/share/man/man5/*.5
MAN6!=ls /usr/share/man/man6/*.6
MAN7!=ls /usr/share/man/man7/*.7
MAN8!=ls /usr/share/man/man8/*.8
MAN9!=ls /usr/share/man/man9/*.9

.include "man1.mk"

.PHONY: all clean
all: man1
clean:
	rm -f man.epub intro.txt intro.xhtml

.SUFFIXES: .1 .xhtml
.1.xhtml: header.xhtml footer.xhtml sed/ascii2html.sed
	cat header.xhtml > $@
	mandoc -Tascii $< | sed -Ef sed/ascii2html.sed >> $@
	cat footer.xhtml >> $@

intro.xhtml: /usr/share/man/man1/intro.1
	cat header.xhtml > $@
	mandoc -Tascii $> | sed -Ef sed/ascii2html.sed >> $@
	cat footer.xhtml >> $@

intro.txt: /usr/share/man/man1/intro.1
	mandoc -Tascii $> | sed -f rm-esc.sed > $@

man1.epub: intro.xhtml 
	cd man
	zip ../man.epub -r man/*
	cd ..

man1.idx: ${MAN}

curses.idx:
	grep -rl '#include <curses.h>' /usr/share/man/man3 > $@

openssl.idx:
	grep -rl '#include <openssl' /usr/share/man/man3 > $@

krb5.idx:
	grep -rl '#include <krb5.h>' /usr/share/man/man3 > $@
