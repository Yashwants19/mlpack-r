  Following commands can be use for test the octave bindings:
  (Assumption: Octave and All required dependices(libarmadillo, liboctave-dev) are installed.)

     $ export LD_LIBRARY_PATH=:$HOME/mlpack-octave/build/lib
     
     $ mkoctfile octave_util.cpp '-lmlpack' -std=c++11 '-L$HOME/mlpack-octave/build/lib' -I$HOME/mlpack-octave/src/ -g -Wall -fpermissive

     $ mkoctfile test_octave.cpp '-lmlpack' -std=c++11 '-L$HOME/mlpack-octave/build/lib' -I$HOME/mlpack-octave/src/ -g -Wall -fpermissive

     $ octave-cli
     octave:1> source test_octave.m
     octave:2> test octave_binding_tests.m


  In order to get documentation we can use:

     octave:1> help test_octave.m
