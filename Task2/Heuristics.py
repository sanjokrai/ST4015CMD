import time
# List of students to be seated
students  = ["Alice", "Bob", "Charlie", "Diana", "Eve"]

# Pairs who are friends and should NOT sit next to each other
friends   = {("Alice", "Bob"), ("Bob", "Charlie"), ("Diana", "Eve")}

# Pairs from the same city who should NOT sit next to each other
same_city = {("Alice", "Charlie"), ("Bob", "Diana")}

# Check if two students conflict (friends or same city)
def are_conflicting(a, b):
    return (a, b) in friends or (b, a) in friends or \
           (a, b) in same_city or (b, a) in same_city

# Check if the entire arrangement is valid (no adjacent conflicts)
def is_valid(arr):
    return all(not are_conflicting(arr[i], arr[i+1]) for i in range(len(arr)-1))

# Count how many students a given student conflicts with
def conflict_count(s):
    return sum(1 for x in students if x != s and are_conflicting(s, x))

print("HEURISTIC APPROACH")
print("-" * 35)

start = time.time()  # Start timer

# Sort students by conflict count (least conflicted first)
remaining = sorted(students, key=conflict_count)

# Start seating with the least conflicted student
seated = [remaining.pop(0)]

# Place each remaining student one by one
while remaining:
    placed = False

    # Try adding the next student at the end of the row
    for s in remaining:
        if not are_conflicting(seated[-1], s):
            seated.append(s)
            remaining.remove(s)
            placed = True
            break

    # If no one fits at the end, try inserting at any position
    if not placed:
        for s in remaining:
            for i in range(len(seated) + 1):
                candidate = seated[:i] + [s] + seated[i:]
                if is_valid(candidate):
                    seated = candidate
                    remaining.remove(s)
                    placed = True
                    break
            if placed:
                break

elapsed = time.time() - start  # Stop timer

print(f"Result   : {' | '.join(seated)}")
print(f"Time     : {elapsed:.6f} seconds")
print(f"Status   : {'VALID' if is_valid(seated) else 'INVALID'}")