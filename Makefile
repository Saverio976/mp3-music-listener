SOURCE=main.v
V=v
TARGET=listiny

all:	build	run

build:
	$(V) -prod -skip-unused $(SOURCE) -o $(TARGET)

build-dev:
	$(V) $(SOURCE) -o $(TARGET)

run:
	./$(TARGET)
