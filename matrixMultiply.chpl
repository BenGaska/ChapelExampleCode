


module matrixMultiply{
  

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

 
	var m1:[{1..2, 1..2}] int;
	m1(1,1) = 1; m1(1,2) = 2;
	m1(2,1) = 3; m1(2,2) = 4;
	writeln("Matrix 1 is:\n", m1, "\n");
 
	var m2:[{1..2, 1..2}] int;
	m2(1,1) = 2; m2(1,2) = 3;
	m2(2,1) = 4; m2(2,2) = 5;
	writeln("Matrix 2 is:\n", m2, "\n");
 
	var m3 = m1 * m2;
	writeln("Matrix 3 = Matrix 1 * Matrix 2:\n", m3,"\n");
 
	var m4:[{1..2, 1..3}] int;
	m4(1, 1) = 1; m4(1, 2) = 2; m4(1, 3) = 3;
	m4(2, 1) = 4; m4(2, 2) = 5; m4(2, 3) = 6;
	writeln("Matrix 4 is:\n",m4,"\n");
 
	var m5:[{1..3, 1..2}] int;
	m5(1, 1) = 7; m5(1, 2) = 4;
	m5(2, 1) = 6; m5(2, 2) = 3;
	m5(3, 1) = 5; m5(3, 2) = 2;
	writeln("Matrix 5 is:\n", m5, "\n");
 
	writeln("Matrix 6 = Matrix 4 * Matrix 5:\n", m4 * m5,"\n");
      

}
