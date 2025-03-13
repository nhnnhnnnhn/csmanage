-- Tạo cơ sở dữ liệu
CREATE DATABASE SchoolManagement;
GO

USE SchoolManagement;
GO

-- Tạo bảng Học sinh
CREATE TABLE Students (
    student_id INT PRIMARY KEY IDENTITY(1,1),
    first_name NVARCHAR(50) NOT NULL,
    last_name NVARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender NVARCHAR(10) CHECK (gender IN (N'Nam', N'Nữ', N'Khác')),
    address NVARCHAR(255),
    phone_number VARCHAR(15),
    email VARCHAR(100),
    enrollment_date DATE DEFAULT GETDATE(),
    status NVARCHAR(20) DEFAULT N'Đang học' CHECK (status IN (N'Đang học', N'Nghỉ học', N'Tốt nghiệp'))
);
GO

-- Tạo bảng Giáo viên
CREATE TABLE Teachers (
    teacher_id INT PRIMARY KEY IDENTITY(1,1),
    first_name NVARCHAR(50) NOT NULL,
    last_name NVARCHAR(50) NOT NULL,
    date_of_birth DATE,
    gender NVARCHAR(10) CHECK (gender IN (N'Nam', N'Nữ', N'Khác')),
    address NVARCHAR(255),
    phone_number VARCHAR(15),
    email VARCHAR(100),
    hire_date DATE DEFAULT GETDATE(),
    salary DECIMAL(10, 2),
    status NVARCHAR(20) DEFAULT N'Đang dạy' CHECK (status IN (N'Đang dạy', N'Nghỉ phép', N'Đã nghỉ việc'))
);
GO

-- Tạo bảng Môn học
CREATE TABLE Subjects (
    subject_id INT PRIMARY KEY IDENTITY(1,1),
    subject_name NVARCHAR(100) NOT NULL,
    description NVARCHAR(MAX),
    credits INT NOT NULL CHECK (credits > 0),
    is_active BIT DEFAULT 1
);
GO

-- Tạo bảng Lớp học
CREATE TABLE Classes (
    class_id INT PRIMARY KEY IDENTITY(1,1),
    class_name NVARCHAR(50) NOT NULL,
    grade_level INT CHECK (grade_level BETWEEN 1 AND 12),
    academic_year NVARCHAR(20) NOT NULL,
    homeroom_teacher_id INT,
    FOREIGN KEY (homeroom_teacher_id) REFERENCES Teachers(teacher_id)
);
GO

-- Tạo bảng Đăng ký lớp học (nhiều học sinh - nhiều lớp)
CREATE TABLE ClassEnrollments (
    enrollment_id INT PRIMARY KEY IDENTITY(1,1),
    student_id INT NOT NULL,
    class_id INT NOT NULL,
    enrollment_date DATE DEFAULT GETDATE(),
    status NVARCHAR(20) DEFAULT N'Đang học' CHECK (status IN (N'Đang học', N'Hoàn thành', N'Đã rút')),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (class_id) REFERENCES Classes(class_id),
    -- Mỗi học sinh chỉ có thể đăng ký một lớp một lần
    CONSTRAINT UC_StudentClass UNIQUE (student_id, class_id)
);
GO

-- Tạo bảng Phân công giảng dạy (nhiều giáo viên - nhiều môn học)
CREATE TABLE TeachingAssignments (
    assignment_id INT PRIMARY KEY IDENTITY(1,1),
    teacher_id INT NOT NULL,
    subject_id INT NOT NULL,
    class_id INT NOT NULL,
    semester NVARCHAR(20) NOT NULL,
    academic_year NVARCHAR(20) NOT NULL,
    FOREIGN KEY (teacher_id) REFERENCES Teachers(teacher_id),
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id),
    FOREIGN KEY (class_id) REFERENCES Classes(class_id),
    -- Mỗi môn học trong một lớp chỉ được phân công cho một giáo viên trong một học kỳ
    CONSTRAINT UC_SubjectClassSemester UNIQUE (subject_id, class_id, semester, academic_year)
);
GO

-- Tạo bảng Điểm số
CREATE TABLE Grades (
    grade_id INT PRIMARY KEY IDENTITY(1,1),
    student_id INT NOT NULL,
    subject_id INT NOT NULL,
    teacher_id INT NOT NULL,
    semester NVARCHAR(20) NOT NULL,
    academic_year NVARCHAR(20) NOT NULL,
    exam_type NVARCHAR(50) NOT NULL CHECK (exam_type IN (N'Kiểm tra 15 phút', N'Kiểm tra 1 tiết', N'Giữa kỳ', N'Cuối kỳ')),
    score DECIMAL(5, 2) CHECK (score BETWEEN 0 AND 10),
    grade_date DATE DEFAULT GETDATE(),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id),
    FOREIGN KEY (teacher_id) REFERENCES Teachers(teacher_id)
);
GO

-- Tạo bảng Người dùng hệ thống
CREATE TABLE Users (
    user_id INT PRIMARY KEY IDENTITY(1,1),
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL, -- Lưu mật khẩu đã hash
    role NVARCHAR(20) NOT NULL CHECK (role IN (N'Admin', N'Giáo viên', N'Học sinh')),
    teacher_id INT NULL,
    student_id INT NULL,
    last_login DATETIME,
    is_active BIT DEFAULT 1,
    FOREIGN KEY (teacher_id) REFERENCES Teachers(teacher_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    -- Kiểm tra: mỗi người dùng chỉ được liên kết với một vai trò (teacher hoặc student)
    CONSTRAINT CHK_UserRole CHECK (
        (role = N'Giáo viên' AND teacher_id IS NOT NULL AND student_id IS NULL) OR
        (role = N'Học sinh' AND student_id IS NOT NULL AND teacher_id IS NULL) OR
        (role = N'Admin' AND teacher_id IS NULL AND student_id IS NULL)
    )
);
GO

-- Thêm dữ liệu mẫu cho môn học
INSERT INTO Subjects (subject_name, description, credits) VALUES
(N'Toán', N'Môn học cơ bản về Đại số và Hình học', 4),
(N'Văn học', N'Môn học về ngôn ngữ và văn chương', 3),
(N'Vật lý', N'Môn học về các quy luật tự nhiên', 4),
(N'Hóa học', N'Môn học về các chất và phản ứng hóa học', 4),
(N'Sinh học', N'Môn học về các sinh vật sống', 3),
(N'Lịch sử', N'Môn học về quá khứ của loài người', 2),
(N'Địa lý', N'Môn học về trái đất và các đặc điểm của nó', 2),
(N'Tin học', N'Môn học về máy tính và lập trình', 3),
(N'Tiếng Anh', N'Môn học ngôn ngữ quốc tế', 3),
(N'Giáo dục công dân', N'Môn học về đạo đức và xã hội', 1);
GO