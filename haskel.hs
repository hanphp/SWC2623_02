type StudentID = String
type StudentName = String
type CourseCode = String

type Student = (StudentID, StudentName, [(CourseCode, Int)])

-- 1. Student detail

students :: [Student]
students =
    [ ("s001", "Wayat", [("c101",85), ("c102",90), ("c103",78)])
    , ("s002", "Nayli", [("c101",92), ("c102",95), ("c103",88)])
    , ("s003", "Hazim", [("c101",70), ("c102",65), ("c103",72)])
    , ("s004", "Aiman", [("c101",88), ("c102",84), ("c103",90)])
    ]

-- 2. Calculation (process)

average :: [(CourseCode, Int)] -> Double
average subjects =
    fromIntegral (sum (map snd subjects)) /
    fromIntegral (length subjects)

-- 3. List student avarage

studentAverages :: [(StudentID, StudentName, Double)]
studentAverages =
    [ (sid, name, average subjects)
    | (sid, name, subjects) <- students ]

-- 4. stud_average(>80)

distinctions :: [(StudentID, StudentName, Double)]
distinctions =
    filter (\(_, _, avg) -> avg > 80) studentAverages

-- 5. top student

topStudent :: (StudentID, StudentName, Double)
topStudent =
    foldl1 (\x y -> if getAvg x > getAvg y then x else y)
    studentAverages
  where
    getAvg (_, _, avg) = avg

-- 6. Helper Function for Print sub

printSubjects :: [(CourseCode, Int)] -> IO ()
printSubjects =
    mapM_ (\(code, mark) ->
        putStrLn ("   - " ++ code ++ ": " ++ show mark))

-- 7. Main Program Output

main :: IO ()
main = do
    putStrLn "============================================"
    putStrLn "        STUDENT GRADE REPORT"
    putStrLn "============================================\n"

    -- Print each student's details
    mapM_ (\(sid, name, subjects) -> do
        putStrLn ("Student ID : " ++ sid)
        putStrLn ("Name       : " ++ name)
        putStrLn "Courses:"
        printSubjects subjects
        let avg = average subjects
        putStrLn ("Average    : " ++ show (round avg))
        putStrLn "--------------------------------------------"
        ) students

    -- Print distinction students
    putStrLn "\nStudents with Distinction (Average > 80):"
    if null distinctions
        then putStrLn "   - None"
        else mapM_ (\(sid, name, avg) ->
            putStrLn ("   - " ++ sid ++ " (" ++ name ++ ") - " ++ show (round avg)))
            distinctions

    -- Print top-performing student
    let (topID, topName, topAvg) = topStudent
    putStrLn "\nTop-Performing Student:"
    putStrLn ("   - " ++ topID ++ " (" ++ topName ++
              ") with average " ++ show (round topAvg))

    putStrLn "\n============================================"
