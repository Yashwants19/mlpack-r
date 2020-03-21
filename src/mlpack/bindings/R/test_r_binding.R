library(Rcpp)
source('r_util.R')
dyn.load('test_r_binding.so')

CLIGetParamGaussianKernelPtr <- function(paramName)
{
  return (.Call("CLI_GetParamGaussianKernelPtr", paramName))
}

CLISetParamGaussianKernelPtr <- function(paramName, value)
{
  .Call("CLI_SetParamGaussianKernelPtr", as.character(paramName), value)
}

testRBinding <- function(doubleIn, intIn, stringIn, matrixIn = matrix(NA), buildModel = FALSE, flag1 = FALSE, flag2 = FALSE, modelIn = NULL)
{
  CLIRestoreSettings("R binding test")

  CLISetParamDouble("double_in", doubleIn)

  CLISetParamInt("int_in", intIn)

  CLISetParamString("string_in", stringIn)

  if (buildModel != FALSE)
  {
    CLISetParamBool("build_model", buildModel)
  }

  if (!identical(modelIn,NULL))
  {
    CLISetParamGaussianKernelPtr("model_in", modelIn)
  }

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
  CLISetPassed("model_out")
  CLISetPassed("model_bw_out")

  .Call("test_r_binding_mlpackMain")

  doubleOut = CLIGetParamDouble("double_out")
  intOut = CLIGetParamInt("int_out")
  stringOut = CLIGetParamString("string_out")
  matrixOut = CLIGetParamMat("matrix_out")
  modelOut = CLIGetParamGaussianKernelPtr("model_out")
  modelBwout = CLIGetParamDouble("model_bw_out")

  CLIClearSettings()

  my_list <- list("doubleOut" = doubleOut, "intOut" = intOut, "stringOut" = stringOut, "matrixOut" = matrixOut, "modelOut" = modelOut, "modelBwout" = modelBwout)

  return (my_list)
}
