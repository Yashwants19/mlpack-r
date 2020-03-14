## -*- texinfo -*-
## @deftypefn {Function File}{[@var{double_out}, @var{int_out}, @var{matrix_out}, @var{string_out}] =} test_octave(@var{matrix_in}, @var{double_in}, @var{int_in}, @var{string_in}, @var{flag1}, @var{flag2})
##
## A simple program to test Octave binding functionality.                             
## 
## @strong{Optional input}
## @table @asis
## @item @var{double_in} : 
## Input double, must be 4.0.
## @item @var{int_in} :
## Input int, must be 12.
## @item @var{string_in} :
## Input string, must be "hello".
## @item @var{flag1} :
## Input flag, must be specified.  Default value `false`.
## @item @var{flag2} :
## Input flag, must not be specified.  Default value `false`.
## @item @var{matrix_in} :
## Input matrix.
## @item @var{verbose} :
## Display informational messages and the full list of parameters and timers at the end of execution.  Default value `false`.
## @end table
##
## @strong{Return values}
## @table @asis
## @item @var{double_out} :
## Output double, will be 5.0.
## @item @var{int_out} :
## Output int, will be 13.
## @item @var{matrix_out} :
## Output matrix.
## @item @var{string_out} :
## Output string, will be "hello2".
## @end table
## 
## @end deftypefn

function [double_out, int_out, matrix_out, string_out] = test_octave(matrix_in = zeros(1, 1), double_in, int_in, string_in, flag1 = false, flag2 = false)

  octfile1 = strcat(pwd,"/test_octave.oct");
  autoload("TestOctaveBinding",octfile1);
  octfile = strcat(pwd,"/octave_util.oct");
  autoload("CLISetParamString",octfile);
  autoload("CLISetParamDouble",octfile);
  autoload("CLISetParamInt",octfile);
  autoload("CLISetParamBool",octfile);
  autoload("CLISetPassed",octfile);
  autoload("CLIRestoreSettings",octfile);
  autoload("CLIEnableVerbose",octfile);
  autoload("CLIDisableVerbose",octfile);
  autoload("CLIResetTimers",octfile);
  autoload("CLIGetParamInt",octfile);
  autoload("CLIGetParamDouble",octfile);
  autoload("CLIGetParamString",octfile);
  autoload("CLISetParamMat",octfile);
  autoload("CLIGetParamMat",octfile);

  CLIRestoreSettings("Octave binding test");

  CLISetParamDouble("double_in", double_in);

  CLISetParamInt("int_in", int_in);

  CLISetParamString("string_in", string_in);

  if (flag1 != false)
    CLISetParamBool("flag1", flag1);
  end

  if (flag2 != false)
    CLISetParamBool("flag2", flag2);
  end

  if (matrix_in != zeros(1, 1))
    CLISetParamMat("matrix_in", matrix_in');
  end

  CLISetPassed("double_out");
  CLISetPassed("int_out");
  CLISetPassed("matrix_out");
  CLISetPassed("string_out");

  TestOctaveBinding();

  double_out = CLIGetParamDouble("double_out");
  int_out = CLIGetParamInt("int_out");
  matrix_out = CLIGetParamMat("matrix_out");
  string_out = CLIGetParamString("string_out");
end
