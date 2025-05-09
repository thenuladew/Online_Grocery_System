package com.example.groccery.utils;

import com.example.groccery.models.Product;

import java.util.ArrayList;
import java.util.List;
import java.util.Comparator;

public class ProductsMergeSort {

    public static void sort(List<Product> products, String sortBy) {
        if (products == null || products.size() <= 1) return;

        mergeSort(products, 0, products.size() - 1, getComparator(sortBy));
    }

    private static void mergeSort(List<Product> list, int left, int right, Comparator<Product> comparator) {
        if (left < right) {
            int mid = (left + right) / 2;
            mergeSort(list, left, mid, comparator);
            mergeSort(list, mid + 1, right, comparator);
            merge(list, left, mid, right, comparator);
        }
    }

    private static void merge(List<Product> list, int left, int mid, int right, Comparator<Product> comparator) {
        List<Product> temp = new ArrayList<>(list.subList(left, right + 1));
        int i = 0, j = mid - left + 1, k = left;

        while (i <= mid - left && j <= right - left) {
            if (comparator.compare(temp.get(i), temp.get(j)) <= 0) {
                list.set(k++, temp.get(i++));
            } else {
                list.set(k++, temp.get(j++));
            }
        }

        while (i <= mid - left) {
            list.set(k++, temp.get(i++));
        }

        while (j <= right - left) {
            list.set(k++, temp.get(j++));
        }
    }

    private static Comparator<Product> getComparator(String sortBy) {
        return switch (sortBy.toLowerCase()) {
            case "price" -> Comparator.comparingDouble(Product::getPrice);
            case "category" -> Comparator.comparing(Product::getCategory);
            default -> Comparator.comparing(Product::getName); // default fallback
        };
    }
}