#include "bmp.h"

void fillHeader(BFHeader *bf, FILE *fp) {
    // BitmapFileHeader is read first
    fread(&bf -> signature, 1, 2, fp);
    fread(&bf -> imageSize, 4, 1, fp);
    fread(&bf -> reserved1, 2, 1, fp);
    fread(&bf -> reserved2, 2, 1, fp);
    fread(&bf -> pixelDataOffset, 4, 1, fp);

    // Then, BitmapInfoHeader is read
    fread(&bf -> biHeader.headerSize, 4, 1, fp);
    fread(&bf -> biHeader.width, 4, 1, fp);
    fread(&bf -> biHeader.height, 4, 1, fp);
    fread(&bf -> biHeader.planes, 2, 1, fp);
    fread(&bf -> biHeader.bitsPerPixel, 2, 1, fp);
    fread(&bf -> biHeader.compression, 4, 1, fp);
    fread(&bf -> biHeader.imageRawSize, 4, 1, fp);
    fread(&bf -> biHeader.horizontalRes, 4, 1, fp);
    fread(&bf -> biHeader.verticalRes, 4, 1, fp);
    fread(&bf -> biHeader.colorPallete, 4, 1, fp);
    fread(&bf -> biHeader.importantColors, 4, 1, fp);
}

int ceiling(int x, int y) {
    return (x % y > 0) ? 
        (x / y + 1) : (x / y);
}


// This funciton aims to check a bit in a byte
int checkBit(unsigned char *ch, int pos) {
    int result;
    asm (
        "mov %[pos], %%ebx\n\t"       // Move 'pos' into ebx
        "mov 8(%%ebp), %%eax\n\t"     // Move the address of 'ch' into eax (8(%%ebp) is the offset for ch in GCC)
        "mov (%%eax), %%eax\n\t"      // Dereference 'ch' to get the byte value
        "bt %%ebx, %%eax\n\t"         // Test the bit in 'eax' at position 'ebx'
        "jc ret1\n\t"                 // Jump if the carry flag is set (bit is 1)
        "xor %%eax, %%eax\n\t"        // Clear eax (set to 0)
        "jmp end\n\t"                 // Jump to 'end'

        "ret1:\n\t"
        "xor %%eax, %%eax\n\t"        // Clear eax (set to 0)
        "inc %%eax\n\t"               // Increment eax to set it to 1

        "end:\n\t"
        "mov %%eax, %[result]\n\t"    // Move the result into the output variable
        : [result] "=r" (result)      // Output operand
        : [pos] "r" (pos), "r" (ch)   // Input operands
        : "eax", "ebx", "cc"          // Clobbered registers
    );
    return result;
}