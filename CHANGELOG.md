<!--next-version-placeholder-->

## v0.6.0 (2023-10-07)

### Feature

* **docker:** Add virtual environment and path in Dockerfile.base ([`00f681e`](https://github.com/entelecheia/invokeai-container/commit/00f681e30ff6236f6c433e1d1169c5e32571a711))
* **docker:** Add new ARG parameters in docker-compose.base.yaml ([`affafc0`](https://github.com/entelecheia/invokeai-container/commit/affafc006b5e94503afc47eb459449982a5b3ed3))

## v0.5.1 (2023-10-06)

### Fix

* **docker:** Change CONTAINER_USER_UID to USER_UID ([`e609730`](https://github.com/entelecheia/invokeai-container/commit/e6097301e38fae0c9e53940c36f0f91b2560e3b1))

## v0.5.0 (2023-10-06)

### Feature

* **.docker:** Add openssh-server in Dockerfile.base ([`4cdd343`](https://github.com/entelecheia/invokeai-container/commit/4cdd343c1cd75260ebcfd50345c18dd94b6f95f9))

### Fix

* **docker:** Modify environment variable names and simplify SSH setup ([`f89d423`](https://github.com/entelecheia/invokeai-container/commit/f89d423e90b93e75db4953fe39ca7d8ebaa446e0))
* **Dockerfile.app:** Reorganize commands and add patchmatch build ([`4075220`](https://github.com/entelecheia/invokeai-container/commit/4075220a7f10105440053694b4c2d17e185d24d1))

## v0.4.2 (2023-10-06)

### Fix

* **docker:** Comment out USER_UID environment variable ([`e4dd131`](https://github.com/entelecheia/invokeai-container/commit/e4dd131da7984ed79bdb70b54a03b52576c53770))

## v0.4.1 (2023-10-06)

### Fix

* **docker:** Remove redundant environment variables ([`74f270d`](https://github.com/entelecheia/invokeai-container/commit/74f270dd68bf1146b801951ad6dd892b584aa4b3))
* **docker-compose:** Remove unnecessary args and add USER_UID to environment variables ([`04a5564`](https://github.com/entelecheia/invokeai-container/commit/04a5564acb085d14dd2185c058bf6a3d37bfbffc))

## v0.4.0 (2023-10-06)

### Feature

* **docker:** Enhance launch.sh script with user configuration, SSH support, and root prevention ([`2ed8bc6`](https://github.com/entelecheia/invokeai-container/commit/2ed8bc6c26a54c367ca7da409bfb0467b6dd9da2))
* **docker:** Add new environment variables and versions ([`c51c261`](https://github.com/entelecheia/invokeai-container/commit/c51c261899162bd59768f7d5bfde7e517cbbd89f))
* **docker:** Add InvokeAI root variables ([`da99db6`](https://github.com/entelecheia/invokeai-container/commit/da99db67253103378190788f1901190d185925c9))
* **docker-compose:** Add torch, torchvision, and cudnn versions arguments ([`8a5be80`](https://github.com/entelecheia/invokeai-container/commit/8a5be80cd747491545ddaaa5c68560de06d18195))
* **docker:** Add new environment variables ([`3d1c643`](https://github.com/entelecheia/invokeai-container/commit/3d1c6435c31ae17f3b53488cde9490ce8307ecf8))

## v0.3.0 (2023-10-05)

### Feature

* **docker:** Update Dockerfile.app with new environment settings, install dependencies for Python and Torchvision in Dockerfile.app ([`cbda971`](https://github.com/entelecheia/invokeai-container/commit/cbda971ba090cb8e85809f1ecff16b23306feec5))

## v0.2.0 (2023-10-03)

### Feature

* **README.md:** Add instructions for building Docker image, include configuration step for Docker image ([`1eac828`](https://github.com/entelecheia/invokeai-container/commit/1eac8284fcf86c3563f33fb95d6e4251142e751c))
* **docker:** Add configure.sh script for InvokeAI configuration ([`fd6059f`](https://github.com/entelecheia/invokeai-container/commit/fd6059fc424e818f4981988fc4ea60781b349676))

## v0.1.1 (2023-10-03)

### Fix

* **docker:** Upgrade Python to version 3.9 ([`c070756`](https://github.com/entelecheia/invokeai-container/commit/c0707568e570f960a7f65830d7255f9dff0f9237))

## v0.1.0 (2023-10-03)

### Feature

* Initial version ([`00857e2`](https://github.com/entelecheia/invokeai-container/commit/00857e29899a1fdbee40759727a6a079e7946590))
