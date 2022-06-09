#-------------------------------------------------------------------#
# This tutorial gives an introduction into SageMath with a focus    #
# on computations in finite fields and algebraic coding             #
#-------------------------------------------------------------------#

###
# 1. Basic computations

# Sage is based on Python and the syntax is essentially the same. If you already know
# Python, you can probably skip this section.

# The most common structures used for linear algebra are lists, vectors and matrices

L = [2,1,3] # list
V = vector([6,5,4]) # vector
M = matrix([[1,0],[2,1],[0,1]]) # matrix

# lists and vectors seem similar at first but have different properties

try:
    P1 = L*M # gives an error
except:
    print('Multiplication of list and matrix not possible')

P2 = V*M # works as expected

# As sage is based on python, it is class based. Each data type has its own functions.
# For example, type L. and press Tab to see the functions defined for lists.
# Often times the desired function can be found intuitively, e.g. the transpose of
# a matrix is found by

MT = M.transpose()

# For manipulation and building lists, in-line for loops and if statements are very handy.
# E.g. to get a list of the first 5 powers of 2

L2 = [2^i for i in range(5)] # range(a) returns the list [0,1,2,...,a-1]

# and to get a lists of the powers of 2 for all exponents in L larger 1

L2 = [2^e for e in L if e>1]


###
# 2. Finite Fields and Algebraic Coding


# Sage handles finite fields very well and has a large library of implementations of
# algebraic codes and decoders.
# Let's start by defining a finite integer field

F11 = GF(11)

# The integer 11 gives the cardinality of the field and has to be a prime or a power of a prime.
# Now we can perform calculations in this field, which is just taking the modulo for normal
# addition and multiplication

F11(11) == 0
F11(7+10) == mod(7+10,11)
F11(9*3) == mod(9*3,11)

# An extension field can be defined by

F.<a> = GF(16,modulus=x^4+x+1) # instead of an explicit ploynomial you can use modulus='primitive'

# Now F is defined as a field of cardinality 16 and represents its elements as polynomials over a.
# As the modulus we chose here is a primitive polynomial, a is a generator and we can get a list
# of all field elements by

LF = [0]+[a^i for i in range(15)]

# or alternatively

LF2 = F.list()
