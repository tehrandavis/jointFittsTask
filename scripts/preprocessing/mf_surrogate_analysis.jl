using DataFrames, CSV

qValues = [-5:5;]
scales = [3:11;]
n_surrogates = 30

mfw_df = DataFrame()
mfSpectrum_df = DataFrame()


for pair in 201:212

    for trial in 1:28

        for person in 1:2

            filename = string("data/surrogateTS/Pair_", pair, "_trial_", trial, "_p", person,".txt")

            surrogates = CSV.read(filename)

            for i in 1:n_surrogates

                ## getting mfw and adding to dataframe ------
                # run mf analysis
                mfSpectrum = ChhabraJensen(surrogates[:,i], qValues, scales)
                # remove bad fits
                #filter!(row -> row[:Rsqr_alpha] > .949, mfSpectrum)
                # get mfw
                mfw = maximum(mfSpectrum.alpha) - minimum(mfSpectrum.alpha)
                # add row of data to the dataframe
                append!(mfw_df, DataFrame(pair=pair, trial=trial, person=person, surrogate = i, mfw=mfw))

                # ------------

                ## show entire spectrum and print diagnostic plots ----

                trial_col = repeat([trial], outer=length(qValues))
                pair_col = repeat([pair], outer=length(qValues))
                person_col = repeat([person], outer=length(qValues))
                surrogate_col = repeat([i], outer=length(qValues))


                append!(mfSpectrum_df,
                    hcat(DataFrame(trial=trial_col,
                    pair = pair_col, person = person_col,
                    surrogate = surrogate_col), mfSpectrum)
                    )
            end
        end
    end
end

CSV.write("data/surrogateTS/_surrogates_mfw.txt", mfw_df)
CSV.write("data/surrogateTS/_surrogates_mfSpectrum.txt", mfSpectrum_df)
