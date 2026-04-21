Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFD5F327D0
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 09:53:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 126C410E858;
	Tue, 21 Apr 2026 09:53:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VlEZwojm";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012033.outbound.protection.outlook.com [52.101.43.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13F9E10E844;
 Tue, 21 Apr 2026 09:53:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMssY/KzyK3E6joX3Xcq7aEXpKmzo0G7c2kGVzSoq6K4/IcJ0wgNPcdM+E21BGuoNVBcJBM/mniZmpuPcYbqm90usDhuHcBT+aYnO1/nmyVyHMXkrm6pQrQOL5O16Pz3ae6P93hxf/S7dzV8nEO1ZYGmveLz/WAijCdH+CQieQA6yqtkEKk/DaIDRr3XBml7CSNEILbzByZX6tRDtLE1vNIp7L/ugSNaAum2Mf5SDEDKIj25tcW7+YzHGWPyJ2S3Sk5ygnKle3QDF2QXBKvBmxosnD859HugZ2Wm1LATszF/mPlyVxzCXgGue1r6y5yV2N/fJ/t92JQZmq0AKtvgnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMLVy/TwcoG3IjsnKt/K7EKNVHMEGV+HFbZIUD1LQBI=;
 b=BlsMJpEmY0/wrromaD20r2ovGU0MrxjvJEKIVD1kE7lbbyF9OqZyEJk4MQfDGTYVyqrdHrumSQN+6W1XuWGMruu5fW7Few1e0qkxnGUTQlD1FVKZ4G5VOCNFUeaPc3Qnf/NYt24j2jxYGSBcL6U4NWmcm/3EEVm+EXdF/EFdkYuzkHoJJ7bhtAkQ6ALsk60JcmO2bgoj0nvNNF84Scm9mfhFUkdBRIZjYPyVOVFbDSdLbShKsniEmlAXYzLSWxF8F79zznQAAWM7ajVSeST4KSIY3jg8iiak5shZpOfgC8PAF9z28gsMsFA+W1X5HwWvDztFwpMf8AvIFB6ArWiLDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMLVy/TwcoG3IjsnKt/K7EKNVHMEGV+HFbZIUD1LQBI=;
 b=VlEZwojmXfZZOzv9HXd9QUnmzq81KalB7CmmIMNFsgKCDroTNCNWihZJTpEuVklK1g15aRvXzX0vVnErHvnb7H8opEGB6vkwNHf510P+wL4ob1t/WkqmbKRmytBNDe2KupYBH89VYEHIEfyAdobjrlYlI43YZ0FtCkAhl4jAdNw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by DS7PR12MB9527.namprd12.prod.outlook.com (2603:10b6:8:251::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 09:53:06 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.20.9846.017; Tue, 21 Apr 2026
 09:53:06 +0000
Message-ID: <ba4a1d11-b774-4429-bf3b-690e826bc72b@amd.com>
Date: Tue, 21 Apr 2026 17:52:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/POC PATCH 01/12] drm/amdgpu: add SVM UAPI definitions
To: Matthew Brost <matthew.brost@intel.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexander.Deucher@amd.com, Felix.Kuehling@amd.com, Oak.Zeng@amd.com,
 Jenny-Jing.Liu@amd.com, Philip.Yang@amd.com, Xiaogang.Chen@amd.com,
 Ray.Huang@amd.com, Lingshan.Zhu@amd.com, Junhua.Shen@amd.com,
 rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com, dakr@kernel.org,
 aliceryhl@google.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260420120739.1811731-1-honglei1.huang@amd.com>
 <20260420120739.1811731-2-honglei1.huang@amd.com>
 <cda09d5d-4cca-46a1-8625-fe9fa687e5a2@amd.com>
 <50d13ae3-be27-4b79-91ef-e1b386054943@amd.com>
 <54bb7286-2ffb-47f0-b37d-83b5c39ad9a0@amd.com>
 <aeZPBoJVTqOKd4bq@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: "Huang, Honglei1" <honghuan@amd.com>
In-Reply-To: <aeZPBoJVTqOKd4bq@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0049.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::20) To CY5PR12MB6430.namprd12.prod.outlook.com
 (2603:10b6:930:3a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|DS7PR12MB9527:EE_
X-MS-Office365-Filtering-Correlation-Id: 48ac5522-ae5e-434e-faa4-08de9f8bc862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: g9D1Ll6fguaUGb0jNmml7ZVyvP587cJCE7M0LR7JzqA5lDWrA/j6nz2RZyXTDCg1R09nLuEhuYq1gDIvr8KJdhf3SjIsQWxhBuhSaXOZFCR9aHv9NfDNtm1C2SRayjU5htrv1UldO/S5bby6JgCcWI3HwBweV8whcr0W3bOCPetuAMtIsgLOiMLRmSLLTuQn4DfIzizCnkTYgH35s0h0gx/yus+ZsEMxIt+sP44EXKzeMPwPSQj9FDRa9EgY8H0Vw+BX6yHuBNJY8LddiWBD5ib+3i1/VnIuiPrGZzDnKHUIfiCEVijuLpnGM0tscqXGHlWEhfDCUCjB+avGg/uMttkSFTe4WS3LFmRCt0FO0AH7pzOALMzIa4e0ME3NhRlXdwfCjKplKIpAfULVjyDvusqTa4HGnUxcnCYqr+oLe5Sj4rSdWyeREdbyLdB+Uk000Mvg3ZcEx/BJFNHks/zA90tauBDwvLbxWzYo0sdrLng7zQSvyLXDYl/0FygjFLc12AAtTV6VAzH2H2yxKxQVeIcvg1IvE7SB1hs2nKyuBGR7x/O44ZlTiLi3Vm8xNiP3LjDASH/1PNvnccGf7er2u8sNw+jZE0rJjRlmqUp5BhBWWaWmmrSQTUoDTwN5gR8mAVwcq2cHoqbI9LNwCKvTDoULeRuiHZmt8hXF0cInbZKwkmiP2oVQoN8y5s9L4qpqrdEGuOZkSam1xNEYtRNNvi+cow+Y4QjR3GusvEpK9xo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm9oNUNuMHVLdWlQbFh4VmxrMnpseko5MU01TGM5YkpjdjhpbmwvTVVhQlFG?=
 =?utf-8?B?QkhoY1R6R0p4aWQyTldWWkw2QjJzQ0lQaTExeXZWR1VsVTRFam1hazNPZnVL?=
 =?utf-8?B?MW1ZSUFvaHhYcFN0aFZKY2JsQloxbUxpS3MrbE05Tm9OWUhVdGFTUlliUjZp?=
 =?utf-8?B?YW0rL0xLQ1poNFdWWGRzWm5teno0RFp4ZkF3V3FEZGIxVFEvSVUvMVRtZWt3?=
 =?utf-8?B?TElyT1BYTC9STUNWYjFtT05PWGVJMlFPaSthNzhERElkYlVieURDdEZIWkVy?=
 =?utf-8?B?NjE3bGgyVVlPb2pZRzcwd2toS1A3YXpHZUZGTWcvMncxQldhc3JENWpmVmJZ?=
 =?utf-8?B?SGRFZzF4emxFUnZLM0Z1UW55WER0dFNYUXR1V1NFeGNCMzhiZGtLWThCcDVl?=
 =?utf-8?B?NnVWbnlFL3N4bzB6SXR3cTFDRFpHUVBNYzZpZWpLRFVHMGdXNjluYnkwQzhS?=
 =?utf-8?B?QXQrSC96NUowSnJ6bU9TR3lQM2JTVkZaK3BxUnNaRHVwRllwQ2swanVNL2k4?=
 =?utf-8?B?bkgrSTZWRWkzMUdUTWxJK2hyc2lFWHdHYWdaczhNUGxFNTZtQzV2UFpZdUF6?=
 =?utf-8?B?a2R5Mk1lK3JmU1RZL2xNU1F6ZmJhRDVxQVNBcFRSWmZ3N00rcjZLR2NlVXZM?=
 =?utf-8?B?UzVxRGU2eXZLUUg1c2dVczROYW82dkJtcVIyYVdud3RWTm5ITTVaVDNCSE5X?=
 =?utf-8?B?YlUvcGtMZXdjUVorSlZiNldrVGhTbUJhWjdMRnFGZkEwRldlbGZjSmluQzhh?=
 =?utf-8?B?VVNGMzVUZkpaN05WV2M5VElvYTVSMVVlcCthNzNDRGU0amxRY2I1b3NOVHIv?=
 =?utf-8?B?VkhPYzNuZkZQejBjNGdJWHNhb1IwWXluQ0liWHFKdFQxWm1rZFV5WWRycG94?=
 =?utf-8?B?MGtnM3FjVitpR1Yxd2hmbUZiODcxL1R2c2RzRS9XUEFiTW9OQ3BnaFZQNHVZ?=
 =?utf-8?B?VlA4M1ZiYVdnZW1YdURERHpBRmVLUzJoWW1aUUplWlVET2E1eWp3V0M0UU1j?=
 =?utf-8?B?dmxBdEh6Nm9TVm9pb0g4bU1pRXQyUnhsWjFuMXpmOWxKSXgxTk5BYzVlbS96?=
 =?utf-8?B?UVRMV0FlUTdyQUVyOUI4VGl0RDJIVk1rK3hGSXp2YlNYUlZMOXAyR3hpWk83?=
 =?utf-8?B?N3RIVnRhSk03M3RLbFY3dEk2Sitkd2kweEFlVEdVdjNMV0ZnK00rQUc1OTRY?=
 =?utf-8?B?RnlhK1JGTVdkVlpQOU1yQnR5UElhbWlIazRrRThIdGJTVDlOWDZKOUVjRG40?=
 =?utf-8?B?YTFsRExjc0Jhb3RacERPTVpPUjJCVTdWU1FiV2RKRFZmTG5MVHpxNFhzK2sy?=
 =?utf-8?B?dW1uZXhoLy8xTVRRbkcvcFBPZkxwakRUYWZBVjJZclhjWk5rMHBEWWYzd1VU?=
 =?utf-8?B?QVBiVW4ybmVuSzI1Vk50dnc1NXZiZDducE5WamU4blBsWk4yUkhOOWM0Nm9p?=
 =?utf-8?B?RERqcFRLQ29VVzFxOWtWUEJiYWpuUHM2dHpSZHpWUmxmZFBMZHdFRWlNWkd0?=
 =?utf-8?B?amJoN1JiKy9uTXZEY0R6eEVoNElBc0IvNFNUeDNqUEF5dW9TUkFjdm1LdkdW?=
 =?utf-8?B?YmhoMkM2U1JCcnhzMUNCVVlrdkdrRHlqZGtXcXhzRWVtTkRMcHloK1lHdmxY?=
 =?utf-8?B?YXVHTldMcW9wcXJKOU5tWG9qMEtvLzdWSTlNbnlQbmEzQlhnT1Q3QVNITTZ5?=
 =?utf-8?B?MkZvbnFkTWRxbFkxWk9wTzNhRFBtb1Y5QUhYcWxQbC80b3NlNEtWZ1p6V0hj?=
 =?utf-8?B?dnk3NGszc0hydHNnUS80QzIxSmhXQ01CN0ROL0V5a215aTBvWWp0RVlKSlJT?=
 =?utf-8?B?akRYNVVDa0xDWU5yYWY3Nll5LzAwcUJlN2U1VFVhUWlJQThhQjdYWnEzV25U?=
 =?utf-8?B?VnN6UmxPVk4rdy9nUkpQQXZRQnUyTWsrOFk0bU9SQlRyYWVmekVJalFSeThy?=
 =?utf-8?B?UERscW1qT1pXRXhnSCtnMkxwaStEU2wyd2RFcVJVTmdHZzNOK2x3OHpvblVw?=
 =?utf-8?B?RlF2SG1jU3NvLzdLY2N4V1QxN3F5bG1CeU9qVVY2d1hzVDJjc0o5eU00dzlt?=
 =?utf-8?B?STU0Y2xJVW9zOHZFaFdac1dBTU54V2lUaXRpRlRUTHZwU0Vjd3BOb20yRm8r?=
 =?utf-8?B?aE16WUVNdVRqdHh1UE5iRVhqLzRTV1RQVHR1S25BS08zcnJWVHVBUGdzMnQ5?=
 =?utf-8?B?eHNDd1ZPZHZhWWwzZWR3QkpDSzY0MU1tV1lQTk13M3Y4UTZWM0xZc2ZzV3Vt?=
 =?utf-8?B?Q2dhMGphQ0k2VlYvd0R5REFUVHIrbU9Ub1FKUVB5d1NrdmV1NXpkeVkzRnk3?=
 =?utf-8?Q?a2nmNPm9VItoYrXc25?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ac5522-ae5e-434e-faa4-08de9f8bc862
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 09:53:05.8523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xv3PUk4PHOPipD3s0Bg9lnIyNrer4434uygMrmhHMDv79glD+cVFvP3D4is9LT64EYKFfqjlqcq3iQlKlF+Jwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9527
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



On 4/21/2026 12:06 AM, Matthew Brost wrote:
> On Mon, Apr 20, 2026 at 05:37:43PM +0200, Christian König wrote:
>> On 4/20/26 15:30, Huang, Honglei1 wrote:
>>> On 4/20/2026 8:15 PM, Christian König wrote:
>>>>
>>>>
>>>> On 4/20/26 14:07, Honglei Huang wrote:
>>>>> From: Honglei Huang <honghuan@amd.com>
>>>>>
>>>>> Add amdgpu drm SVM API definitions built on the
>>>>> DRM GPUSVM framework.
>>>>>
>>>>> This includes:
>>>>> - DRM_AMDGPU_GEM_SVM ioctl
>>>>> - AMDGPU_SVM_FLAG_* flags
>>>>> - AMDGPU_SVM_OP_SET_ATTR / AMDGPU_SVM_OP_GET_ATTR operations
>>>>> - AMDGPU_SVM_ATTR_* attribute types
>>>>> - AMDGPU_SVM_LOCATION_SYSMEM / AMDGPU_SVM_LOCATION_UNDEFINED
>>>>> - struct drm_amdgpu_svm_attribute and struct drm_amdgpu_gem_svm
>>>>>
>>>>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>>>>> ---
>>>>>    include/uapi/drm/amdgpu_drm.h | 39 +++++++++++++++++++++++++++++++++++
>>>>>    1 file changed, 39 insertions(+)
>>>>>
>>>>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>>>>> index 406a42be4..bed71ed9b 100644
>>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>>> @@ -58,6 +58,7 @@ extern "C" {
>>>>>    #define DRM_AMDGPU_USERQ_SIGNAL        0x17
>>>>>    #define DRM_AMDGPU_USERQ_WAIT        0x18
>>>>>    #define DRM_AMDGPU_GEM_LIST_HANDLES    0x19
>>>>> +#define DRM_AMDGPU_GEM_SVM        0x1a
>>>>>      #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>>>>>    #define DRM_IOCTL_AMDGPU_GEM_MMAP    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>>>>> @@ -79,6 +80,7 @@ extern "C" {
>>>>>    #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>>>>>    #define DRM_IOCTL_AMDGPU_USERQ_WAIT    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>>>>>    #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
>>>>> +#define DRM_IOCTL_AMDGPU_GEM_SVM    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_SVM, struct drm_amdgpu_gem_svm)
>>>>>      /**
>>>>>     * DOC: memory domains
>>>>> @@ -1665,6 +1667,43 @@ struct drm_color_ctm_3x4 {
>>>>>        __u64 matrix[12];
>>>>>    };
>>>>>    +#define AMDGPU_SVM_FLAG_HOST_ACCESS        0x00000001
>>>>> +#define AMDGPU_SVM_FLAG_COHERENT        0x00000002
>>>>> +#define AMDGPU_SVM_FLAG_HIVE_LOCAL        0x00000004
>>>>> +#define AMDGPU_SVM_FLAG_GPU_RO            0x00000008
>>>>> +#define AMDGPU_SVM_FLAG_GPU_EXEC        0x00000010
>>>>> +#define AMDGPU_SVM_FLAG_GPU_READ_MOSTLY        0x00000020
>>>>> +#define AMDGPU_SVM_FLAG_GPU_ALWAYS_MAPPED    0x00000040
>>>>> +#define AMDGPU_SVM_FLAG_EXT_COHERENT        0x00000080
>>>>> +
>>>>> +#define AMDGPU_SVM_OP_SET_ATTR        0
>>>>> +#define AMDGPU_SVM_OP_GET_ATTR        1
>>>>> +
>>>>> +#define AMDGPU_SVM_ATTR_PREFERRED_LOC        0
>>>>> +#define AMDGPU_SVM_ATTR_PREFETCH_LOC        1
>>>>
>>>> Up till here the interface makes perfect sense, but then it becomes a bit fuzzy.
>>>>
>>>>> +#define AMDGPU_SVM_ATTR_ACCESS            2
>>>>> +#define AMDGPU_SVM_ATTR_ACCESS_IN_PLACE        3
>>>>> +#define AMDGPU_SVM_ATTR_NO_ACCESS        4
>>>>
>>>> Why are those separate attributes? What is the difference between those?
>>>
>>> Really thanks for the comments, I have some content mistaken in V2, so I updated the V3 to fix that. For the header they are same. for other content please review the V3, sorry about that. And will fix the concern you raised in next version.
>>>
>>> So the meaning of AMDGPU_SVM_ATTR_ACCESS and AMDGPU_SVM_ATTR_NO_ACCESS are clear, GPU can access it or not, and the SVM can set the preferred location, it can be in VRAM or system, for AMDGPU_SVM_ATTR_ACCESS it can be migrated between RAM and VRAM. For AMDGPU_SVM_ATTR_ACCESS_IN_PLACE,
>>> it can not migrate, GPU only can access it in the initial place.
>>
>> Yeah but that doesn't then the interface doesn't seem to make sense since such states are mutual exclusive.
>>
>> It would make sense when you have some attribute which is named (for example) AMDGPU_SVM_ATTR_ACCESS which can have the values INACCESSIBLE, IN_PLACE, MIGRATE.
>>
>>>>> +#define AMDGPU_SVM_ATTR_SET_FLAGS        5
>>>>> +#define AMDGPU_SVM_ATTR_CLR_FLAGS        6
>>>>
>>>> Why is that separated into set and clear flags?
>>>
>>> This method inherits from KFD and is also designed to be compatible with upper layer applications such as ROCR.
>>
>> That is *not* sufficient as justification. We need to document why that is necessary and *not* just say ROCR works that way.
>>
>> As far as I can see just a SET_FLAGS should be sufficient.
>>
>>>>> +#define AMDGPU_SVM_ATTR_GRANULARITY        7
>>>>> +
>>>>> +#define AMDGPU_SVM_LOCATION_SYSMEM        0
>>>>> +#define AMDGPU_SVM_LOCATION_UNDEFINED        0xffffffff
>>>>
>>>> No location for device local memory?
>>>
>>> Vaule > 0 means for device memory, in xe_svm, it seems like it uses fd for device local memory.
> 
> I have no stake in AMD’s uAPI, but I can at least explain how Xe’s uAPI
> works here—and admittedly, it’s somewhat goofy.
> 
> 0 == device-local memory, with first-touch placement on whichever
> device/tile touches the memory first
> 
> -1 == system memory
> 
> ≥ 0 == a render-node FD (which could refer to a local or remote device),
> paired with a region instance to extract the pgmap for the desired
> placement
> 
> I believe the reason this isn’t fully FD-based is that the compute UMD
> team wasn’t keen on exporting every pgmap as an FD, though that was
> something that had been considered.
> 

Thanks for explaining Xe's SVM interface. I have a quick question :

0 means device-local memory with first-touch placement, and a 
render-node FD means explicit placement on a specific device.

What is the difference between 0 and fd points to renderer node it self?

The reason I ask is that for amdgpu, the current design for drm gpu svm 
is per FD per SVM per GPU, so device local means the current GPU. And 
the behavior for 0, sounds like a global semantics/multi GPU semantics.

This can easily cause conflicts. Is there a plan to add a global 
coordination feature in the drm gpu SVM instead of pushing this 
responsibility to UMD?

Regards,
Honglei

>>
>> Absolute clear NAK for that approach. This interface is per FD!
>>
>> We need some value AMDGPU_SVM_LOCATION_DEVICE which means that the memory should be migrated to the current device.
>>
>> We also need to make sure that setting attributes for different devices doesn't affect each other.
> 
> We landed on the conclusion that it is undefined behavior if different
> render FDs—or more specifically, VMs across devices within the same SVM
> address space—set different madvise attributes. I believe this was at
> Sima's suggestion.
> 
>  From the UMD point of view, every madvise call therefore becomes:
> 
> for_each_fd_vm
> 	set_madvise_attributes
> 
> This choice was made to keep madvise attributes local to the per-device
> VM structure, rather than introducing some form of cross-device shared
> storage.
> 
> A misbehaving user can absolutely shoot themselves in the foot, but at
> worst this only ends up corrupting behavior within their own process
> shared across devices.
> 
> Matt
> 
>>
>> Regards,
>> Christian.
>>
>>>
>>>>
>>>>> +
>>>>> +struct drm_amdgpu_svm_attribute {
>>>>> +    __u32 type;
>>>>> +    __u32 value;
>>>>> +};
>>>>> +
>>>>> +struct drm_amdgpu_gem_svm {
>>>>> +    __u64 start_addr;
>>>>> +    __u64 size;
>>>>> +    __u32 operation;
>>>>> +    __u32 nattr;
>>>>> +    __u64 attrs_ptr;
>>>>> +};
>>>>
>>>> Those struct make perfect sense but clearly need documentation. Preferable as kerneldoc.
>>>>
>>>> And we usually use unions in this header to separate the input from the output parameters.
>>>
>>> Got it will add documentation for it and will use unions in next version. Really thanks for the comments.
>>>
>>> Regards,
>>> Honglei
>>>
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> +
>>>>>    #if defined(__cplusplus)
>>>>>    }
>>>>>    #endif
>>>>
>>>
>>

