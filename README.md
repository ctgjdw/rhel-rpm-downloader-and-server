# RHEL RPM Downloader

RHEL rpm repository downloader and http web server. Useful for offline mirroring of RHEL RPM packages.

These scripts contains the downloader for rpm repositories and the http web-server for hosting the rpm repositories. The downloader will download the rpm repositories listed in `repolist` for `RHEL-7`. For other versions of `RHEL`, do update the `Dockerfile-downloader` according to your desired version. The 2nd service will then serve the rpm repository with `nginx`.

## Requisites

-   Online connection to RHEL servers
-   Redhat account with relevant subscriptions \(RHEL subscription\)
-   **_Ensure_** `download-repo.sh` and `repolist` are in `LF` line ending formats
-   Tested on `Docker-Desktop` for `Windows`
-   Update `CHANGE_ME` fields with the required inputs (username/password for Redhat)
-   Update `repolist` with your required rpm repos using it's `Repo ID`, separated by newlines. You may refer to [here](#to-view-the-repo-ids-available) for instructions on retrieving the `Repo ID` from `Red Hat`

## To view the Repo IDs available

-   Make sure to fulfil the [requisites](#requisites)
-   `docker-compose build`
-   `docker run rhel-rpm-downloader-and-server-rpm-download subscription-manager repos` to find the list of applicable `Repo ID`s

## To download and serve

-   Run `docker-compose up --build`
-   View your downloaded files in `./rpm`
    -   The file structure should be:
        -   `./rpm`
            -   `./rpm/repodata`
            -   `./rpm/<REPO_ID_1>`
            -   `./rpm/<REPO_ID_2>`
-   The 2nd docker service will serve the rpm repository with nginx at port `80` / `http`

## Update YUM repository to use your custom rpm repo

Add a new file ending with `.repo` in `/etc/yum.repos.d/`

e.g. `/etc/yum.repos.d/my-repo.repo`.

```conf
[repository]
name=<REPO_NAME>
baseurl=http://host.docker.internal # or your repo URL
gpgcheck=0
```

Then do a `yum update`
