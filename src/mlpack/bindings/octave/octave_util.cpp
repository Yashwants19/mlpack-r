#include <octave/oct.h>
#include <mlpack/prereqs.hpp>
#include <mlpack/core/util/cli.hpp>

using namespace mlpack;


DEFUN_DLD (CLISetParamString, args, nargout, "CLISetParamString")
{
  std::string paramName = args(0).string_value();
  std::string paramValue = args(1).string_value();
  CLI::GetParam<std::string>(paramName) = paramValue;
  CLI::SetPassed(paramName);
  // Return empty matrices for any outputs
  octave_value_list retval (nargout);
  for (int i = 0; i < nargout; i++)
    retval(i) = octave_value (Matrix ());

  return retval;
}

DEFUN_DLD (CLISetParamDouble, args, nargout, "CLISetParamDouble")
{
  std::string paramName = args(0).string_value();
  double paramValue = args(1).double_value();
  CLI::GetParam<double>(paramName) = paramValue;
  CLI::SetPassed(paramName);
  // Return empty matrices for any outputs
  octave_value_list retval (nargout);
  for (int i = 0; i < nargout; i++)
    retval(i) = octave_value (Matrix ());

  return retval;
}

DEFUN_DLD (CLISetParamInt, args, nargout, "CLISetParamInt")
{
  std::string paramName = args(0).string_value();
  int paramValue = args(1).int_value();
  CLI::GetParam<int>(paramName) = paramValue;
  CLI::SetPassed(paramName);
  // Return empty matrices for any outputs
  octave_value_list retval (nargout);
  for (int i = 0; i < nargout; i++)
    retval(i) = octave_value (Matrix ());

  return retval;
}

DEFUN_DLD (CLISetParamBool, args, nargout, "CLISetParamBool")
{
  std::string paramName = args(0).string_value();
  bool paramValue = args(1).bool_value();
  CLI::GetParam<bool>(paramName) = paramValue;
  CLI::SetPassed(paramName);
  // Return empty matrices for any outputs
  octave_value_list retval (nargout);
  for (int i = 0; i < nargout; i++)
    retval(i) = octave_value (Matrix ());

  return retval;
}

DEFUN_DLD (CLISetPassed, args, nargout, "CLISetPassed")
{
  std::string paramName = args(0).string_value();
  CLI::SetPassed(paramName);
  // Return empty matrices for any outputs
  octave_value_list retval (nargout);
  for (int i = 0; i < nargout; i++)
    retval(i) = octave_value (Matrix ());

  return retval;
}

DEFUN_DLD (CLIRestoreSettings, args, nargout, "CLIRestoreSettings")
{
  std::string programName = args(0).string_value();
  CLI::RestoreSettings(programName);
  // Return empty matrices for any outputs
  octave_value_list retval (nargout);
  for (int i = 0; i < nargout; i++)
    retval(i) = octave_value (Matrix ());

  return retval;
}

DEFUN_DLD (CLISetParamMat, args, nargout, "CLISetParamMat")
{
  std::string paramName = args(0).string_value();
  NDArray paramValue = args(1).array_value();
  double* memptr = const_cast<double *> (paramValue.fortran_vec ());
  dim_vector dim = paramValue.dims();
  size_t rows = dim(0);
  size_t cols = dim(1);
  arma::mat m(memptr, rows, cols, false, true);
  CLI::GetParam<arma::mat>(paramName) = std::move(m);
  CLI::SetPassed(paramName);
  // Return empty matrices for any outputs
  octave_value_list retval (nargout);
  for (int i = 0; i < nargout; i++)
    retval(i) = octave_value (Matrix ());

  return retval;
}

DEFUN_DLD (CLIEnableVerbose, args, nargout, "CLIEnableVerbose")
{
  Log::Info.ignoreInput = false;
  // Return empty matrices for any outputs
  octave_value_list retval (nargout);
  for (int i = 0; i < nargout; i++)
    retval(i) = octave_value (Matrix ());

  return retval;

}

DEFUN_DLD (CLIDisableVerbose, args, nargout, "CLIDisableVerbose")
{
  Log::Info.ignoreInput = true;
  // Return empty matrices for any outputs
  octave_value_list retval (nargout);
  for (int i = 0; i < nargout; i++)
    retval(i) = octave_value (Matrix ());

  return retval;

}

DEFUN_DLD (CLIResetTimers, args, nargout, "CLIResetTimers")
{
  CLI::GetSingleton().timer.Reset();
  // Return empty matrices for any outputs
  octave_value_list retval (nargout);
  for (int i = 0; i < nargout; i++)
    retval(i) = octave_value (Matrix ());

  return retval;

}

DEFUN_DLD (CLIGetParamInt, args, nargout, "CLIGetParamInt")
{
  std::string paramName = args(0).string_value();
  return octave_value(CLI::GetParam<int>(paramName));
}

DEFUN_DLD (CLIGetParamDouble, args, nargout, "CLIGetParamDouble")
{
  std::string paramName = args(0).string_value();
  return octave_value(CLI::GetParam<double>(paramName));
}

DEFUN_DLD (CLIGetParamString, args, nargout, "CLIGetParamString")
{
  std::string paramName = args(0).string_value();
  return octave_value(CLI::GetParam<std::string>(paramName));
}

DEFUN_DLD (CLIGetParamMat, args, nargout, "CLIGetParamMat")
{
  std::string paramName = args(0).string_value();

  // Are we using preallocated memory?  If so we have to handle this more
  // carefully.
  arma::mat& mat = CLI::GetParam<arma::mat>(paramName);
  int rows = CLI::GetParam<arma::mat>(paramName).n_rows;
  int cols = CLI::GetParam<arma::mat>(paramName).n_cols;
  if (mat.n_elem <= arma::arma_config::mat_prealloc)
  {
    double* newMem = new double[mat.n_elem];
    arma::arrayops::copy(newMem, mat.mem, mat.n_elem);
    dim_vector dim(cols, rows);
    NDArray reval(dim);
    double* a_vec = reval.fortran_vec ();
    for (int i = 0; i < rows; i++) 
    {
       for (int j = 0; j < cols; j++) 
       {
         *a_vec++ = mat(i, j);
       }
    }
    return octave_value(reval);
  }
  else
  {
    arma::access::rw(mat.mem_state) = 1;
    dim_vector dim(cols, rows);
    NDArray reval(dim);
    double* a_vec = reval.fortran_vec ();
    for (int i = 0; i < rows; i++) 
    {
       for (int j = 0; j < cols; j++) 
       {
         *a_vec++ = mat(i, j);
       }
    }
    return octave_value(reval);
  }
}
