using TensorFlow
using Base.Test

# Try your first TensorFlow program
# https://github.com/tensorflow/tensorflow#try-your-first-tensorflow-program

hello = TensorFlow.constant("Hello, TensorFlow!")
@test isa(hello, TensorFlow.Tensor)

sess = TensorFlow.Session()
result = run(sess, hello)
@test isa(result, String)
@test "Hello, TensorFlow!" == result

a = TensorFlow.constant(10)
b = TensorFlow.constant(32)
result = run(sess, a+b)
@test isa(result, Int)
@test 42 == result

c = TensorFlow.constant(complex(Float32(3.2), Float32(5.0)))
result_r = run(sess, real(c))
@test Float32(3.2) == result_r
result_i = run(sess, imag(c))
@test Float32(5.) == result_i

d_raw = 1. + rand(10)
d = TensorFlow.constant(d_raw)
for unary_func in [erf, erfc, lgamma, tanh, tan, sin, cos, abs, exp, log]
                   result = run(sess, unary_func(d))
                   @test unary_func.(d_raw) ≈ result
end
result = run(sess, -d)
@test -d_raw == result

f_raw = rand(10)./2
f = TensorFlow.constant(f_raw)
for func in [acos, asin, atan]
    result = run(sess, func(f))
    @test func.(f_raw) ≈ result
end

mat_raw = rand(10, 10)
mat = TensorFlow.constant(mat_raw)
result = run(sess, inv(mat))
@test inv(mat_raw) ≈ result
result = run(sess, det(mat))
@test det(mat_raw) ≈ result
result = run(sess, diag(mat))
@test diag(mat_raw) ≈ result

diag_raw = rand(5)
diag_mat = TensorFlow.constant(diag_raw)
result = run(sess, det(diagm(diag_mat)))
@test prod(diag_raw) ≈ result
