# git-tagger
Small and simple Docker image to create and push a tag into a git repository

## Usage

You need to run the docker image with the following environment variables set:

* `GIT_USER_NAME` Name of the user who will create the tag. Required for git configuration.
	* Eg. `Gitlab CI`
* `GIT_USER_EMAIL` Email of the user who will create the tag. Required for git configuration.
	* Eg. `git@example.com`
* `GIT_REPO` Git SSH URL repository of which you want to push the tag.
	* Eg. `git@github.com:manoamaro/git-tagger.git`
* `GIT_PRIVATE_KEY` Private key of git repository account encoded in base64. This account needs to have write access to the repository.
	* How to generate: `cat ~/.ssh/id_rsa | openssl base64 | tr -d '\n'`
* `GIT_HOST` The host of the git repository, for ssh known hosts reasons.
	* Eg. `github.com`
* `GIT_REF` The branch name where the tag should be created.
	* Eg. `develop`
* `TAG_NAME` The new tag name.
	* Eg. `release_1.0`

## Example

* Using Gitlab CI predefined variables
	* `CI_COMMIT_REF_NAME`
	* `GITLAB_USER_NAME`
	* `GITLAB_USER_EMAIL`
* Using defined variables in CI
	* `GIT_REPO`
	* `TAG_NAME`
	* `GIT_PRIVATE_KEY`

```
docker run --rm \
  -e GIT_USER_NAME="$GITLAB_USER_NAME" \
  -e GIT_USER_EMAIL="$GITLAB_USER_EMAIL" \
  -e GIT_REPO="$GIT_REPO" \
  -e GIT_PRIVATE_KEY="$GIT_PRIVATE_KEY" \
  -e GIT_HOST="gitlab.com" \
  -e GIT_REF="$CI_COMMIT_REF_NAME" \
  -e TAG_NAME="$TAG_NAME"\
  manoamaro/git-tagger:latest
```
