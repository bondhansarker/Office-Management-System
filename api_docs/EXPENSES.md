### Table of Contents
* [Index](#markdown-header-index)
* [Show](#markdown-header-show)
* [Create](#markdown-header-create)
* [Update](#markdown-header-update)
* [Destroy](#markdown-header-destroy)
* [Approve](#markdown-header-approve)
* [Undo](#markdown-header-undo)
* [Reject](#markdown-header-reject)


## Index

Shows all the expenses the active user can access.

* **URL:** `/api/expenses`

* **Method:**  `GET` 
  
* **Authentication required:**  Yes
  
* **URL Params**
  
     * **Optional:**
   
        * The search will be held based on 3 attributes(*user name, category name or product name*) of expense resource.
   
            `search = [string]`   (i.e. /api/expenses?token=value&search=value)
      
        * The date search will be held based on *expense date* of expense resource.
      
             `from = [date]`  `to = [date]`   (i.e. /api/expenses?token=value&from=start_date&to=end_date)
            
             `date format = 'yy-mm-dd'`
   
   
* **Success Response:**
  
    * **Code:** `200`
    * **Content:** 
    
```json 
     {
       "pending_expenses": [
         {
           "id": 17,
           "user": {
             "id": 6,
             "name": "Api Admin"
           },
           "product_name": "Pencil",
           "category": "d",
           "cost": "45.0",
           "expense_date": "2020-03-01",
           "url": "/api/expenses/17.json"
         }
       ],
       "approved_expenses": [
         {
           "id": 15,
           "user": {
             "id": 6,
             "name": "Api Admin"
           },
           "product_name": "Pen",
           "category": "d",
           "cost": "45.0",
           "expense_date": "2020-03-01",
           "url": "/api/expenses/15.json"
         }
     ],
       "rejected_expenses": [
         {
           "id": 10,
           "user": {
             "id": 8,
             "name": "Bondhan Sarker"
           },
           "product_name": "Pen",
           "category": "d",
           "cost": "45.0",
           "expense_date": "2020-03-01",
           "url": "/api/expenses/10.json"
         }
       ]
     }
```
 
* **Notes:**

The response will return all the expenses based on status by 3 arrays( **pending_expenses, approved_expenses, rejected_expenses** ).
  
  
## Show

Show the expense if the login user have access.

* **URL:** `/api/expenses/:id`

* **Method:** `GET` 
  
* **Authentication required:**  Yes
  
* **Success Response:**
  
      * **Code:** `200`
      * **Content:** 
    
```json 
     {
       "id": 17,
       "user": {
         "id": 6,
         "name": "Api Admin"
       },
       "product_name": "Pencil",
       "category": "d",
       "cost": "45.0",
       "expense_date": "2020-03-01",
       "url": "/api/expenses/17.json",
       "status": "pending"
     }
```
 
* **Error Response:**

      * **Code:** `401 UNAUTHORIZED`
      * **Content:** 
```json
    { "error" : "Access Denied" }
```

* or

      * **Code:** `422 UNPROCESSABLE ENTITY`
      * **Content:** 
```json
    { "error": "Record not found!!" }
```

## Create

Can create new expense.

* **URL:** `/api/expenses`

* **Method:**  `POST` 
  
* **Authentication required:**  Yes
  
* **Required Fields**
    
    `product_name = [string]`
    
    `cost = [decimal]`
    
    `expense_date = [string]`
    
    `category_id = [integer]`
    
* **Payload:**
     
```json
    {
      "expense": {
        "product_name": "Pencil",
        "cost": 45.00,
        "expense_date": "2020-03-01",
        "category_id": 1
      }
     }
```
* **Success Response:**
 
       * **Code:** `201 CREATED`
       * **Content:** 
   
```json 
    {
      "id": 17,
      "user": {
        "id": 6,
        "name": "Api Admin"
      },
      "product_name": "Pencil",
      "category": "d",
      "cost": "45.0",
      "expense_date": "2020-03-01",
      "url": "/api/expenses/17.json",
      "status": "pending"
    }
```
* **Error Response:**

      * **Code:** `422 UNPROCESSABLE ENTITY`
      * **Content:** 
```json 
   {
     "errors": {
       "product_name": [
         "can't be blank"
       ],
       "cost": [
         "can't be blank",
         "is not a number"
       ]
     }
   }
```

* **Note:**

Based on expense date's month and year it will set the budget id.


## Update

Can update existing expense if user have access and it's status is pending.

* **URL:** `/api/expenses/:id`

* **Method:**  `PATCH` 
  
* **Authentication required:**  Yes
  
* **Required Fields**
    
    `product_name = [string]`
    
    `cost = [decimal]`
    
    `expense_date = [string]`
    
    `category_id = [integer]`
    
* **Payload:**
     
```json
    {
      "expense": {
        "product_name": "Pencil",
        "cost": 45.00,
        "expense_date": "2020-03-01",
        "category_id": 1
      }
     }
```
* **Success Response:**
 
       * **Code:** `202 ACCEPTED`
       * **Content:** 
   
```json 
    {
      "message": "Expense has been updated successfully!!",
      "url": "/api/expenses/19.json"
    }
```
* **Error Response:**

      * **Code:** `422 UNPROCESSABLE ENTITY`
      * **Content:** 
```json 
   {
     "errors": {
       "product_name": [
         "can't be blank"
       ],
       "cost": [
         "can't be blank",
         "is not a number"
       ]
     }
   }
   
```
   
* or   

      * **Code:** `401 UNAUTHORIZED`
      * **Content:** 
```json
    { "error" : "Access Denied" }
```

* or

      * **Code:** `422 UNPROCESSABLE ENTITY`
      * **Content:** 
```json
    { "error": "Record not found!!" }
```

* **Note:**

Based on expense date's month and year it will set the budget id.


## DESTROY


Can Destroy existing expense if user have access and it's status is pending or rejected.


* **URL:** `/api/expenses/:id`

* **Method:**  `DELETE` 
  
* **Authentication required:**  Yes
  
* **Success Response:**
 
       * **Code:** `202 ACCEPTED`
       * **Content:** 
   
```json 
    {
      "message": "Expense has been removed successfully!!",
    }
```
* **Error Response:**

      * **Code:** `422 UNPROCESSABLE ENTITY`
      * **Content:** 
```json
    { "error" : "Expense could not be deleted!!" }
```
   
* or   

      * **Code:** `401 UNAUTHORIZED`
      * **Content:** 
```json
    { "error" : "Access Denied" }
```

* or

      * **Code:** `422 UNPROCESSABLE ENTITY`
      * **Content:** 
```json
    { "error": "Record not found!!" }
```

## Approve

Can approve existing expense if the user is admin and the expense is pending.


* **URL:** `/api/expenses/:id/approve`

* **Method:**  `PUT` 
  
* **Authentication required:**  Yes
  
* **Success Response:**
 
       * **Code:** `202 ACCEPTED`
       * **Content:** 
   
```json 
   {
     "message": "Expense has been approved successfully!!",
     "url": "/api/expenses/19.json"
   }
```
* **Error Response:**

      * **Code:** `401 UNAUTHORIZED`
      * **Content:** 
```json
    { "error" : "Access Denied" }
```

* or

      * **Code:** `422 UNPROCESSABLE ENTITY`
      * **Content:** 
```json
    { "error": "Record not found!!" }
```

* **Note:**

Based on expense date's month and year it will set the budget id. So when a expense will be approved the expense will be added to that budget.

## Undo


Can undo an existing expense if the user is admin and the expense is approved.


* **URL:** `/api/expenses/:id/approve`

* **Method:**  `PUT` 
  
* **Authentication required:**  Yes
  
* **Success Response:**
 
       * **Code:** `202 ACCEPTED`
       * **Content:** 
   
```json 
   {
     "message": "The Expense has been queued for pending!!",
     "url": "/api/expenses/19.json"
   }
```
* **Error Response:**

      * **Code:** `401 UNAUTHORIZED`
      * **Content:** 
```json
    { "error" : "Access Denied" }
```

* or

      * **Code:** `422 UNPROCESSABLE ENTITY`
      * **Content:** 
```json
    { "error": "Record not found!!" }
```

* **Note:**

Based on expense date's month and year it will set the budget id. So when a expense will be undo the expense will be reduced from that budget.


## Reject

Can reject existing expense if the user is admin and the expense is pending.


* **URL:** `/api/expenses/:id/reject`

* **Method:**  `PUT` 
  
* **Authentication required:**  Yes
  
* **Success Response:**
 
       * **Code:** `202 ACCEPTED`
       * **Content:** 
```json 
   {
     "message": "Expense has been rejected successfully!!",
     "url": "/api/expenses/19.json"
   }
```
* **Error Response:**

      * **Code:** `401 UNAUTHORIZED`
      * **Content:** 
```json
    { "error" : "Access Denied" }
```

* or

      * **Code:** `422 UNPROCESSABLE ENTITY`
      * **Content:** 
```json
    { "error": "Record not found!!" }
```




  