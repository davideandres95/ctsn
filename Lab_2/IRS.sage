# Coding Theory for Storage and Networks
# Lab on Interleaved Reed-Solomon Codes
# Sage Version v1, 2018-03

# --------Assignment--------
# --------------------------------
# Define the field order
# We work in the Galois Field GF(16)=GF(2^4)
p = 2
m = 4
q = 2^4
F.<a> = GF(q, modulus = 'primitive')
# IRS code
l_1 = 2 # number of rows of IRS code
n = q - 1 # code length
# The information length can be chosen
k_1 = 8
# Given evaluation points and a RS construction
L = [a^i for i in range(n)]
RS1 = codes.GeneralizedReedSolomonCode(L, k_1)
# As RS codes are MDS, the minimum Hamming distance can be computed
# directly using the Singleton bound.
dmin_1 = n - k_1 + 1

# --------------------------------
print("----Task 1 Homogeneous Interleaved Reed-Solomon Code----")
# --------------------------------

# ----Task 1.1----
# Calculate maximum number of errors decodable using IRS codes.
tmax_1 = # ?
assert tmax_1 == 4, "Maximum decoding radius is wrong."

# ----Task 1.2----
# Add info_12, c_12, y_12, s_12 for second RS(15,8) code at the
# corresponding places.

# Given 4 random information vectors over GF(2^m) of length k.
info_11 = random_vector(F, k_1)
info_12 = random_vector(F, k_1)
info_13 = random_vector(F, k_1)
info_14 = random_vector(F, k_1)
# Encode the information word using the generator matrix of the given RS code.
G1 = RS1.generator_matrix()
c_11 = # ?
c_12 = # ?
c_13 = # ?
c_14 = # ?
# Create error vectors
e_11 = vector(F, n)
e_11[1] = a^2
e_11[5] = a^4
e_11[9] = a^10
e_11[10] = a^3

e_12 = vector(F, n)
e_12[1] = a^6
e_12[5] = a^7
e_12[9] = a^2
e_12[10] = a^3

# Add the error to the codeword to obtain the received vector
y_11 = c_11 + e_11
y_12 = c_12 + e_12
y_13 = c_13 + e_11
y_14 = c_14 + e_12

# Calculate the syndromes.
H1 = # ?
s_11 = # ?
s_12 = # ?
s_13 = # ?
s_14 = # ?

assert s_11 == s_13, "s_11 and s_13 should be equal."
assert s_12 == s_14, "s_12 and s_14 should be equal."

# ----Task 1.3----
# Implement a function irs_decoding() that returns the error positions given the syndrome.
def irs_decoding(F, tmax, synd_vec):
    """
    locate the errors by solving the linear system of equations
    Input parameters:
        F: the Field
        tmax: Maximum number of errors decodable by IRS codes
        synd_vec: Syndrome vectors
    Return values:
        errloc: locations of the errors
        t: Actual number of errors
    """
    # ========
    # Block of your implementation
    pass
    # return errloc, t
    # ========


# Calculate the error positions.
errloc, t = irs_decoding(F, tmax_1, [s_11, s_12])
errloc.sort()
assert errloc == [1,5,9,10], "Error locations are wrong."
print('Error positions:\n %s' % errloc)

# --------------------------------
print("----Task 2 Heterogeneous Interleaved Reed-Solomon Code----")
# --------------------------------
k_2 = 6
# Create the RS code for the given k_2
RS2 = codes.GeneralizedReedSolomonCode(L, k_2)
# encode the random info_2 using generator matrix
G2 = RS2.generator_matrix()
info_2 = random_vector(F, k_2)
c_2 = info_2 * G2

# error vector
e_2 = vector(F, n)
e_2[1] = a^2
e_2[5] = a^3
e_2[9] = a^1
e_2[10] = a^9
e_2[12] = a^4
e_11[12] = a
e_12[12] = 1
# Add the error to the codeword to obtain the received vector.
y_2 = c_2 + e_2
y_11 = c_11 + e_11
y_12 = c_12 + e_12

# ----Task 2.1----
# What is the error-correction radius of C_2?
k_mean = # ?
l_2 = 3
tmax_2 = # ?

# ----Task 2.2----
# Calculate the syndrome s_2 corresponding to the additional TS code.
H2 = # ?
s_2 = # ?
s_11 = # ?
s_12 = # ?

# ----Task 2.3----
# Calculate the error positions using system of equations.
# Hint: using the irs_decoding().
errloc, t = # ?
errloc.sort()
assert errloc == [1,5,9,10,12], "Error locations are wrong."
print('Error positions of heterogeneous IRS:\n %s' % errloc)

# ----Task 2.4----
# Do we need the syndromes of all three RS codes for the decoding?

# ========
# Write the answer here in the comment:
"""



"""
# ========

# --------------------------------
print("----Task 3: Virtual Interleaving (Power Decoding)----")
# --------------------------------

k = 2;
RS4 = codes.GeneralizedReedSolomonCode(L, k)
# Create a random information word over GF(2^m) of length k.
info = random_vector(F, k)

# Encode the information word using generator matrix of a RS code.
G4 = RS4.generator_matrix()
c = info * G4

# errors happen at index = 0,2,3,4,6,9,11,13,14
e = vector(F, [a^5, 0, a^2, a^6, a^1, 0, a, 0, 0, a^5, 0, a^6, 0, a^7, a^9])

# Add the error to the codeword to obtain the received vector.
y = c + e

# ----Task 3.1----
# Calculate the maximum decoding radii for all virtual interleaving orders
# i = 2,...,6. Determine the sufficient virtual interleaving order.

# ========
# Write the answer here in the comment:
"""

"""
# ========
t_max = # ?
i_max = # ?

# ----Task 3.2----
# Complete the function Power_dec() for power decoding algorithm.
def Power_dec(F, k, y, t_max, i_max):
    """
    Perform power decoding for a received RS codeword. i.e. construct a virtual IRS by
    powering the RS codeword, then do IRS decoding.
    Inputs:
        F: the finite field
        k: the dimension of the RS code
        y: the received RS codewords
        t_max: the maximum decoding radius
        i_max: the sufficient virtual interleaving order to obtain tmax
    """
    L = [a^i for i in range(n)] # evaluation points for RS code construction
    s_vec = [] # list of syndromes of virtual IRS code
    for i in range(1,i_max+1):
    # The power decoding algorithm has to do the following steps:
        # Calculate element-wise power of the received word
        y_i = # ?

        # Calculate the dimensions of virtual codes
        k_i = # ?
        RS_i = # ?

        # Calculate original syndrome and virtual syndromes
        H_i = # ?
        s_vec.append() # ?
    # Calculate the error locations using irs_decoding()
    [errloc, t] = # ?

    return errloc, t

errloc, t = # ?
errloc.sort()
assert errloc == [0,2,3,4,6,9,11,13,14], "Error locations are wrong."
print('Error positions of virtual extension:\n %s' % errloc)

# --------------------------------
print("----Task 4: Decoding Failure----")
# --------------------------------

# ----Task 4.1----
# Run power decoding over 1000 random error vectors of length 15 and weight
# t_max and calculate the failure probability of power decoding.
# Hint: adapt the function irs_decoding() to raise an error when the decoding fails.
iteration = 1000
fail = 0
# In each iteration, create a random error vector of weight t_max and add to
# the codeword generated in Task 3. Decode the erroneous word using power decoding
# and count decoding failures.
# Hint: use try-except to catch the errors.
# ========
# Block of your implementation





# ========

# Calculate the decoding failure probability for error of weight tmax
probfail = RealField(20)(100*fail/iteration)
# Compare the result with the estimation from the lecture.
probfail_est = # ?
print('Probability of failure: %s %%' % probfail)
print('Estimated probability of failure: %s %%' % probfail_est)
