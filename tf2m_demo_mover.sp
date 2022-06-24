#include <sourcemod>
#include <sdkhooks>
#define PL_VERSION "1.0.0"

public Plugin:myinfo =
{
    name = "TF2Maps.net Demo Mover",
    author = "Mr.Burguers",
    description = "Move demos to upload folder",
    version = PL_VERSION,
    url = "http://TF2Maps.net/"
};


public void OnMapStart() {
    DirectoryListing hDir = OpenDirectory(".");
    if (hDir == null) {
        PrintToServer("Error opening game directory");
        return;
    }
    char sCurr[PLATFORM_MAX_PATH];
    while (ReadDirEntry(hDir, sCurr, sizeof(sCurr))) {
        int iDot = FindCharInString(sCurr, '.', true);
        if (iDot != -1 && !strncmp(sCurr[iDot], ".dem", 4)) {
            char sDest[PLATFORM_MAX_PATH];
            Format(sDest, sizeof(sDest), "demos_finished/%s", sCurr);
            PrintToServer("Moving %s to %s", sCurr, sDest);
            RenameFile(sDest, sCurr);
        }
    }
    CloseHandle(hDir);
}