module nBottlesOfBeer{

       config const n : int = 99;

       forall i in (1..n){
           writeln(i, " Bottles of Beer on the wall.", i, " Bottles of beer. Take 1 down pass it around ", i - 1," Bottles of Beer on the wall.");
       }
}
