Python
======

Modules, Packages
-------

* module => a way to put definitions in a file and use them in a script or in an interactive instance of the interpreter
* can be imported => into other modules or into the main module

The file name is the module name with the suffix .py

global variable __name__ => the module name

the author of a module can use global variables in the module without worrying about accidental clashes with a user’s global variables.

### Import Modules
Several styles

```
import fibo
fibo.fib(1000)
```

```
from fibo import fib, fib2
fib(1000)
```

```
from fibo import *
fib(500)
```

```
import fibo as fib
fib.fib(500)
```

```
from fibo import fib as fibonacci
fibonacci(500)
```

### Standard Modules

* sys => always available
* winreg => only on windows

### Module Inspection

```
import fibo, sys
dir(fibo)
```

### Packages

Example about how to structure source files for a sound editing application.
```
sound/                          Top-level package
      __init__.py               Initialize the sound package
      formats/                  Subpackage for file format conversions
              __init__.py
              wavread.py
              aiffread.py
              ...
      effects/                  Subpackage for sound effects
              __init__.py
              echo.py
              surround.py
              ...
      filters/                  Subpackage for filters
              __init__.py
              equalizer.py
              vocoder.py
              ...
```
### Import PAckages

```
import sound.effects.echo
sound.effects.echo.echofilter(input, output, delay=0.7, atten=4)
```

```
from sound.effects import echo
echo.echofilter(input, output, delay=0.7, atten=4)
```

```
from sound.effects.echo import echofilter
echofilter(input, output, delay=0.7, atten=4)
```

```
from sound.effects import *
```
This is a very special case explaied here: https://docs.python.org/3/tutorial/modules.html#importing-from-a-package

```
from . import echo
from .. import formats
from ..filters import equalizer
```
This is for intra package

References
----------
* GUI
  * <https://www.reddit.com/r/Python/comments/a9t69r/what_is_your_goto_fast_and_quick_python_gui/>
  * <https://pysimplegui.readthedocs.io/en/latest/>
* Modules & Packages
  * <https://docs.python.org/3/tutorial/modules.html>
