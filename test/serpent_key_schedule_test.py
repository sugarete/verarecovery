
key = 0x00112233445566778899aabbccddeeffffeeddccbbaa99887766554433221100
word_array = []
key_array = []

# Apply Sboxes to 4 words

def sbox(data_in, sbox_index):
    """Applies the selected Serpent S-box to a 4-bit input."""
    sboxes = [sbox0, sbox1, sbox2, sbox3, sbox4, sbox5, sbox6, sbox7]
    if 0 <= sbox_index <= 7:
        return sboxes[sbox_index](data_in)
    else:
        return 0  # Invalid S-box index

def sbox0(data_in):
    # ... (S-box 0 lookup table)
    return sbox_lookup(data_in, [3, 8, 15, 1, 10, 6, 5, 11, 14, 13, 4, 2, 7, 0, 9, 12])

def sbox1(data_in):
    # ... (S-box 1 lookup table)
    return sbox_lookup(data_in, [15, 12, 2, 7, 9, 0, 5, 10, 1, 11, 14, 8, 6, 13, 3, 4])

# ... (Define sbox2 through sbox7 similarly)
def sbox2(data_in):
    return sbox_lookup(data_in, [8, 6, 7, 9, 3, 12, 10, 15, 13, 1, 14, 4, 0, 11, 5, 2])

def sbox3(data_in):
    return sbox_lookup(data_in, [0, 15, 11, 8, 12, 9, 6, 3, 13, 1, 2, 4, 7, 5, 10, 14])

def sbox4(data_in):
    return sbox_lookup(data_in, [1, 15, 8, 3, 12, 0, 11, 6, 2, 5, 4, 10, 9, 14, 7, 13])

def sbox5(data_in):
    return sbox_lookup(data_in, [15, 5, 2, 11, 4, 10, 9, 12, 0, 3, 14, 8, 13, 6, 7, 1])

def sbox6(data_in):
    return sbox_lookup(data_in, [7, 2, 12, 5, 8, 4, 6, 11, 14, 9, 1, 15, 13, 3, 10, 0])

def sbox7(data_in):
    return sbox_lookup(data_in, [1, 13, 15, 0, 14, 8, 2, 11, 7, 4, 12, 10, 9, 3, 5, 6])

def sbox_lookup(data_in, table):
    """Helper function to perform S-box lookup."""
    return table[data_in]

def sboxes_function(w0, w1, w2, w3, i_sbox_index):
    """Python equivalent of the sboxes Verilog module."""

    # Apply S-boxes to 4-bit slices
    sbox_output = []
    for i in range(32):
        bit_slice = ((w3 >> i) & 1) << 3 | ((w2 >> i) & 1) << 2 | ((w1 >> i) & 1) << 1 | (w0 >> i) & 1
        sbox_output.append(sbox(bit_slice, i_sbox_index))

    # Reassemble 32-bit words
    w0_out = sum((sbox_output[i] & 1) << i for i in range(32))
    w1_out = sum(((sbox_output[i] >> 1) & 1) << i for i in range(32))
    w2_out = sum(((sbox_output[i] >> 2) & 1) << i for i in range(32))
    w3_out = sum(((sbox_output[i] >> 3) & 1) << i for i in range(32))

    # Combine words into 128-bit output
    o_data = w0_out | (w1_out << 32) | (w2_out << 64) | (w3_out << 96)
    return o_data


def rotate(x, n):
    return ((x << n) | (x >> (32 - n))) & 0xffffffff

def generate_word(key):
    for i in range(8):
        word = key & 0xffffffff
        key >>= 32
        word_array.append(word)
    for i in range(8, 140):
        word = rotate(word_array[i-8] ^ word_array[i-5] ^ word_array[i-3] ^ word_array[i-1] ^ 0x9e3779b9 ^ (i-8), 11)
        word_array.append(word)

def generate_key():
    for i in range(33):
        key[i] = sboxes_function(word_array[4*i], word_array[4*i+1], word_array[4*i+2], word_array[4*i+3], (3 - i) % 8)


# Generate words
generate_word(key)
# Generate key
generate_key()

for i in range(0, 140):
    print(f"Word {i}: {word_array[i]:#0{10}x}")

for i in range(0, 33):
    print(f"Key {i}: {key_array[i]:#0{10}x}")