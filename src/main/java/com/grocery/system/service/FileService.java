package com.grocery.system.service;

import com.grocery.system.dto.Product;

import java.io.*;
import java.util.List;
import.java.util.UUID;

public class FileService {
    private static final String PRODUCT_FILE = "products.csv";

    //read all products from the file
    public class FileService{
        public static final String PRODUCT_FILE = "products.csv";
           public List<Product> readAllProducts(){
               File file = new File(PRODUCT_FILE);

               //Create file if it doesn't exist
               if(!file.exists()){
                   file.createNewFile();
                   file.create
               }
           }
    }

}
