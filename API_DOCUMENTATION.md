# AZAM POS Backend API Documentation

## Table of Contents
1. [Authentication](#authentication)
2. [Charge Categories](#charge-categories)
   - [Bulk Insert/Update Charge Categories](#bulk-insertupdate-charge-categories)
3. [Sales Management](#sales-management)
   - [Get Sales with Items and Date Filter](#get-sales-with-items-and-date-filter)
   - [Bulk Insert/Update Sales](#bulk-insertupdate-sales)
4. [Returns Management](#returns-management)
5. [Error Handling](#error-handling)

---

## Base URL
```
http://localhost:8000/api/v1
```

---

## Authentication

### Register User
Register a new user account.

**Endpoint:** `POST /auth/register`

**Request Body:**
```json
{
  "username": "string",
  "email": "string",
  "password": "string",
  "full_name": "string"
}
```

**Response (201 Created):**
```json
{
  "message": "User registered successfully",
  "user": {
    "id": "uuid",
    "username": "string",
    "email": "string",
    "full_name": "string",
    "created_at": "2024-01-01T00:00:00Z"
  }
}
```

**Error Responses:**
- `400 Bad Request` - Validation error
- `409 Conflict` - User already exists

---

### Login
Authenticate user and receive access token.

**Endpoint:** `POST /auth/login`

**Request Body:**
```json
{
  "email": "string",
  "password": "string"
}
```

**Response (200 OK):**
```json
{
  "message": "Login successful",
  "access_token": "jwt_token_here",
  "token_type": "Bearer",
  "expires_in": 3600,
  "user": {
    "id": "uuid",
    "username": "string",
    "email": "string",
    "full_name": "string"
  }
}
```

**Error Responses:**
- `401 Unauthorized` - Invalid credentials
- `400 Bad Request` - Missing required fields

---

## Charge Categories

### Get All Charge Categories
Retrieve all charge categories with their prices.

**Endpoint:** `GET /charge-categories`

**Headers:**
```
Authorization: Bearer {access_token}
```

**Response (200 OK):**
```json
{
  "categories": [
    {
      "id": "uuid",
      "name": "string",
      "price": 0.00,
      "description": "string",
      "ready_time": "2024-01-01T12:00:00Z",
      "created_at": "2024-01-01T00:00:00Z",
      "updated_at": "2024-01-01T00:00:00Z"
    }
  ],
  "total": 10
}
```

---

### Get Charge Category by ID
Retrieve a specific charge category.

**Endpoint:** `GET /charge-categories/{id}`

**Headers:**
```
Authorization: Bearer {access_token}
```

**Response (200 OK):**
```json
{
  "id": "uuid",
  "name": "string",
  "price": 0.00,
  "description": "string",
  "ready_time": "2024-01-01T12:00:00Z",
  "created_at": "2024-01-01T00:00:00Z",
  "updated_at": "2024-01-01T00:00:00Z"
}
```

**Error Responses:**
- `404 Not Found` - Category not found

---

### Create Charge Category
Create a new charge category with price and ready time.

**Endpoint:** `POST /charge-categories`

**Headers:**
```
Authorization: Bearer {access_token}
Content-Type: application/json
```

**Request Body:**
```json
{
  "name": "string",
  "price": 0.00,
  "description": "string",
  "ready_time": "2024-01-01T12:00:00Z"
}
```

**Response (201 Created):**
```json
{
  "message": "Charge category created successfully",
  "category": {
    "id": "uuid",
    "name": "string",
    "price": 0.00,
    "description": "string",
    "ready_time": "2024-01-01T12:00:00Z",
    "created_at": "2024-01-01T00:00:00Z",
    "updated_at": "2024-01-01T00:00:00Z"
  }
}
```

**Error Responses:**
- `400 Bad Request` - Validation error
- `401 Unauthorized` - Invalid or missing token

---

### Update Charge Category
Update an existing charge category.

**Endpoint:** `PUT /charge-categories/{id}`

**Headers:**
```
Authorization: Bearer {access_token}
Content-Type: application/json
```

**Request Body:**
```json
{
  "name": "string",
  "price": 0.00,
  "description": "string",
  "ready_time": "2024-01-01T12:00:00Z"
}
```

**Response (200 OK):**
```json
{
  "message": "Charge category updated successfully",
  "category": {
    "id": "uuid",
    "name": "string",
    "price": 0.00,
    "description": "string",
    "ready_time": "2024-01-01T12:00:00Z",
    "created_at": "2024-01-01T00:00:00Z",
    "updated_at": "2024-01-01T00:00:00Z"
  }
}
```

---

### Delete Charge Category
Delete a charge category.

**Endpoint:** `DELETE /charge-categories/{id}`

**Headers:**
```
Authorization: Bearer {access_token}
```

**Response (200 OK):**
```json
{
  "message": "Charge category deleted successfully"
}
```

---

### Bulk Insert/Update Charge Categories
Insert or update multiple charge categories in a single transaction.

**Endpoint:** `POST /charge-categories/bulk`

**Headers:**
```
Authorization: Bearer {access_token}
Content-Type: application/json
```

**Request Body:**
```json
{
  "categories": [
    {
      "id": "uuid",
      "name": "string",
      "price": 0.00,
      "description": "string",
      "ready_time": "2024-01-01T12:00:00Z"
    },
    {
      "name": "string",
      "price": 0.00,
      "description": "string",
      "ready_time": "2024-01-01T12:00:00Z"
    }
  ]
}
```

**Note:** 
- If `id` is provided, the category will be updated
- If `id` is not provided, a new category will be created
- All operations are performed in a single database transaction
- If any operation fails, all changes are rolled back

**Response (201 Created):**
```json
{
  "message": "Categories processed successfully",
  "created": [
    {
      "id": "uuid",
      "name": "string",
      "price": 0.00,
      "description": "string",
      "ready_time": "2024-01-01T12:00:00Z",
      "created_at": "2024-01-01T00:00:00Z",
      "updated_at": "2024-01-01T00:00:00Z"
    }
  ],
  "updated": [
    {
      "id": "uuid",
      "name": "string",
      "price": 0.00,
      "description": "string",
      "ready_time": "2024-01-01T12:00:00Z",
      "created_at": "2024-01-01T00:00:00Z",
      "updated_at": "2024-01-01T00:00:00Z"
    }
  ],
  "total": 2
}
```

**Error Responses:**
- `400 Bad Request` - Validation error
- `401 Unauthorized` - Invalid or missing token
- `404 Not Found` - Category ID provided but not found (for updates)

---

## Sales Management

### Create Sale
Create a new sale with categories, quantities, price, and ready time stamp.

**Endpoint:** `POST /sales`

**Headers:**
```
Authorization: Bearer {access_token}
Content-Type: application/json
```

**Request Body:**
```json
{
  "items": [
    {
      "category_id": "uuid",
      "quantity": 1,
      "price": 0.00
    }
  ],
  "ready_time": "2024-01-01T12:00:00Z"
}
```

**Response (201 Created):**
```json
{
  "message": "Sale created successfully",
  "sale": {
    "id": "uuid",
    "order_number": "ORD-2024-001",
    "total_amount": 0.00,
    "ready_time": "2024-01-01T12:00:00Z",
    "items": [
      {
        "id": "uuid",
        "category_id": "uuid",
        "category_name": "string",
        "quantity": 1,
        "price": 0.00,
        "subtotal": 0.00
      }
    ],
    "created_at": "2024-01-01T00:00:00Z",
    "created_by": "uuid"
  }
}
```

**Error Responses:**
- `400 Bad Request` - Validation error or invalid category
- `401 Unauthorized` - Invalid or missing token

---

### Get All Sales
Retrieve all sales with pagination.

**Endpoint:** `GET /sales`

**Headers:**
```
Authorization: Bearer {access_token}
```

**Query Parameters:**
- `page` (optional): Page number (default: 1)
- `limit` (optional): Items per page (default: 20)
- `start_date` (optional): Filter sales from date (ISO 8601)
- `end_date` (optional): Filter sales to date (ISO 8601)

**Response (200 OK):**
```json
{
  "sales": [
    {
      "id": "uuid",
      "order_number": "ORD-2024-001",
      "total_amount": 0.00,
      "ready_time": "2024-01-01T12:00:00Z",
      "items_count": 3,
      "created_at": "2024-01-01T00:00:00Z",
      "created_by": "uuid"
    }
  ],
  "pagination": {
    "page": 1,
    "limit": 20,
    "total": 100,
    "total_pages": 5
  }
}
```

---

### Get Sales with Items and Date Filter
Retrieve sales with their complete sale items, filtered by date range. This endpoint returns full item details including category information, quantities, and prices.

**Endpoint:** `GET /sales/with-items`

**Headers:**
```
Authorization: Bearer {access_token}
```

**Query Parameters:**
- `page` (optional): Page number (default: 1, minimum: 1)
- `limit` (optional): Items per page (default: 20, minimum: 1, maximum: 100)
- `start_date` (optional): Filter sales created on or after this date (ISO 8601 format)
- `end_date` (optional): Filter sales created on or before this date (ISO 8601 format)

**Example Request:**
```
GET /sales/with-items?start_date=2024-01-01T00:00:00Z&end_date=2024-01-31T23:59:59Z&page=1&limit=20
```

**Response (200 OK):**
```json
{
  "sales": [
    {
      "id": "uuid",
      "order_number": "ORD-2024-001",
      "total_amount": 25.97,
      "ready_time": "2024-01-01T12:00:00Z",
      "items": [
        {
          "id": "uuid",
          "category_id": "uuid",
          "category_name": "Coffee",
          "quantity": 2,
          "returned_quantity": 0,
          "price": 5.99,
          "subtotal": 11.98
        },
        {
          "id": "uuid",
          "category_id": "uuid",
          "category_name": "Tea",
          "quantity": 1,
          "returned_quantity": 0,
          "price": 3.99,
          "subtotal": 3.99
        }
      ],
      "created_at": "2024-01-01T00:00:00Z",
      "created_by": "uuid"
    }
  ],
  "pagination": {
    "page": 1,
    "limit": 20,
    "total": 100,
    "total_pages": 5
  }
}
```

**Notes:**
- Returns complete sale item details including category names, quantities, returned quantities, prices, and subtotals
- Date filters can be used independently or together:
  - Only `start_date`: Returns all sales from the start date onwards
  - Only `end_date`: Returns all sales up to the end date
  - Both: Returns sales within the date range
- Results are ordered by creation date (newest first)
- Each sale includes all its items with full details

**Error Responses:**
- `401 Unauthorized` - Invalid or missing token
- `400 Bad Request` - Invalid query parameters (e.g., invalid date format)

---

### Get Sale by ID
Retrieve a specific sale with all details.

**Endpoint:** `GET /sales/{id}`

**Headers:**
```
Authorization: Bearer {access_token}
```

**Response (200 OK):**
```json
{
  "id": "uuid",
  "order_number": "ORD-2024-001",
  "total_amount": 0.00,
  "ready_time": "2024-01-01T12:00:00Z",
  "items": [
    {
      "id": "uuid",
      "category_id": "uuid",
      "category_name": "string",
      "quantity": 1,
      "price": 0.00,
      "subtotal": 0.00
    }
  ],
  "created_at": "2024-01-01T00:00:00Z",
  "created_by": "uuid"
}
```

**Error Responses:**
- `404 Not Found` - Sale not found

---

### Get Sale by Order Number
Retrieve a sale by its order number (direct lookup).

**Endpoint:** `GET /sales/order/{order_number}`

**Headers:**
```
Authorization: Bearer {access_token}
```

**Response (200 OK):**
```json
{
  "id": "uuid",
  "order_number": "ORD-2024-001",
  "total_amount": 0.00,
  "ready_time": "2024-01-01T12:00:00Z",
  "items": [
    {
      "id": "uuid",
      "category_id": "uuid",
      "category_name": "string",
      "quantity": 1,
      "price": 0.00,
      "subtotal": 0.00
    }
  ],
  "created_at": "2024-01-01T00:00:00Z",
  "created_by": "uuid"
}
```

**Error Responses:**
- `404 Not Found` - Sale with the given order number not found

**Note:** This endpoint is useful for quick lookup by order number, especially in returns workflow.

---

### Update Sale
Update an existing sale.

**Endpoint:** `PUT /sales/{id}`

**Headers:**
```
Authorization: Bearer {access_token}
Content-Type: application/json
```

**Request Body:**
```json
{
  "items": [
    {
      "category_id": "uuid",
      "quantity": 1,
      "price": 0.00
    }
  ],
  "ready_time": "2024-01-01T12:00:00Z"
}
```

**Response (200 OK):**
```json
{
  "message": "Sale updated successfully",
  "sale": {
    "id": "uuid",
    "order_number": "ORD-2024-001",
    "total_amount": 0.00,
    "ready_time": "2024-01-01T12:00:00Z",
    "items": [
      {
        "id": "uuid",
        "category_id": "uuid",
        "category_name": "string",
        "quantity": 1,
        "price": 0.00,
        "subtotal": 0.00
      }
    ],
    "updated_at": "2024-01-01T00:00:00Z"
  }
}
```

---

### Delete Sale
Delete a sale.

**Endpoint:** `DELETE /sales/{id}`

**Headers:**
```
Authorization: Bearer {access_token}
```

**Response (200 OK):**
```json
{
  "message": "Sale deleted successfully"
}
```

---

### Bulk Insert/Update Sales
Insert or update multiple sales in a single transaction. Tickets are automatically created for new sales.

**Endpoint:** `POST /sales/bulk`

**Headers:**
```
Authorization: Bearer {access_token}
Content-Type: application/json
```

**Request Body:**
```json
{
  "sales": [
    {
      "id": "uuid",
      "items": [
        {
          "category_id": "uuid",
          "quantity": 1,
          "price": 0.00
        }
      ],
      "ready_time": "2024-01-01T12:00:00Z"
    },
    {
      "items": [
        {
          "category_id": "uuid",
          "quantity": 1,
          "price": 0.00
        }
      ],
      "ready_time": "2024-01-01T12:00:00Z"
    }
  ]
}
```

**Note:** 
- If `id` is provided, the sale will be updated (replaces all items)
- If `id` is not provided, a new sale will be created (ticket is automatically generated)
- All operations are performed in a single database transaction
- If any operation fails, all changes are rolled back

**Response (201 Created):**
```json
{
  "message": "Sales processed successfully",
  "created": [
    {
      "id": "uuid",
      "order_number": "ORD-2024-001",
      "total_amount": 0.00,
      "ready_time": "2024-01-01T12:00:00Z",
      "items": [
        {
          "id": "uuid",
          "category_id": "uuid",
          "category_name": "string",
          "quantity": 1,
          "price": 0.00,
          "subtotal": 0.00
        }
      ],
      "created_at": "2024-01-01T00:00:00Z",
      "created_by": "uuid"
    }
  ],
  "updated": [
    {
      "id": "uuid",
      "order_number": "ORD-2024-001",
      "total_amount": 0.00,
      "ready_time": "2024-01-01T12:00:00Z",
      "items": [
        {
          "id": "uuid",
          "category_id": "uuid",
          "category_name": "string",
          "quantity": 1,
          "price": 0.00,
          "subtotal": 0.00
        }
      ],
      "created_at": "2024-01-01T00:00:00Z",
      "created_by": "uuid"
    }
  ],
  "total": 2
}
```

**Error Responses:**
- `400 Bad Request` - Validation error or invalid category
- `401 Unauthorized` - Invalid or missing token
- `404 Not Found` - Sale ID provided but not found (for updates)

---

## Returns Management

### Process Return
Process a return by order number, creating a negative sale entry.

**Endpoint:** `POST /returns`

**Headers:**
```
Authorization: Bearer {access_token}
Content-Type: application/json
```

**Request Body:**
```json
{
  "order_number": "ORD-2024-001",
  "reason": "string",
  "items": [
    {
      "sale_item_id": "uuid",
      "quantity": 1
    }
  ]
}
```

**Response (201 Created):**
```json
{
  "message": "Return processed successfully",
  "return": {
    "id": "uuid",
    "return_number": "RET-2024-001",
    "original_sale_id": "uuid",
    "original_order_number": "ORD-2024-001",
    "total_amount": -0.00,
    "reason": "string",
    "items": [
      {
        "id": "uuid",
        "original_sale_item_id": "uuid",
        "category_name": "string",
        "quantity": 1,
        "price": 0.00,
        "subtotal": -0.00
      }
    ],
    "processed_at": "2024-01-01T00:00:00Z",
    "processed_by": "uuid"
  }
}
```

**Error Responses:**
- `400 Bad Request` - Invalid order number or validation error
- `404 Not Found` - Sale not found
- `409 Conflict` - Return already processed for this sale/item

---

### Get All Returns
Retrieve all processed returns.

**Endpoint:** `GET /returns`

**Headers:**
```
Authorization: Bearer {access_token}
```

**Query Parameters:**
- `page` (optional): Page number (default: 1)
- `limit` (optional): Items per page (default: 20)
- `order_number` (optional): Filter by order number
- `start_date` (optional): Filter returns from date (ISO 8601)
- `end_date` (optional): Filter returns to date (ISO 8601)

**Response (200 OK):**
```json
{
  "returns": [
    {
      "id": "uuid",
      "return_number": "RET-2024-001",
      "original_order_number": "ORD-2024-001",
      "total_amount": -0.00,
      "reason": "string",
      "processed_at": "2024-01-01T00:00:00Z"
    }
  ],
  "pagination": {
    "page": 1,
    "limit": 20,
    "total": 50,
    "total_pages": 3
  }
}
```

---

### Get Return by ID
Retrieve a specific return with full details.

**Endpoint:** `GET /returns/{id}`

**Headers:**
```
Authorization: Bearer {access_token}
```

**Response (200 OK):**
```json
{
  "id": "uuid",
  "return_number": "RET-2024-001",
  "original_sale_id": "uuid",
  "original_order_number": "ORD-2024-001",
  "total_amount": -0.00,
  "reason": "string",
  "items": [
    {
      "id": "uuid",
      "original_sale_item_id": "uuid",
      "category_name": "string",
      "quantity": 1,
      "price": 0.00,
      "subtotal": -0.00
    }
  ],
  "processed_at": "2024-01-01T00:00:00Z",
  "processed_by": "uuid"
}
```

**Error Responses:**
- `404 Not Found` - Return not found

---

## Error Handling

All API endpoints follow a consistent error response format:

**Error Response Format:**
```json
{
  "error": {
    "code": "ERROR_CODE",
    "message": "Human-readable error message",
    "details": {
      "field": "Additional error details if applicable"
    }
  }
}
```

### Common HTTP Status Codes

- `200 OK` - Request successful
- `201 Created` - Resource created successfully
- `400 Bad Request` - Invalid request data
- `401 Unauthorized` - Authentication required or invalid token
- `403 Forbidden` - Insufficient permissions
- `404 Not Found` - Resource not found
- `409 Conflict` - Resource conflict (e.g., duplicate entry)
- `422 Unprocessable Entity` - Validation error
- `500 Internal Server Error` - Server error

### Error Codes

- `AUTH_REQUIRED` - Authentication required
- `INVALID_CREDENTIALS` - Invalid login credentials
- `INVALID_TOKEN` - Invalid or expired token
- `VALIDATION_ERROR` - Request validation failed
- `RESOURCE_NOT_FOUND` - Requested resource not found
- `DUPLICATE_ENTRY` - Resource already exists
- `INSUFFICIENT_PERMISSIONS` - User lacks required permissions
- `RETURN_ALREADY_PROCESSED` - Return already processed for this ticket/item

---

## Authentication

All protected endpoints require a Bearer token in the Authorization header:

```
Authorization: Bearer {access_token}
```

The access token is obtained from the `/auth/login` endpoint and should be included in all subsequent requests to protected endpoints.

---

## Data Types

- **UUID**: Universally unique identifier (string format)
- **Decimal**: Decimal number with 2 decimal places (e.g., 19.99)
- **ISO 8601 DateTime**: Date and time in ISO 8601 format (e.g., "2024-01-01T12:00:00Z")
- **String**: Text data
- **Integer**: Whole number

---

## Rate Limiting

API rate limiting may be implemented. If exceeded, the API will return:

**Response (429 Too Many Requests):**
```json
{
  "error": {
    "code": "RATE_LIMIT_EXCEEDED",
    "message": "Too many requests. Please try again later.",
    "retry_after": 60
  }
}
```

---

## Versioning

The API uses URL versioning. The current version is `v1` as indicated in the base URL.

---

## Support

For API support or questions, please contact the development team.
