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
