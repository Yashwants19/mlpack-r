/**
 * @file get_type.hpp
 * @author Yasmine Dumouchel
 *
 * Template metaprogramming to return the string representation of the type
 * for the Go bindings.
 *
 * mlpack is free software; you may redistribute it and/or modify it under the
 * terms of the 3-clause BSD license.  You should have received a copy of the
 * 3-clause BSD license along with mlpack.  If not, see
 * http://www.opensource.org/licenses/BSD-3-Clause for more information.
 */
#ifndef MLPACK_BINDINGS_GO_GET_TYPE_HPP
#define MLPACK_BINDINGS_GO_GET_TYPE_HPP

#include <mlpack/prereqs.hpp>
#include <mlpack/core/util/param_data.hpp>
#include <mlpack/core/util/is_std_vector.hpp>

namespace mlpack {
namespace bindings {
namespace go {

template<typename T>
inline std::string GetType(
    const util::ParamData& /* d */,
    const typename boost::disable_if<util::IsStdVector<T>>::type* = 0,
    const typename boost::disable_if<data::HasSerialize<T>>::type* = 0,
    const typename boost::disable_if<arma::is_arma_type<T>>::type* = 0)
{
  return "unknown";
}

template<>
inline std::string GetType<int>(
    const util::ParamData& /* d */,
    const typename boost::disable_if<util::IsStdVector<int>>::type*,
    const typename boost::disable_if<data::HasSerialize<int>>::type*,
    const typename boost::disable_if<arma::is_arma_type<int>>::type*)
{
  return "Int";
}

template<>
inline std::string GetType<float>(
    const util::ParamData& /* d */,
    const typename boost::disable_if<util::IsStdVector<float>>::type*,
    const typename boost::disable_if<data::HasSerialize<float>>::type*,
    const typename boost::disable_if<arma::is_arma_type<float>>::type*)
{
  return "Float";
}

template<>
inline std::string GetType<double>(
    const util::ParamData& /* d */,
    const typename boost::disable_if<util::IsStdVector<double>>::type*,
    const typename boost::disable_if<data::HasSerialize<double>>::type*,
    const typename boost::disable_if<arma::is_arma_type<double>>::type*)
{
  return "Double";
}

template<>
inline std::string GetType<std::string>(
    const util::ParamData& /* d */,
    const typename boost::disable_if<util::IsStdVector<std::string>>::type*,
    const typename boost::disable_if<data::HasSerialize<std::string>>::type*,
    const typename boost::disable_if<arma::is_arma_type<std::string>>::type*)
{
  return "String";
}

template<>
inline std::string GetType<bool>(
    const util::ParamData& /* d */,
    const typename boost::disable_if<util::IsStdVector<bool>>::type*,
    const typename boost::disable_if<data::HasSerialize<bool>>::type*,
    const typename boost::disable_if<arma::is_arma_type<bool>>::type*)
{
  return "Bool";
}

template<typename T>
inline std::string GetType(
    const util::ParamData& d,
    const typename boost::enable_if<util::IsStdVector<T>>::type* = 0)
{
  return "Vec" + GetType<typename T::value_type>(d);
}

template<typename T>
inline std::string GetType(
    const util::ParamData& /* d */,
    const typename boost::enable_if<arma::is_arma_type<T>>::type* = 0)
{
  std::string type = "";
  if (std::is_same<typename T::elem_type, double>::value)
  {
    if (T::is_row)
      type = "Row";
    else if (T::is_col)
      type = "Col";
    else
      type = "Mat";
  }
  else if (std::is_same<typename T::elem_type, size_t>::value)
  {
    if (T::is_row)
      type = "Urow";
    else if (T::is_col)
      type = "Ucol";
    else
      type = "Umat";
  }

  return type;
}

template<typename T>
inline std::string GetType(
    const util::ParamData& d,
    const typename boost::disable_if<arma::is_arma_type<T>>::type* = 0,
    const typename boost::enable_if<data::HasSerialize<T>>::type* = 0)
{
  return d.cppType + "*";
}

/**
 * Function is used to generate the type names that are used in calls to
 * functions like gonumToArma<type>() or setParam<type>(), and therefore
 * what's returned isn't exactly the Go native type used for that parameter
 * type.
 *
 * @param data Parameter data struct.
 * @param input Unused parameter.
 * @param output Output storage for the string.
 */
template<typename T>
void GetType(const util::ParamData& d,
             const void* /* input */,
             void* output)
{
  *((std::string*) output) =
      GetType<typename std::remove_pointer<T>::type>(d);
}

} // namespace go
} // namespace bindings
} // namespace mlpack

#endif
