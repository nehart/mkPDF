# mkPDF

The following guideline was created by Norbert EHART (norbert@ehart.net) in 2024 under the CC-BY license and is intended to provide information to those working on the `mkPDF` project.

## Clone the Repository

In order to work on the `mkPDF` project, it is first necessary to clone this repository.

```text
git pull git@gitlab.ans.co.at:templates/mkpdf.git
```

```text
cd mkpdf
```

## Branches

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

## Development

The development server can be started by entering the following command, which will provide a test site accessible under the URL `http://127.0.0.1:8000`. Additionally, a link to the actual rendered PDF file can be found on the site.

```text
docker compose run --rm mmdocs serve --config-file "mkdev.yml"
```

Now, the development process can begin.

```text
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

vi .gitignore
```

Following the completion of the development process, it is imperative to conduct a localised test.


```text
docker build --no-cache --file dockerfile --tag registry.ans.co.at/templates/mkpdf/mkpdf:latest .
```

```text
rm -rf test; mkdir test; cd test
```

```text
cp ../compose.yml .
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
docker compose run --rm --user $(id -u):$(id -g) mkpdf update
```

```text
docker compose run --rm --user $(id -u):$(id -g) mkpdf clean
```

```text
cd ..; rm -rf test
```

```text
docker image prune --all --force
```

## Pushing the Changes

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

Once the development process is finished, the development branch must be merged into the master branch, and then deleted. The development branch should only be merged if it has been successfully tested.

## Tags and Releases

After merging a development branch into the main branch, a new tag associated with the build date must be created. The build date must follow the format `YYYYMMDDXX`. The tags are also used to initiate a pipeline that generates the docker images in the container registry along with a new release.

```text
git tag -a 2024012100 -m ""
```

```text
git push --tags
```

## Documentation

It is essential that any changes made are documented accordingly to ensure accuracy and consistency.

  * https://gitlab.ans.co.at/templates/mkpdf/-/blob/main/contribution.md
