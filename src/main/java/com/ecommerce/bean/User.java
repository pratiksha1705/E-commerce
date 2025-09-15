package com.ecommerce.bean;

import java.sql.Timestamp;

public class User {

    private int id;
    private String name;
    private String email;
    private String password_hash;
    private String phone;
    private Timestamp created_at;

    // Default constructor
    public User() {
    }

    // --- Getters and Setters ---
    // Pro Tip: In NetBeans, you can right-click in the editor,
    // choose "Insert Code...", and then "Getter and Setter..."
    // to generate these automatically.

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword_hash() {
        return password_hash;
    }

    public void setPassword_hash(String password_hash) {
        this.password_hash = password_hash;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Timestamp getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Timestamp created_at) {
        this.created_at = created_at;
    }
}