JFLAGS = -g -d ./bin -cp ./src
JC = javac
.SUFFIXES: .java .class
.java.class:
	$(JC) $(JFLAGS) $<

CLASSES = \
	src/LargestDivisors.java\
	src/Main.java

MAIN = Main
RFLAGS = -cp ./bin
default: classes

classes: $(CLASSES:.java=.class)

clean:
	$(RM) *.class