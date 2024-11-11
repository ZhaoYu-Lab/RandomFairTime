dtmc

//const double D;  // Deposit
//const double VT; // Value True
//const double OP; // Original Price
//const double DP; // Discount Price



//const double Pob = (OP-VT)/VT;   //
//const double Pdb = (DP-VT)/VT;   // Pdb +  g

//const double Pp = D/VT;


//const double g = 0.1;    //g-gap
const double g;    //g-gap 

//const double Pdb = 0.6;   
const double Pdb;   
const double Pob = min(1,Pdb+g);   

//const double Pp = 0.6;  
const double Pp;  

//const int Tdt=3;

const int Tdt;



//const int Tot; 
//const int Toa;  


//const int Tst; 
//const int Tsa; 

//const int Trt = 5; 
//const int Tp = 4; 
const int Trt; 
const int Tp; 

//const double Ph = 0.8;
const double Ph;


// Pob > Pdb
// Pob 0-->1 g 0-->1 Pp 0-->1 


const double Pho = min(1,Ph*(1+Tdt*1/50));  
const double Phe = max(0,Ph*(1-(Tp*1)/(5*Trt)));  
const double Phoe = max(0,Pho*(1-(Tp*1)/(5*Trt)));  

const double Pa = 0.01;  


const double Pd_good = (Ph+Pp+Pdb)/3;  

//const double Pd_extend = ((1-Pdb)/2+(1-Ph))/3;  

//const double Pd_exit = ((1-Pp)+(1-Pdb)/2)/3;  

const double Pd_exit =  ((1-Pp)/2+(1-Ph)/2+(1-Pdb)/2)/3;
const double Pd_extend = ((1-Pp)/2+(1-Ph)/2+(1-Pdb)/2)/3;

const double Po_good = (Pho+Pp+Pob)/3;  

//const double Po_extend = ((1-Pob)/2+(1-Pho))/3;  
//const double Po_exit = ((1-Pp)+(1-Pob)/2)/3;  
const double Po_exit =  ((1-Pp)/2+(1-Pho)/2+(1-Pob)/2)/3;
const double Po_extend = ((1-Pp)/2+(1-Pho)/2+(1-Pob)/2)/3;

const double Pd_extend_good = (Phe+Pp+Pdb)/3;  
//const double Pd_extend_refund = ((1-Pdb)/2+(1-Phe))/3;  
//const double Pd_extend_exit = ((1-Pp)+(1-Pdb)/2)/3;  
const double Pd_extend_exit = ((1-Pp)/2+(1-Phe)/2+(1-Pdb)/2)/3;
const double Pd_extend_refund = ((1-Pp)/2+(1-Phe)/2+(1-Pdb)/2)/3;

const double Po_extend_good = (Phoe+Pp+Pob)/3;  
//const double Po_extend_refund = ((1-Pob)/2+(1-Phoe))/3; 
//const double Po_extend_exit = ((1-Pp)+(1-Pob)/2)/3;  
const double Po_extend_exit = ((1-Pp)/2+(1-Phoe)/2+(1-Pob)/2)/3;
const double Po_extend_refund = ((1-Pp)/2+(1-Phoe)/2+(1-Pob)/2)/3;


module seller

	// local state
	s : [0..22] init 0;
	// s=0  Sstart
	// s=1  s0 wait for deposit
	// s=2  Sabort
	// s=3  s1
	// s=4  s2
	// s=5  s3
	// s=6  s4
	// s=7  s5
	// s=8  s6
	// s=9  s7
	// s=10 s8
	// s=11 s9
	// s=12 s10

	// s=13 s11
	// s=14 s12
	
	// s=15 s13
	// s=16 s14
	// s=17 s15	
	
	// s=18 Ssucc 
	// s=19 Equity Damage ED ED1-Sfail1
	// s=20 ED2-Ssucc_con
	// s=21 ED3-Sfail2
	// s=22 ED4-Sfail3
	
	
	[] s=0 -> 1 : (s'=1);
	[] s=1 -> Pa : (s'=2) + (1-Pa) : (s'=3);
	//[] s=2 -> (s'=2);
	
	//
	[] s=3 -> 0.5 : (s'=4) + 0.5 : (s'=5);   
	
	[] s=4 -> Pd_good : (s'=6)  + Pd_exit : (s'=7) + Pd_extend : (s'=10);
	[] s=5 -> Po_good : (s'=8)  + Po_exit : (s'=9) + Po_extend : (s'=11);
	
	// 
	[] s=6 -> 1 : (s'=18);
	[] s=7 -> 1 : (s'=19);
	[] s=8 -> 1 : (s'=18);
	[] s=9 -> 1 : (s'=19);
	
	[] s=10 -> Pd_extend_good : (s'=12) +  Pd_extend_refund : (s'=13) + Pd_extend_exit : (s'=14);
	[] s=11 -> Po_extend_good : (s'=15) +  Po_extend_refund : (s'=16) + Po_extend_exit : (s'=17);
	
	
	//
	[] s=12 -> 1 : (s'=20);
	[] s=13 -> 1 : (s'=21);
	[] s=14 -> 1 : (s'=22);
	[] s=15 -> 1 : (s'=20);
	[] s=16 -> 1 : (s'=21);
	[] s=17 -> 1 : (s'=22);
	
endmodule