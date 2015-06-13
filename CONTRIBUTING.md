Contributing to UV-CDAT
======================

Where to start?
---------------

All contributions, bug reports, bug fixes, documentation improvements,
enhancements and ideas are welcome.

If you are simply looking to start working with the *UV-CDAT* codebase,
navigate to the [GitHub "issues"
tab](https://github.com/UV-CDAT/uvcdat/issues) and start looking through
interesting issues.

Feel free to ask questions on [mailing
list](uvcdat-users@llnl.gov)

Bug Reports/Enhancement Requests
--------------------------------

Bug reports are an important part of making *UV-CDAT* more stable. Having
a complete bug report will allow others to reproduce the bug and provide
insight into fixing. Since many versions of *UV-CDAT* are supported,
knowing version information will also identify improvements made since
previous versions. Often trying the bug-producing code out on the
*master* branch is a worthwhile exercise to confirm the bug still
exists. It is also worth searching existing bug reports and pull
requests to see if the issue has already been reported and/or fixed.

Bug reports must:

1.  Include a short, self-contained Python snippet reproducing the
    problem. You can have the code formatted nicely by using [GitHub
    Flavored
    Markdown](http://github.github.com/github-flavored-markdown/): :

        ```python
        >>> import vcs
        >>> vcs.init()
        ...
        ```

2.  Explain why the current behavior is wrong/not desired and what you
    expect instead.

The issue will then show up to the *UV-CDAT* community and be open to
comments/ideas from others.

Working with the code
---------------------

Now that you have an issue you want to fix, enhancement to add, or
documentation to improve, you need to learn how to work with GitHub and
the *UV-CDAT* code base.

### Version Control, Git, and GitHub

To the new user, working with Git is one of the more daunting aspects of
contributing to *UV-CDAT*. It can very quickly become overwhelming, but
sticking to the guidelines below will make the process straightforward
and will work without much trouble. As always, if you are having
difficulties please feel free to ask for help.

The code is hosted on [GitHub](https://www.github.com/UV-CDAT/uvcdat). To
contribute you will need to sign up for a [free GitHub
account](https://github.com/signup/free). We use
[Git](http://git-scm.com/) for version control to allow many people to
work together on the project.

Some great resources for learning git:

-   the [GitHub help pages](http://help.github.com/).
-   the [NumPy's
    documentation](http://docs.scipy.org/doc/numpy/dev/index.html).
-   Matthew Brett's
    [Pydagogue](http://matthew-brett.github.com/pydagogue/).

### Getting Started with Git

[GitHub has instructions](http://help.github.com/set-up-git-redirect)
for installing git, setting up your SSH key, and configuring git. All
these steps need to be completed before working seamlessly with your
local repository and GitHub.

### Forking

You may want to fork UV-CDAT to work on the code if you have access to the repository,
then just create a branch there instead. If you don't then follow these guidelines
for forking UV-CDAT. Go to the [UV-CDAT project page](https://github.com/UV-CDAT/uvcdat)
and hit the *fork* button. You will want to clone your fork to your machine:

    git clone git://github.com/UV-CDAT/uvcdat.git UV-CDAT-yourname
    cd UV-CDAT-yourname
    git remote add myuvcdat git@github.com:your-user-name/uvcdat.git

This creates the directory UV-CDAT-yourname and connects your repository
to the upstream (main project) *UV-CDAT* repository.

You will also need to hook up Travis-CI to your GitHub repository so the
suite is automatically run when a Pull Request is submitted.
Instructions are
[here](http://about.travis-ci.org/docs/user/getting-started/).

### Creating a Branch

You want your master branch to reflect only production-ready code, so
create a feature branch for making your changes. For example:

    git branch shiny-new-feature
    git checkout shiny-new-feature

The above can be simplified to:

    git checkout -b shiny-new-feature

This changes your working directory to the shiny-new-feature branch.
Keep any changes in this branch specific to one bug or feature so it is
clear what the branch brings to *UV-CDAT*. You can have many
shiny-new-features and switch in between them using the git checkout
command.

### Making changes
Before making your code changes, it is often necessary to build the code
that was just checked out. The best way to develop *UV-CDAT* is to build
using default settings:

        mkdir uvcdat-build
        cmake uvcdat-path-to-source
        make -jN

    If you startup the Python interpreter in the *UV-CDAT* source
    directory you will call the built C extensions

Contributing to the documentation
---------------------------------

If you're not the developer type, contributing to the documentation is
still of huge value. You don't even have to be an expert on *UV-CDAT* to
do so! Something as simple as

Contributing to the code base
-----------------------------
### Code Standards

*UV-CDAT* uses the [PEP8](http://www.python.org/dev/peps/pep-0008/)
standard. There are several tools to ensure you abide by this standard.

Alternatively, use [flake8](http://pypi.python.org/pypi/flake8) tool for
checking the style of your code. Additional standards are outlined on
the [code style wiki
page](LINK HERE).

Please try to maintain backward-compatibility. *UV-CDAT* has lots of
users with lots of existing code, so don't break it if at all possible.
If you think breakage is required clearly state why as part of the Pull
Request. Also, be careful when changing method signatures and add
deprecation warnings where needed.

### Test-driven Development/Writing Code
*UV-CDAT* is serious about [Test-driven Development
(TDD)](http://en.wikipedia.org/wiki/Test-driven_development). This
development process "relies on the repetition of a very short
development cycle: first the developer writes an (initially failing)
automated test case that defines a desired improvement or new function,
then produces the minimum amount of code to pass that test." So, before
actually writing any code, you should write your tests. Often the test
can be taken from the original GitHub issue. However, it is always worth
considering additional use cases and writing corresponding tests.

Adding tests is one of the most common requests after code is pushed to
*UV-CDAT*. It is worth getting in the habit of writing tests ahead of
time so this is never an issue.

#### Writing tests

All tests should go into the *tests* subdirectory of the specific
package. There are probably many examples already there and looking to
these for inspiration is suggested.

The `testing.checkimage.py` module has special `check_result_image` function
that make it easier to check whether plot produced after data extraction and
transformation are equivalent to baseline. For an example see below:

    import cdms2,sys,vcs,sys,os
    src = sys.argv[1]
    pth = os.path.join(os.path.dirname(__file__),"..")
    sys.path.append(pth)
    import checkimage
    x = vcs.init()
    x.drawlogooff() // It is important to disable logo for testing
    f = cdms2.open(vcs.prefix+"/sample_data/clt.nc")
    s = f("clt",slice(0,1),squeeze=1)
    b = x.createboxfill()
    b.level_1 = .5
    b.level_2 = 14.5
    x.plot(s,b,bg = 1)

    fnm = "test_boxfill_lev1_lev2.png"

    x.png(fnm)

    ret = checkimage.check_result_image(fnm,src,checkimage.defaultThreshold)
    sys.exit(ret)

#### Running the test suite

The tests can then be run directly inside your build tree by typing::

    ctest

To save time and run tests in Pararallel

    ctest -jN

The tests suite is exhaustive and takes around 20 minutes to run. Often
it is worth running only a subset of tests first around your changes
before running the entire suite. This is done using one of the following
constructs:

    ctest -R test-name
    ctest -R regex*

#### Running the performance test suite

TODO

### Documenting your code

TODO

Contributing your changes to *UV-CDAT*
-------------------------------------

### Committing your code

Keep style fixes to a separate commit to make your PR more readable. Once you've made changes, you can see them by typing:

    git status

If you've created a new file, it is not being tracked by git. Add it by
typing :

    git add path/to/file-to-be-added.py

Doing 'git status' again should give something like :

    # On branch shiny-new-feature
    #
    #       modified:   /relative/path/to/file-you-added.py
    #

Finally, commit your changes to your local repository with an
explanatory message. An informal commit message format is in effect for
the project. Please try to adhere to it. Here are some common prefixes
along with general guidelines for when to use them:

> -   ENH: Enhancement, new functionality
> -   BUG: Bug fix
> -   DOC: Additions/updates to documentation
> -   TST: Additions/updates to tests
> -   BLD: Updates to the build process/scripts
> -   PERF: Performance improvement
> -   CLN: Code cleanup

The following defines how a commit message should be structured. Please
reference the relevant GitHub issues in your commit message using GH1234
or \#1234. Either style is fine, but the former is generally preferred:

> -   a subject line with \< 80 chars.
> -   One blank line.
> -   Optionally, a commit message body.

Now you can commit your changes in your local repository:

    git commit -m

If you have multiple commits, it is common to want to combine them into
one commit, often referred to as "squashing" or "rebasing". This is a
common request by package maintainers when submitting a Pull Request as
it maintains a more compact commit history. To rebase your commits:

    git rebase -i HEAD~#

Where \# is the number of commits you want to combine. Then you can pick
the relevant commit message and discard others.

### Pushing your changes

When you want your changes to appear publicly on your GitHub page, push
your forked feature branch's commits :

    git push origin shiny-new-feature

Here origin is the default name given to your remote repository on
GitHub. You can see the remote repositories :

    git remote -v

If you added the upstream repository as described above you will see
something like :

    origin  git://github.com/UV-CDAT/uvcdat.git
    myuvcdat git@github.com:yourname/uvcdat.git (fetch)
    myuvcdat git@github.com:yourname/uvcdat.git (fetch)

Now your code is on GitHub, but it is not yet a part of the *UV-CDAT*
project. For that to happen, a Pull Request needs to be submitted on
GitHub.

### Review your code

When you're ready to ask for a code review, you will file a Pull
Request. Before you do, again make sure you've followed all the
guidelines outlined in this document regarding code style, tests,
performance tests, and documentation. You should also double check your
branch changes against the branch it was based off of:

1.  Navigate to your repository on
    GitHub--<https://github.com/your-user-name/uvcdat>.
2.  Click on Branches.
3.  Click on the Compare button for your feature branch.
4.  Select the base and compare branches, if necessary. This will be
    master and shiny-new-feature, respectively.

### Finally, make the Pull Request

If everything looks good you are ready to make a Pull Request. A Pull
Request is how code from a local repository becomes available to the
GitHub community and can be looked at and eventually merged into the
master version. This Pull Request and its associated changes will
eventually be committed to the master branch and available in the next
release. To submit a Pull Request:

1.  Navigate to your repository on GitHub.
2.  Click on the Pull Request button.
3.  You can then click on Commits and Files Changed to make sure
    everything looks okay one last time.
4.  Write a description of your changes in the Preview Discussion tab.
5.  Click Send Pull Request.

This request then appears to the repository maintainers, and they will
review the code. If you need to make more changes, you can make them in
your branch, push them to GitHub, and the pull request will be
automatically updated. Pushing them to GitHub again is done by:

    git push -f myuvcdat shiny-new-feature

This will automatically update your Pull Request with the latest code
and restart the Travis-CI tests.

### Delete your merged branch (optional)

Once your feature branch is accepted into upstream, you'll probably want
to get rid of the branch. First, merge upstream master into your branch
so git knows it is safe to delete your branch :

    git fetch origin
    git checkout master
    git reset --hard origin/master

Then you can just do:

    git branch -d shiny-new-feature

Make sure you use a lower-case -d, or else git won't warn you if your
feature branch has not actually been merged.

The branch will still exist on GitHub, so to delete it there do :

    git push origin --delete shiny-new-feature
