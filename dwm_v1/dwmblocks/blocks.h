//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
        /*Icon*/        /*Command*/                                                     /*Update Interval*/     /*Update Signal*/
        {"[RAM: ",      "$HOME/.config/dwmblocks/scripts/memory.sh",                    15,                     0},
        {"CPU: ",       "$HOME/.config/dwmblocks/scripts/cpu.sh",                       15,                     0},
        {"Vol: ",       "$HOME/.config/dwmblocks/scripts/volume.sh",                    10,                     0},
        {"Bat: ",       "$HOME/.config/dwmblocks/scripts/battery.sh",                   20,                     0},
        {"",            "$HOME/.config/dwmblocks/scripts/date.sh",                       5,                     0},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = "] [";
static unsigned int delimLen = 5;

