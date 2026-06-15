Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2448CD98DE
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 12:43:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04A7010E3E7;
	Mon, 15 Jun 2026 12:43:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IkMi0cpW";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E36FD10E3E7;
 Mon, 15 Jun 2026 12:43:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQ1R5Hj3JZXzqsOI8EHGnjL+HA/TkrrFbgPwTzxcMuhGnPmCqCXH4CdAWw9iZESmiLRjZf1FepwrMoSs3lSgoPBTKjQ3lSKguGftOlVxYo3WWBT5EwIZ90XXAIcXheQKnldMsl+ZEItX+JtVbI93+LrP51NcMUkepvy6lDuuhFTBR9XRPWwkRbVEzTjVvkCUhsS7f0jgpgLMHnZHajIDnrEb2ncJ3xxA4GFHBHhsymndoeo5npfIF900W7BCsIaVPCdIdVGxBRX83j9SusSTLWrvcGqX+1OUjzH0Lq2I1eQAqLYiYbxpdXgIuzj0ISfU14fC+bCMO0pznxnT4EnaMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sqha64RvhoRlkXB3WFmGT4j3L3d1vHeDBsOFuQjm2Zk=;
 b=J+5GJQGBcpvNXA7S59IkTfqO1XL7ytHVc1/df2aRzESidYvMR1YE/6I9DENnduHvI8EBG9EHIAQbOc45SZ0cZgSfUIFBUVm7Jmaj49wXVk4DuTPHQboWmYyBAUfurTlXaxN6uB4Y0AA1nLqBctt4YmStzPlGC5kGq2SLqM6fUKpV6lKB0JeaOJcIHP/Z4mCBuxJePtHTLGc6j4HhpVWh+hpdahN0BhsaO97N8vgs3GtuZ9mAX2SCGkwCGBn13o3diP2DtPjNmeOzvd8gByKoG/yl1VXIvTVoklOCnYP7qw8Ck2DaK2qAwOZY7JleqM2DZ257BgEGwEeNg4OatGZVTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sqha64RvhoRlkXB3WFmGT4j3L3d1vHeDBsOFuQjm2Zk=;
 b=IkMi0cpWRAXUFszuCQDR6UCl6e6ZtwLmNnoDwMoBxg+anddexYa88i3dyvDM/T+2Gzs9J+dXvYuEJAxEBpELEYN7NyqkYWyxQr5+mV4CEN3tS9WZ4LJ1DUKyVcEpQu+eaKAspUj3LHt9oEm68ynD9jsa/zSXkR2uygYlTTnXROk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB8021.namprd12.prod.outlook.com (2603:10b6:806:305::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 15 Jun
 2026 12:43:09 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Mon, 15 Jun 2026
 12:43:09 +0000
Message-ID: <c946b8ac-77c2-4366-8d73-938f4b2277ff@amd.com>
Date: Mon, 15 Jun 2026 14:43:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/18] drm/amdgpu: add SVM core header and VM
 integration
To: "Huang, Honglei" <honghuan@amd.com>, Huang Rui <ray.huang@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Matthew Brost <matthew.brost@intel.com>
Cc: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Jenny Liu <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>,
 Yiru Ma <yiru.ma@amd.com>, Simona Vetter <simona@ffwll.ch>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260612090928.29682-1-ray.huang@amd.com>
 <20260612090928.29682-3-ray.huang@amd.com>
 <889e580d-5ecc-4bed-b1b1-a5693692cf79@amd.com>
 <03e6e547-3c03-446e-91e7-da5b043344ea@amd.com>
 <e8ecc15d-63f2-4bd2-9fb0-1d800498c1f5@amd.com>
 <a9e22971-ec11-4b9c-937c-30d202019f1e@amd.com>
 <81ead8f8-ffa8-4f92-89ef-b016d141b371@amd.com>
 <46c13593-b5e2-4b05-9c81-34d33ebb7bb3@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <46c13593-b5e2-4b05-9c81-34d33ebb7bb3@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0598.namprd03.prod.outlook.com
 (2603:10b6:408:10d::33) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB8021:EE_
X-MS-Office365-Filtering-Correlation-Id: ae127864-aa5a-4bb6-09ef-08decadba74f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|11063799006|56012099006|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: ogRebryVgqZnFvbZDJW7RB5ecSvweLO/1Z+LEVkMcmXKU2ZY0hroA5Nqx/HzvW6c5l/o77R6rLuq5PT5MI48RLxb5GVvBY7vyo5D0yxyz7k2488mKKpn7o3/J7MINFSxje1l1gxluzLYGXcQp3yPXLGTCdWv4juRbaJOk2/bmPk1x3eiXJwJ3hbBAmRKrPRiaDl5NMwW9z1mURwzwiZqkg2W+PBXfRh3p0YVP3Y6jo0pOfheWR/HnuOaAJpP7xj5JNBps5WX8yNSPSf66g3oEuWFjearLzw6bpLMzR0RNDMl0QSIf7AcieiBNRYX12KajGHGrDn+u8mRf4YWYSxeH2z81G23Wn8jNCsyUKsfV5/jH+WFhRfYgd3o/QpigrxKS3u5gBXwtk6o5HJ9QMcO9aiC6r+gfBG9WP5ok+qRqnnc01ON3fYyhPzTlOO0x4Tw6Oa3a9OmYO8iX6xllS6RlWZZLYjtjlTc576Bu/nRWpbqltKP9IcQFeYF9Axnk/9E1XmrSVsP9kkagzg+1WAINgIkDbqGnnTGED8GNIUpNFj4LC07TQC43UauoniWvnDUnIGdHoq12QsnAndhp275M0+nX3iY1dAhcqP97/gK21b0ZODQERsijpHiy3K9l3XL8RrlCqYsOCCCgnA8Ely+1BPTZyW49z7EnMYqcKSWpOpWeGCIqcTGcLZHnhFvL9qo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(11063799006)(56012099006)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnRrWWZaYkxMVE9YYlMwOGlUUElmYk9nd0JMUkViZnFTKzZkVDJLdTZhWWIy?=
 =?utf-8?B?eStnQ1EvWWFnN095dVloUElXeEh1VjdoYUV3NExQeGR4OEkzZXJjSmt3ZHpS?=
 =?utf-8?B?NzlrajAydTYzWTlHNDkzdVQvWEhJRTJZZXNvWlhSYkd6QVpVeWpNc1FUY0RS?=
 =?utf-8?B?V0c1OUYyRjcxak9tVVZ6MDRhd1VNZSswZlBuaTZlajlzYld1eUlKbDhyY2Q2?=
 =?utf-8?B?L05GUDJNS3pNNjZvVW0zSC9xT3Z0a09LQ1RydnVVVDhGVjZIVC9SVldMTnB4?=
 =?utf-8?B?amRqM2ZESHZrSnRCdGdGTUo0M1d0NjljVG50ZjJ6UCtmNDVZWE5BZzUya1Fj?=
 =?utf-8?B?KzJtdDZJUVZ6QlFiRmRrZmFPeVNqY3lvcWlJU2NNQXIvaE9NQTNnamRRZWZm?=
 =?utf-8?B?K3hIRnllTlFaei94VXVlc3ViZHN1Z2sxSUlzS2RTQk5jZmdPb0RKVVpmVVpx?=
 =?utf-8?B?M0Q2aXFMKytLSkxtM0FlZGhWZGU4VFpjUFdGSnMyRnFwZzdnT1NxT2hQc0xk?=
 =?utf-8?B?RGkrOGhEb2NyRjd1aHBMQVZQMHZnbktaMVRpNXF4ck9Db3ZqdU91bWdvOGVa?=
 =?utf-8?B?QmhNUTBORHVYRmtRSjdQZ2EyUC9Wem1qNkxLVlZodE9XdXNtSUNaWjFTTXow?=
 =?utf-8?B?cG1GdTZnUVhIc1pUV2F1WVM5bm9TRnhqSnowbU9OVFlWYmhLTnVYTEJuTVMr?=
 =?utf-8?B?SUtrdFBXR1FGemNRSFhvOFFoNGo4Rk9oL1hTdFgxSW1Tc2Zka05ZUFU5K0dQ?=
 =?utf-8?B?dURuQitaWFJnVDBLQm9rMUN6MlpOaXlIN3Z5NkZqWGdCbmtNNjVsV1dDS0hI?=
 =?utf-8?B?NUdOQTVabjlnQ25WcmtqUGVaOENjR2p6cy91cUsyR0JXL015S0VrejMwRUVo?=
 =?utf-8?B?dmFJQmRwdkd0RlFSWHRTTnJURlpvd2RRMTcrUmVPcnVsL0hIc0lZWVkwUEJX?=
 =?utf-8?B?bVdNdGRpTDhVc3BJZEVwSkZNS0gvcUV1THJ2UVNDYUQ0cXhzNFB0VVV2aFVh?=
 =?utf-8?B?MS9pWmRWY2pFdFh3UHBCZ0hLVElOM2Y5OEdkUWVoa0tKUVB6cnhXMkxQeWI3?=
 =?utf-8?B?RVA0MlBzMUxSb3RTUUVDMmM0UEZJWnk2N2FFcTMzbDdEWExhVkk5TXMxMkxu?=
 =?utf-8?B?eGIrUXFKZTJIaXVJZmFtcGkxTmFwWkxGRlBNOFhlcEtDM0FoNzZFM1VzbXlZ?=
 =?utf-8?B?S0pyOXZHWmRrai9JdUhlK1VSMFlUL0NMUFZXMXY4ODV5U29CS2d2VUNXb2po?=
 =?utf-8?B?d1JYNlQyZ3JxRnR3ektqbW5kWS9YK3FpM2h1V1R4QXlGK1UwM3AvNCtCTTlt?=
 =?utf-8?B?eDJjR1Z6VVdpSHhMMWNWTVRJR0hoQzQ3dm9wbnVvRkkwVlc2MWRMRHp4TUxM?=
 =?utf-8?B?Wm1yYTRsZDRIK3RBQW5ZV0xEYzFvZ3IvOUVBL3E1eER1ZFJKdmRIQ2EyNVJt?=
 =?utf-8?B?V3hqNy9jT2dqbGkvQm1hcWkvUkk1azJDdmNDL2tZNElWTDBwTlkweGJaOUcv?=
 =?utf-8?B?WmJkckIyMWp1ZndnMlFwdDhldDhNQlkyVDBQQTZSVEliZnAxWE1sa0hKdTB1?=
 =?utf-8?B?VXYvNjZlTmJMS05XWnkzUkhQMHFPMUlFNEJPMk1QdkRGTU9mWkxQRnhsR1RE?=
 =?utf-8?B?V3Nrc1gyQlBHQzExWUNGY3RwczMzT1lPWHNkcnlhZHdkbi9DNjdPR1VMSWkx?=
 =?utf-8?B?L0F4dklPZ1BPTkZDN3N6YmJoZkJXUm5uOWRoZXp5VEhpRkdKbFdKMHpVbG9w?=
 =?utf-8?B?YldwR0xIaTFvK3VhVVhlNmYvUXpsNVkvQzBEWVF5bFZRM1pObG1VM2M2REtN?=
 =?utf-8?B?N1RqUk16d0VLOWUzTGoxY2pBMEFDVW5JR05uZWZPRjFabG96SEJFbXZLUlph?=
 =?utf-8?B?Rmh2Ti9tekttanNpSkkzdWpMN0pRZVdxK3BsR2NtcG5tMEpzbHo1dWJjNEc1?=
 =?utf-8?B?WWlDVG5YZ3dpemI1OFRkSjMwSkdheVdwQU00alV4b1VuamhnZnoyOFdER1Nx?=
 =?utf-8?B?cFA1NFdyR1dHUXg5TGovSVo1d29jbFZZUXltMXAzYVlweWJNVFdlcngxWmdr?=
 =?utf-8?B?MGE0TFJkQk1NUmpUNm1VTnMxbUdsMlp6bHBVaVhpYXg4cXFBV3N2NVpPR3FO?=
 =?utf-8?B?c2taRmQxZWQvNUx0ZGhjb2JvRUVDQ0xZakZVdjdlMmloWnlxY1B2eUdLcmFK?=
 =?utf-8?B?dnpIRDI3ZHdNbTFqTU9kZ0RZV1pZR0J4ZmZQTFJBZldmWEFKcWsySk0zVUVy?=
 =?utf-8?B?ZEdNSG5BSzZwZzFqRm1kSzRWRWVXalZhUjRLZ3BWeXJpWjQ2K1I5anFNQ3p5?=
 =?utf-8?Q?Ca8uLr6V5y+LR/eoRH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae127864-aa5a-4bb6-09ef-08decadba74f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 12:43:08.8990 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UlFYJNgoF39KwVlWvTKHO2ldh9UoS5ce8G4vRIWEMGN4vYW2gtSPyFB9+yV6yrCp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8021
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

On 6/15/26 14:31, Huang, Honglei wrote:
> On 6/15/2026 7:49 PM, Christian König wrote:
>> On 6/15/26 11:36, Huang, Honglei wrote:
>>>
>>>
>>> On 6/15/2026 4:08 PM, Christian König wrote:
>>>> On 6/12/26 15:20, Huang, Honglei wrote:
>>>>> On 6/12/2026 8:02 PM, Christian König wrote:
>>>>>> On 6/12/26 11:09, Huang Rui wrote:
>>>>>>> From: Honglei Huang <honghuan@amd.com>
>>>> ...
>>>>>>> +static inline void amdgpu_svm_assert_locked(struct amdgpu_svm *svm)
>>>>>>> +{
>>>>>>> +    lockdep_assert_held_write(&svm->svm_lock);
>>>>>>> +}
>>>>>>
>>>>>> What exactly is that lock protecting?
>>>>>>
>>>>>
>>>>> this lock is the driver_svm_lock required by the drm_gpusvm framework
>>>>> It is registered by drm_gpusvm_driver_set_lock(), and drm_gpusvm lockdep asserts it on every structural entry point, e.g.
>>>>> drm_gpusvm_range_find_or_insert() / drm_gpusvm_range_remove().
>>>>>
>>>>> Per amdgpu_svm it serializes the write/commit side against the fault
>>>>> handler: range/notifier tree insert+remove, attribute changes, and the
>>>>> garbage collector.
>>>>>
>>>>> This is the same thing xe does, in drivers/gpu/drm/xe/xe_svm.c:
>>>>>
>>>>> drm_gpusvm_driver_set_lock(&vm->svm.gpusvm, &vm->lock);
>>>>
>>>> This is clearly incorrect in that case. Our equivalent in amdgpu is vm->eviction_lock.
>>>>
>>>> That was already completely incorrect in the old KFD implementation, please don't use that one as blueprint.
>>>
>>> I really want to use vm->eviction_lock as SVM primary lock,
>>> but it seems like in Xe, Xe uses vm->lock as an outer VM lock by design rwsem instead of mutex lock to broad VM ownership, not an eviction lock, they are semantically different.
>>
>> No, they are actually identical in the handling.
>>
>>>
>>> I tried to replace the svm lock with eviction lock locally, ABBA dead lock encountered:
>>>
>>> amdgpu_svm_handle_fault
>>>    amdgpu_svm_lock (A: eviction_lock)
>>
>> That's nonsense. This lock can only be grabbed while updating the mapping range.
>>
>>>      fault_map_range
>>>        amdgpu_svm_range_update_mapping
>>>               drm_gpusvm_notifier_lock (B)
>>>
>>>
>>> drm_gpusvm_notifier_invalidate
>>>     down_write(B - notifier_lock)
>>
>> Same here. You simply can't call the VM code with the lock held.
>>
>> The VM code itself must take it as appropriate.
> 
> 
> I think the core gap is what exactly does SVM lock (drm_gpusvm_driver_set_lock) do in the framework
> 
> I checked xe svm, in xe_svm.c:1209:__xe_svm_handle_pagefault() the very first thing is:
> 
> lockdep_assert_held_write(&vm->lock);
> 
> The lock is already held on entry and stays held across the entire fault progress:
> 
> xe_svm_garbage_collector(vm)
> xe_svm_range_find_or_insert(...)
> xe_svm_alloc_vram(...) (possible migration)
> xe_svm_range_get_pages(...)
> xe_vm_range_rebind(...) (the actual bind)
> 
> they are not grabbed while updating the mapping range.
> 
> And the drm_gpusvm framework itself requires the driver lock to be held at the structural entry points:
> 
> 
> drm_gpusvm_range_find_or_insert()
>     ...
>     drm_gpusvm_driver_lock_held(gpusvm);
>     ...
> 
> drm_gpusvm_range_remove()
>     ...
>     drm_gpusvm_driver_lock_held(gpusvm);
>     ...
> 
> The garbage collector and unmap paths hold the same lock in write mode:
> 
> xe_svm_garbage_collector()
>     ...
>     lockdep_assert_held_write(&vm->lock);
>     ...
>     __xe_svm_garbage_collector
>     ...
> 
> xe_svm_unmap_address_range
>     
>     ...
>     lockdep_assert_held_write
>     __xe_svm_garbage_collector
>     drm_gpusvm_range_put
>     ...
> 
> These codes indicate that this lock needs to be held on the outer layer to protect the data structure of SVM, rather than just during GPU mapping.

In that case that is a major bug in the drm_svm handling. The lock *must* be held only during GPU mapping and all other data structures lifetime handled by reference counting.

That is a core requirement of the SVM handling because you can't allocate much memory in the MMU notifier and so you also can't allocate memory under that lock when it is held in the MMU notifier.

Regards,
Christian.

> 
> Making eviction lock the main lock of SVM will indeed block the functionality of SVM and also violate the design philosophyof drmgpu svm
> as far as I ca see, at least I can not make the SVM functional under this conditions.
> 
> I am not a expert of drmgpu svm, how about ask maintainer of drmgpu svm
> to ask how to use the drm_gpusvm_driver_set_lock, and can eviction lock be used for drm_gpusvm_driver_set_lock.
> 
> Regards,
> Honglei
> 
> 
>>
>> Regards,
>> Christian.
>>
>>>        amdgpu_svm_invalidate
>>>           amdgpu_svm_range_invalidate
>>>              amdgpu_svm_range_notifier_event_begin
>>>                amdgpu_svm_range_zap_ptes
>>>                  amdgpu_vm_update_range
>>>                     amdgpu_vm_eviction_lock (A: eviction_lock)
>>>
>>>
>>> the current SVM side can switch its registered driver lock at any time easily as you wish, but doing so safely is not just an amdgpu SVM local change.
>>>
>>> The issue is that change lock / change lock registration is easy, while lock semantics are not. SVM execution paths like fault handling, invalidation, mapping updates, garbage collection, notifier callbacks... are coupled with VM locking and update flows follow the xe svm style. If we switch SVM to a different VM lock now, we can introduce lock recursion, ABBA lock...
>>>
>>> SVM can technically switch lock registration now.
>>> But make all stack works and pass all tests maybe needs amdgpu VM refactoring.
>>>
>>> Regards,
>>> Honglei
>>>
>>>
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>
>>
> 

