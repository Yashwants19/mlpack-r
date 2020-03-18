library(Rcpp)
source('r_util.R')
dyn.load('test_r_binding.so')

testRBinding <- function(doubleIn, intIn, stringIn, matrixIn = matrix(NA), flag1 = FALSE, flag2 = FALSE) 
{
  CLIRestoreSettings("R binding test")

  CLISetParamDouble("double_in", doubleIn)

  CLISetParamInt("int_in", intIn)

  CLISetParamString("string_in", stringIn)


  if (!identical(matrixIn,matrix(NA)))
  {
    CLISetParamMat("matrix_in", matrixIn)
  }

  if (flag1 != FALSE)
  {
    CLISetParamBool("flag1", flag1)
  }

  if (flag2 != FALSE)
  {
    CLISetParamBool("flag2", flag2)
  }

  CLISetPassed("double_out")
  CLISetPassed("int_out")
  CLISetPassed("string_out")
  CLISetPassed("matrix_out")

  .Call("test_r_binding_mlpackMain")

  doubleOut = CLIGetParamDouble("double_out")
  intOut = CLIGetParamInt("int_out")
  stringOut = CLIGetParamString("string_out")
  matrixOut <- CLIGetParamMat("matrix_out")

  my_list <- list("doubleOut" = doubleOut, "intOut" = intOut, "stringOut" = stringOut, "matrixOut" = matrixOut)

  return (my_list)
}

