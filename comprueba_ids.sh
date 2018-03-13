#Canvi de separadors
sed -i 's/::/§/g' users.dat
sed -i 's/::/§/g' movies.dat
sed -i 's/::/§/g' ratings.dat


counter=0
commandSed=''

#Cambio numeracion de users
awk  -F '§' 'BEGIN{print "userId§gender§age§occupation§zip-code"} NR>1 {print ($1-1)"§"$2"§"$3"§"$4"§"$5}' users.dat > formated_users.dat
awk  -F '§' 'BEGIN {print "userId§movieId§rating§timestamp"} NR>1 {print $1-1"§"$2"§"$3"§"$4}' ratings.dat> formated_ratings_temp.dat



exec 3> formated_movies.dat
exec 4> formated_ratings.dat

#headers
echo 'movieId§movieName§genres' >&3
echo 'userId§movieId§rating§timestamp' >&4

while IFS='§' read -r id name genre
do
        echo $counter'§'$genre >&3
        commandSed=$commandSed"s/§$id(§.*§.*$)/§$counter\1/g;"
        counter=$(($counter+1))
done <"movies.dat"

sed -r $commandSed formated_ratings_temp.dat >&4
rm ./formated_ratings_temp.dat
#echo $commandSed
#awk  -F '§' 'NR>1 {print $1-1"§"$2"§"$3"§"$4}' formated_ratings.dat
#awk  -F '§' 'BEGIN {print "userId§movieId§rating§timestamp"} NR>1 {print $1-1"§"$2"§"$3-1"§"$4}' formated_ratings2.dat> formated_ratings.dat
