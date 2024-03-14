class complex
{
  float re, im;
  complex()                      {re=0; im=0;}
  complex(float re_, float im_)  {re=re_; im=im_;}
};

complex c_add(complex a, complex b)   {complex c = new complex(a.re+b.re, a.im+b.im); return c;}
complex c_sub(complex a, complex b)   {complex c = new complex(a.re-b.re, a.im-b.im); return c;}
complex c_mult(complex a, complex b)  {complex c = new complex(a.re*b.re - a.im*b.im, a.re*b.im + a.im*b.re); return c;}
float modulus(complex z)              {return sqrt(z.re*z.re+z.im*z.im);}
float modulussq(complex z)            {return z.re*z.re+z.im*z.im;}

complex pixelsToComplex(int x, int y, complex center) {
  float H = IH * zoom, W = IW * zoom;
  float real = map(x, 0, width, center.re-W/2, center.re+W/2);
  float img = map(y, height, 0, center.im-H/2, center.im+H/2);
  complex c = new complex(real, img); 
  return c;
}
