# cr_degradation
This script manages the validity and degradation of items within player inventory. It is designed to simulate the natural aging and deterioration of certain items, such as food, based on time.

## Features:

1. **Validity and Expiration:**
    - Each item has an associated expiration date.
    - When a player acquires an item, the script automatically sets its validity period.
    - As time passes, the item’s validity gradually decreases.
   
2. **Storage Behavior:**
    - If a player stores the item in a **chest** or their **horse’s saddlebag**, the validity countdown continues.
    - Even when not in use, the item still degrades.
  
3. **Spoiled Versions:**
    - When an item reaches its expiration date, you can configure two options:
        - **Remove from Inventory:** The item is removed entirely from the player’s inventory.
        - **Replace with Spoiled Version:** The item is replaced with a “spoiled” version. For example:
            - An apple becomes an **“applespoiled”**.
            - A loaf of bread becomes **“breadspoiled”**.

## Implementation:

- The script utilizes **time events** to update item validity.
- It regularly checks the current date and compares it with each item’s expiration date.

# Installation
- Download the cr_degradation script.
- Extract the cr_degradation folder into your RedM resources directory.
- Ensure cr_degradation is listed in your server.cfg or resources.cfg file.
- Start or restart your RedM server.
  
## Benefits:

- **Realism:** Adds a layer of realism to the game, encouraging players to manage their resources with care.
- **Dynamic Economy:** Item degradation can impact the server’s economy, making fresh products more valuable.
