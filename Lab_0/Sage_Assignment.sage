# Coding Theory for Storage and Networks
# Lab Introduction: Finite Field in Sage
# Version 1, 21-01-2018

# --------Assignment--------
# --------------------------------
print("----Task 1 Defining finite field elements and performing basic operations----")
# --------------------------------
p = 2
m = 4
q = p^m

# ----Task 1.1----
# Define the field F_q with a primitive element named a.
F = GF(q,a)


# ----Task 1.2----
# Define two elements.
ele1 = a^2 + 1
ele2 = a^2 + a

# calculate the logarithm w.r.t a
log1 = log(ele1, a)
log2 = log(ele2, a)

# check primitivity
powers1 = [ ele1^i for i in range(0, 15) ]
powers2 = [ ele2^i for i in range(0, 15) ]
print(powers1)
print(powers2)

# --------------------------------
print("----Task 2 Plynomials over finite fields----")
# --------------------------------

G.<x> = F[] # First possibility
G.<x> = PolynomialRing(F) # Second possibility
G = PolynomialRing(F, 'x') # Third possibility
x = polygen(F) # Forth possibility

# ----Task 2.1----
# Represent the polynomial
poly_f = x^5 + a^2*x^4 + (a^3 + a^2 + a)*x^3 + (a^3 + a^2 + a)*x^2 + a^3*x + a + 1
poly_coef = poly_f.list()
print("The coefficients are\n%s" % (poly_coef))

# ----Task 2.2----
# Find the roots of the polynomial
f_roots = poly_f.roots()
print("The roots are \n%s" % (f_roots))
