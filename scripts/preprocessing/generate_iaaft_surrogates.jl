

using DataFrames, CSV, TimeseriesSurrogates, Statistics

n_surrogates = 30

for pair in 201:212

    for trial in 1:28

        filename = string("data/processed_marker_data/Pair_", pair, "_trial_", trial, ".csv")


        marker_positions = CSV.read(filename)

        #individual lateral hand positions
        p1_hand_pos = marker_positions.p1handZ .- minimum(marker_positions.p1handZ) .+ 1
        p2_hand_pos = marker_positions.p2handZ .- minimum(marker_positions.p2handZ) .+ 1

        # preallocate surrogate arrays, going to decimal to ensure its a Float64
        p1_surrogates = fill(0.0, length(p1_hand_pos), n_surrogates)
        p2_surrogates = fill(0.0, length(p2_hand_pos), n_surrogates)


        for i in 1:n_surrogates
            p1_surrogates[:,i] = iaaft(p1_hand_pos)
            p2_surrogates[:,i] = iaaft(p2_hand_pos)
        end

        p1_outputFilename = string("data/surrogateTS/Pair_", pair, "_trial_", trial, "_p1.txt")
        p2_outputFilename = string("data/surrogateTS/Pair_", pair, "_trial_", trial, "_p2.txt")


        CSV.write(p1_outputFilename, DataFrame(p1_surrogates))
        CSV.write(p2_outputFilename, DataFrame(p2_surrogates))
    end
end
