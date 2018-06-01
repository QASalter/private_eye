# How to Use
Place the method call where you want image regression to take place.
`PrivateEye::Compare.new(report, step).run`
On its first run it will take a base photo, every time it is run again it will compare the new photo to the base one.

The method either returns true or false depending on if the image is within 5% tolerance. This can be changed later in a config file.
So it can be put inside an expect block in cucumber ot rspec.

e.g.
`PrivateEye::Compare.new(ReportData.base[:report], Step.find_by_title('We load the kiosk start screen ?(.*)')).run`

# Installation

    gem install private_eye

# TODO

* Write code and documentation
* Add config file
