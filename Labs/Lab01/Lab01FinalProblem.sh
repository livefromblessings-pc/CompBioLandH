#Remove first empty column from file, then view the last lines of new edited file
cut -f 2-4 -d , PredPreyData.csv >> EditPredPreyData.csv

#Extract first line from edited file and make new file
head -1 EditPredPreyData.csv >> Last11PredPreyData.csv

#Extract last 11 lines from edited file and add to same new file
tail -11 EditPredPreyData.csv >> Last11PredPreyData.csv
