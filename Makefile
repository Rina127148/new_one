CXX = g++
CXXFLAGS = -std=c++17 -Wall -Wextra -Wno-missing-field-initializers
TARGET = kubsh

PACKAGE_NAME = kubsh
VERSION = 1.0.0
DEB_FILE = $(PACKAGE_NAME)_$(VERSION)_amd64.deb

all: $(TARGET)

$(TARGET): src/kubsh.cpp
	$(CXX) $(CXXFLAGS) src/kubsh.cpp -o $(TARGET) -lpthread -lreadline

deb: $(TARGET)
	@echo "Creating .deb package..."
	rm -rf kubsh-package
	mkdir -p kubsh-package/DEBIAN
	mkdir -p kubsh-package/usr/local/bin
	cp $(TARGET) kubsh-package/usr/local/bin/$(TARGET)
	chmod +x kubsh-package/usr/local/bin/$(TARGET)

	echo "Package: $(PACKAGE_NAME)" > kubsh-package/DEBIAN/control
	echo "Version: $(VERSION)" >> kubsh-package/DEBIAN/control
	echo "Architecture: amd64" >> kubsh-package/DEBIAN/control
	echo "Maintainer: user" >> kubsh-package/DEBIAN/control
	echo "Priority: optional" >> kubsh-package/DEBIAN/control
	echo "Section: utils" >> kubsh-package/DEBIAN/control
	echo "Description: Custom shell kubsh" >> kubsh-package/DEBIAN/control
	echo "Depends: libreadline8" >> kubsh-package/DEBIAN/control

	dpkg-deb --build kubsh-package $(DEB_FILE)
	@echo "Package created: $(DEB_FILE)"

clean:
	rm -f $(TARGET) *.deb
	rm -rf kubsh-package

.PHONY: all deb clean
