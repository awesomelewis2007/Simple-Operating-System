all: compile
compile:
	echo "Compiling OS this may take time..."
	mkdir bin
	nasm -f bin os.asm -o bin/os.img
	cd ..
run:
	sudo qemu-system-x86_64 -drive format=raw,file=bin/os.img
clean:
	rm -rf bin