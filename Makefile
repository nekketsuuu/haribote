.PHONY: run

run:
	cp ./helloos.img ./qemu/fdimage0.bin
	cd ./qemu && ./run.sh
