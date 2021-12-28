#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define LONG_MAX_NOMBRE 50

int main(int argc, char **argv) {
	int n;
	char **palabras;
	FILE *f, *fp;
	char bbdd_actual[LONG_MAX_NOMBRE];
	char bbdd_anterior[LONG_MAX_NOMBRE];
	int i;
	int cont = 0;

	if (argc != 2) {
		fprintf(stderr, "Formato: %s 'archivo' ...\n", argv[0]);
        	exit(EXIT_FAILURE);
	}

	n = argc - 2;
	palabras = argv + 2;

	f = fopen(argv[1], "r");
	fp = fopen("nombresBBDD.txt", "wt");
	if (f == NULL) {
		fprintf(stderr, "No se pudo abrir el archivo %s\n", argv[1]);
		exit(EXIT_FAILURE);
	}

	while (!feof(f)) {
		fscanf(f, "%s", bbdd_actual);
		if (cont > 0 && strcmp(bbdd_actual, bbdd_anterior) != 0 ) {
			fputs(("%s\n", bbdd_actual), fp);
			fputs("\n", fp);
  		}
		strcpy(bbdd_anterior, bbdd_actual);
		cont++;
	}
	printf("\n");

	fclose(f);
	fclose(fp);

	if(remove(argv[1])!=0)
		printf("No se pudo eliminar el archivo\n");
	exit(EXIT_SUCCESS);
}
