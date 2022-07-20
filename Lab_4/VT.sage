# Coding Theory for Storage and Networks
# Lab on VT Codes
# Sage Version 1, 07-2022

# --------Assignment--------
# --------------------------------
# --------------------------------
print("----Task 1: VT Decoding ----")
# --------------------------------
n = 15
a = 0

# ----Task 1.1----
# Check, if c is a valid codeword by computing its checksum.
c = vector(GF(2),[0, 1, 1, 0, 0, 0, 0, 1, 0, 1, 0, 1, 1, 0, 0])
S = # ?

print('The codeword c is %s.' % c)
if # ?:
    print('c is a valid codeword.\n')


# ----Task 1.2----
# Implement a VT_decoder(r,n) that can correct a single deletion or insertion.
def VT_Decoder(r, n):
	"""
	Binary Varshamov-Tenengolts decoder for a single deletion
	Inputs:
		r: received word
		n: length of the code
	Ouput: 
		c_hat: extimated codeword
		pos: where deletion or insertion happens
		err_type: "deletion" or "insertion"
	"""
	# ========
	# Block of your implementation




	# ========
	return c_hat, pos, err_type

# ----Task 1.3----
# (1) A random deletion occurs to the codeword c. Correct the error using your VT_decoder. 
# A random deletion occurs
del_pos = randint(0, n-1)
r_del = c.list()
r_del.pop(del_pos) # del r_del[del_pos] # alternative
r_del = vector(r_del)
print('Received word with deletion at position %s \nis %s.\n' % (del_pos, r_del))

# Correct the error and find the postion and type of the error
c_hat, pos, err_type = # ?

assert c_hat == c, "Decoding of deletion is not correct.\n"
print('Deletion is decoded corretly.\n')


# (2) A random insertion occurs to the codeword c. Correct the error using your VT_decoder. 
# A random insertion occurs
ins_pos = randint(0, n-1)
ins_val = GF(2).random_element()
r_ins = vector(c[:ins_pos].list()+[ins_val]+c[ins_pos:].list())
print('Received word with insertion %s at position %s is \n%s.\n' % (ins_val, ins_pos, r_ins))

# Correct the error and find the postion and type of the error
c_hat, pos, err_type = # ?

assert c_hat == c, "Decoding of insertion is not correct.\n"
print('Insertion is decoded corretly.\n')

