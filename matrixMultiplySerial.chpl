


module matrixMultiply{
       use Time;
       use Random;
       config const n : int = 1000;
       config const m : int = n;       

       proc main(){
            var a : [1..n,1..m] real;
            var b : [1..m,1..n] real;
   
            Random.fillRandom(a);
            Random.fillRandom(b);
                          
            var timer = new Timer();
            timer.start();

            var c  = a * b;

            timer.stop();
            writeln(timer.elapsed());

       }

       proc *(a:[], b:[]) {
             var (aRows, aCol) = a.domain.dims();
             var (bRows, bCol) = b.domain.dims();
 
             var c : [{aRows, bCol}] a.eltType = 0;
             for i in aRows {
                  for j in bCol {
                      for k in aCol {
                          c(i,j) += a(i,k) * b(k,j);
                      }
                  }
              }
              return c;
        }
}
