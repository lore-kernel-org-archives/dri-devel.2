Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D3BC79FA0
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:53:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19F2410E4D4;
	Mon,  7 Sep 2026 11:53:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z4VV1SNo";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010060.outbound.protection.outlook.com [52.101.85.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A7D510E4D4;
 Mon,  7 Sep 2026 11:53:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T4I+1qwodNVAb0w9ygqDs57wnnjrgT/k+YF+bTseF6oxilZtK1RKS8zhKZxTem2yKJd0b7VVFyV5JnmcGZjWY+xAttMp//vNQkcAQndr/XzKCWo3nGIH8K0XtSecCBLeGN2JoAZgAI9j35ycwXazulYzIvhqOtoTtZET2oTHMb+RZ1UJ9cbZIznjLtIC4vttFby2eUUSI1IvN4Pq5SAtuxj0b//4xMEKIxayqZBaI0c0mLcRCFtosk2II8HhkhImZmolN8IlvtoSBXWgpvgB6auucvVccbisq/oQ9XF3JW7TkLzz8195MUmwVXyLzKW9TJq9WoBHRNUxEgo0FuW1tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQ5eA/TiWT3R2mHmfoMWS4oim23Kgp0DsfXE5Sg7yYE=;
 b=vPbOOXS52iVjncq9/S1bAxNZLaa3EAXN0fH5GF5f/m0ELpMBODPGaEL0bA2wWTnlz2vBjsNwZKwv3GdZwlYoxyByIvhcNswbSy5J0Ui1O2p+o3gRAUS2ejFkbgY6EcoATNtZQ/33Kr+3RYgKWKfXgbxmXUxjFUOBzbZ6LWjFPLcG+2gBLHrXFXU2uL68i83L+oUJHbPao2MpdaD3pc3D2gIP14fVFjDer1IUxJ78nxlQqV/p84PXAtVsOWhRVbmwm05XD38ijjxbGXq8OTVdf8fUqJntze2YjHNPCl/HmONTa2nIU2or13zihiHKyOz61/1WeZFpAkFhe0xfhX5Neg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQ5eA/TiWT3R2mHmfoMWS4oim23Kgp0DsfXE5Sg7yYE=;
 b=Z4VV1SNoJ7yMCA6wTBbRZULR05JRtO9WHdEzCQeNpZ/88xzJ/PvcU/7D4xBhFdFztn9zL6KcwJB8HFQBhEQG5vXjIZI+V/zhW8THop5cC8HsA2xsEab3SPH4cyA1nVIFuX2Jc4G9I4yJqPfxuhx7/JdqKJRAFo98LOneyZ+GObg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 11:53:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Mon, 7 Sep 2026
 11:53:20 +0000
Message-ID: <2030085d-5f14-4bd7-8694-dc8a6a2a25ed@amd.com>
Date: Mon, 7 Sep 2026 13:53:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915: fix incorrect RCU teardown order
To: Tvrtko Ursulin <tursulin@ursulin.net>, jani.nikula@linux.intel.com,
 joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260903113621.54660-1-christian.koenig@amd.com>
 <30c0848e-e8f6-4bb7-8505-89316158c49e@ursulin.net>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <30c0848e-e8f6-4bb7-8505-89316158c49e@ursulin.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0205.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8909:EE_
X-MS-Office365-Filtering-Correlation-Id: ce51e985-50ea-450e-3c5d-08df0cd69c85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ipC0RrQDFhruYc90rZgA0+3teoWvIRX7xrZmr/Dn4o0P+zrtnt6JdzZPwoiUXllZnGUZW11xNc8nOTlovcgjR9/hP89W0m6U2SHU/ixwdyN/YPPv6PfRt9l8wlQ+LtvsShrqQ6wEBezQ4t+9/Qllmj43YI53+22vZ2mHJEqCAZHqynl2NC1uXb7m/+zFMAUPnG1h6ZaBdkW7vNcvDk/+lLkuIAVn0v7QXGpKjj2MkWmn3wYlxF2Ymp63WYVVWVJge8BdoauL5l4U880zP+ZEykVOgxV2/3KzNI7qERUcY5ZqBifHgrakB+tFZQJy6ZV9EG8fXdp83aUU7X7zxkDI+lVUGQ3x4d9SIRiByqm7vMK65sFqQy7NYVeV4fOdUuS9GyTrGb+6MZL4k4Nul4dw1mJxUP8j3Q6tp0foOOeXEeMfbET1AgOkcb6HqGxjqRNcMFnfAKu2PlFi9QwVVd/OwTKXZ8O8/5oRh7PQxLRj1Mq9J+ooyUnWaEXPVHI785YdqwYDQjulu/L6TSMsxOiKSQ0CbjeXeyxfZGjffkJ1TV6/VLQ9c4Ws0j2AJ9iu/GgIOEn2e99qu9q+Rvkjy68HwZ+NoxP+tms3s0D13IoSg10380mZt7BNtNaNMToZvScMQSumT4h3ppqVJWOFuUGK3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzRLcm5VTk94Z1lkbDRPZ1NvTWNITk1lbTFnU0tiZEdLK014OG1odXlINHRP?=
 =?utf-8?B?TjZ6ek1xblZIbzlaejh3ZURQRmw3cEdMcHNPZ3dpMkxtV3hydmUwMFVCVkhI?=
 =?utf-8?B?ZzkxdC81c0lUMjVmTmNJVWdhYmNseDFrb0xHZUxMOTdQa1ZNZWduRlR2M0VS?=
 =?utf-8?B?ZWdCaUF0d0NkL2ZneVdOeTJWeExiZ1JTU083N1lFeUR4RERTTHJDUFk3bTVP?=
 =?utf-8?B?a3dBZ0FIL0I1emNBeVFtSXdpWEw5bUUyTDBHQXRNYWV3TmdLZkFsU1ZjakYx?=
 =?utf-8?B?dy9rdXdQZTdkZjdJYmFsMUkzcXdlU0ZOSmNyZWtvZi9haDFCU0tVOW5ZYVk1?=
 =?utf-8?B?azF1bUd6OWF0Y2FRVTlMWCtxZHZHM1V1Y25rZTA2aC8rUGlTVCtYTHhiNW9D?=
 =?utf-8?B?Qlk3VUV3QnJyeXczZGdnWGFISmRzMmFzek4zaS81bTgzNTBBL2huV0ZUMnpU?=
 =?utf-8?B?S3Z6T096bW50cDJCQjF4bGN0QUpucFRHRndMaDZGZUtaK081ajVlRGxTdnVW?=
 =?utf-8?B?VTg2UjJDbUF3aXRwamhKeHJScUxnT2p3bU5yc3A4TjRqUEFlOVpBZUJLcGlC?=
 =?utf-8?B?SlJLaHp0cWQ5dVJYQytiTDdsa0lXQ0o1eVV3cGxidnlUN2hqWktPTHRDWmtF?=
 =?utf-8?B?RGtjMHd1NUxQb0U4TWc3L0g5Q3lGUzZrbUJZdDh2TEFwTCtDalcwejlCaXFT?=
 =?utf-8?B?eVhLQit4NE9Xc0RrVDAvTHhtOG80aXBVZG5mWVUwVnRBRGdKNm1FV2F4Q0dm?=
 =?utf-8?B?V2hiUkV6V0MxZEIwd2QwRVJZZ2QwcktlTTdwNFo4ZGwrb08yN2RmS2xyQmxW?=
 =?utf-8?B?MUt1WkVhTE1PVm8rSkpOeDl5aEZrS1VkMzhLMkVsWlZsVHEyUzhWSEdxWDVz?=
 =?utf-8?B?dStYQURtWkN2LzJlQzZKdUtuQ2oyUjlIZ3FiSHpiN2pGekVqMmk0YkloTUcv?=
 =?utf-8?B?aFRSWXA5eXZ6cGVlNVNTeUNrNWZyY2w4ZUlEU0U2c2xidzgrcCs0UEFNVWdy?=
 =?utf-8?B?Yzk1VjlQOEd3Wklzc2lQcW9NTnlXSUV3SGlWNFhRQTlTdU16bzRDY3pGYVVs?=
 =?utf-8?B?OG1HRFRQRkZrTU9LOFcycGZNckdEaExhRVJJOEdieFZaZ1NkRkR4S2RyVzdI?=
 =?utf-8?B?VmhlRUdERzI0WjVja3JYcnBpQlE5MnFUWjZ1dlplbC81OG9kL2labWk0NUlO?=
 =?utf-8?B?VzZvUlBFR0RaSFVxL0ZISVhvWmZ5SzFKb29GVHFNc1RtOFp0aHlqNzNENWhC?=
 =?utf-8?B?am5JNEhMTHBuL3pJYVRQOERJSm16dHlBZnpJckovSXdQV1ZjU2dZRTM0NVJI?=
 =?utf-8?B?ZnZxZ093TDJsaXVGN21nVEJmd0kzclJKVC8raEVFTG02UUgxalFFS1VNdzgr?=
 =?utf-8?B?TmZaR2R5bHZDakk3YzFrck16ZE9iSmU5N1g4bGI4eUNUZS95YWNmNmdPdU5q?=
 =?utf-8?B?Qm9nL2toUXRjRHU3aTljQ0RTeGxoN3Bja053L3MyNEpzaTZuU1BhWkt2SHBv?=
 =?utf-8?B?TmdFblVXaXdrUlQzZUJGampyS1Fienc1d0VOazJHUjlKVW9CTTE5aEJMSkt5?=
 =?utf-8?B?S3VnREhmNVd1b1VCSTJkNFhJNzVoQTd5M0UyK01NTTlZNjVsQnBrUGx0cjVx?=
 =?utf-8?B?RGpuQlNIaHdvK0dCekRBNFZtSGxkVjhrci9MdWVLdktaMnhNb29aaW5Pb2hP?=
 =?utf-8?B?ZUdyc0hka251RStwS0NCaWJEenVGVVp6QVhlL3d0bDdoY21yOElMTXRZVjYy?=
 =?utf-8?B?YkdjZmUvZDZ3ZEhVanFDTWN5Q0NBM08yajZVMFByQ2JOWTc1YllnSW1od1Rv?=
 =?utf-8?B?ak56R2hUbktuMFdtSnJsVk9oMHBaOWFFaDZISlZ1b0s5LzBCd0Y2OHE4MHVn?=
 =?utf-8?B?U0pVQlNyU1VIL1Y3SCt1Uk9xSzZpYXVBc2V4eXlCZVo4OWc5bUFwSWdSVmZr?=
 =?utf-8?B?NW1Xb0JNWnpaeE9Pa2xYaUJ1R05QbHlqYy9QUU9rQlc5eWlzUS9xMjNtSFdl?=
 =?utf-8?B?c01HN28vOWZUOHpicEphVHU1dVdmKzFsK2cwWGF5eU5xNUp0Ly9zTkxjUTVH?=
 =?utf-8?B?akxlTWNDeVJKT1FuZ3FiMVQ0MmJaTWRZdGlZWUxNQ3ZmZG9nWVlpKzRoaDg2?=
 =?utf-8?B?Q0gyRjA3Q3hWSUVhWkhHR0xOYUJiM1hKSTc4Y0JIdGp2VWZZSlJxVzlWcUE4?=
 =?utf-8?B?d0ZSRmNOOC9TNW9pYkxyYW1rUXV4RTI5QVlRMUxqMlBhYndrY2lwQlh4Rzdp?=
 =?utf-8?B?dGVOeEQxZlhvM3lYckJzSHNkT0xkVmJvR0ZzSHg3ZGsyNFlPdWlKZ3BRbmhX?=
 =?utf-8?Q?yxj4visqdjDXop44P2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce51e985-50ea-450e-3c5d-08df0cd69c85
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 11:53:19.9720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: axL3ZG9b/A2N7+91MgHNVE6EsHthGmbxq+XU/dwZfvXqr5vhAMPD/eI8fCiHDdN9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8909
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

On 9/7/26 11:54, Tvrtko Ursulin wrote:
> 
> On 03/09/2026 12:36, Christian König wrote:
>> i915_gem_busy_ioctl uses dma_resv_for_each_fence_unlocked() to iterate
>> over the fences in an GEM object without holding a reference but only
>> the RCU read side lock.
>>
>> What can happen here is that the GEM object is destroyed concurrently
>> while i915_gem_busy_ioctl is still running. This won't free the GEM
>> objects memory, but still drops all the dma_fence references.
>>
>> Now when dma_resv_for_each_fence_unlocked() sees a destroyed dma_fence it
>> assumes that a new fence list was installed and re-starts the loop.
>>
>> But in the case of a destroyed GEM object a new fence list is never
>> installed, only the old one freed and therefore the iteration never
>> finishes resulting in an endless loop.
> 
> Only i915_busy can get into this failure mode? None of the other users of the iterator?

Yes, at least as far as I can see.

The problem is completely i915 specific because it is the only driver (I could find) which protects GEM objects by RCU.

> Also, the reference counting series makes the fix irrelevant?

No, that series just helped uncover the issue.

Sashiko-bot correctly complained that i915 is dropping the new dma-resv reference to early resulting in potential use after free. And I was thinking wait a second when the dma_resv_fini() is called to early in the existing code then the dma_fence references are dropped to early as well... so that is an pre-existing bug.

Before the commit mentioned in the fixes tag the i915_gem_busy_ioctl() could just return nonsense, but after that change it could result in an endless loop and that is problematic.

Regards,
Christian.

> 
> Regards,
> 
> Tvrtko
> 
>>
>> The solution is to drop the fence references only after the RCU grace
>> period.
>>
>> The fixes tag is not necessary the patch introducing the problem, but the
>> one making it so worse that we need to address it.
>>
>> This problem was pointed out by Sashiko-bot.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> Fixes: 912ff2ebd695 ("drm/i915: use the new iterator in i915_gem_busy_ioctl v2")
>> CC: stable@vger.kernel.org
>> ---
>>   drivers/gpu/drm/i915/gem/i915_gem_object.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.c b/drivers/gpu/drm/i915/gem/i915_gem_object.c
>> index 5172d3982654..9e01f8b2079a 100644
>> --- a/drivers/gpu/drm/i915/gem/i915_gem_object.c
>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_object.c
>> @@ -89,6 +89,7 @@ struct drm_i915_gem_object *i915_gem_object_alloc(void)
>>     void i915_gem_object_free(struct drm_i915_gem_object *obj)
>>   {
>> +    dma_resv_fini(&obj->base._resv);
>>       return kmem_cache_free(slab_objects, obj);
>>   }
>>   @@ -144,7 +145,6 @@ void __i915_gem_object_fini(struct drm_i915_gem_object *obj)
>>   {
>>       mutex_destroy(&obj->mm.get_page.lock);
>>       mutex_destroy(&obj->mm.get_dma_page.lock);
>> -    dma_resv_fini(&obj->base._resv);
>>   }
>>     /**
> 

