# Bootloaders
> This project is designed to store some implementations of Bootloaders.

### How to run it?

> It is explained using Linux OS, but it is possible to use in Windows as well.
> 
> Two softwares are required:
>	1.  [FASM Assembly](https://flatassembler.net/download.php) -> Assembler used to transform Assembly files into Binary ones;
>	2. qemu -> This is a machine emulator, which allows you to "boot a machine" easily with the Bootloader file (to install run `sudo apt install qemu-system-x86`, make sure your OS is updated with the command `sudo apt update`).

#### 1. First Step
Select the Bootloader file you want and then save it to a directory. Next, go to the FASM installation directory and run the following command:
 - `FASM.exe [filePath]`
	 - `[filePath]` -> Directory where the `.asm` file is located, combined with the `.asm` file (ex.: `/home/username/Bootloaders/Basic/firstTest.asm`)

This will generate a binary file in the `[filePath]` directory (using the example above, the file `firstTest.bin` would be generated into the `/home/username/Bootloaders/Basic` directory).

#### 2. Second Step
With the binary file generated, you are going to:
1. Go to the directory where it was generated (using the given example `/home/username/Bootloaders/Basic`)
2. Run the following command to emulate the machine and boot it with the selected Bootloader
	- `qemu-system-x86_64 [fileName]`
		- Where `[fileName]` is the name of the file, for example `firstTest.bin`

---

#### Optional Method

> I have used Windows for this method, because I think it is easier and less complicated.

There are several methods to test a Bootloader, but, for simplicity, I have chosen to show a method running the Bootloader using Virtual Machines.

Basically, you are going to install the VMWare software, and after installed and opened you are going to create a new machine. In the option to select which OS you are going to use, you mark the option to choose later.
After that, you can just use the default settings of a machine. After creating the machine, you edit it, click on "Add" button, then "Floppy Drive" and then "Next".
Now, the "Floppy Drive" appears on the list, so you click on it, select the option "Use floppy image file" and then you search for your `.bin` file.

> You might not be able to find the file because of the type, so instead of only accepting floppy image (`.flp`) and `.img` types, select to accept all (`*.*`) on the Windows file search screen.

With the file selected, click on the "Ok" button and just run the machine.
When a question pops up, click on "No".

---

Following those steps you are going to be able to test the Bootloader files found on this repository.



---

> The references for this work are: [hackingnaweb](https://hackingnaweb.com/) and [x-hacker](http://www.x-hacker.org/ng/bios/ngd4d7.html) for BIOS interruptions.