package com.example.groccery.utils;

import com.example.groccery.models.Product;

public class SimpleProductList {
    private Product[] data;
    private int size;
    private static final int INITIAL_CAPACITY = 10;

    public SimpleProductList() {
        data = new Product[INITIAL_CAPACITY];
        size = 0;
    }

    public void add(Product p) {
        if (size == data.length) resize();
        data[size++] = p;
    }

    public Product get(int index) {
        if (index < 0 || index >= size) throw new IndexOutOfBoundsException();
        return data[index];
    }

    public void set(int index, Product p) {
        if (index < 0 || index >= size) throw new IndexOutOfBoundsException();
        data[index] = p;
    }

    public int size() {
        return size;
    }

    public SimpleProductList subList(int from, int to) {
        SimpleProductList sub = new SimpleProductList();
        for (int i = from; i < to; i++) sub.add(get(i));
        return sub;
    }

    public Product[] toArray() {
        Product[] arr = new Product[size];
        for (int i = 0; i < size; i++) arr[i] = data[i];
        return arr;
    }

    private void resize() {
        Product[] newData = new Product[data.length * 2];
        for (int i = 0; i < data.length; i++) newData[i] = data[i];
        data = newData;
    }
} 
