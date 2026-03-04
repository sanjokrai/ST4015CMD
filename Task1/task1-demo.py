import base64
from urllib.parse import quote, unquote

# ASCII
text = "This is Encoding"
for ch in text:
    print("This is ASCII Value")
    print(f"{ch} => {ord(ch)}")
    

# Base64
encoded = base64.b64encode(text.encode()).decode()
decoded = base64.b64decode(encoded).decode()
print(f"\nOriginal : {text}")
print(f"Encoded Base64 : {encoded}")
print(f"Decoded  : {decoded}")

# URL Encoding
url = "name=Sanjok Rai&city=Kathmandu Nepal"
enc_url = quote(url)
dec_url = unquote(enc_url)
print(f"\nOriginal : {url}")
print(f"Encoded URL : {enc_url}")
print(f"Decoded  : {dec_url}")

