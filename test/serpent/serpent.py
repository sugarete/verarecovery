from Crypto.Cipher import Serpent
from binascii import hexlify

# Example key (256-bit)
key = bytes.fromhex('000102030405060708090A0B0C0D0E0F101112131415161718191A1B1C1D1E1F')

# Create a new Serpent cipher object in ECB mode (no actual encryption, just to access round keys)
cipher = Serpent.new(key, Serpent.MODE_ECB)

# Function to extract round keys (pycryptodome does not expose round keys directly)
def get_round_keys(cipher, rounds=33):
    # This part is pseudo-code as actual extraction depends on library internals
    # Assuming we have a function get_round_key that extracts round keys from internal state
    round_keys = []
    for i in range(rounds):
        round_key = cipher.get_round_key(i)
        round_keys.append(round_key)
    return round_keys

# Get the round keys
# Note: PyCryptodome does not provide a direct method to get round keys.
# You might need to use another library or tool to extract round keys, or refer to the Serpent specification.
round_keys = get_round_keys(cipher)

# Print the round keys
for i, rk in enumerate(round_keys):
    print(f"Round {i}: {hexlify(rk).decode()}")
