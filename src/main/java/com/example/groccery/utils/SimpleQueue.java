package com.example.groccery.utils;

public class SimpleQueue {
    private static class Node {
        String value;
        Node next;
        Node(String value) { this.value = value; }
    }
    private Node head, tail;
    private int size = 0;

    public void enqueue(String value) {
        Node node = new Node(value);
        if (tail != null) tail.next = node;
        tail = node;
        if (head == null) head = node;
        size++;
    }

    public String dequeue() {
        if (head == null) return null;
        String value = head.value;
        head = head.next;
        if (head == null) tail = null;
        size--;
        return value;
    }

    public boolean contains(String value) {
        Node curr = head;
        while (curr != null) {
            if (curr.value.equals(value)) return true;
            curr = curr.next;
        }
        return false;
    }

    public String[] toArray() {
        String[] arr = new String[size];
        Node curr = head;
        int i = 0;
        while (curr != null) {
            arr[i++] = curr.value;
            curr = curr.next;
        }
        return arr;
    }

    public boolean isEmpty() {
        return size == 0;
    }

    public int size() {
        return size;
    }

    public void clear() {
        head = tail = null;
        size = 0;
    }
} 