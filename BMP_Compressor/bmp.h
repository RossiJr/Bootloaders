#pragma once
#include <stdio.h>

struct BitmapInfoHeader {
    unsigned int headerSize;        // Offset 0E - 4 bytes (this header needs to be 40 bytes length)
    unsigned int width;             // Offset 12 - 4 bytes (the documentation says it has to be signed, but as it is a compressor, doesn't make any difference)
    unsigned int height;            // Offset 16 - 4 bytes (the documentation says it has to be signed, but as it is a compressor, doesn't make any difference)
    unsigned short planes;          // Offset 1A - 2 bytes (this field needs to value 1)
    unsigned short bitsPerPixel;    // Offset 1C - 2 bytes (as this compressor is designed to work only in monocromathic images, this field needs to be 1)
    unsigned int compression;       // Offset 1E - 4 bytes
    unsigned int imageRawSize;      // Offset 22 - 4 bytes (can be 00)
    unsigned int horizontalRes;     // Offset 26 - 4 bytes (can be 00 - as it is a compressor, it doesn't need to have this information and the documentation says it has to be signed, but it will be not)
    unsigned int verticalRes;       // Offset 2A - 4 bytes (can be 00 - as it is a compressor, it doesn't need to have this information and the documentation says it has to be signed, but it will be not)
    unsigned int colorPallete;      // Offset 2E - 4 bytes (can be 00)
    unsigned int importantColors;   // Offset 32 - 4 bytes (can be 00, as it is usually ignored)
};


struct BitmapFileHeader {
    unsigned char signature[2];     // Offset 00 - 2 bytes
    unsigned int imageSize;         // Offset 02 - 4 bytes
    short reserved1;                // Offset 06 - 2 bytes
    short reserved2;                // Offset 08 - 2 bytes
    unsigned int pixelDataOffset;   // Offset 0A - 4 bytes
    struct BitmapInfoHeader biHeader;
};

typedef struct BitmapFileHeader BFHeader;
typedef struct BitmapInfoHeader BIHeader;

void fillHeader(BFHeader *bf, FILE *fp);
int ceiling(int x, int y);
int checkBit(unsigned char *ch, int pos);