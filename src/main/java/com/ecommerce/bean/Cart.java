package com.ecommerce.bean;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class Cart {
    private List<CartItem> items;

    public Cart() {
        items = new ArrayList<>();
    }

    // Add an item to the cart or update quantity if it already exists
    public void addItem(Product product, int quantity) {
        for (CartItem item : items) {
            if (item.getProduct().getId() == product.getId()) {
                item.setQuantity(item.getQuantity() + quantity);
                return;
            }
        }
        items.add(new CartItem(product, quantity));
    }

    public List<CartItem> getItems() {
        return items;
    }

    // Calculate the total price of all items in the cart
    public BigDecimal getTotal() {
        BigDecimal total = BigDecimal.ZERO;
        for (CartItem item : items) {
            total = total.add(item.getSubtotal());
        }
        return total;
    }
    
    
        // Add these two new methods inside your Cart.java class

    /**
     * Updates the quantity of an item in the cart.
     * If the quantity is 0 or less, the item is removed.
     * @param productId The ID of the product to update.
     * @param quantity The new quantity.
     */
    public void updateItem(int productId, int quantity) {
        if (quantity <= 0) {
            removeItem(productId);
            return;
        }
        for (CartItem item : items) {
            if (item.getProduct().getId() == productId) {
                item.setQuantity(quantity);
                return;
            }
        }
    }

    /**
     * Removes an item completely from the cart.
     * @param productId The ID of the product to remove.
     */
    public void removeItem(int productId) {
        items.removeIf(item -> item.getProduct().getId() == productId);
    }
}