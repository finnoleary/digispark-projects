CC=avr-gcc
CFLAGS= -Wall -Os -Iusbdrv -mmcu=attiny85 -DF_CPU=16500000
OBJCPY=avr-objcopy
OBJFLAGS = -j .text -j .data -O ihex

OBJS = usbdrv/usbdrv.o usbdrv/oddebug.o usbdrv/usbdrvasm.o main.o
HEX=main.hex

all:V: $HEX

deploy:V:
  sudo micronucleus $HEX

clean:V:
  rm *.o *.hex *.elf usbdrv/*.o

%.hex: %.elf
  $OBJCPY $OBJFLAGS $prereq $stem.hex

main.elf: $OBJS
  $CC $CFLAGS $OBJS -o $target

# ($OBJS): usbdrv/usbconfig.h

%.o: %.c
  $CC $CFLAGS -c $prereq -o $target

%.o: %.S
  $CC $CFLAGS -x assembler-with-cpp -c $prereq -o $target
  
