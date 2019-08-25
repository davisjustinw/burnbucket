# Development Sessions Log
## BEGIN: Sun May 26 11:37:30 PDT 2019

- Set up user migration and base
- Add concerns folder and Slugifiable module

## Pause Sun May 26 12:03:38 PDT 2019
## Unpause Sun May 26 17:42:41 PDT 2019

- Add user sign up, login and logout
- Add validation for filled username, email, password and no dups
- Add flash message for signup validations errors

## Pause Sun May 26 19:13:56 PDT 2019
## Unpause Sun May 26 19:18:18 PDT 2019
## Pause Sun May 26 19:38:13 PDT 2019
## Unpause Sun May 26 19:55:44 PDT 2019

## Committed

- Flash message errors formatted

## Committed

## Pause Sun May 26 20:24:36 PDT 2019
## Unpause Sun May 26 20:29:55 PDT 2019

- set up bucket migration and model



## Pause Sun May 26 20:54:33 PDT 2019
## Unpause Mon May 27 09:12:02 PDT 2019

- fixed slugifiable needing an explicit require to make bucket work


## Pause Mon May 27 09:41:16 PDT 2019
## Unpause Mon May 27 19:31:49 PDT 2019

- add bucket index, create

## Committed

## Pause Mon May 27 19:59:52 PDT 2019
## Unpause Wed May 29 20:32:56 PDT 2019

- protect bucket from non-users
- bucket edit, show views and routes

## Committed

## Pause Wed May 29 21:52:16 PDT 2019
## Unpause Thu May 30 19:55:32 PDT 2019

- entry model and migration
- Add entry edit on edit bucket page
- Add entry list to show bucket page
- Add edit button to show bucket page
- Add entry new to edit bucket page
- Add amounts to entry lists on bucket edit and show

## Pause Thu May 30 21:23:18 PDT 2019
## Unpause Sun Jun  2 10:28:45 PDT 2019

## Pause Sun Jun  2 11:14:49 PDT 2019
## Unpause  Sun Jun  2 13:47:19 PDT 2019


## Pause Sun Jun  2 15:36:00 PDT 2019
## Unpause Sun Jun  2 18:37:40 PDT 2019
## Pause Sun Jun  2 20:39:13 PDT 2019
## Unpause Mon Jun  3 20:35:41 PDT 2019
## Pause Mon Jun  3 22:19:50 PDT 2019
## Unpause Tue Jun  4 19:29:54 PDT 2019
## Pause Tue Jun  4 20:29:54 PDT 2019
## Unpause Wed Jun  5 19:49:31 PDT 2019
## Pause Wed Jun  5 21:34:20 PDT 2019

## Unpause Tue Jun 11 19:51:38 PDT 2019
## Pause Tues Jun 11 21:00:22 PDT 2019

## Unpause Wed Jun 12 09:45:38 PDT 2019

- buckets breadcrumb partial
- add "new" as placeholder in bucket/new for @bucket.name
- slug bucket name
- slug user name (scrapped for now)
- create concatenated url (scrapped for now)

- unit

## Jul 8
- back up and running
- took date time out of model.
- added psi psi naught

## Jul 9

- add delete button to bucket cards
- fix edit bucket link to route to edit buckets
- fix bucket widths

## Jul 10

- fix moments each on edit bucket erb
- update moment section of edit bucket to new model
- credit debit position on edit bucket for moments

## Jul 13 - 16
- work out unit relationship to get Bucket based unit sums
- create journal entry input on buckets page

## Aug 13
- fix bucket sum
- add value and bucket to journal entry


## Aug 17

- add date time to journal entry
- add action (ratio sum)
-- add validation for 2 max unit types
-- it two units ratio is calculated

## Aug 18
- numberless entry
- unitless bucket?
- edits pages
-- journal entry
-- bucket
- fix edit routes to convention
- add placeholder logic to edit pages
- Delete behavior
- bucket name uniqueness validation
- sorting
- edit user and delete
- fix session bug

- layout sweep
-- hover behavior on form controls
-- journal row
-- bucketlist row
-- bucket row
-- bucket_lists edit if empty no catch


- validation sweep

- comment and clean

- timestamp journal entries
- counter page

- redirect if not logged in
- password input change
- login redirects to proper routes
- double database hit find vs find_by find_by returns nil

# Backlog

- many to many for bucket and bucketlist

# Blog
- code like you'll return
- sometimes you have to break the spin
- small wins
- make the engine to the honda
- is the time spent spinning taking from the time your app will live
- don't lose sight of the goal, when stories break down this will get you on track
- think about layout first
