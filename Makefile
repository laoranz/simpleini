CC=g++
CFLAGS=-Wall
CPPFLAGS=-Wall

OBJS=testsi.o test1.o snippets.o ConvertUTF.o

help:
	@echo This makefile is just for the test program \(use \"make clean all test\"\)
	@echo Just include the SimpleIni.h header file to use it.
	
all: $(OBJS) testevent
	$(CC) -o testsi $(OBJS) -lpthread

clean:
	rm -f core *.o testsi testevent

data:
	sed 's/\r\n$$/\n/g' < test1-expected.ini > unix.out
	mv unix.out test1-expected.ini

test: testsi
	./testsi -u -m -l test1-input.ini > test1-blah.ini
	diff test1-output.ini test1-expected.ini

testevent: test-ini.c TestEvent.cpp TestEvent.h
	$(CC) test-ini.c TestEvent.cpp Configuration.cpp -lpthread -o testevent
	
install:
	@echo No install required. Just include the SimpleIni.h header file to use it.

testsi.o test1.o snippets.o test-ini.o TestEvent.o : SimpleIni.h
