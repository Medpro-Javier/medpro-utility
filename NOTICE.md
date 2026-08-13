# Third-Party Notices

## Chris Titus Tech WinUtil

MedPro Utility's architecture and a substantial portion of the tweak
definitions in `config/tweaks.json` and `config/debloat.json` are derived from
**WinUtil** by Chris Titus Tech, used under the MIT License.

- Project: https://github.com/ChrisTitusTech/winutil
- Documentation: https://winutil.christitus.com
- License: MIT

```
MIT License

Copyright (c) 2024 Chris Titus Tech

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

### What was reused

- The overall project layout (`Compile.ps1` → single-file output, `config/*.json`,
  `xaml/`, `functions/public` + `functions/private`).
- The convention-based UI binding model and the synchronized `$sync` hashtable
  runspace pattern.
- Registry paths, values, and `OriginalValue` undo data for the ported tweaks.

### What is MedPro's own work

- The MedPro application catalog and the direct-download install engine.
- The Provisioning tab (rename, domain join, power profile and screen lock).
- The MedPro brand theme, build script, logging, and preset definitions.
