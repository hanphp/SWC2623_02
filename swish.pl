% Facts
student(yat, s001).
student(hazim, s002).
student(nayli, s003).

enrolled(s001, c101).
enrolled(s001, c102).
enrolled(s001, c103).
enrolled(s002, c101).
enrolled(s002, c103).
enrolled(s003, c102).

prerequisite(c102, c101).
prerequisite(c101, c103).

% Rule: Check if a student is eligible to enroll in a course
eligible(StudentID, CourseCode) :-
    prerequisite(CourseCode, Prereq),
    enrolled(StudentID, Prereq).

% Rule: Prerequisites completed
completed(StudentID, CourseCode) :-
    enrolled(StudentID, CourseCode).

% Rule: Recommend suitable courses based on completed prerequisites
recommend(StudentID, CourseCode) :-
    \+ enrolled(StudentID, CourseCode),
    \+ (prerequisite(CourseCode, Prereq),
    \+ completed(StudentID, Prereq)).

% Rule: Identify students eligible for graduation
graduation(StudentID) :-
    student(_, StudentID),
    \+ (required(CourseCode),
        \+ completed(StudentID, CourseCode)).

% Add: Required courses for graduation
required(c101).
required(c102).
required(c103).