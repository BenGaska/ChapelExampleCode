module mandlebrotParallel{


    use MPlot;
    use Time;

    //Param indicates that it is a constant known at compile time
    param STEPS = 100;

    //For task distributed parallelism we define numTasks as numCores we have available to use
    const numTasks = here.numCores;
    config const rows = 1000;
    config const cols = rows;

    var time = new Timer();
    time.start();
    var image: [0..#rows, 0..#cols] int;
    coforall tid in 0..#numTasks{
        compute(image, numTasks, tid);
    }
    time.stop();

    writeln("Time Elapsed: ",time.elapsed());

    plot(image);

    proc detectBoundaries(numTask, rng, tid){
         var span = (rng.high + 1) - rng.low;
 
         if (tid == numTask) {
             return rng.high + 1;
         }
         return rng.low + tid * (span / numTask);
    }

    //Chapel contains means for querying a formal argument.
    //Int this case, the [?D] means, query the domain of image, and 
    //store the value in D.
    proc compute(image: [?D] int, numTasks, tid){
        var blockRowRange = detectBoundaries(numTasks, D.dim(1), tid)..
                          (detectBoundaries(numTasks, D.dim(1) - 1, tid + 1));
        var blockColRange = D.dim(2);
        
        for i in blockRowRange{
            for j in blockColRange{
                image(i,j) = findPoint(i,j);
            }
        }
    }

    proc findPoint(x, y){
	const complexVal = mapImg2CPlane(x,y);
        var sum: complex;
        for i in 1..STEPS{
            sum = sum * sum  + complexVal;
            if( abs(sum) > 2.0 ) {
                return i;
            }   
        }   
        return 0;
    }

    proc mapImg2CPlane(row, col) {
          const (rmin, rmax) = (-1.5, .5);
          const (imin, imax) = (-1i, 1i);

         return ((rmax - rmin) * col / cols + rmin) +
               ((imin - imax) * row / rows + imax);
     }
}
