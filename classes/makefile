CXX=		g++
CXXFLAGS=	-g -Wall -std=gnu++11

PROGRAMS=	class

all: class

class: class.cpp
	$(CXX) $(CXXFLAGS) -o $@ $^

.PHONY: clean

clean:
	rm -f $(PROGRAMS)

