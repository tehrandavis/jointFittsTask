
Pkg.add("DataFrames", "CSV", "TimeseriesSurrogates")

using DataFrames, CSV, TimeseriesSurrogates


surrogate_iterations = 1:30
surrogate_column_names =


for pair in 201:212
    for trial in 1:28

        pair = 201
        trial = 1
        filename = string("data/processed_marker_data/Pair_", pair, "_trial_", trial, ".csv")

        ts = CSV.read(filename);

        p1_df =
        p2_df = DataFrame()

        for i in 1:30
            p1_df[i] = iaaft(ts.z)

        end

        outputFilename = string("surrogateTS/Pair_", pair, "_trial_", trial, ".txt")

        CSV.write(outputFilename, df)
    end
end

pair = 201
trial = 1
filename = string("data/processed_marker_data/Pair_", pair, "_trial_", trial, ".csv")
DataFrame([Float64, Float64, Float64], [:x], 10)
ts = CSV.read(filename);
