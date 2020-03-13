#include "test_octave_binding_main.cpp"
#include <mlpack/bindings/go/mlpack/capi/cli_util.hpp>
#include <octave/oct.h>

using namespace mlpack;
using namespace mlpack::util;
using namespace std;

DEFUN_DLD (TestOctaveBinding, args, nargout, "TestOctaveBinding")
{
  mlpackMain();
  // Return empty matrices for any outputs
  octave_value_list retval (nargout);
  for (int i = 0; i < nargout; i++)
    retval(i) = octave_value (Matrix ());

  return retval;

}
