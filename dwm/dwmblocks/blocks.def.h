//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
        /*Icon*/        /*Command*/             			               			 /*Update Interval*/     /*Update Signal*/
	// {"",      	"$HOME/.config/dwmblocks/scripts/spotify.sh || echo 'Not running'",	          5,                     7},
        {"RAM: ",       "$HOME/.config/dwmblocks/scripts/memory.sh",                   		 	 15,                     5},
        {"CPU: ",       "$HOME/.config/dwmblocks/scripts/cpu.sh",                       		 15,                     4},
        // {"",	        "$HOME/.config/dwmblocks/scripts/network.sh",			 		  5,                     6},
        {"Vol: ",       "$HOME/.config/dwmblocks/scripts/volume.sh",                     		  0,                     3},
        {"Bat: ",       "$HOME/.config/dwmblocks/scripts/battery.sh",                   		 20,                     2},
        {"",            "$HOME/.config/dwmblocks/scripts/date.sh",                       		  5,                     1},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = "] [";
static unsigned int delimLen = 5;

//sudo make clean install && { killall -q dwmblocks;setsid dwmblocks & } para reiniciar o dmwblocks
