# #2 Settings configuration
*Prerequisites:* 
- A GitHub account.
- An Azure account.
- An LCS account.
- A NuGet feed.

![Created repo](/Scenarios/images/2a.png)
1. Done [scenario 1](SetupRepo.md)
1. Update settings file in the .FSC-PS folder.
~~~javascript
{
    "uploadPackageToLCS" : false,
    "githubRunner":"windows,winstandard",
    "models":"Contoso,ContosoTestEssentials",
    "modelsIntoPackagePattern": "Contoso",
    "packageName": "ContosoExtension",
    "nugetPackagesPath": "NuGets",
    "nugetFeedName":"Artifactory",
    "nugetFeedUserSecretName": "AF_CONNECTORS_CICD_USER",
    "nugetFeedPasswordSecretName": "AF_CONNECTORS_CICD_PASS",
    "nugetSourcePath":"https://contoso.nuget.com/artifactory/api/nuget/connector-nuget-local",
    "githubSecrets": "AZ_TENANT_USERNAME,AZ_TENANT_PASSWORD,AZ_CLIENTSECRET,AZ_CLIENTID,AZDO_PAT,AZDO_TEST_PAT,AZ_TEST_CLIENTID,AZ_TEST_CLIENTSECRET,AZ_TEST_ENV_URL,AZ_TEST_TENANT_NAME,AZ_TEST_TENANT_PASSWORD,AZ_TEST_TENANT_USERNAME,GIST_SECRET,REPO_SCOPED_TOKEN,AF_CONNECTORS_CICD_USER,AF_CONNECTORS_CICD_PASS",
    "buildPath": "_bld",
    "metadataPath": "PackagesLocalDirectory",
    "lcsProjectId": 1234566,
    "lcsClientId": "892da30e-e292-437a-b1aa-ec2ecff7b21f",
    "lcsUsernameSecretname": "AZ_TENANT_USERNAME",
    "lcsPasswordSecretname": "AZ_TENANT_PASSWORD",
    "azTenantId": "dfc1b5c3-94fc-4abc-b8fb-09484816c011",
    "azClientId" : "492b2997-68ed-4bca-95c5-306cdedf288a",
    "azClientsecretSecretname" : "AZ_CLIENTSECRET",
    "buildVersion": "10.0.27",
    "deploy": false
}
~~~
Please find setup details [here](settings.md)

1. Update environments file
~~~javascript
[
    {
        "name":"Contoso-QA",
        "settings":{
            "buildVersion": "10.0.29",
            "sourceBranch": "main",
            "lcsEnvironmentId": "73369230-3240-4f14-b9d2-cb214bd31504",
            "azVmname" : "Contoso-QA-1",
            "azVmrg" : "contoso-qa",
            "cron":"0 21 * * *"
        }
    },
    {
        "name":"Contoso-UAT",
        "settings":{
            "buildVersion": "10.0.27",
            "deploy": false,
            "sourceBranch": "release",
            "lcsEnvironmentId": "19450674-0040-4d48-a09f-ff2235042e2c",
            "lcsProjectId": 1234567,
            "lcsClientId": "220ebf68-a86d-4392-ae38-57b2172ee3fc",
            "lcsUsernameSecretname": "AZ_TENANT_USERNAME",
            "lcsPasswordSecretname": "AZ_TENANT_PASSWORD",
            "azTenantId": "dd64b6ec-0a2a-4f60-8ca1-eeaab33884d7",
            "azClientId" : "220ebf68-a86d-4392-ae38-57b2172ee3fc",
            "azClientsecretSecretname" : "AZ_TEST_CLIENTSECRET",
            "azVmname" : "Contoso-UAT-1",
            "azVmrg" : "contoso-uat",
            "cron":"0 21 * * *"
        }
    }
]
~~~
Please find setup details [here](settings.md)

1. Update versions file
~~~javascript
[
    {
        "version": "10.0.26",
        "data":{
            "PlatformVersion": "7.0.6354.86",
            "AppVersion": "10.0.1192.92"
        }
    },
    {
        "version": "10.0.27",
        "data":{
            "PlatformVersion": "7.0.6395.47",
            "AppVersion": "10.0.1227.52"
        }
    },
    {
      "version": "10.0.28",
      "data":{
          "PlatformVersion": "7.0.6441.41",
          "AppVersion": "10.0.1265.20"
        }
    },
    {
      "version": "10.0.29",
      "data":{
          "PlatformVersion": "7.0.6545.43",
          "AppVersion": "10.0.1326.46"
        }
    }
]
~~~
Please find setup details [here](settings.md)


---
[back](/README.md)