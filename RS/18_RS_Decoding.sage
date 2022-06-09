import time

def get_column_multipliers(n, alphas, vs_G):
	"""Returns columns multipliers of H for given column multipliers of G"""
	A = matrix(F, n-1, n, lambda i,j: alphas[j]^i*vs_G[j])
	return A.right_kernel_matrix().list()	# Returns a non-zero vector b with A*b=0 (as a list)

def random_error(n, F, t):
	"""Returns an error word of length n over the field F with t many errors"""
	error_pos = sample(range(n), t)
	error = [F(0)]*n
	for i in error_pos:
		while error[i].is_zero():
		    error[i] = F.random_element()
	return vector(F, error)

# Parameters
q = next_prime(1000) 			# Choose a prime power
n = q-1			# n<q
k = floor(n/3)		# k<n (here k ~ n/3)
d = n-k+1		# RS codes are MDS codes
t = floor((n-k)/2)	# Unique error-correction radius

# Choose alphas
F      = GF(q, 'a')	# Construct a finite field of q elements
alphas = F.list()[1:]	# Choose alphas to be all non-zero field elements
vs_G   = [F(1) for i in range(n)]		  # Column multipliers (of G) v_i'=1
vs_H   = get_column_multipliers(n, alphas, vs_G)  # Compute the col. mult. v_i of H (using the function defined above)

# Generator matrix
print('########################################################\n')
G = matrix(F, k, n, lambda i,j: alphas[j]^i*vs_G[j])	# A generator matrix as in the lecture notes
H = matrix(F, n-k, n, lambda i,j: alphas[j]^i*vs_H[j])	# A parity-check matrix as in the lecture notes
print('G =')
print(G)			# print G (if n is too large, it only shows the dimensions of G)
print('\nH =')
print(H)			# print H
print('\nG*H^T =')
print(G*H.transpose())	# print G*H^T (must be a kx(n-k) all-zero matrix)

# Construct code and print parameters and minimum distance
print('\n########################################################\n')
C = codes.LinearCode(G)	# Construct the code given by the generator matrix G
print(C)
print('n-k+1 =', n-k+1)			# Print n-k+1
#print('d     =', C.minimum_distance())	# Print the minimum distance of C (must be n-k+1). This only works for small n since the sage implementation of minimum_distance() has exponential complexity in n.
print('=> Can correct %d errors uniquely'%t)	# Print the number of uniquely correctable errors

# Choose random codeword, error, and compute the received word
print('\n########################################################\n')
u = VectorSpace(F,k).random_element()	# Choose random information vector of length k
c = u*G 				# Encode u, alternatively: C.random_element()
e = random_error(n, F, t)		# Get random error of weight t (using the funcion defined above)
r = c+e
error_pos = [i for i in range(0, n) if not e[i].is_zero()]
print('u =', u)
print('c =', c)
print('e =', e)
print('r =', r)
print('error positions =', error_pos)

# Compute syndrome, ELP, and EEP (the latter two are unknown at the receiver!)
print('\n########################################################\n')
Polys  = F['x']			# Define polynomial ring over F
x      = Polys.gen()		# Define x to be its variable
s = r*H.transpose()		# Compute the syndrome
SPoly = Polys(s.list())		# Compute the syndrome polynomial
ELP = prod([1-alphas[i]*x for i in error_pos])	# Compute ELP (note that a receiver cannot do this since the error positions are unknown)
EEP = sum([e[i]*vs_H[i]*prod([1-alphas[j]*x for j in error_pos if i!=j]) for i in error_pos])	# Compute EEP (note that a receiver cannot do this since the error positions are unknown)
print('Lambda(x) =', ELP)
print('Omega(x)  =', EEP)
print('S(x)      =', SPoly)
print('Lambda(x)*S(x)-Omega(x) =', ELP*SPoly-EEP)	# Print Lambda(x)*S(x)-Omega(x). According to the key equation, this polynomial is equal to 0 modulo x^(d-1). Hence, the polynomial must be divisible by x^(d-1), which means that all coefficients with index smaller than d-1 are zero.
print('x^(d-1) =', x^(d-1))

# Obtain ELP and error positions from key equation (only works for exactly t errors)
before = time.time()	# start timer
print('\n########################################################\n')
S = matrix(F, t, t, lambda i,j: s[t-1-j+i])	# Set up syndrome matrix S (as in the lecture notes)
print('S = ')
print(S)
print('rank(S)        =', S.rank())		# Determine the rank of S (if we added <t errors, the rank would be <t and we would need to decrease t)
T = vector([s[t+i] for i in range(t)])		# Set up the vector on the right-hand side in the linear system for determining Lambda(x) (see lecture notes)
print('T = ')
print(T)
lambdavec = S.solve_right(-T)			# Obtain Lambda_1,...,Lambda_t
est_ELP = Polys([1]+lambdavec.list())		# Compute Lambda(x)
print('Lambda(x)      =', ELP)
print('est. Lambda(x) =', est_ELP)		# Compare the actual Lambda(x) and the estimated Lambda(x) given by solving the key equation
est_error_pos = [l for l in range(n) if est_ELP(alphas[l]^-1)==0]	# Find the error positions by evaluating Lambda(x) at all alphas[l]^-1
print('error pos.      =', error_pos)
print('est. error pos. =', est_error_pos)	# Compare the estimated error positions with the actual ones

# Obtain ELP and error positions
print('\n########################################################\n')
est_EEP = (SPoly*est_ELP).quo_rem(x^(d-1))[1]	# Omega(x) = (Lambda(x)*S(x) mod x^(d-1)) (Note that a.quo_rem(b) returns the quotient and remainder of the polynomial division a/b, a.quo_rem(b)[1] returns only the remainder)
print('Omega(x)      =', EEP)
print('est. Omega(x) =', est_EEP)
est_ELP_der = est_ELP.derivative()		# Compute the formal derivative of ELP
est_e = vector([F(0)]*n)			# All-zero vector
for l in est_error_pos:				# Apply Forney's formula
	est_e[l] = -alphas[l]/vs_H[l]*est_EEP(alphas[l]^-1)/est_ELP_der(alphas[l]^-1)
print('e      =', e)
print('est. e =', est_e)		# Compare the estimated error word with the actual one


# Compute transmitted codeword and information
print('\n########################################################\n')
est_c = r-est_e			# Compute estimated codeword
print('c      =', c)
print('est. c =', est_c)		# Compare the estimated codeword to the actual one
est_u = G.solve_left(est_c)	# Compute the estimated information word (assuming that encoding was done with the matrix G)
print('u      =', u)
print('est. u =', est_u)		# Compare the estimated information word to the actual one 



# Display timing and number of corrected errors
print('\n########################################################\n')
elapsed = time.time() - before
print('%d errors corrected\n'%len(est_error_pos))
print('Decoding took %f seconds'%elapsed)
print('\n########################################################\n')
