package com.aaron212.javadzy;

import java.io.*;
import java.util.TreeMap;

public class StudentDataHandler {
    private static StudentDataHandler instance = null;
    private TreeMap<Integer, Student> students;
    private final File file = new File(System.getProperty("user.home"), "/.cache/data.dat");

    private void readData() {
        System.out.println(System.getProperty("user.dir"));
        try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(file))) {
            this.students = (TreeMap<Integer, Student>) ois.readObject();
        } catch (Exception e) {
            this.students = new TreeMap<>();
            e.printStackTrace();
        }
    }

    private void writeData() {
        try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(file))) {
            oos.writeObject(students);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private StudentDataHandler() {
        readData();
    }

    public static synchronized StudentDataHandler getInstance() {
        if (instance == null) {
            instance = new StudentDataHandler();
        }
        return instance;
    }

    public void addStudent(int id, String name) throws StudentDataException {
        Student student = new Student(name);
        if (!students.containsKey(id)) {
            students.put(id, student);
        } else {
            throw new StudentDataException("学号已存在");
        }

        writeData();
    }

    public void addScore(int id, String course, int grade) throws StudentDataException {
        if (students.containsKey(id)) {
            Student student = students.get(id);
            student.addScore(new Score(course, grade));
        } else {
            throw new StudentDataException("学号不存在");
        }

        writeData();
    }

    public void removeStudent(int id) throws StudentDataException {
        if (students.containsKey(id)) {
            students.remove(id);
        } else {
            throw new StudentDataException("学号不存在");
        }

        writeData();
    }

    public TreeMap<Integer, Student> getStudents() {
        return students;
    }

    public Student getStudent(int id) {
        return students.get(id);
    }
}
