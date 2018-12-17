# EarmarkWrapper

Insert `Earmark's` output into `EEx` templates.

Either use the provided templates (`html5` only for the time being) or provide your own templates to the escript.

## Usage

```
    mix escript.build # if necessary
    earmark_wrapper [options] input_files...
```

Legal options are the keys of the `options` variable described in the API section below plus `--version` and `--help`.

The values of the options `earmark_options` and `custom` are provided as comma seperated `key=value` pairs, where the
absence of `=value` is interpreted as `true`.

All options can be abbreviated by their first letter, where the first letter of `title` is defined as `T`.

Examples:

```
    earmak_wrapper -j myscript.js --earmark_options breaks,code_class_prefix=elixir -c author=YHS,date=2018-12-15
    earmak_wrapper --javascript=fancy.js -s styles.css -t xhmtl input1.md input2.md
```

When providing your own templates note the API described below, the template is rendered with two variables (`html` the text rendered from
`Earmark` and `options` a struct containing the command line options or their defaults).


## API

| Variable |  Content | Default | Typical Usage |
|----------|----------|---------|---------------|
|  `html`    | `Earmark`'s output of all converted input files | -- |`<body><div><%= html %>...` |
| `options.lang` | Language of doc | `"en"`| `<html lang="<%= options.lang %>` |
| `options.javascript` | Location of javascript to include | -- | `<script src="<%= options.javascript %>"/>`|
| `options.stylesheet` | Location of stylesheet to apply | -- | `<link rel="stylesheet" href="<%= options.stylesheet %>"/>`|
| `options.template`   | Name of the template to be rendered | Built in `html5` | Not really useful, the template knows its own name |
| `options.title` | Title | -- | `<head><title><%= options.title %>...` |
| `options.earmark_options` | options passed into `Earmark.as_html` | `%Earmark.Options{}` | not really useful in the template |
| `options.custom` | A map of type `map(atom(), String.t())` | %{} | to allow custom templates to use more options |


## Author

Copyright © 2018 Robert Dober, robert.dober@gmail.com

## LICENSE

Apache 2 (c.f. LICENSE)

SPDX-License-Identifier: Apache-2.0
