#include <stdio.h>
#include <stdlib.h>

#ifdef INTEL
#define BPATH "/sys/class/backlight/intel_backlight"
#elif ACPI
#define BPATH "/sys/class/backlight/acpi_video0/"
#else
#error Please select backlight type
#endif
const char set_file[] = BPATH "/brightness";
const char max_file[] = BPATH "/max_brightness";

int main(int argc, char * argv[])
{
    FILE * fp;
    unsigned brightness;
    unsigned brightness_max;

    /* Read max value */
    fp = fopen(max_file, "r");
    if (fp == NULL) {
        perror("Can't open file for read");
        exit(1);
    }
    fscanf(fp, "%u\n", &brightness_max);
    fclose(fp);

    /* Parse arg */
    if (argc >= 2) {
        if (sscanf(argv[1], "%u\n", &brightness) == EOF) {
            fprintf(stderr, "Invalid argument\n");
            exit(3);
        }

        /* Clamp */
        if (brightness > 100)
            brightness = 100;
    } else brightness = 100;

    /* Set value */
    fp = fopen(set_file, "w");
    if (fp == NULL) {
        perror("Can't open file for write");
        exit(2);
    }
    fprintf(fp, "%u\n", brightness * brightness_max / 100);
    fclose(fp);

    return 0;
}
