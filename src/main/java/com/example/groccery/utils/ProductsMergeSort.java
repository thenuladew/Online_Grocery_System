package com.example.groccery.utils;

import com.example.groccery.models.Product;

public class ProductsMergeSort {

    public static void sort(SimpleProductList products, String sortBy) {
        if (products == null || products.size() <= 1) return;
        mergeSort(products, 0, products.size() - 1, sortBy);
    }

    private static void mergeSort(SimpleProductList list, int left, int right, String sortBy) {
        if (left < right) {
            int mid = (left + right) / 2;
            mergeSort(list, left, mid, sortBy);
            mergeSort(list, mid + 1, right, sortBy);
            merge(list, left, mid, right, sortBy);
        }
    }

    private static void merge(SimpleProductList list, int left, int mid, int right, String sortBy) {
        int n = right - left + 1;
        Product[] temp = new Product[n];
        for (int i = 0; i < n; i++) temp[i] = list.get(left + i);
        int i = 0, j = mid - left + 1, k = left;
        while (i <= mid - left && j <= right - left) {
            if (compare(temp[i], temp[j], sortBy) <= 0) {
                list.set(k++, temp[i++]);
            } else {
                list.set(k++, temp[j++]);
            }
        }
        while (i <= mid - left) {
            list.set(k++, temp[i++]);
        }
        while (j <= right - left) {
            list.set(k++, temp[j++]);
        }
    }

    private static int compare(Product a, Product b, String sortBy) {
        switch (sortBy.toLowerCase()) {
            case "price":
                return Double.compare(a.getPrice(), b.getPrice());
            case "category":
                return a.getCategory().compareTo(b.getCategory());
            default:
                return a.getName().compareTo(b.getName());
        }
    }
}