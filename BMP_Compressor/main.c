#include <stdio.h>
#include <stdlib.h>
#include "bmp.h"

BFHeader bf;

int main(int argc, char *argv[]) {

    FILE *fp;
    char arg[] = ".\\binaryPicJoseFernando_2.bmp";
    int totalWidth = 0, bytesPerRow = 0;
    int x, y, counter;
    unsigned char currentByte = 0;
    unsigned char currentBit = 1;       // The enconding already starts considering the first bit will be white

    fp = fopen(arg, "rb");

    if (!fp){
        printf("Error opening file\n");
        return 0;
    }

    fillHeader(&bf, fp);

    if (bf.biHeader.bitsPerPixel != 1){
        printf("Error: It only works with mono images\n");
        fclose(fp);
        return 0;
    }

    totalWidth = bf.biHeader.bitsPerPixel * bf.biHeader.width;
    bytesPerRow = ceiling(totalWidth, 32) * 4;

    // Jump to the pixel data part
    fseek(fp, bf.pixelDataOffset, SEEK_SET);


    unsigned char temp = 0;
    for (y = 0; y < bf.biHeader.height; y++){
        int readBits = 0;
        int repeatedBits = 0;


        for (x = 0; x < bytesPerRow; x++){
            fread(&currentByte, 1, 1, fp);
            for (counter = 7; counter >= 0; counter--){

                if (readBits < totalWidth){
                    temp = checkBit(&currentByte, counter);
                    if (temp == currentBit) {
                        repeatedBits++;
                    } else {
                        printf("%d,", repeatedBits);
                        repeatedBits = 1;
                        currentBit = temp;
                    }
                }
                readBits++;
            }
        }
        printf("%d,", repeatedBits);
    }


    return 0;
}

