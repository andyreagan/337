# make the executable
./taylor -name tbp -o tbp.c -jet -step tbp.in 
./taylor -name tbp -o taylor.h -header
./taylor -name tbp -o main_tbp.c -main_only tbp.in
gcc -O3 main_tbp.c tbp.c -lm -s