
#include <Rcpp.h>

#include "test_r_binding_main.cpp"

using namespace mlpack;
using namespace mlpack::util;
using namespace std;
using namespace Rcpp;

extern "C"
{

// [[Rcpp::export]]
SEXP test_r_binding_mlpackMain()
{
  mlpackMain();
}

}
