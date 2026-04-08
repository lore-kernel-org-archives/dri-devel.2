Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63CE7FD5F87
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 08:28:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B252F10E582;
	Wed,  8 Apr 2026 08:28:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IsYBrXry";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010033.outbound.protection.outlook.com [52.101.61.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E10B710E57B;
 Wed,  8 Apr 2026 08:28:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCy1r306+SXJC774sXk3/iNiHxkyEDjN2x1hUAEPc2kAALD5+VUfmOL5VayMo2o3AKA2m/LOH5XQZOV0O1LX9IzCPlCtceurLbz7mvQ+El8DRRpZxfJFFPWtCCa4g++KcrFXPWMrUtM5sZVFCJ/boIVwlXWrZtuYSK006k5Vh0eoOZoz/Td1TVldNsOqKZcBo/kD7KkB0NqZci8cP0sj/U8F5nuEqLpVLOhFICHjA3oHj65mW5G3JFOwIFVO18MTatFOPCtdKTKM5aCv5vCmYh/UWFESCwDM1mpxoxXoQ3vBzXTA4h9hz2kOqQi9Lj2BLgFpeEOIM+5dQIKHDi9spg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PAgOfATeiEUHaxhEaivKlYO0kMjkNBHAatKiag6s4w=;
 b=mSETbvKAspzqSrSg1Y1pNqU+jQXEKvI4sDQZ+YkOI+DGwPUPOS/zL6PUEhNjXBM2t8vxRLQH7YRa4JFVQ+2O9YYAWsO4FKgzhQQ9xABFFuUGshBuFMpSxGoVpzFrveVe7vBSujmYb3dQvEzvvlT7Inr4ThZgI7WsNVR86xpwGhZWX+0mT9eIQwBJ/4/KKFDg+Evj2z2BsAWnsVKV2mR0h1HMf3tmmV8A5tzPhjzH3AeRM+hFlonZXTfNKX4ie5JVAHo8X1ddkcxENome0U4ogSUWVREr1t5Rph1+yYqkTcQ1AltiAmc8tqY2sbsu6HKKi0kgaVjY9smxdS7fGI7Rpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PAgOfATeiEUHaxhEaivKlYO0kMjkNBHAatKiag6s4w=;
 b=IsYBrXryjpOJcpE7OGqLkJ5rZJq59z2l6c3V+GKI4Ov2btoPLUkzoKa4/3oQLOlCbMp/znY9L4cK55Sv8vewnCS/U4jGH0es5L023gjYvhI3sispPTBJUgzW392qH9HfNwotVXQv3+Q5GqBzrM8mmPVdhnuycHW2oBRGVPBOOW0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA0PR12MB7479.namprd12.prod.outlook.com (2603:10b6:806:24b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 08:28:49 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 08:28:49 +0000
Message-ID: <5a72b57e-8e5e-4769-b36f-f7d7f585605b@amd.com>
Date: Wed, 8 Apr 2026 10:28:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/7] drm/amdgpu: give ttm entities access to all the
 sdma scheds
To: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260403083602.1771-1-pierre-eric.pelloux-prayer@amd.com>
 <20260403083602.1771-4-pierre-eric.pelloux-prayer@amd.com>
 <c9123064-413d-4cf3-b39f-5268cedcf92d@amd.com>
 <cb980ffb-1180-4613-a801-6e8bed5d669c@damsy.net>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <cb980ffb-1180-4613-a801-6e8bed5d669c@damsy.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA0PR12MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: 61518612-4da2-4cf7-e863-08de9548dbc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: sFplFCPmU37QlPkp2/yRceNweroIXeHVnIeP3zOuSNNaIfynp3va6Ghkqu2adRbh7enJSwNnLWZG7M6RzpSI8GJoTBmPTbxY702ueL0m6fnk2o5eOObp42om+/LJ/whGZHi8rlyXODsnVTxgc97pCXxayyFVHsYOb6OEjae7YBOtvRTH/BTkPJKH+uDzDmENE0UPiEj/8k3WupLq/IrT52zB1qPy2ffUDtZtXpB/wAi5spcTSmueG7HGxF3qqtuBoik7nMynTCPHHFMFj7opZiQHaF6HwviXkiOPrBMbJW71J1lzfJMvCMxBwe4vlFrOtppfnz3lGPFiVvxSChx0NsrnfrnA3UIkDNmMemUSs1p8ekkxhAm7bCEMuZtb51uhX0Cfa8iqXbZ3berMmwqjJGd+TnydMRBYlGIHqIzARSWGJAhV3ySg0BBh+eOIDE1q5MzLmUQENvYKfn8ImCvPmaZHzvmOBcSHQ15fSFMfb2Er73Bt99fge4F5X0CnpZ+nfgIHj4kMEGXFNo8EF88gyZrA3NPDE1LYXvD/D9IqnW9tauyjcw5vdRNScN4mkPPsQbqGeNj9ZDLDzlrkT2LbUrLTbFGeiM9ys1nSGo6Mq5s0IO5+eO+9978Uz62aQEiXMQunvk5g6UtuQSbtcxCpddco4Tftn8OhMyrQ2mQi1uJMbi3brZJdTEVa4+PA+CTwKmgPGSLVBOJJgno2qk0noEQXcx/YFq9+MI/mHfDABmY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXRVaC9wNjFxNEtuV0orVFR0NnN1UUhYbXp6UkVoVUFJc0dCYUFnWEdUOEk5?=
 =?utf-8?B?RnZIeStJSmx3TExsQy9CUThrSS90WlY2RnNjRzBMS1VQNzBuZlBIc3E3YVJa?=
 =?utf-8?B?Q2VzSk9mMjZIN0pXSkE1QTNFM2NuaWNNYVd4MHBkcE50Q2RacDFnMkZMSXhv?=
 =?utf-8?B?TG1WejVWcllMWmNBOEJZOVBvTVFwS2xBZ01jVnd5Mzl4cWtTWGVIb05naFE0?=
 =?utf-8?B?aTRFSTU0VGl1Tmw0aFRia0lXQklrTXFKMXZLYVNEUmxxZmRTMDNVTnZZQVUy?=
 =?utf-8?B?Z1JJdzNkMWNTYy9BWHVTZVhYemprY2Q0Z09sNTduTWJ3NzhSL0paNmpibitP?=
 =?utf-8?B?ZXZlZVg0R2c1bHVzcjdTZ0pWQlhORnhxQS9PRFUrUk9PTFpVRTc1cGo4MG84?=
 =?utf-8?B?QlFKM051N25Hak9rNGpUVFFmVmg2akdPOWFCbGF2bHNSd0pEN0RzWkxOOUYw?=
 =?utf-8?B?RjY4bDYreTF3Mjk2WUdwMXRGSDZIZjB1YVN6S2dQQjI1cUQ2OXFtOXl4Q2lD?=
 =?utf-8?B?OUxMZURTSDBTa3hxOFVrQXp4cFpPUitUeTAxM1drYnJRcENHNGdsVForMENy?=
 =?utf-8?B?S09iN3RjamRRUC9aQ0JsbFNEQmFDcTd5YXdUWnpNZkNWcXpaQkRoUVoyVC9W?=
 =?utf-8?B?dlVkL3FIR2tQZkZDOThYcEZqSDBENnBZL2xyZXVaN1gwdkJCcXNBbGZwSXJj?=
 =?utf-8?B?RHlYUHJEVlBFeDl1clU5eWJ6dGcxc2NRbXJoUlhlSWJENnFnNHI4c0djdXhX?=
 =?utf-8?B?Z0IwbGJjODVwLytlSUw0Z1VTZGxZblQzbm5QcHZzeGJDNHVpZFdGZTFrSGxn?=
 =?utf-8?B?UGZ0Vmd3dG12LzBlZmFVaWVPTmJENmkzcHV3bDRiaU54dDBXYjNxMnB2VVd6?=
 =?utf-8?B?SFdtVE5jYzRCRlhBc0lnNG1yRFVUR2pocklPaFBuV3V5VnFvTjBGYVVpN2ZD?=
 =?utf-8?B?S0gyc1JRMDMzdlBCNDJKVEN3OEFxd3pJd3VUa0N0eWhCM0pUMytyTVJROEFY?=
 =?utf-8?B?OHdzSENyTU0rQWhyWjVwS2QxcW5EazRuR0tiakc2S2MzY00zM1g3SXh0QUFQ?=
 =?utf-8?B?MkkzVE5nTHJGTEFuM2YzS005OSt6enBUZWdYWmpSaVdQemoxS1dQbTJ4bUtv?=
 =?utf-8?B?WlpIYnB2TklnMU9TbVNHNnF6MWkwVHJVSGVGL2Yrdk52cUJBWVM2L25nSm9R?=
 =?utf-8?B?dEZOenMvK21uNEJwc2J4c0lvSU5ONXBjbFVzbG50OFp6aEVFR0J1SXU3NFdu?=
 =?utf-8?B?L0c2bDNwY1F0MWlJZmZjSEZUNTM5eTJZSVNnVTZDaE5uenJrb1JHKzl6dWk4?=
 =?utf-8?B?c0kzYjRDRXg3ZUJLVDEvU2tzYitzNkxHWmN5YUQyZ0VXcksxVWRPTXMzRFl3?=
 =?utf-8?B?amszYmRDelVwenJ1eFcyWVE0RUpHeElxc1VzNllaWER5clpCbWJlMkxvL2JW?=
 =?utf-8?B?VVRJUFFLNi9oVDZHT1pCQmVWWTBNQ2ppbGZTbm5MZnhDa09WNlBURDFQSjZ6?=
 =?utf-8?B?aHBjdWFaSFhRMWFFQURnVGtpMDMxSnNhR3FMRkVoVWNmYXgvTkdKUXdiVkxn?=
 =?utf-8?B?OVdOU21TMmx5YWU5QVBhU3M2RktEOUx1WFpMd051WWQ1TlpKWnNpUlZjaVlZ?=
 =?utf-8?B?WmFlbTVZMXVTNmU3S0xPZTQwejlVTEtuY2VFUW1Va0RnWlM5NUJLOXJMNlFI?=
 =?utf-8?B?TmNaWG52dm13Z3NSUkxRNDBWTzhWcHpINFcvaGwxT2JvT3ZDaWJUTlo5M3RH?=
 =?utf-8?B?WWx1MU00NnltY3Nnc3BtMGRwTUJqd0NTMDcyY0w3RG1YWTJPRyt3ZnA0bE5F?=
 =?utf-8?B?SGtjblR2dEJKZ3FwVnczSmVwaFUxRjJGQnc0Q3c4NjVaYU9MQjNaQzZYWGQw?=
 =?utf-8?B?L2VjRnZYbWZDL0Y3TngzdnovemdkbTZzSk5tRG5LL3FnNEtrRWVMenBTSHAr?=
 =?utf-8?B?eHcwTjk5bUdUU2VCZ3c0ZzlkNENnN0MvUkxDYy9QMVRucjlNelN2a0lia2pp?=
 =?utf-8?B?ajdCN1luOWRyYTNqQkFKZDgrVGsyVnBJVnRBbU1ZZTB6L0lFNUh3a0JNUHE1?=
 =?utf-8?B?NFdKZE51akoyRjVURG9vdXNnVjNjZlRTeDgzcjFOd2JNbll0dzBPRFVTNGk3?=
 =?utf-8?B?ZC9pT3JyMkFrbU84NHFWM1FXM2VOTko2RFp3cWZQUk1NQmUwZ2F0aGtPbnJa?=
 =?utf-8?B?aXI1WGpESlM2NlNQQUtWK25TcHNYQ3Nhc1hubHFJaW1sYnIxQ0Y3VjFDT2ox?=
 =?utf-8?B?Rk9yVDA4bnV2aTBEOXU1aHUyNGhHemdUWU9lWDc1bUc3NVhMUmJNMmZMTlBV?=
 =?utf-8?Q?PZkJhZwuJdfAVSsbk5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61518612-4da2-4cf7-e863-08de9548dbc1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 08:28:49.3352 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hu4uryhXCrLpdn7AXJiaiU7ifTkyY5TBtwrujLBM1rZnxxVT9GwJbRIo02R0REvj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7479
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

On 4/8/26 10:26, Pierre-Eric Pelloux-Prayer wrote:
> 
> 
> Le 07/04/2026 à 12:05, Christian König a écrit :
>> On 4/3/26 10:35, Pierre-Eric Pelloux-Prayer wrote:
>>> With this change we now have as many clear and move entities as we
>>> have sdma engines (limited to TTM_NUM_MOVE_FENCES).
>>>
>>> To enable load-balancing this patch gives access to all sdma
>>> schedulers to all entities.
>>>
>>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 16 +++++++++-------
>>>   1 file changed, 9 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> index 83f6d00dc3a0..648ad344e89c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> @@ -2349,8 +2349,6 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
>>>           return;
>>>         if (enable) {
>>> -        struct drm_gpu_scheduler *sched;
>>> -
>>>           if (!adev->mman.num_buffer_funcs_scheds) {
>>>               dev_warn(adev->dev, "Not enabling DMA transfers for in kernel use");
>>>               return;
>>> @@ -2358,11 +2356,10 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
>>>             num_clear_entities = MIN(adev->mman.num_buffer_funcs_scheds, TTM_NUM_MOVE_FENCES);
>>>           num_move_entities = MIN(adev->mman.num_buffer_funcs_scheds, TTM_NUM_MOVE_FENCES);
>>> -        sched = adev->mman.buffer_funcs_scheds[0];
>>>           r = amdgpu_ttm_buffer_entity_init(&adev->mman.gtt_mgr,
>>>                             &adev->mman.default_entity,
>>>                             DRM_SCHED_PRIORITY_KERNEL,
>>> -                          &sched, 1, 0);
>>> +                          adev->mman.buffer_funcs_scheds, 1, 0);
>>
>> Why still giving num_schedulers as 1 here???
>>
> 
> Because I think multiple schedulers aren't useful for this entity. But if you prefer I can pass all available schedulers to all ttm entities (in which case I'd remove the parameters from amdgpu_ttm_buffer_entity_init).

Ah! Yeah that makes sense, but please add a comment why we do that.

I completely missed that this is for the default_entity.

Regards,
Christian.

> 
>>>           if (r < 0) {
>>>               dev_err(adev->dev,
>>>                   "Failed setting up TTM entity (%d)\n", r);
>>> @@ -2380,8 +2377,11 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
>>>             for (i = 0; i < num_clear_entities; i++) {
>>>               r = amdgpu_ttm_buffer_entity_init(
>>> -                &adev->mman.gtt_mgr, &adev->mman.clear_entities[i],
>>> -                DRM_SCHED_PRIORITY_NORMAL, &sched, 1, 1);
>>> +                &adev->mman.gtt_mgr,
>>> +                &adev->mman.clear_entities[i],
>>> +                DRM_SCHED_PRIORITY_NORMAL,
>>
>> That should be DRM_SCHED_PRIORITY_KERNEL, same below.
> 
> OK, will update in v6.
> 
> Thanks,
> Pierre-Eric
> 
> 
>>
>> Regards,
>> Christian.
>>
>>> +                adev->mman.buffer_funcs_scheds,
>>> +                adev->mman.num_buffer_funcs_scheds, 1);
>>>                 if (r < 0) {
>>>                   for (j = 0; j < i; j++)
>>> @@ -2400,7 +2400,9 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
>>>               r = amdgpu_ttm_buffer_entity_init(
>>>                   &adev->mman.gtt_mgr,
>>>                   &adev->mman.move_entities[i],
>>> -                DRM_SCHED_PRIORITY_NORMAL, &sched, 1, 2);
>>> +                DRM_SCHED_PRIORITY_NORMAL,
>>> +                adev->mman.buffer_funcs_scheds,
>>> +                adev->mman.num_buffer_funcs_scheds, 2);
>>>                 if (r < 0) {
>>>                   for (j = 0; j < i; j++)

