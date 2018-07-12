using PerlaTonettiWaugh, Base.Test, Parameters, NamedTuples

# Generate default parameters. 

simple_numerical_params = @kw_nt(γ = 0.005, σ = 0.02, α = 2.1, r = 0.05, ζ = 14.5)


z = unique([linspace(0.0, 1.0, 151)' linspace(1.0, 5.0, 201)'])

# Test

@test_broken results = stationary_numerical_simple(simple_numerical_params(), z)
@test_broken results.g ≈ 0.0211182826;
@test_broken results.ν ≈ 1.75369955156;
@test_broken results.v[1] ≈ 35.04962283;
@test_broken results.v[40] ≈ 165.31581267;
@test_broken results.v[end] ≈ 3312.7957099;