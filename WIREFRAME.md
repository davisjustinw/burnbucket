# Stories
As a user I can
- Sign up with a unique login and password DONE
- Login with username and password. DONE
- CRUD budgets-with-names aka buckets
- Set bucket totals
- Set bucket time period
- CRUD units
- CRUD line items aka entries
- Set line item cost per period unit
- Set line item start and end periods
- Budget a line item
- Spend against the line item
- View the bucket per unit rate

# Models

## User
User and owner of buckets.  Users can CRUD their own buckets.  Maybe users can share buckets for other user to view.  

### Attributes
- username
- password

### Associations
- has_secure password
- has_many buckets
- has_many units
- has_many rates through units

### Validations
- username not empty
- password not empty
- username unique


## Bucket
The parent model.  Represents one of many "budgets" a user can track.  

### Attributes
- name
- start_time
- end_time
- total

### Associations
has_many entries
belongs_to user

### Validations
- end_time after start time
- valid time
- number for total
- name not empty
- only owner can CUD

## Entry
A line item on a budget.  Represents a plan to spend or

### Attributes
- name
- start_time
- end_time
- amount

### Associations
- belongs_to bucket

### Validations
- end_time after start_time
- valid time
- name not empty
- only owner can CUD

## Unit
The custom "currency" being budgeted

### Attributes
- name (singular and plural)

### Associations
- belongs_to buckets
- belongs_to entries through buckets?
- Has many rates?

### Validations
- no duplicates
- name not empty
- only owner can CUD

## Rate
The burn rate for a given unit. Not sure if this is necessary.

### Attributes
- period

### Associations
- belongs_to entries
- belongs_to units
- belongs_to users

### Validations
- period must be empty
- must associate with unit, user
