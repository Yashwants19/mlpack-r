dyn.load('r_util.so')

#functions to call underlying compiled code specifying R data types via coercion 

CLIRestoreSettings <- function(programName)
{
  .Call("CLI_RestoreSettings", as.character(programName))
}

CLISetParamInt <- function(paramName, paramValue) 
{
  .Call("CLI_SetParamInt", as.character(paramName), as.integer(paramValue))
}

CLISetParamDouble <- function(paramName, paramValue) 
{
  .Call("CLI_SetParamDouble", as.character(paramName), as.double(paramValue))
}

CLISetParamString <- function(paramName, paramValue)
{
  .Call("CLI_SetParamString", as.character(paramName), as.character(paramValue))
}

CLISetParamBool <- function(paramName, paramValue)
{
  .Call("CLI_SetParamBool", as.character(paramName), as.logical(paramValue))
}

CLISetParamMat <- function(paramName, paramValue)
{
  .Call("CLI_SetParamMat", as.character(paramName), as.matrix(paramValue))
}

CLIGetParamInt <- function(paramName, paramValue)
{
  .Call("CLI_GetParamInt", as.character(paramName))
}

CLIGetParamDouble <- function(paramName, paramValue)
{
  .Call("CLI_GetParamDouble",  as.character(paramName))
}

CLIGetParamMat <- function(paramName, paramValue)
{
  mat = .Call("CLI_GetParamMat", as.character(paramName))
  nrows = .Call("CLI_GetParamMatRows", as.character(paramName))
  ncols = .Call("CLI_GetParamMatCols", as.character(paramName))
  return (matrix(mat, ncols, nrows, byrow = TRUE))
}

CLIGetParamBool <- function(paramName, paramValue)
{
  .Call("CLI_GetParamBool", as.character(paramName))
}

CLIGetParamString <- function(paramName, paramValue)
{
  .Call("CLI_GetParamString", as.character(paramName))
}

CLIEnableVerbose <- function(programName)
{
  .Call("CLI_EnableVerbose", as.character(programName))
}

CLIDisableVerbose <- function(programName)
{
  .Call("CLI_DisableVerbose", as.character(programName))
}

CLIResetTimers <- function(programName)
{
  .Call("CLI_ResetTimers", as.character(programName))
}

CLISetPassed <- function(programName)
{
  .Call("CLI_SetPassed", as.character(programName))
}

CLIClearSettings <- function()
{
  .Call("CLI_ClearSettings")
}
