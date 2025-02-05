# README

# School project

This is an application for a school's tutoring system that allows the user to do following actions:

**For Tutors:**
* Create a tutor
* Delete a tutor
* Edit a tutor

**For Lessons:**
* Schedule lessons for tutors
* Reschedule lessons
* Delete lessons

Each page has a **navigation bar** that lets the user:

* Create new tutors.
* Do a search of tutors depending on their names, surnames, specializations.
* Search for specific dates, on which none of the tutors have lessons.

In the **index page** of the application the user can: 

* Access a paginated list of all available tutors - they will be sorted in a * descending order, depending on how many hours they have. Tutors with most hours will be at the top of the list.
* Go to a specific tutors profile by selecting the tutor from the list.

**Tutor profile pages** user can:
* View general information about the tutor - full name, specialization, hourly price and their lesson plan. 
* Edit and delete tutors. 
* View a list of scheduled lessons, with lessons in the past crossed out. 
* Schedule lessons for the tutor in the future as well as rescheduling lessons that are not in the past. 

**Restrictions:**
* Tutors must have all their profile fields filled in - name, surname, specialization and hourly price during creation.
* Tutors may have multiple specializations, however, there cannot be two tutors with the same full name teaching the same subject.
* Lessons can be scheduled only in the future.
* Lessons that have already happened cannot be rescheduled, only deleted from the list.

## Technical information
* This application uses **Ruby version 3.0.2** and runs on **Rails 7.1.5.1**

* Application uses **Bundler version 2.5.23** for gems and **Yarn 1.22.22** for running Javascript dependencies

* Database uses **Postgresql**.

## Setup

* To make sure all gems are working run  ``bundle install``

* To make sure Javascript dependencies are working run ``yarn install``

* To access application in a browser ``run rails s``

* To run Rspec tests run ``bundle exec rspec``

* To populate database run:

        ``rake db:import_lessons``               
        ``rake db:import_tutors``

