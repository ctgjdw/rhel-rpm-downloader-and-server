# RHEL RPM Downloader

RHEL rpm repository downloader and http web server. Useful for offline mirroring of RHEL RPM packages.

These scripts contains the downloader for rpm repositories and the http web-server for hosting the rpm repositories. The downloader will download the rpm repositories listed in `repolist` for `RHEL-7` or `CentOS-7`. For other versions of `RHEL`, do update the `Dockerfile-downloader-rhel` according to your desired version. The 2nd service will then serve the rpm repository with `nginx`.

-   Tested on `Docker-Desktop` for `Windows`

## Requisites

-   Online connection
-   **_Ensure_** `download-repo.sh` and `repolist` are in `LF` line ending formats
-   (Optional): Update `repolist` with your required rpm repos using it's `Repo ID`, separated by newlines. You may refer to [here](#to-view-the-repo-ids-available) for instructions on retrieving the `Repo ID` from `Red Hat`. If `./repolist` is empty, it will download all repositories in `/etc/yum.repos.d/*`

## Further requisites for RHEL-7

-   Redhat account with relevant subscriptions \(RHEL subscription\)
-   Update `CHANGE_ME` fields with the required inputs (username/password for Redhat)
-   Change the `docker-compose` to point to `./Dockerfile-downloader-rhel` instead.

## To view the Repo IDs available

-   Make sure to fulfil the [requisites](#requisites)
-   `docker-compose build`

### For Rhel

-   `docker run --rm rhel-rpm-downloader-and-server-rpm-download subscription-manager repos` to find the list of applicable `Repo ID`s for the RHEL repos.

### For CentOs

-   or `docker run --rm rhel-rpm-downloader-and-server-rpm-download yum repolist -y` for non-Redhat repositories. The repoId is listed under the `repo id` col, use the name only without the parts seperated by the `/`.

## To download and serve

-   Run `docker-compose up --build`
-   View your downloaded files in `./rpm`
    -   The file structure should be:
        -   `./rpm`
            -   `./rpm/repodata`
            -   `./rpm/<REPO_ID_1>`
            -   `./rpm/<REPO_ID_2>`
-   The 2nd docker service will serve the rpm repository with nginx at port `80` / `http`

## To add other non-standard yum repos

For repos that are not available in Redhat's repositories. You will need to add them into the Docker image manually. This can be done by manually editing `Dockerfile-downloader`.

```bash
...
# Any other non-standard yum repositories ...
## FOR NVIDIA CONTAINER TOOLKIT REPO ...

distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
   && curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.repo | sudo tee /etc/yum.repos.d/nvidia-container-toolkit.repo
```
