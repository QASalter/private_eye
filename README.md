I have no clue what this library does.

# Pro Tip

To not have too many boilerplate commits (so you avoid ppl from thinking "WTF?
Why did he/she start with rspec but instantly switched to minitest, and what's
all that nonsense in the readme?") use `git commit --amend` to make changes in
the initial commit rather than creating new commits. Just saying.

# Usage

``` ruby
require 'private_eye'
fail("Dunno how to use %p" % PrivateEye)
```

# Installation

    gem install private_eye

# TODO

* Write code and documentation
* Fix project description in gemspec
* Change testing framework if necessary (see Rakefile, currently RSpec)
* Adjust private_eye.gemspec if your github name is not GITHUB_USER
* Adjust License if your real name is not QASalter
