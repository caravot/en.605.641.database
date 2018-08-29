# JHU EN.605.441.81 Final Term Project


Title: Zoo Database (ZooDB)
Term: Summer, 2018


# Project Objective

Managing and maintaining a zoo is a large endeavor and requires constant updating of personal, animals, shows, and more to run smoothly. Without a proper database that can automate most actions this would be left to manual records on paper that take time, are not redundant, are prone to errors, and are not easily shared with others. Creating a zoo database management system (DBMS) will allow all of the managerial zoo tasks to be separated from the daily operations, thus alleviating general zoo staff from having to update anything, such as logging and records. 

ZooDB includes the ability to manage all staff members and their various roles. Departments oversee multiple zones with each zone representing a part of the park. Zones have shops and animals in them. The zoo also conducts shows that include staff members and animals. At each shop, items are sold and stocked, with each item able to associate with categories to help track high volume purchases (i.e. food), and low sale categories.

With centralizing the system to a database and having record keeping tracked in a coherent way, records are quickly produced to show current and past zoo statuses, employees are quickly found, and shops can be restocked according to demand with the general staff's involvement. It prevents user error by ensuring each records have the same data types and constraints as others related to it and prevents user typos/misspellings, as well as validating entries for basic error checking (such as a store having negative item inventory). As a byproduct of using a computer system in lieu of paper tracking, it also helps with creating a greener environment.

This system ensures that business logic and technology requirements and maintenance are not required by the general zoo staff but by experienced technology. ZooDB will not be required to host the database itself, as it will rely upon cloud services for this, thus reducing the overhead maintenance and support of a local server. That said general zoo staff can still easily update and manage the system that is needed for their daily job activities. The ZooDB provides the tickets effectively without any corrupted data or information and to provide a security data base to store all animals’ details. By this way, the history record can be maintained without much manual effort and storage of paper. So this reduces the usage of papers which in turns helps to keep green.

# Entities

STAFF: Every employee at the Zoo is inserted into this table and given a unique staff id (StaffID) that is the primary key of the table. This also contains the information regarding an employee, such as gender/email/phone. Each staff member may have a supervisor, who must be already listed in the staffing table. A staff member may also manage a department.

DEPARTMENT: A department is what oversees different parts of the zoo and upon creation is given a unique department id (DepartmentID) that is the primary key of the table. Each department must be managed by one staff employee. Each department has a unique name.

ZONE: Zones track the different areas physically located in a park and when inserted is given a unique zone id (ZoneID) that acts as the primary key to the table. Each zone has a unique name and must belong to a department. Departments can oversee more than one zone in the zoo.

ANIMAL: Every animal the zoo has is inserted into this table and given a unique id (AnimalID) that is also the primary key of the table. Each animal has a name and what type of animal it is (i.e. elephant, hippo, tiger), when the zoo acquired it, the date of birth, and gender. Each animal must be part of a specific zone in the zoo and must have a primary caregiver that is in the staff table. Animals may have the same name as another.

SHOW: The zoo puts on daily shows for visitors and each show is given a unique id (ShowID) that is the primary key for the table. Each show also has a unique name, optional description, and a total capacity count of how many visitors can watch each show. Each show can have one or more animals and one or more staff members conducting it.

SHOP: The zoo has many different shops throughout the park and each is identified by a unique id (ShopID) that acts as the primary key for the table. Each shop has a unique name, optional description, and open and close times. Each shop must be located in a zone and must have a supervisor from the staff associated with it. A shop can have one or more staff members working at it. The same staff member may manage multiple shops.

ITEMS: Everything that is for sale at the zoo is considered an item and is given a unique id (ItemID) that is the primary key for the table. Each item has a unique name and optional description associated with it. An item keeps track of its current stock and the minimum number of stock it’s required to have on hand. Each time stock is reordered a date is tracked in the items database.

CATEGORY: Categories help with identifying different types of items that are for sale at the. Each category has a unique id (CategoryID) that is the primary key for the table. Each category must have a unique name and has zero or more items associated with it.

# Relationships

STAFF_MANAGES: Every department must have a staff member who supervises it.

STAFF_IS_SUPERVISED_BY: Each staff member may be supervised by one other staff employee.

DEPARTMENT_HAS: Each staff member may be associated with a department.

ZONE_BELONGS_TO_DEPARTMENT: Each department must belong to one zone and each zone can have zero or more departments.

STAFF_MANAGES_ZONE: Each zone is managed by a staff employee.

ANIMAL_BELONG_TO_ZONE: Every animal must belong to one zone and each zone can have zero or more animals in it.

ANIMAL_HAS_CAREGIVER: Every animal is assigned a primary caregiver from the staff members.

SHOP_RESIDES_IN_ZONE: Each shop must belong to one zone and each zone can have zero or more shops.

SHOW_HAS_ANIMALS: Every show must have at least one animal associated with it.

SHOW_HAS_STAFF: Every show must have at least one staff member associated with it.

SHOP_HAS_STAFF: Every shop must have at least one staff member associated with it and multiple staff members can work at each shop.

SHOP_HAS_ITEMS: Each shop must have at least one item for sale at it and each item can be sold at multiple shops.

ITEM_HAS_CATEGORIES: Each item must be associated with at least one category and can be associated with more than one category.
