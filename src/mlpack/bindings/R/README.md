  Following commands can be use for test the r bindings in this folder:
  (Assumption: R Programming and All required dependices(libarmadillo, Rcpp) are installed.)

    $ export LD_LIBRARY_PATH=:$HOME/mlpack-r/build/lib

    $ g++ -std=c++11 -fopenmp -I/usr/share/R/include -DNDEBUG -lmlpack -I"$HOME/mlpack-r/src" -I"$HOME/R/x86_64-pc-linux-gnu-library/3.4/Rcpp/include" -fpic -g -O2 -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g -c r_util.cpp -o r_util.o

    $ R CMD SHLIB -std=c++11 -fopenmp -larmadillo -lboost_program_options -L$HOME/mlpack-r/build/lib/ -lmlpack r_util.cpp

    $ g++ -std=c++11 -fopenmp -I/usr/share/R/include -DNDEBUG -lmlpack -I"$HOME/mlpack-r/src" -I"$HOME/R/x86_64-pc-linux-gnu-library/3.4/Rcpp/include" -fpic -g -O2 -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -g -c test_r_binding.cpp -o test_r_binding.o

    $ R CMD SHLIB -std=c++11 -fopenmp -larmadillo -lboost_program_options -L$HOME/mlpack-r/build/lib/ -lmlpack test_r_binding.cpp

    $ R
    > x <- matrix ( c( 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15), nrow = 5)
    > source('test_r_binding.R')
    > lists <- testRBinding(4.0, 12, 'hello', flag1 = TRUE, buildModel = TRUE)
    > testRBinding(4.0, 12 , 'hello', x, TRUE, TRUE, modelIn = lists$modelOut)
