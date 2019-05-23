# Cloudfoundry Orb ![CircleCI status](https://circleci.com/gh/CircleCI-Public/cloudfoundry-orb.svg "CircleCI status") [![CircleCI Orb Version](https://img.shields.io/badge/endpoint.svg?url=https://badges.circleci.io/orb/circleci/cloudfoundry)](https://circleci.com/orbs/registry/orb/circleci/cloudfoundry) [![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/CircleCI-Public/cloudfoundry-orb/master/LICENSE) [![CircleCI Community](https://img.shields.io/badge/community-CircleCI%20Discuss-343434.svg)](https://discuss.circleci.com/c/ecosystem/orbs)
CircleCI orb supporting deployments to Cloud Foundry runtimes

Orb consists of both Job and Commands to simplify your config.yml.  Please see [samples](samples) for more examples.


## Simple Push

### Using Previous Job assets
You can use the `workspace_path` to consume artifacts created by a previous job.

```
version: 2.1
orbs:
  cloudfoundry: circleci/cloudfoundry@1.0

workflows:
  version: 2
  build-deploy:
    jobs:
      - build
      - cloudfoundry/push:
      	  requires:
      	  	- build
          appname: blueskygreenbuilds
          org: eddies-org
          space: circleci
          workspace_path: /tmp
          manifest: /tmp/cf-manifest.yml
          package: /tmp/standalone-app.jar

jobs:
  build:
   # your custom build job...
```

### Building and push in single job

You can use `build-steps` to define commands that generate an asset

```
version: 2.1
orbs:
  cloudfoundry: circleci/cloudfoundry@1.0

workflows:
  version: 2
  build-deploy:
    jobs:
      - cloudfoundry/push:
          appname: blueskygreenbuilds
          org: eddies-org
          space: circleci
          build_steps:
          	- run: mvn clean install
          manifest: /tmp/cf-manifest.yml
          package: /tmp/standalone-app.jar

```

## Blue/Green Deployments

You can use either `blue_green` to run both as single job, adding any `validation_steps` to run in between.  Alternately you can use `dark_deploy` and `live_deploy` to have more control over the deployment, using approval jobs for instance.

In all cases the job expects either a `workspace_path` or `build_steps` along with the required parameters.

### Blue Green Deployment with Manual Approval

```
version: 2.1
orbs:
  cloudfoundry: circleci/cloudfoundry@1.0

workflows:
  build_deploy:
    jobs:
      - cloudfoundry/dark_deploy:
          context: Demos-Context
          appname: blueskygreenbuilds
          org: eddies-org
          space: circleci
          build_steps:
          	- run: mvn clean install
          manifest: cf-manifest.yml
          package: target/standalone-app.jar
          domain: blueskygreenbuilds.com
      - hold:
          type: approval
          requires:
            - cloudfoundry/dark_deploy
      - cloudfoundry/live_deploy:
          requires:
            - hold
          context: Demos-Context
          appname: blueskygreenbuilds
          org: eddies-org
          space: circleci
          domain: blueskygreenbuilds.com


```
