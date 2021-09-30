SOURCE=main.v
VCMD=v
TARGET=listiny
DESKTOP_FILE=./Listiny.desktop
DESKTOP_LINK=$(HOME)/Desktop

build:
	$(VCMD) -prod $(SOURCE) -o $(TARGET)
	rm -f $(DESKTOP_FILE)
	cp $(PWD)/assets/Listiny.desktop.template $(DESKTOP_FILE)
	echo "Exec=$(PWD)/$(TARGET)" >> $(DESKTOP_FILE)
	echo "Icon=$(PWD)/assets/icon.jpg" >> $(DESKTOP_FILE)
	echo "Path=$(PWD)" >> $(DESKTOP_FILE)
	cp $(DESKTOP_FILE) $(DESKTOP_LINK)

build-dev:
	$(VCMD) $(SOURCE) -o $(TARGET)
