# Test that when we run the binding correctly (with correct input parameters),
# we get the expected output.
%!test disp ("TestRunBindingCorrectly")
%! [double_out, int_out, ~, string_out] = test_octave( :, 4.0, 12, "hello", true);
%! assert(string_out, "hello2");
%! assert(int_out, 13);
%! assert(double_out, 5.0);

# If we forget the mandatory flag, we should get wrong results.
%!test disp ("TestRunBindingNoFlag")
%! [double_out, int_out, ~, string_out] = test_octave( :, 4.0, 12, "hello");
%! assert(string_out, "wrong");
%! assert(int_out, 11);
%! assert(double_out, 3.0);

# If we give the wrong int, we should get wrong results.
%!test disp ("TestRunBindingWrongInt")
%! [~, int_out, ~, ~] = test_octave( :, 4.0, 15, "hello", true);
%! assert(int_out, 11);

# If we give the wrong double, we should get wrong results.
%!test disp ("TestRunBindingWrongDouble")
%! [double_out, ~, ~, ~] = test_octave( :, 2.0, 12, "hello", true);
%! assert(double_out, 3.0);

# If we give the wrong string, we should get wrong results.
%!test disp ("TestRunBindingWrongString")
%! [~, ~, ~, string_out] = test_octave( :, 4.0, 12, "goodbye", true);
%! assert(string_out, "wrong");

# If we give the second flag, this should fail.
%!test disp ("TestRunBadFlag")
%! [double_out, int_out, ~, string_out] = test_octave( :, 4.0, 12, "hello", true,
%!                                                     true);
%! assert(string_out, "wrong");
%! assert(int_out, 11);
%! assert(double_out, 3.0);

# The matrix we pass in, we should get back with the third dimension doubled and
# the fifth forgotten.
%!test disp ("TestMatrix")
%! X = [1, 2, 3, 4, 5 ; 6, 7, 8, 9, 10; 11, 12, 13, 14, 15];
%! [~, ~, matrix_out, ~] = test_octave(X, 4.0, 15, "hello");
%!  for i = [0, 1, 3]
%!    for j = 1:3
%!      assert(matrix_out(j, i + 1), X(j, i + 1));
%!    end
%!  end
%!  for j = 1:3
%!    assert(matrix_out(j, 3), 2 * X(j, 3));
%!  end
