In order to work on the `mkPDF` project, it is first necessary to clone this repository.

```text
git pull git@gitlab.ans.co.at:templates/mkpdf.git
```

```text
cd mkpdf
```

Then, we need to change into the TEMPLATES directory.

```text
cd tmpl
```

The stable version of this project is located in the main branch. In order to conduct development work, a new branched should be created. There is no specific naming convention for the development branches.

```text
git branch fix_issue_122
```

```text
git switch fix_issue_122
```

```text
git push --set-upstream origin fix_issue_122
```

The development server can be started by entering the following command. The URL for accessing the development website can be found in the command output.

```text
docker compose run --rm --user $(id -u):$(id -g) nndocs serve --config-file "mkdev.yml"
```

Now, the development process can begin.

```text
[...]

vi overrides/cover.html.j2
vi overrides/back_cover.html.j2

[...]

vi overrides/cover.scss
vi overrides/paging.scss
vi overrides/heading.scss
vi overrides/toc.scss
vi overrides/fonts.scss

[...]

vi mkdev.yml
vi mkbase.yml
vi mkdocs.yml

[...]

vi entrypoint.sh

[...]

vi dockerfile

[...]

vi env.conf
vi compose.yml

[...]
```

Following the completion of the development process, it is imperative to conduct a localised test.

```text
docker build --no-cache --file dockerfile --tag registry.ans.co.at/templates/mkpdf/mkpdf:latest .
```

```text
[[ -d /tmp/mkpdf ]] && rm -rf /tmp/mkpdf; mkdir -p /tmp/mkpdf
```

```text
cp compose.yml /tmp/mkpdf
```

```text
cp env.conf /tmp/mkpdf
```

```text
cd /tmp/mkpdf
```

```text
docker compose run --rm --user $(id -u):$(id -g) mkpdf bash
```

```text
docker compose run --rm --user $(id -u):$(id -g) mkpdf sh
```

```text
docker compose run --rm --user $(id -u):$(id -g) mkpdf init
```

```text
docker compose run --rm --user $(id -u):$(id -g) mkpdf serve
```

```text
docker compose run --rm --user $(id -u):$(id -g) mkpdf build
```

```text
docker image prune --all --force
```

After completing your changes, you can push them to the current branch.

```text
git pull
```

```text
git add .
```

```text
git commit -a -m "."
```

```text
git push
```

Then, you can switch back to the main branch.

```text
git switch main
```

Once the development process is finished, the development branch must be merged into the master branch, and then deleted. The development branch should only be merged if it has been successfully tested. After merging a development branch into the main branch, a new tag associated with the build date must be created. The build date must follow the format `YYYYMMDDXX`. The tags are also used to initiate a pipeline that generates the docker images in the container registry along with a new release.

```text
git tag -a 2024012100 -m ""
```

```text
git push --tags
```
