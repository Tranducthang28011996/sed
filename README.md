##Secondary Education: Education Management System (SED-EMS)

This is my second attempt at a better implementation of the [Dixie State College][dsc]: Education Management System. It is intended for internal use for the DSC Professors and Advisors.

For the purposes of Authentication, it uses a simple implementation of `has_secure_password` [(documentation)][hsp]. See below for a link to Ryan Bates' Railscast on how to implement this feature.

##Purpose:
The Secondary Education department at Dixie State College of Utah needed a way for the faculty there to administer Surveys that students can take. After they have responses provided by the students taking the various Surveys, the application then permits the faculty to export data regarding responses as a `.csv` file that can be imported into any spreadsheet program.

##Authentication
Originally we planned to use the wonderful [Devise][devise] gem, but for our purposes, we chose to implement authentication based on [this][authentication] Railscast. Users are added explicitly by the professors, instead of having the students register on the site. Students have the option to confirm their account by editing their profile information.

##Authorization
To handle the need for multiple roles for the application, I used Ryan Bates gem, [CanCan][cancan]. Currently, there are four basic roles: Student, Advisor, Professor, God (intended as Admin). Since the application uses an integer on the User model `roles_mask`, it is easy to add additional roles at the end of the array.

# TODO:
* In the near future, I intend to refactor the application to implement the [Surveyor][surveyor] gem to handle all the Survey logic.
* Refactor the styling to use [Twitter Bootstrap][bootstrap].
* Add `Evaluations` to the User model for students. 
* Implement the Advisor role.
* Add a `Graduation Requirements` model that belongs to students.
* And much, much more...

# Support and Copyright
Email: mark.d.holmberg@gmail.com

Copyright: I don't mind people viewing the source of this application to learn from, but if you plan on implementing this commercially or in an education related fashion, _please contact me first_ so we can work something out. I've put a lot of hours and hard work into this.

## References
* [Devise][devise]
* [has_secure_password][hsp]
* [CanCan][cancan]
* [Surveyor][surveyor]
* [Twitter Bootstrap][bootstrap]


[devise]: https://github.com/plataformatec/devise  "Devise Gem"
[hsp]: http://apidock.com/rails/ActiveModel/SecurePassword/ClassMethods/has_secure_password "Has Secure Password Documentation"
[cancan]: https://github.com/ryanb/cancan "Make Role Based Authorization Easy with CanCan!"
[surveyor]: https://github.com/NUBIC/surveyor "Survey on Rails."
[bootstrap]: http://twitter.github.com/bootstrap/ "Twitter Bootstrap makes Interface Design Easy."
[dsc]: http://new.dixie.edu "Dixie State College of Utah"
[authentication]: http://http://railscasts.com/episodes/250-authentication-from-scratch-revised "Authentication From Scratch (revised)"
