##   This program is free software; you can redistribute it and/or
##   modify it under the terms of the GNU General Public License as
##   published by the Free Software Foundation; either version 3, or
##   (at your option) any later version.
##  
##   This program is distributed in the hope that it will be useful,
##   but WITHOUT ANY WARRANTY; without even the implied warranty of
##   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
##   General Public License for more details.
##  
##   You should have received a copy of the GNU General Public License
##   along with this program; see the file COPYING.  If not, write to
##   the Free Software Foundation, Inc., 51 Franklin Street, Fifth
##   Floor, Boston, MA 02110-1301, USA.

DESTDIR=
prefix=$(DESTDIR)/usr
bindir=$(prefix)/bin
mandir=$(prefix)/share/man/man1

.PHONY : help doc install uninstall
all : help
help :
	@echo "Usage:"
	@echo "    make [doc|install|uninstall|help] [DESTDIR=\"$(DESTDIR)\"] [prefix=\"$(prefix)\"]"

doc :
	@echo "==> make document..."
	@-mkdir doc
	@echo "==> done."

install :
	@echo "==> install..."
	install -m755 pkgbuildup $(bindir)
	install -m644 man/pkgbuildup.1 $(mandir)
	@echo "==> done."

uninstall :
	@echo "==> uninstall..."
	rm -f $(bindir)/pkgbuildup
	rm -f $(mandir)/pkgbuildup.1 
	@echo "==> done."
