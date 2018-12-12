parameter_defaults = @with_kw (ρ = 0.02,
                                σ = 3.9896,
                                N = 10,
                                θ = 4.7060,
                                γ = 1.00,
                                κ = 0.0103,
                                ζ = 1.,
                                η = 0.,
                                Theta = 1,
                                χ = 0.4631,
                                υ = 0.0755,
                                μ = 0.,
                                δ = 0.053,
                                d_0 = 3.0700,
                                d_T = 2.5019,
                                d = d_T,
                                d0 = 3.07)

# some default settings
settings_defaults = @with_kw (z_max = 5,
                                z = unique([range(0., 0.1, length = 400)' range(0.1, 1., length = 400)' range(1., z_max, length = 100)']),
                                Δ_E = 1e-6,
                                iterations = 2,
                                ode_solve_algorithm = CVODE_BDF(),
                                g_node_count = 30,
                                T = 40.0,
                                t = range(0.0, T, length = 10),
                                g = LinearInterpolation(t, stationary_numerical(parameter_defaults(), z).g .+ 0.01*t),
                                E_node_count = 15,
                                entry_residuals_nodes_count = 15,
                                transition_x0 = [-0.9292177397159866, -0.7943649969667788, -0.6074874641357887, -0.49189979684672824, -0.3347176170032159, -0.24481769383592616, -0.24481769383592616, -0.12833092365907556, -0.08936576264703058, -0.07942433422192792, -0.05398997533585611, -0.041889325410586, -0.02836357671136145, -0.02836357671136145],
                                fifty_node_iv = [-0.929218, -0.841391, -0.803333, -0.794365, -0.754679, -0.736209, -0.607487, -0.577871, -0.558031, -0.4919, -0.479076, -0.465534, -0.360035, -0.334718, -0.332038, -0.323274, -0.311173, -0.244818, -0.244818, -0.244818, -0.244818, -0.244818, -0.244818, -0.244818, -0.237423, -0.219363, -0.216696, -0.146547, -0.128331, -0.12802, -0.10991, -0.0897189, -0.0895796, -0.0893658, -0.0820695, -0.0794243, -0.0781519, -0.0586852, -0.0547494, -0.05399, -0.0471126, -0.0446752, -0.0437074, -0.0435607, -0.0418893, -0.0397457, -0.0351173, -0.0291903, -0.0283636, -0.0283636],
                                transition_lb = transition_x0,
                                transition_ub = transition_lb,
                                transition_iterations = 2,
                                transition_weights = [fill(15, 3); fill(1, entry_residuals_nodes_count-3)],
                                transition_penalty_coefficient = 0.0, # coefficient to be used for a penalty function for constraints on increasing E
                                tstops = nothing)
