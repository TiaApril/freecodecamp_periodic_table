PSQL="psql --username=freecodecamp --dbname=periodic_table -t --tuples-only -c"

#if no argument
if [[ -z $1 ]]
then
echo "Please provide an element as an argument."
exit
else
  VALID_ID1=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE atomic_number = $1")
  VALID_ID2=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE symbol = '$1' OR name = '$1'")
  
  #if it's integer
  if [[ $VALID_ID1 ]]
  then
    echo $VALID_ID1 | while IFS=" |" read an name symbol type mass mp bp 
    do
    echo "The element with atomic number $an is $name ($symbol). It's a $type, with a mass of $mass amu. $name has a melting point of $mp celsius and a boiling point of $bp celsius."
    done
    else
    #if it's string
      if [[ $VALID_ID2 ]]
      then
       echo $VALID_ID2 | while IFS=" |" read an name symbol type mass mp bp 
      do
      echo "The element with atomic number $an is $name ($symbol). It's a $type, with a mass of $mass amu. $name has a melting point of $mp celsius and a boiling point of $bp celsius."
      done
      else
      #not valid argumnent
      # if argumnet is not atomic number
      echo "I could not find that element in the database."
      exit
      fi
  fi
fi
