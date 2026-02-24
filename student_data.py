from functools import reduce
import pandas as pd

# Create a Student class
class Student:
    def __init__(self, name, student_id, courses, grades):
        self.name = name
        self.student_id = student_id
        self.courses = courses          # List of course names
        self.grades = grades            # List of grades

    # calculate average using functional style (reduce)
    def average(self):
        total = reduce(lambda x, y: x + y, self.grades)
        return total / len(self.grades)

    # Predict performance based on average grade
    def predict_performance(self):
        avg = self.average()
        if avg >= 85:
            return "Excellent"
        elif avg >= 70:
            return "Good"
        elif avg >= 50:
            return "Average"
        else:
            return "At Risk"

# Create student objects
students = [
    Student("Hazim", "s002", ["c101", "c102", "c103"], [92, 95, 88]),
    Student("Hiwayat", "s001", ["c101", "c102", "c103"], [85, 90, 78]),
    Student("Nayli", "s003", ["c101", "c102", "c103"], [78, 65, 72])
]
# Functional-style data processing
# Use map() to get list of averages
averages = list(map(lambda s: (s.name, round(s.average(), 2)), students))

# Use filter() to find at-risk students
at_risk = list(filter(lambda s: s.predict_performance() == "At Risk", students))

# Use reduce() to find top-performing student
top_student = reduce(lambda s1, s2: s1 if s1.average() > s2.average() else s2, students)

# Use pandas to create and display data as table
data = {
    "Name": [s.name for s in students],
    "ID": [s.student_id for s in students],
    "Courses": [", ".join(s.courses) for s in students],
    "Average": [round(s.average(), 2) for s in students],
    "Performance": [s.predict_performance() for s in students]
}
df = pd.DataFrame(data)
print("=== Student Performance Table ===")
print(df.to_string(index=False))
print("\nStudent Averages:", averages)
print("At Risk Students:", [s.name for s in at_risk])
print("Top Performing Student:", top_student.name, "-", round(top_student.average(), 2))
