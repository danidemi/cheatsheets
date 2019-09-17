Python
======

Modules
-------

* module => a way to put definitions in a file and use them in a script or in an interactive instance of the interpreter
* can be imported => into other modules or into the main module

The file name is the module name with the suffix .py

global variable __name__ => the module name

the author of a module can use global variables in the module without worrying about accidental clashes with a user’s global variables.

### Import
Two styles

```
import fibo
fibo.fib(1000)
```

```
from fibo import fib, fib2
fib(1000)
```

References
----------
* GUI
  * <https://www.reddit.com/r/Python/comments/a9t69r/what_is_your_goto_fast_and_quick_python_gui/>
  * <https://pysimplegui.readthedocs.io/en/latest/>
