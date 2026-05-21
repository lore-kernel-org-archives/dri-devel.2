Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52798CD4F3D
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 04:32:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1A1110E468;
	Thu, 21 May 2026 04:32:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VZGbu8xh";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012029.outbound.protection.outlook.com [52.101.43.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6927910E468
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 04:32:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KIceTXdAIXzm8YSoaweF22URZqtvvfggTNNzKryHaAPqW2BDd0Toyso9yvH48Eacn3uS4SMEfdGMxGM+IBR2edRpiUbssfyixw+Mt7AMHsnulm9AQEf3WESFCy7HPAuBflq0tQk9ezwQuad+mUijopavGjxdyXGMHEBz3z7PR5NVmitN3nClIJQLoDm2BxvZXYtHerTrKjnxLnsreL1IS9zAkGcM6B+3OC81YqwdMpSpiseIcIV72RrLezNR7NskmdrOwmacX8+9iIBB5lwxokEUq1rcLwseqiCK0N4+olV3RwzpJ/vBhIrebPz9YIM32ovNVdvCahCH8JaW3zgnMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2oray1XoZApab6AqFYyB2wyEExgjbqhn1WAw8muOhc=;
 b=BTJdwzqjeBuVuk0QbbdZhhVtweMqAJm4SbXVOJOp6rsxX/Xdr6O7HBj1tjUr07CfQ/WX1u3uVHsh+yyt51ldMMtCYgxqYGyzqBCqYXawZpPJnv7znQ0nIAriSl1xRhGb+UFCvRHrCRKmhYeVcoy5vzlJapWr0ssoEPWzrIR5YqRgr/hSQYJDEWSwRjJgtqbg3RikllO2oaDiFlzJhoki2A65Fem+d+GUMS/ZU3ZZaJfcqE4EFBxOxc0rasBrJAw8A3HIBT3nm5QvS17rUaLNALi5XaZjcg90o/XCsFVsGpdZELnMcWa100SGRlwQrjic8raEcMTuTeZAAp2GgQIixA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2oray1XoZApab6AqFYyB2wyEExgjbqhn1WAw8muOhc=;
 b=VZGbu8xhGzOK6oSVykyibNosGAoW12inNidHvMaZ8g9mBZ+kyW2oOYqhLTln4wXx3F6slovKiQRjKlfGwFMjvYPfs4ar4xfvLu56kMxG/d5C0PPBuMvc5BHmTDS+jg5tcGiuyBjYh7OWFbxKcJ7cACq7OJ3JU7skVgPAI/kSF80=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999147.namprd12.prod.outlook.com (2603:10b6:8:38b::11)
 by SJ2PR12MB7963.namprd12.prod.outlook.com (2603:10b6:a03:4c1::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 04:32:51 +0000
Received: from DSVPR12MB999147.namprd12.prod.outlook.com
 ([fe80::98c5:8206:6a4:c445]) by DSVPR12MB999147.namprd12.prod.outlook.com
 ([fe80::98c5:8206:6a4:c445%3]) with mapi id 15.20.9870.023; Thu, 21 May 2026
 04:32:50 +0000
Message-ID: <3154ab4f-1808-4e8c-a7a2-128938d52299@amd.com>
Date: Wed, 20 May 2026 23:32:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Block running when IOMMU is off
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 karol.wachowski@linux.intel.com
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com
References: <20260520223531.1403302-1-lizhi.hou@amd.com>
 <c0018792-7867-4fc6-b64d-7e0fb8717f08@amd.com>
 <88097167-1bf9-235a-36dc-467207ee63c6@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <88097167-1bf9-235a-36dc-467207ee63c6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0167.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::22) To DSVPR12MB999147.namprd12.prod.outlook.com
 (2603:10b6:8:38b::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999147:EE_|SJ2PR12MB7963:EE_
X-MS-Office365-Filtering-Correlation-Id: 5712691e-c501-46fe-1a39-08deb6f20418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|4143699003|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: qRGadC2QSzM2XY8lU/Qpe1O87eXQzKEmAuwlcVjK0o4c+7/DMdbaUUiQDApxDc7iu5NK2GTFk/ZxkCVfP92Lowe6hzLVFV8c0/n+G8IkERN+SOqIa3mxvi22BW35wZzgoUDxUJV6k3b1mY+vzv/STP1TaaKn+FR6+TwRxZtvD8kUem8WcymmxQ6yE62Piw2/siV8Axfq1TRDgpjRTtWSTl7K5EhcE/H2f7ymg9wBvi3Zo+ZEM508uHyKqzVyzfqkysdzycBYSDqoNEBGSN8YepcQI5mD6lkTT1Eo5qa8Rd1rYczoycMyhThN1FznJvM7rtWWGaj0ZrhLcqA74XmffezjrM46Bm5dO8+Fz2WrMBsTqnc1JQ/z/iCMRN6EG4xD7/7ASInKa8bU+mq8ndFWScbVYBi8OG6yKrOCn9W4NEMRGnh+BErxVbJpOAa+Ze8r7kcckMETYGDWp5uAeMJM22/Y0qy2y8N17/P0ohtDldgNPNh8KSfQB15mpvJQyavEjSidw6ohtyETe77wbj8GaEP34L5KjH7fU3TwBOB8qN8JBhjbko4LBUdv0U/vWV2ZZG9ZS+2wPskGCVGsyhDBr2zz55wV0woXRPWLyA/UXkMDVm/pPF59PoDDte+g12AS63BjaKnNYctdLB7tVyRurA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DSVPR12MB999147.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(4143699003)(56012099003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXdOMkZPZjlkak1OazN4ZmQxYWVWTFFSVVdjWG9BamFqT3ZQSnlrWjBSQnBX?=
 =?utf-8?B?ZGVWUDNlOHF4ekVhc3Q5SVVyYUVaT01hTGp2SkZkM2FIRUpMK1doK2h1cEVV?=
 =?utf-8?B?dVp0UmlENVdOSEdOZnJzZno5azJUT0dFRThJd0UyRUpXMDFZYUxYSDNFQ0h2?=
 =?utf-8?B?SW5wam5xbVhGaS9lc0JIenMyRklxN0xVbk55SkY3bytGRlUrOWJwdnZrVjND?=
 =?utf-8?B?STB4cG1UdjhncW5DTDBpUlVmSW5VUEdTUUd1cVVFRjVmbnNpZVdDeVd4Znp3?=
 =?utf-8?B?Vno1WW5JcGtzeDNCMmk0Y1JINGZ2OVRzalE3WUdGSXIzZmtPT3A0QlBuQUVr?=
 =?utf-8?B?eU5PNXNiWkgzTU90WGVsQ0dDOStRUEhZZ0tONFhpa0VkYkk5MFkxSkt3UFlZ?=
 =?utf-8?B?RTlMTGg2UE9pNlphcSs3WE5kUExZc1ZnSDNDN1l6TEtZNVdsZElhS2N1SnRW?=
 =?utf-8?B?TXpjOVJkRlYra1RWdmdMNVBNd2xrM1RpcCsvL3hnVFJydS9uUEFiU3dwZ05F?=
 =?utf-8?B?VmdzczBudDAzMzJuWHNBR3ZRU3lhb0J0d0tXVXoyWEt6MFcvWkJTa3hydmJ3?=
 =?utf-8?B?Q0pEOHlHaktpR2lxcTRkdFg2U1B0T0hBSnZBUmNwNytySEY5QUlTdDZ0YnRu?=
 =?utf-8?B?S1RZSFBJcFpCcm1XWTcxMC9oRy8zaU5zcDdiVHNZNC9wYzQzWW5DaUdvUE1H?=
 =?utf-8?B?WnVQVkM2ZGdndmFQbldEUVNYaG1Zbm5SRmJKNFd6K3kwTmt1NVlNU2YxT1Zp?=
 =?utf-8?B?THlKN1hpOXRPbjNUU3ZtUDlVMGZTbUtWL1BQS1hkRVQ5OWdRVG9qbEVobkdS?=
 =?utf-8?B?cXl3UWp4K0FTcVZTV3VTbU8zdjYrL3B2TzRSbWRVWDVNZDh6aFNiVnhJUTVm?=
 =?utf-8?B?aDk2NEo0OVBLTFFHcU1KZ1FIalFqSExiMzdXN0t0UXpaakdzYjMxK0oxd241?=
 =?utf-8?B?c2R3NDFEYk00QWE2SW1zWGU0d1I5cW50eHA3bW1nQ0xJS1NwVzNYV2FEK3Ft?=
 =?utf-8?B?OENqeGpyb1M0MVNhbDlDV1hObzdSN1lrdTNndk1OZUN2VE1mRFdXSTFja2R5?=
 =?utf-8?B?eEQ5RTVTYjhyYS9wckhIMExWS0ZsRzNtZ3lrSjhLb04zY3RnVnNrNkEwVnUv?=
 =?utf-8?B?SDhYdFpOVHVCcVovdEFGaEpQZk9tNlh6bnN6RG5qL0hmYU16SGRHa2o5NERj?=
 =?utf-8?B?R0tmSGc1VTBIZXkrZzAzR1RaekVoK0IrN3BUblB5bW93dGJzYVRzYk1scmlW?=
 =?utf-8?B?SndCYkZBRkFiNXlicSs2QUV2NEFFNnBQb0xwbDd1bytsK3lQbzFaNHhKNE9Z?=
 =?utf-8?B?VmprcFV0dUVncTVUZnJ6T3ZqNHNhN1lnWnlyMlp5eEpWQ3BXVTdpUno1VDdM?=
 =?utf-8?B?Y211bytiRVRQUkNSV0xjY1NYWUJDMjhwNTZuZlcxcndOcnd4SG9TY2FvRmxY?=
 =?utf-8?B?aHc0TWxsbnhCVzJPSHNGeXhHS1BNRXBzRmZ0MWtRWk5NNVNCL1QzZm0rengv?=
 =?utf-8?B?dUh4cTNIVGROeGlkdWRadm9iNUV2bzAzVjQySk9ueExGajI5Ukx2K013VGlw?=
 =?utf-8?B?OVRVdjg1SjJLdEwwMXdEOU9zWFZ3cGY2OThXcmdmSEk0b25wNU1KeHl2WkNW?=
 =?utf-8?B?V0tTbkxTV1k1aUpsSWRoYXV2U1hhb29yemIzTmJUcC91MXJUUDU4MUdwZ0Ni?=
 =?utf-8?B?Y3Uzb1BEVEhvMUZpRFVHVnlDSmpOaHRhVTJuakFubTQ0YzFkVmRCVlBtRWRM?=
 =?utf-8?B?Wldsdm1Pak9iejFJdlVlbDJQOW5qcWpVeGpKa2ZBb1VORExXU0ZWZHR6Mmgz?=
 =?utf-8?B?MlZySFg3SHE1dDNBQmlabE1Mbmt5SG44SFM0b2lHN2VtTFBUUnE1MXY5VDJX?=
 =?utf-8?B?TGhraGpVOEoxbFNpbzR3YVc2VHVQTW83c0VoSkQwVVNaczJBYU5nTGZ6UWEy?=
 =?utf-8?B?SjRkRDdLaU02TGNjRFVycko2ZUFIZ0JWMm9XWlVKeDBMNzVqdzRMVCs2a0ZG?=
 =?utf-8?B?Z3QyTzZ3cytOcyt5MEtFZ0paSEY5bVRZTWtkU1NOVU9yYVkwcmlZUDJrK2Mz?=
 =?utf-8?B?cW5RQTlMY3hSOExMb2I4WTdJR3NXZDRQYjFLNjdiMTVxRFJIU2xWc0xWRWZ1?=
 =?utf-8?B?cVJuVjlmMkZpRU5vWVAwTGZOUWticnhQY05MQlBhblorNjM0VkprQU43cGFl?=
 =?utf-8?B?Tkx6cTduQ2JjYWJFb0RhUjhFRDZoS2RjTHJsMUR3TUxGbUxOWXRYZExyTFFM?=
 =?utf-8?B?ZVF3ZFRjZURRbDRpK0VjTFZmWUQrWHoyVmpyTWQvdHRHQmxZdXcyL2MzOVlQ?=
 =?utf-8?B?anI5bzJZOHRhUmNySWYrTFdEdGN2WHZXQTdZZ2RrQU5sem9rclpqUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5712691e-c501-46fe-1a39-08deb6f20418
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999147.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 04:32:50.2167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jz9noKksyso3T7fhptRrHZKKO2F6qg6jdtKTa60vsJwucNKNZUCsq9AVztznwkaHS32jh5Ya3iSD8NhkqVgmNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7963
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>



On 5/20/26 22:43, Lizhi Hou wrote:
> 
> On 5/20/26 17:57, Mario Limonciello wrote:
>>
>>
>> On 5/20/26 17:35, Lizhi Hou wrote:
>>> The AIE2 device firmware requires IOMMU on.
>>>
>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5319
>>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>>> ---
>>>   drivers/accel/amdxdna/aie2_pci.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/ 
>>> amdxdna/aie2_pci.c
>>> index c4d345d4c76b..22f66c7f534d 100644
>>> --- a/drivers/accel/amdxdna/aie2_pci.c
>>> +++ b/drivers/accel/amdxdna/aie2_pci.c
>>> @@ -490,6 +490,11 @@ static int aie2_init(struct amdxdna_dev *xdna)
>>>           return -EINVAL;
>>>       }
>>>   +    if (!xdna->group) {
>>> +        XDNA_ERR(xdna, "Running without IOMMU not supported");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>>       ndev = drmm_kzalloc(&xdna->ddev, sizeof(*ndev), GFP_KERNEL);
>>>       if (!ndev)
>>>           return -ENOMEM;
>>
>> I think it would be better to change the return for amdxdna_iommu_init().
> 
> amdxdna_iommu_init() is common code for all kinds of hardware. I would 
> keep the check only for AIE2 now, which is known to require IOMMU on.
Got it.  Then this makes sense.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> 
> Lizhi
> 
>>
>> This has a check that lets !xdna->group pass; which can be turned into 
>> an error code instead.

