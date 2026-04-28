Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A02FF8864
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 02:24:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4CF510E9F9;
	Tue, 28 Apr 2026 02:24:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oYShngMI";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010022.outbound.protection.outlook.com [52.101.46.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF49010E9F9;
 Tue, 28 Apr 2026 02:24:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrGVtj1nCz8CSMUHFE2rqYxzIwnAhz9LgCy4u7un3GVtw3PTTK9kIDrnero1sQ1Jvh58d/dFy/laNDIvsEI59XEUdIBFswhzUjMf80nzc7wYLuoM638p9aZ9vEbDuN+WID9HDbbDCvkwDWNJCj8hAvCqMk1hxNx5Br1jgKVABvf+SmPNbja8v2Ol3btkv32LXAw2Xyh1JDZcRdDytIwrqpDUo4n8NIOEC9UGpFL+uc5xBWi3GyN41lT2ED+wpdtTGErHvsi+sGjPScBQvw9IzeZImyqeL/3UGBeGM7Jm8eZh1KessBn8yTw1O3CfqLkeJHc0cXmPSEExdcg3vXzsZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUN/26x1DrdtHvrnwZc0s4EzjUIbki4M4bpBs3xK3CI=;
 b=g7z74M/xwpo35C/Puym80zfZlp1OMzk7aUNNpnq7IiRJ/zZgP6392sbGrMyC6whFjZRlPnVAtrUNrmoUhcAR/OEj69xt5JesMte9edEq2aLBMf1BiHZeNL9zVxCrvRtAzDPgSMQZzS2w83nPXQHyjuNXI+aWtXqEO4XaEKz9+nI8uTXhX8x5xwvdsnFXwNb6OjgdiglMdTvLQixedh3qmGhudVA70SBbT/tAw5PVvYX/u0pDs6ZB61sALq9gMjsy/pHkNjHLtyxMLAo1G2evQb8TpLIwo38t/pW8EKrOpZjq+uCW5IzVQYsrg1nvAdcgoeC81zZk8oOnMZGGvxNuKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUN/26x1DrdtHvrnwZc0s4EzjUIbki4M4bpBs3xK3CI=;
 b=oYShngMIJ2aAe77+0Tww0W1b6VbBiaIVHfjeTRG4I0lsFYbpNrTzfSxZ4rsggF6/eVJNj58MMj0Q4nSAsR4T0w/Qwx5gGYcUnVjQFk0/XQIP6KziZ6sGpHkz5JGt6X9+EAYH7qVGWd/kWYhkGZ648eUAokyi5JyFAYSy7CPet08=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by IA0PR12MB8696.namprd12.prod.outlook.com (2603:10b6:208:48f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 02:24:48 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 02:24:47 +0000
Message-ID: <ab5ee013-9c41-4d28-b6e0-1358c0f4f647@amd.com>
Date: Tue, 28 Apr 2026 10:24:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/POC PATCH 01/12] drm/amdgpu: add SVM UAPI definitions
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alexander.Deucher@amd.com, Oak.Zeng@amd.com, Jenny-Jing.Liu@amd.com,
 Philip.Yang@amd.com, Xiaogang.Chen@amd.com, Ray.Huang@amd.com,
 Lingshan.Zhu@amd.com, Junhua.Shen@amd.com, matthew.brost@intel.com,
 rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com, dakr@kernel.org,
 aliceryhl@google.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260420120739.1811731-1-honglei1.huang@amd.com>
 <20260420120739.1811731-2-honglei1.huang@amd.com>
 <cda09d5d-4cca-46a1-8625-fe9fa687e5a2@amd.com>
 <50d13ae3-be27-4b79-91ef-e1b386054943@amd.com>
 <54bb7286-2ffb-47f0-b37d-83b5c39ad9a0@amd.com>
 <9e2bee93-306a-4ef0-80be-daed33c8bbb5@amd.com>
 <7a3ebad2-839a-4a88-911f-c9bb7be3b00e@amd.com>
 <daa7239f-7fc9-492d-849f-2d46bd84999b@amd.com>
 <9c5afd4b-f9f0-445a-9b39-35f56fa2bea4@amd.com>
 <67e190b3-deb9-44c0-a3a1-d269de677c21@amd.com>
Content-Language: en-US
From: "Huang, Honglei1" <honghuan@amd.com>
In-Reply-To: <67e190b3-deb9-44c0-a3a1-d269de677c21@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0059.apcprd01.prod.exchangelabs.com
 (2603:1096:820:5::23) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|IA0PR12MB8696:EE_
X-MS-Office365-Filtering-Correlation-Id: ad881cd8-c547-4581-0c6f-08dea4cd514d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: P7fGNS4yA1EJsuupFsFe5tLUz4DP20A8HNNt4Pe0BG9HkMRIbprQIqU712UakOT4Wm3gwjtO8cdcatnaGe6bLRriGFEvejR7J/B+C4glIeyr2vGdj+ODD2BVfGmoHSnVHYv5krHDGfhBt2YuqBxjNML9eGAIpS/8ryzOJSBdPFMspe00UEalV0uL0b+EqxNQEVfgp5iT+NCy/do62epgi8ZnVNiF1OVj4Xp+op1ixSWQkIUjxfl87t954Y8F9ed2rUpt+lTcn7LSQXZ76mcphuwiRbBGHB3Yp2LhShWOkoAebsqWA/pR4Qz4uUWBAKclWCg/G94KcOYUMfxk9yXseEseLXjZULxn+Y/+OufHw4GfgoOZHB5lLVn39vwrdTWQ1z+G3Pna8vir+Ot9yEqpHWQDGqdceTNEgXMVbVMkhtG4SxpvLBwF1x8/hHXZ5VKwKkBtkj3WW3YwiakDCfDLt3UMLGiLOfJa6VSgGPpF126ZB3mjK8bI1RnqFDRc//UnsugQF5W0Dlb3+3QhcAhkmC3t1a+bwZIiqZ1Cjlf7LjarCRLpbkcVgG4x3uMq7pESNtn/LdNGpUIB1Q5gkxEDRHNzbL66ha4tHwGDple9hQlx69BKCNidZhEeFR28XHUCA0yNvTTTejAEOX5CU+YrpORGUOHI8pX6pNj/SOyT31PwMG82rsgKQbSRYM40UtHbk5rilXQGJHYfTZBejREhcTiVVW/iuarU71+llHl1huI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGJYTUM5eENvMnNjVEk4Y3NlWG9VT2tsRnQ4OXRVazhNMmtaQWFpSHdoUXFM?=
 =?utf-8?B?US80Q2ZnSUphVGg3M3BCek52WUdJRlQ4cG5iSlV2TXFScGdrVzFHWWk5N0FU?=
 =?utf-8?B?TCtOSEYrZStxZnRTOEJTeDRkMElzSDFLNEpkc3Q4bndGcGRRaGVOOU91bFFP?=
 =?utf-8?B?bkQ5NWVscE9uektReDltMGVRS1haUXZ4NGlkSDh2MVdWd0FvejdaelNYWDJj?=
 =?utf-8?B?VTZiby9pRER2czIvRElrNVRFdXJJTStMdEhjeHlZSGFGTEtoNnBjWGhFajE3?=
 =?utf-8?B?V0h1bVhwbXVkdlcxYVJNWmJUR3RVV3c5NUJHV0dkNk00TW9YSkdIMlNVdmFP?=
 =?utf-8?B?bzcrZ2psaXRBWnlDLzhiQlRMSHlRdkMzbUJHR1luR3FuZENXQ3UrMjE2ditY?=
 =?utf-8?B?TG9JSzc0clNkQVFpQ2dPY3UxUmRQSUVqZ0R6RWNQUmpQZ1pVelpOQ25ZTVlR?=
 =?utf-8?B?UnhXL25DOW1walZPNy8ralRhVXc4dEZqNzlzdytkL3VCTzl6MzBTdUQ0SEpW?=
 =?utf-8?B?RElFMnRLcHEwaHZsajRHSG9DRWlwcEM5L0F0TXdjR3JMa2Y0dzZsZEp5NXRn?=
 =?utf-8?B?YlZEVysyemxxTFlLVFlyRVk0OGE3MjhieDFHYTNtbjA3RkxTWHlON2h0Q2tD?=
 =?utf-8?B?aXB2R3dBSWk4ZC9QWkF4YytRMDBXenRmbFpxWjBuN052YUdocUJwZitFai9N?=
 =?utf-8?B?eXorMTRQMzQxSHZtTTFLM21xd0ZnTDloOUVIZ1NtR09SRzl6bnVPL2JvNGI5?=
 =?utf-8?B?dVAwZEZxcTllZEJNaHB0bURZUEhOV0p2Q053RjhYRFYwVzJ6VG1Ya1hGclFj?=
 =?utf-8?B?YnN6UEh6OXQ2MkZlVm9kek11dTk1SXlmNk9BZjN3WjQzb1pPOVgwcGh1bi9Q?=
 =?utf-8?B?YnRwWlMxR3huMkgwTkJvM243bkN0ajFnS1I0ZWhFSmN3UG4yOUIzbWdYUUxp?=
 =?utf-8?B?cFhSeFFkOFR1c0N0blhiUmtQaEFmRVVJekhJTjhGK3diU3BUMW52WDRCUHNW?=
 =?utf-8?B?YjFST2tUSFdMYWJQMm0yakVLaHhPc3NEQjFLUXpTRjY1SHQyMlUzOUhyMWM3?=
 =?utf-8?B?UWw4UWpabFRwRjJQUXNCdkErNTMxbWhSU2JQb3BhcEtXMFlOcFQ2YU1TaU8z?=
 =?utf-8?B?UTVrZ083NVNmYjVFampXam1tTjcxQ2htNlZ1T1lnc0NaNDRxdnB1eFhkbThP?=
 =?utf-8?B?STFzQllEd05uRGJVNTVZcUFnYnZWcGlIOVVMdHljNDFYSHAyeEJZd242OVJB?=
 =?utf-8?B?cTcrV1BDeUdwU2lhLy91dVNxQmhvQlJVZ2J1T0VBaDJxRCtFbXp3ellNMzRV?=
 =?utf-8?B?V2VBbnBLaWd3MnU1MCtHamFHczdobXpaQ0xickR4dGprdXg3dFNTK291eTE1?=
 =?utf-8?B?ZkRTNmg3ejlKd0RnK1gwUk91VzArZkpRd2hJY3AzRXlmQWc3UHpUTzZRQWxU?=
 =?utf-8?B?NzRKRFVXcGNWQTFTKy9SRElmOHROVzBhOTBXcVI2SENZakp3ZExkdngzNjFR?=
 =?utf-8?B?OFB4M1JlT2xUeitjYk9iOXh3em0xRUpzT2dwYXRKYURrVEk0SUFYNXZTb3Fu?=
 =?utf-8?B?UXZSSDBKcjFvbmtFSXdscis3c2pSTUd1NHVRVlMwaHBERWttTEJZQWs4K2tu?=
 =?utf-8?B?bWRPK1JuV0duN1J2ZnFrdklNWGhLUStrRDFhZlFZSDNpdjFRTStNNUU2akE3?=
 =?utf-8?B?eVk0VDYzZjZIT3dRU0xmaHdRR0xWYlJtK1l0Mk5ONnpUOSs2dS9nam5KRUlS?=
 =?utf-8?B?VmZzRFRuaHB2M1UvK2FUaUU5NXRBbVJhcUV0QitYYmtPUDdqUkZYNGtBYWFP?=
 =?utf-8?B?K2FPWlMxR25jbTdjbHAwSXhpRjU5RllNWHk4VjZrbzBDUFUrNjVsS2g2ZzRa?=
 =?utf-8?B?am1VWEFwYXRwYWxXQklrQkpaM2pEZTZqUlVXYXIxT2lvNDhPazdPdGEyVEM4?=
 =?utf-8?B?ZFpJeDZtbmw1eVM5L2tjbXdTN2w3QWpNdHZmNWlBQ1V4OEl0RExoS2Z0K1oz?=
 =?utf-8?B?a0Ryb1ovUlVFczJQRXRobVRFM3psYTlzYXNKVlV4eEhsbVdqYVNsTmU3anNG?=
 =?utf-8?B?MzBHbHB5NU5tN2NpYlA1WU5xYUkzSll6Wkl6c0xSZ2toa1dqRHU0bjkzYnBy?=
 =?utf-8?B?U2tWcjl4OXhEb05udVBYRmFGYVhmVkdYS1Z2Y0FwZ2YvU0NRSXYwNzhFU1pN?=
 =?utf-8?B?V3JxYkpYS2FGN2E2VWFxVzNyVks0SVgwR3l1N2dKeDYrNm9kbXlmNjJnRjNG?=
 =?utf-8?B?UFFFbmxYSE5ENi9UYWhGMHh4R2REUlo1bUVNRHFwYkdtNmRPbUxwRmR4Zk1n?=
 =?utf-8?B?QUgrdmdBL1NaT1RXZDRiSXllM1JoRlR1bFV4ei9hdmlLUmJwNlgvQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad881cd8-c547-4581-0c6f-08dea4cd514d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 02:24:47.7174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5MG/CM2pqmNRPggROY7zocvt4kynZFPcrFs1KuQawF1Gem5lsvi7Sd+grUC4H3W9mXSV3fthhcMQnDEfbqjdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8696
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



On 4/28/2026 5:05 AM, Felix Kuehling wrote:
> 
> On 2026-04-24 06:12, Huang, Honglei1 wrote:
>>
>>
>> On 4/23/2026 7:06 PM, Huang, Honglei1 wrote:
>>>
>>>
>>> On 4/23/2026 6:39 PM, Christian König wrote:
>>>> On 4/23/26 08:21, Huang, Honglei1 wrote:
>>>>>
>>>>>
>>>>> On 4/20/2026 11:37 PM, Christian König wrote:
>>>>>> On 4/20/26 15:30, Huang, Honglei1 wrote:
>>>>>>> On 4/20/2026 8:15 PM, Christian König wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 4/20/26 14:07, Honglei Huang wrote:
>>>>>>>>> From: Honglei Huang <honghuan@amd.com>
>>>>>>>>>
>>>>>>>>> Add amdgpu drm SVM API definitions built on the
>>>>>>>>> DRM GPUSVM framework.
>>>>>>>>>
>>>>>>>>> This includes:
>>>>>>>>> - DRM_AMDGPU_GEM_SVM ioctl
>>>>>>>>> - AMDGPU_SVM_FLAG_* flags
>>>>>>>>> - AMDGPU_SVM_OP_SET_ATTR / AMDGPU_SVM_OP_GET_ATTR operations
>>>>>>>>> - AMDGPU_SVM_ATTR_* attribute types
>>>>>>>>> - AMDGPU_SVM_LOCATION_SYSMEM / AMDGPU_SVM_LOCATION_UNDEFINED
>>>>>>>>> - struct drm_amdgpu_svm_attribute and struct drm_amdgpu_gem_svm
>>>>>>>>>
>>>>>>>>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>>>>>>>>> ---
>>>>>>>>>     include/uapi/drm/amdgpu_drm.h | 39 ++++++++++++++++++++++++ 
>>>>>>>>> ++ +++++++++
>>>>>>>>>     1 file changed, 39 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/ 
>>>>>>>>> amdgpu_drm.h
>>>>>>>>> index 406a42be4..bed71ed9b 100644
>>>>>>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>>>>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>>>>>>> @@ -58,6 +58,7 @@ extern "C" {
>>>>>>>>>     #define DRM_AMDGPU_USERQ_SIGNAL        0x17
>>>>>>>>>     #define DRM_AMDGPU_USERQ_WAIT        0x18
>>>>>>>>>     #define DRM_AMDGPU_GEM_LIST_HANDLES    0x19
>>>>>>>>> +#define DRM_AMDGPU_GEM_SVM        0x1a
>>>>>>>>>       #define DRM_IOCTL_AMDGPU_GEM_CREATE 
>>>>>>>>> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union 
>>>>>>>>> drm_amdgpu_gem_create)
>>>>>>>>>     #define DRM_IOCTL_AMDGPU_GEM_MMAP DRM_IOWR(DRM_COMMAND_BASE 
>>>>>>>>> + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>>>>>>>>> @@ -79,6 +80,7 @@ extern "C" {
>>>>>>>>>     #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL 
>>>>>>>>> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct 
>>>>>>>>> drm_amdgpu_userq_signal)
>>>>>>>>>     #define DRM_IOCTL_AMDGPU_USERQ_WAIT 
>>>>>>>>> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct 
>>>>>>>>> drm_amdgpu_userq_wait)
>>>>>>>>>     #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES 
>>>>>>>>> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct 
>>>>>>>>> drm_amdgpu_gem_list_handles)
>>>>>>>>> +#define DRM_IOCTL_AMDGPU_GEM_SVM DRM_IOWR(DRM_COMMAND_BASE + 
>>>>>>>>> DRM_AMDGPU_GEM_SVM, struct drm_amdgpu_gem_svm)
>>>>>>>>>       /**
>>>>>>>>>      * DOC: memory domains
>>>>>>>>> @@ -1665,6 +1667,43 @@ struct drm_color_ctm_3x4 {
>>>>>>>>>         __u64 matrix[12];
>>>>>>>>>     };
>>>>>>>>>     +#define AMDGPU_SVM_FLAG_HOST_ACCESS 0x00000001
>>>>>>>>> +#define AMDGPU_SVM_FLAG_COHERENT        0x00000002
>>>>>>>>> +#define AMDGPU_SVM_FLAG_HIVE_LOCAL 0x00000004
>>>>>>>>> +#define AMDGPU_SVM_FLAG_GPU_RO 0x00000008
>>>>>>>>> +#define AMDGPU_SVM_FLAG_GPU_EXEC        0x00000010
>>>>>>>>> +#define AMDGPU_SVM_FLAG_GPU_READ_MOSTLY 0x00000020
>>>>>>>>> +#define AMDGPU_SVM_FLAG_GPU_ALWAYS_MAPPED 0x00000040
>>>>>>>>> +#define AMDGPU_SVM_FLAG_EXT_COHERENT 0x00000080
>>>>>>>>> +
>>>>>>>>> +#define AMDGPU_SVM_OP_SET_ATTR        0
>>>>>>>>> +#define AMDGPU_SVM_OP_GET_ATTR        1
>>>>>>>>> +
>>>>>>>>> +#define AMDGPU_SVM_ATTR_PREFERRED_LOC        0
>>>>>>>>> +#define AMDGPU_SVM_ATTR_PREFETCH_LOC        1
>>>>>>>>
>>>>>>>> Up till here the interface makes perfect sense, but then it 
>>>>>>>> becomes a bit fuzzy.
>>>>>>>>
>>>>>>>>> +#define AMDGPU_SVM_ATTR_ACCESS            2
>>>>>>>>> +#define AMDGPU_SVM_ATTR_ACCESS_IN_PLACE        3
>>>>>>>>> +#define AMDGPU_SVM_ATTR_NO_ACCESS        4
>>>>>>>>
>>>>>>>> Why are those separate attributes? What is the difference 
>>>>>>>> between those?
>>>>>>>
>>>>>>> Really thanks for the comments, I have some content mistaken in 
>>>>>>> V2, so I updated the V3 to fix that. For the header they are 
>>>>>>> same. for other content please review the V3, sorry about that. 
>>>>>>> And will fix the concern you raised in next version.
>>>>>>>
>>>>>>> So the meaning of AMDGPU_SVM_ATTR_ACCESS and 
>>>>>>> AMDGPU_SVM_ATTR_NO_ACCESS are clear, GPU can access it or not, 
>>>>>>> and the SVM can set the preferred location, it can be in VRAM or 
>>>>>>> system, for AMDGPU_SVM_ATTR_ACCESS it can be migrated between RAM 
>>>>>>> and VRAM. For AMDGPU_SVM_ATTR_ACCESS_IN_PLACE,
>>>>>>> it can not migrate, GPU only can access it in the initial place.
>>>>>>
>>>>>> Yeah but that doesn't then the interface doesn't seem to make 
>>>>>> sense since such states are mutual exclusive.
>>>>>>
>>>>>> It would make sense when you have some attribute which is named 
>>>>>> (for example) AMDGPU_SVM_ATTR_ACCESS which can have the values 
>>>>>> INACCESSIBLE, IN_PLACE, MIGRATE.
>>>>>
>>>>> Got it so can I change the UAPI to the following format?
>>>>>
>>>>> enum amdgpu_ioctl_svm_attr_type {
>>>>>      AMDGPU_IOCTL_SVM_ATTR_PREFERRED_LOC,
>>>>>      AMDGPU_IOCTL_SVM_ATTR_PREFETCH_LOC,
>>>>>      AMDGPU_IOCTL_SVM_ATTR_ACCESS,
>>>>>      AMDGPU_IOCTL_SVM_ATTR_SET_FLAGS,
>>>>>      AMDGPU_IOCTL_SVM_ATTR_CLR_FLAGS,
>>>>>      AMDGPU_IOCTL_SVM_ATTR_GRANULARITY
>>>>> };
>>>>>
>>>>> enum amdgpu_ioctl_svm_location {
>>>>
>>>> The enum name could probably be improved, but apart from that looks 
>>>> reasonable to me.
>>>
>>> Will improve the name.
>>>>
>>>>>      AMDGPU_SVM_ACCESS_INACCESSIBLE = 1,
>>>>>      AMDGPU_SVM_ACCESS_IN_PLACE = 2,
>>>>>      AMDGPU_SVM_ACCESS_MIGRATE = 3,
>>>>> };
>>>>>
>>>>>>
>>>>>>>>> +#define AMDGPU_SVM_ATTR_SET_FLAGS        5
>>>>>>>>> +#define AMDGPU_SVM_ATTR_CLR_FLAGS        6
>>>>>>>>
>>>>>>>> Why is that separated into set and clear flags?
>>>>>>>
>>>>>>> This method inherits from KFD and is also designed to be 
>>>>>>> compatible with upper layer applications such as ROCR.
>>>>>>
>>>>>> That is *not* sufficient as justification. We need to document why 
>>>>>> that is necessary and *not* just say ROCR works that way.
>>>>>>
>>>>>> As far as I can see just a SET_FLAGS should be sufficient.
>>>>>
>>>>> Accoding to the reply form Felix, CLR_FLAGS provides a convenient 
>>>>> method for deleting large-scale flags, do we need to redesign this 
>>>>> part?
>>>>
>>>> I think we should expose those flags as individual attributes then.
>>>
>>> Got it will do.
>>>
>>>>
>>>>>>
>>>>>>>>> +#define AMDGPU_SVM_ATTR_GRANULARITY        7
>>>>>>>>> +
>>>>>>>>> +#define AMDGPU_SVM_LOCATION_SYSMEM        0
>>>>>>>>> +#define AMDGPU_SVM_LOCATION_UNDEFINED 0xffffffff
>>>>>>>>
>>>>>>>> No location for device local memory?
>>>>>>>
>>>>>>> Vaule > 0 means for device memory, in xe_svm, it seems like it 
>>>>>>> uses fd for device local memory.
>>>>>>
>>>>>> Absolute clear NAK for that approach. This interface is per FD!
>>>>>>
>>>>>> We need some value AMDGPU_SVM_LOCATION_DEVICE which means that the 
>>>>>> memory should be migrated to the current device.
>>>>>>
>>>>>> We also need to make sure that setting attributes for different 
>>>>>> devices doesn't affect each other.
>>>>>
>>>>>
>>>>> I Totally agreed with your thoughts, but according to the reply 
>>>>> from matt, it seems like we need to consider the P2P/multi GPU 
>>>>> situation.
>>>>
>>>> When the drm_svm or pagemap component has already code to deal with 
>>>> that then it is probably ok to have the same interface.
>>>>
>>>> When when XE only hacked that together on their own then that is a 
>>>> bit questionable because getting the lifetime right is usually tricky.
>>>>
>>>>>
>>>>> So do I need to add a AMDGPU_SVM_LOCATION_DEVICE  flag or do I need 
>>>>> to modify the UAPI to align with xe_svm?
>>>>
>>>> I think we need to full clarify how XE works here. E.g. that you can 
>>>> specify both 0 as well as give the fd to get the memory migrated to 
>>>> the local device sounds odd.
>>>
>>> Got it, for this part maybe require more discussion and time to fully 
>>> understand, so this part will remain unchanged in the next version.
>>>
>>
>> Hi Christian, Felix,
>>
>> Based on the v3 review, I've reworked the SVM UAPI. Please let me know 
>> if anything still looks off before I post v4.
>>
>> Changes with v3 UAPI:
>>   - OP / ATTR_TYPE / ACCESS / LOCATION converted to documented enums.
>>   - Three ACCESS_* attribute types collapsed into a single
>>     AMDGPU_SVM_ATTR_ACCESS carrying enum amdgpu_ioctl_svm_access.
>>   - ACCESS/MIGRATE renamed to ALLOW_MIGRATE to means permitted, not 
>> required
>>   - SET_FLAGS / CLR_FLAGS removed; each former flag is now its own
>>     attribute carrying enum amdgpu_ioctl_svm_flag_value: CLR / SET
>>
>>
>>   enum amdgpu_ioctl_svm_op {
>>           AMDGPU_SVM_OP_SET_ATTR = 0,
>>           AMDGPU_SVM_OP_GET_ATTR = 1,
>>   };
>>
>>   enum amdgpu_ioctl_svm_attr_type {
>>           AMDGPU_SVM_ATTR_PREFERRED_LOC           = 0,
>>           AMDGPU_SVM_ATTR_PREFETCH_LOC            = 1,
>>           AMDGPU_SVM_ATTR_ACCESS                  = 2,
>>           AMDGPU_SVM_ATTR_GRANULARITY             = 3,
>>           AMDGPU_SVM_ATTR_HOST_ACCESS             = 4,
>>           AMDGPU_SVM_ATTR_COHERENT                = 5,
>>           AMDGPU_SVM_ATTR_EXT_COHERENT            = 6,
>>           AMDGPU_SVM_ATTR_HIVE_LOCAL              = 7,
>>           AMDGPU_SVM_ATTR_GPU_RO                  = 8,
>>           AMDGPU_SVM_ATTR_GPU_EXEC                = 9,
>>           AMDGPU_SVM_ATTR_GPU_READ_MOSTLY         = 10,
>>           AMDGPU_SVM_ATTR_GPU_ALWAYS_MAPPED       = 11,
>>   };
>>
>>   enum amdgpu_ioctl_svm_access {
>>           AMDGPU_SVM_ACCESS_INACCESSIBLE          = 0,
>>           AMDGPU_SVM_ACCESS_IN_PLACE              = 1,
>>           AMDGPU_SVM_ACCESS_ALLOW_MIGRATE         = 2,
>>   };
>>
>>   enum amdgpu_ioctl_svm_location {
>>           AMDGPU_SVM_LOCATION_SYSMEM              = 0,
>>           AMDGPU_SVM_LOCATION_UNDEFINED           = 0xffffffff,
>>   };
>>
>>   enum amdgpu_ioctl_svm_flag_value {
>>           AMDGPU_SVM_FLAG_CLR                     = 0,
>>           AMDGPU_SVM_FLAG_SET                     = 1,
>>   };
> 
> Looks reasonable to me. But I'm not sure you really need enum 
> amdgpu_ioctl_svm_flag_value. I'd just use 0 and non-zero to mean false 
> and true.
> 

Got it, will remove amdgpu_ioctl_svm_flag_value, and use 0 and non-zero 
to mean false or true for the flags.

Regards,
Honglei

> Regards,
>    Felix
> 
> 
>>
>>
>> Regards,
>> Honglei
>>
>>> Regards,
>>> Honglei
>>>
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>> Regards,
>>>>> Honglei
>>>>>
>>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>> +
>>>>>>>>> +struct drm_amdgpu_svm_attribute {
>>>>>>>>> +    __u32 type;
>>>>>>>>> +    __u32 value;
>>>>>>>>> +};
>>>>>>>>> +
>>>>>>>>> +struct drm_amdgpu_gem_svm {
>>>>>>>>> +    __u64 start_addr;
>>>>>>>>> +    __u64 size;
>>>>>>>>> +    __u32 operation;
>>>>>>>>> +    __u32 nattr;
>>>>>>>>> +    __u64 attrs_ptr;
>>>>>>>>> +};
>>>>>>>>
>>>>>>>> Those struct make perfect sense but clearly need documentation. 
>>>>>>>> Preferable as kerneldoc.
>>>>>>>>
>>>>>>>> And we usually use unions in this header to separate the input 
>>>>>>>> from the output parameters.
>>>>>>>
>>>>>>> Got it will add documentation for it and will use unions in next 
>>>>>>> version. Really thanks for the comments.
>>>>>>>
>>>>>>> Regards,
>>>>>>> Honglei
>>>>>>>
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Christian.
>>>>>>>>
>>>>>>>>> +
>>>>>>>>>     #if defined(__cplusplus)
>>>>>>>>>     }
>>>>>>>>>     #endif
>>>>>>>>
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>

