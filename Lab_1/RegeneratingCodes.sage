# Coding Theory for Storage and Networks
# Lab on Regenerator Codes
# Sage Version 0, 04-2020

# -------- Assignment --------
import time
# --------------------------------
print("----Task 1 Regenerating Codes by ZigZag Codes----")
# --------------------------------
F3 = GF(3)
n = 5
k = 3
d = 4
alpha = 4
beta = 2
# ----Task 1.1----
# Determine the encoding matrix $\bA_i,\ i=1,\dots,5$ of each user such that $\bs_i=\bA_i\bu$.
A_1 = # ?
A_2 = # ?
A_3 = # ?
A_4 = # ?
A_5 = # ?

# ----Task 1.2----
# Encode $\bu$ and get all the $\bs_i$. How much time does the whole encoding take?
# Hint: Use the function time.time()
u = random_vector(F3,12) # random message
ts = time.time() # log the time when encoding starts
s_1 = # ?
s_2 = # ?
s_3 = # ?
s_4 = # ?
s_5 = # ?
t_enc = time.time() - ts # calulate the time spent on encoding
print("Encoding time: %s" % t_enc)

### ----Task 1.3----
# Assume node 1 has failed. How do you repair it with minimum bandwidth?
# How much time does it take to get the node up and running? Assume downloading one symbol cost 1 second. Calculate the time spent on downloading and measure the time spent on decoding the downloaded symbol to repair Node 1.

d2 = # ? # downloaded symbols from Node 2
d3 = # ? # downloaded symbols from Node 3
d4 = # ? # downloaded symbols from Node 4
d5 = # ? # downloaded symbols from Node 5
t_download = # ? # calculate the time for downloading the symbols

t_s = time.time() # log the time when start downloading and decoding
s_11 = # ? # repair the first symbol of Node 1
s_12 = # ? # repair the second symbol of Node 1
s_13 = # ? # repair the third symbol of Node 1
s_14 = # ? # repair the forth symbol of Node 1

s_1_repair = vector([s_11, s_12, s_13, s_14])

t_decode = time.time() - t_s # measure the time spent on decoding
t_repair = t_download + t_decode
print("Repair time: %s" % t_repair)
print("Repair correctly? %s" % (s_1_repair == s_1))

# ----Task 1.4----
# Calculate the time spent to reconstruct the file by contacting node 1,2,3.
d1 = # ? # download symbols from Node 1
d2 = # ? # download symbols from Node 2
d3 = # ? # download symbols from Node 3
t_reconstruct = # ?
print("Reconstruct time: %s" % t_reconstruct)


### --------------------------------
print("----Task 2 Regenerating Codes by Product Matrix Codes----")
# --------------------------------
n = 5
k = 3
d = 4
F = GF(13)
u = vector(F, (2,2,3,5,6,10))
alpha = 2
beta = 1
# ----Task 2.1----
# Time spent to encode the data to be stored on the $n=5$ nodes.
Psi = # ? # The Vandermonde matrix
M = # ? # matrix composed of file symbols

t_s = time.time()
S = # ? # each row of this matrix is stored in one node
t_enc = time.time() - t_s
print("Encoding time: %s" % t_enc)

# ----Task 2.2----
# Assume node 4 has failed. How do you repair it by connecting $d=4$ nodes with bandwidth $\beta =1$?
# Hint: Determine the coding vector at the helper nodes.
t_s = time.time()
# ============================================
#
#
#   Write your own codes for repairing node 4
#
#
# ============================================

t_decode = time.time()-t_s
t_download = # ? # Calculate the time for downloading
t_repair = t_decode + t_download
print("Repair time: %s" % t_repair)
# print("Correctly repair? %s" %(S[3,:].transpose()==s4_repair))

### ----Task 2.3----
# Reconstruct the file by contacting Node 1,2,3.
contacts = [0,1,2] # indecids of the nodes to contact to reconstruct the file. Be careful the indices in Python start from 0.
t_s = time.time()
# ============================================
#
#
#   Write your own codes for reconstruct the file
#
#
# ============================================

t_decoding = time.time()-t_s
t_download = # ? # calculate the time for downloading the symbols from Node 1,2,3
t_reconstruct = t_decoding + t_download
print("Reconstruct time: %s" % t_reconstruct)
print("Correctly reconstruct? %s" % (u_reconstruct==u))
