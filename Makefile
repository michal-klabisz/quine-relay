MAKEFLAGS += --no-print-directory

NODE := $(shell which nodejs 2>/dev/null || which node)
ifeq ($(NODE),)
  $(warning Node.js not found!)
endif

SCHEME := $(shell which guile csi gosh 2>/dev/null | head -1)
ifeq ($(SCHEME),)
  $(warning Scheme interpreter not found!)
endif
ifeq ($(SCHEME),$(shell which csi 2>/dev/null | head -1))
  SCHEME := csi -s
endif

BF := $(shell which bf beef 2>/dev/null | head -1)
ifeq ($(BF),)
  $(warning Brainfuck interpreter not found!)
endif

.DELETE_ON_ERROR:


all: QR2.rb
	@echo
	@echo "#############"
	@echo "##  CHECK  ##"
	@echo "#############"
	@echo
	diff QR.rb QR2.rb

QR.scala: QR.rb
	@echo
	@echo "########################"
	@echo "##  1: Ruby -> Scala  ##"
	@echo "########################"
	@echo
	ruby QR.rb > QR.scala

QR.scm: QR.scala
	@echo
	@echo "##########################"
	@echo "##  2: Scala -> Scheme  ##"
	@echo "##########################"
	@echo
	scalac QR.scala
	CLASSPATH=. scala QR > QR.scm

QR.sci: QR.scm
	@echo
	@echo "###########################"
	@echo "##  3: Scheme -> Scilab  ##"
	@echo "###########################"
	@echo
	$(SCHEME) QR.scm > QR.sci

QR.bash: QR.sci
	@echo
	@echo "#################################"
	@echo "##  4: Scilab -> Shell (bash)  ##"
	@echo "#################################"
	@echo
	scilab -nw -nb -f QR.sci > QR.bash

QR.sl: QR.bash
	@echo
	@echo "#################################"
	@echo "##  5: Shell (bash) -> S-Lang  ##"
	@echo "#################################"
	@echo
	bash QR.bash > QR.sl

QR.st: QR.sl
	@echo
	@echo "##############################"
	@echo "##  6: S-Lang -> Smalltalk  ##"
	@echo "##############################"
	@echo
	slsh QR.sl > QR.st

QR.spl: QR.st
	@echo
	@echo "###########################"
	@echo "##  7: Smalltalk -> SPL  ##"
	@echo "###########################"
	@echo
	gst QR.st > QR.spl

QR.sml: QR.spl
	@echo
	@echo "#############################"
	@echo "##  8: SPL -> Standard ML  ##"
	@echo "#############################"
	@echo
	splrun QR.spl > QR.sml

QR.sq: QR.sml
	@echo
	@echo "################################"
	@echo "##  9: Standard ML -> Subleq  ##"
	@echo "################################"
	@echo
	mlton QR.sml
	./QR > QR.sq

QR.tcl: QR.sq
	@echo
	@echo "#########################"
	@echo "##  10: Subleq -> Tcl  ##"
	@echo "#########################"
	@echo
	ruby vendor/subleq.rb QR.sq > QR.tcl

QR.t: QR.tcl
	@echo
	@echo "#######################"
	@echo "##  11: Tcl -> Thue  ##"
	@echo "#######################"
	@echo
	tclsh QR.tcl > QR.t

QR.unl: QR.t
	@echo
	@echo "############################"
	@echo "##  12: Thue -> Unlambda  ##"
	@echo "############################"
	@echo
	ruby vendor/thue.rb QR.t > QR.unl

QR.vala: QR.unl
	@echo
	@echo "############################"
	@echo "##  13: Unlambda -> Vala  ##"
	@echo "############################"
	@echo
	ruby vendor/unlambda.rb QR.unl > QR.vala

QR.v: QR.vala
	@echo
	@echo "###########################"
	@echo "##  14: Vala -> Verilog  ##"
	@echo "###########################"
	@echo
	valac QR.vala
	./QR > QR.v

QR.vb: QR.v
	@echo
	@echo "###################################"
	@echo "##  15: Verilog -> Visual Basic  ##"
	@echo "###################################"
	@echo
	iverilog -o QR QR.v
	./QR -vcd-none > QR.vb

QR.ws: QR.vb
	@echo
	@echo "######################################"
	@echo "##  16: Visual Basic -> Whitespace  ##"
	@echo "######################################"
	@echo
	vbnc QR.vb
	mono ./QR.exe > QR.ws

QR.xslt: QR.ws
	@echo
	@echo "##############################"
	@echo "##  17: Whitespace -> XSLT  ##"
	@echo "##############################"
	@echo
	ruby vendor/whitespace.rb QR.ws > QR.xslt

QR.yorick: QR.xslt
	@echo
	@echo "##########################"
	@echo "##  18: XSLT -> Yorick  ##"
	@echo "##########################"
	@echo
	xsltproc QR.xslt > QR.yorick

QR.azm: QR.yorick
	@echo
	@echo "##########################"
	@echo "##  19: Yorick -> Zoem  ##"
	@echo "##########################"
	@echo
	yorick -batch QR.yorick > QR.azm

QR.+: QR.azm
	@echo
	@echo "######################"
	@echo "##  20: Zoem -> A+  ##"
	@echo "######################"
	@echo
	zoem -i QR.azm > QR.+

qr.adb: QR.+
	@echo
	@echo "#####################"
	@echo "##  21: A+ -> Ada  ##"
	@echo "#####################"
	@echo
	a+ -q < QR.+ > qr.adb

QR.als: qr.adb
	@echo
	@echo "########################"
	@echo "##  22: Ada -> AFNIX  ##"
	@echo "########################"
	@echo
	gnatmake qr.adb
	./qr > QR.als

QR.a68: QR.als
	@echo
	@echo "############################"
	@echo "##  23: AFNIX -> ALGOL68  ##"
	@echo "############################"
	@echo
	axi QR.als > QR.a68

QR.ante: QR.a68
	@echo
	@echo "###########################"
	@echo "##  24: ALGOL68 -> Ante  ##"
	@echo "###########################"
	@echo
	a68g QR.a68 > QR.ante

QR.asy: QR.ante
	@echo
	@echo "#############################"
	@echo "##  25: Ante -> Asymptote  ##"
	@echo "#############################"
	@echo
	ruby vendor/ante.rb QR.ante > QR.asy

QR.dats: QR.asy
	@echo
	@echo "############################"
	@echo "##  26: Asymptote -> ATS  ##"
	@echo "############################"
	@echo
	asy QR.asy > QR.dats

QR.awk: QR.dats
	@echo
	@echo "######################"
	@echo "##  27: ATS -> Awk  ##"
	@echo "######################"
	@echo
	atscc -o QR QR.dats
	./QR > QR.awk

QR.bc: QR.awk
	@echo
	@echo "#####################"
	@echo "##  28: Awk -> bc  ##"
	@echo "#####################"
	@echo
	awk -f QR.awk > QR.bc

QR.bef: QR.bc
	@echo
	@echo "#########################"
	@echo "##  29: bc -> Befunge  ##"
	@echo "#########################"
	@echo
	BC_LINE_LENGTH=3000000 bc -q QR.bc > QR.bef

QR.boo: QR.bef
	@echo
	@echo "##########################"
	@echo "##  30: Befunge -> Boo  ##"
	@echo "##########################"
	@echo
	vendor/cfunge-*/cfunge QR.bef > QR.boo

QR.bf: QR.boo
	@echo
	@echo "############################"
	@echo "##  31: Boo -> Brainfuck  ##"
	@echo "############################"
	@echo
	booi QR.boo > QR.bf

QR.c: QR.bf
	@echo
	@echo "##########################"
	@echo "##  32: Brainfuck -> C  ##"
	@echo "##########################"
	@echo
	$(BF) QR.bf > QR.c

QR.cpp: QR.c
	@echo
	@echo "####################"
	@echo "##  33: C -> C++  ##"
	@echo "####################"
	@echo
	${CC} -o QR QR.c
	./QR > QR.cpp

QR.cs: QR.cpp
	@echo
	@echo "#####################"
	@echo "##  34: C++ -> C#  ##"
	@echo "#####################"
	@echo
	${CXX} -o QR QR.cpp
	./QR > QR.cs

QR.clj: QR.cs
	@echo
	@echo "#########################"
	@echo "##  35: C# -> Clojure  ##"
	@echo "#########################"
	@echo
	mcs QR.cs
	mono QR.exe > QR.clj

QR.cob: QR.clj
	@echo
	@echo "############################"
	@echo "##  36: Clojure -> Cobol  ##"
	@echo "############################"
	@echo
	clojure QR.clj > QR.cob

QR.coffee: QR.cob
	@echo
	@echo "#################################"
	@echo "##  37: Cobol -> CoffeeScript  ##"
	@echo "#################################"
	@echo
	cobc -O2 -x QR.cob
	./QR > QR.coffee

QR.lisp: QR.coffee
	@echo
	@echo "#######################################"
	@echo "##  38: CoffeeScript -> Common Lisp  ##"
	@echo "#######################################"
	@echo
	coffee QR.coffee > QR.lisp

QR.fs: QR.lisp
	@echo
	@echo "################################"
	@echo "##  39: Common Lisp -> Forth  ##"
	@echo "################################"
	@echo
	clisp QR.lisp > QR.fs

QR.f: QR.fs
	@echo
	@echo "##############################"
	@echo "##  40: Forth -> FORTRAN77  ##"
	@echo "##############################"
	@echo
	gforth QR.fs > QR.f

QR.f90: QR.f
	@echo
	@echo "##################################"
	@echo "##  41: FORTRAN77 -> Fortran90  ##"
	@echo "##################################"
	@echo
	mv QR.c QR.c.bak
	f2c QR.f
	${CC} -o QR QR.c -L/usr/lib -lf2c -lm
	mv QR.c.bak QR.c
	./QR > QR.f90

QR.go: QR.f90
	@echo
	@echo "###########################"
	@echo "##  42: Fortran90 -> Go  ##"
	@echo "###########################"
	@echo
	gfortran -o QR QR.f90
	./QR > QR.go

QR.groovy: QR.go
	@echo
	@echo "########################"
	@echo "##  43: Go -> Groovy  ##"
	@echo "########################"
	@echo
	go run QR.go > QR.groovy

QR.hs: QR.groovy
	@echo
	@echo "#############################"
	@echo "##  44: Groovy -> Haskell  ##"
	@echo "#############################"
	@echo
	groovy QR.groovy > QR.hs

QR.icn: QR.hs
	@echo
	@echo "###########################"
	@echo "##  45: Haskell -> Icon  ##"
	@echo "###########################"
	@echo
	ghc QR.hs
	./QR > QR.icn

QR.i: QR.icn
	@echo
	@echo "############################"
	@echo "##  46: Icon -> INTERCAL  ##"
	@echo "############################"
	@echo
	icont -s QR.icn
	./QR > QR.i

QR.j: QR.i
	@echo
	@echo "##############################"
	@echo "##  47: INTERCAL -> Jasmin  ##"
	@echo "##############################"
	@echo
	mv QR.c QR.c.bak
	ick -bfO QR.i
	mv QR.c.bak QR.c
	./QR > QR.j

QR.java: QR.j
	@echo
	@echo "##########################"
	@echo "##  48: Jasmin -> Java  ##"
	@echo "##########################"
	@echo
	jasmin QR.j
	CLASSPATH=. java QR > QR.java

QR.ll: QR.java
	@echo
	@echo "############################"
	@echo "##  49: Java -> LLVM asm  ##"
	@echo "############################"
	@echo
	javac QR.java
	CLASSPATH=. java QR > QR.ll

QR.logo: QR.ll
	@echo
	@echo "############################"
	@echo "##  50: LLVM asm -> Logo  ##"
	@echo "############################"
	@echo
	mv QR.bc QR.bc.bak
	llvm-as QR.ll
	lli QR.bc > QR.logo
	mv QR.bc.bak QR.bc

QR.lol: QR.logo
	@echo
	@echo "###########################"
	@echo "##  51: Logo -> LOLCODE  ##"
	@echo "###########################"
	@echo
	logo QR.logo > QR.lol

QR.lua: QR.lol
	@echo
	@echo "##########################"
	@echo "##  52: LOLCODE -> Lua  ##"
	@echo "##########################"
	@echo
	vendor/lci-*/lci QR.lol > QR.lua

QR.mk: QR.lua
	@echo
	@echo "###########################"
	@echo "##  53: Lua -> Makefile  ##"
	@echo "###########################"
	@echo
	lua QR.lua > QR.mk

QR.mac: QR.mk
	@echo
	@echo "##############################"
	@echo "##  54: Makefile -> Maxima  ##"
	@echo "##############################"
	@echo
	make -f QR.mk > QR.mac

QR.il: QR.mac
	@echo
	@echo "##########################"
	@echo "##  55: Maxima -> MSIL  ##"
	@echo "##########################"
	@echo
	maxima -q --init-mac=QR.mac > QR.il

QR.asm: QR.il
	@echo
	@echo "########################"
	@echo "##  56: MSIL -> NASM  ##"
	@echo "########################"
	@echo
	ilasm QR.il
	mono QR.exe > QR.asm

QR.neko: QR.asm
	@echo
	@echo "########################"
	@echo "##  57: NASM -> Neko  ##"
	@echo "########################"
	@echo
	nasm -felf QR.asm
	ld -m elf_i386 -o QR QR.o
	./QR > QR.neko

QR.5c: QR.neko
	@echo
	@echo "##########################"
	@echo "##  58: Neko -> Nickle  ##"
	@echo "##########################"
	@echo
	nekoc QR.neko
	neko QR.n > QR.5c

QR.js: QR.5c
	@echo
	@echo "############################"
	@echo "##  59: Nickle -> NodeJS  ##"
	@echo "############################"
	@echo
	nickle QR.5c > QR.js

QR.m: QR.js
	@echo
	@echo "#################################"
	@echo "##  60: NodeJS -> Objective-C  ##"
	@echo "#################################"
	@echo
	$(NODE) QR.js > QR.m

QR.ml: QR.m
	@echo
	@echo "################################"
	@echo "##  61: Objective-C -> OCaml  ##"
	@echo "################################"
	@echo
	gcc -o QR QR.m
	./QR > QR.ml

QR.octave: QR.ml
	@echo
	@echo "###########################"
	@echo "##  62: OCaml -> Octave  ##"
	@echo "###########################"
	@echo
	ocaml QR.ml > QR.octave

QR.ook: QR.octave
	@echo
	@echo "##########################"
	@echo "##  63: Octave -> Ook!  ##"
	@echo "##########################"
	@echo
	octave -qf QR.octave > QR.ook

QR.gp: QR.ook
	@echo
	@echo "###########################"
	@echo "##  64: Ook! -> PARI/GP  ##"
	@echo "###########################"
	@echo
	ruby vendor/ook.rb QR.ook > QR.gp

QR.pasm: QR.gp
	@echo
	@echo "#################################"
	@echo "##  65: PARI/GP -> Parrot asm  ##"
	@echo "#################################"
	@echo
	gp -f -q QR.gp > QR.pasm

QR.pas: QR.pasm
	@echo
	@echo "################################"
	@echo "##  66: Parrot asm -> Pascal  ##"
	@echo "################################"
	@echo
	parrot QR.pasm > QR.pas

QR.pl: QR.pas
	@echo
	@echo "##########################"
	@echo "##  67: Pascal -> Perl  ##"
	@echo "##########################"
	@echo
	fpc QR.pas
	./QR > QR.pl

QR.php: QR.pl
	@echo
	@echo "#######################"
	@echo "##  68: Perl -> PHP  ##"
	@echo "#######################"
	@echo
	perl QR.pl > QR.php

QR.png: QR.php
	@echo
	@echo "#######################"
	@echo "##  69: PHP -> Piet  ##"
	@echo "#######################"
	@echo
	php QR.php > QR.png

QR.pike: QR.png
	@echo
	@echo "########################"
	@echo "##  70: Piet -> Pike  ##"
	@echo "########################"
	@echo
	vendor/npiet-*/npiet QR.png > QR.pike

QR.ps: QR.pike
	@echo
	@echo "##############################"
	@echo "##  71: Pike -> PostScript  ##"
	@echo "##############################"
	@echo
	pike QR.pike > QR.ps

QR.ppt: QR.ps
	@echo
	@echo "############################################"
	@echo "##  72: PostScript -> PPT (Punched tape)  ##"
	@echo "############################################"
	@echo
	gs -dNODISPLAY -q QR.ps > QR.ppt

QR.prolog: QR.ppt
	@echo
	@echo "########################################"
	@echo "##  73: PPT (Punched tape) -> Prolog  ##"
	@echo "########################################"
	@echo
	ppt -d < QR.ppt > QR.prolog

QR.py: QR.prolog
	@echo
	@echo "############################"
	@echo "##  74: Prolog -> Python  ##"
	@echo "############################"
	@echo
	swipl -q -t qr -f QR.prolog > QR.py

QR.R: QR.py
	@echo
	@echo "#######################"
	@echo "##  75: Python -> R  ##"
	@echo "#######################"
	@echo
	python QR.py > QR.R

QR.r: QR.R
	@echo
	@echo "#######################"
	@echo "##  76: R -> Ratfor  ##"
	@echo "#######################"
	@echo
	R --slave -f QR.R > QR.r

QR.rexx: QR.r
	@echo
	@echo "##########################"
	@echo "##  77: Ratfor -> REXX  ##"
	@echo "##########################"
	@echo
	ratfor -o QR.r.f QR.r
	gfortran -o QR QR.r.f
	./QR > QR.rexx

QR2.rb: QR.rexx
	@echo
	@echo "########################"
	@echo "##  78: REXX -> Ruby  ##"
	@echo "########################"
	@echo
	rexx ./QR.rexx > QR2.rb

clean:
	@mv QR.rb quine-relay.rb
	rm -f qr QR qr.* QR.* QR2.rb *.class gst.im
	@mv quine-relay.rb QR.rb
