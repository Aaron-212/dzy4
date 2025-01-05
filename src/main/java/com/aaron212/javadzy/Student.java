package com.aaron212.javadzy;

import java.io.Serializable;
import java.util.ArrayList;

public class Student implements Serializable {
    private String name;     // 姓名
    private ArrayList<Score> scores;

    public Student(String name) {
        this.name = name;
        this.scores = new ArrayList<>();
    }

    public Student(String name, ArrayList<Score> scores) {
        this.name = name;
        this.scores = scores;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public ArrayList<Score> getScores() {
        return scores;
    }

    public void addScore(Score score) {
        this.scores.add(score);
    }

    public int getSize() {
        return scores.size();
    }

    public class Statistics {
        public float average;
        public int max;
        public int min;
        public float passRate;

        public Statistics() {
            this.average = 0;
            this.max = 0;
            this.min = 100;
            this.passRate = 0;

            int sum = 0;
            int passCount = 0;
            for (Score score : scores) {
                sum += score.getGrade();
                if (score.getGrade() > max) {
                    max = score.getGrade();
                }
                if (score.getGrade() < min) {
                    min = score.getGrade();
                }
                if (score.getGrade() >= 60) {
                    passCount++;
                }
            }

            if (!scores.isEmpty()) {
                average = (float) sum / scores.size();
                passRate = (float) passCount / scores.size();
            }
        }
    }
}
