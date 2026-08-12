Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C990CC5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 08:36:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDCBF10EEC7;
	Wed, 12 Aug 2026 08:36:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="34cuFYb0";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011052.outbound.protection.outlook.com [40.107.208.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 739E510EEC7;
 Wed, 12 Aug 2026 08:36:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U78ytsxwRt3dnri1eG9xV09fIhP/S/scd4zgyF1U6q2C7/2D8JUh5Nqm5UIgAQ/fqOgEm9taOT3TqflQvnF8ePNYpnI88FjCbpWh2fd1BMNmNO3CojWIKuUSE2u+SMhB9ZUkF9BsNKRs7PalvQwnPP5zS+ItHH98Lo0uM3V8P3Wl85E9XQe0OBqtm3M6JAbQbFF9M4YnJgZZytboooS79m7WuO9tvoLtiO001YccrRIdNSUCjdJMBfgqgHzhY5xREH989eoZxzsSh+1WPGmm7xcXnMMhh+QSdC1jil3nYCoYe3g/Jpb7vPjZwp2wgun9ry2bujMLtVbpI42o1bIZfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gx+PcEKiQAgJIHhj9ik4FkiK78eNE1scTECl+dFv/WA=;
 b=qyLKPrM2yIeEF/Mgs3NOo7QE3pjjmK4H+REe/AjnEKUB+v2rvkZ8AL8E7D5OAAc3tWDNpfX3n2fA0tiIHoj79ZCcvj34w4Zg5YFW1hF3RySsKbsyntzJGA4DDvptOCLhx8Mvr1iTzxowUHArgTCv4a9M55tGcnmsU3reHUaQdSgND9fR6Z2+/6u4uKPDjrSM9i/vfIzLem8JXWSfkRB8RLfq1g/T1yrBtw8lOipTRznkYtz+ndO53xwZDUTACDP5eKL72uiyXTncHB6laEbQTg5vX1nU5rBMs852Mop1mSa1Iw7cTx24ebAaiQk3yjduLxfHGPgXiDb/E5JV1P9+9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gx+PcEKiQAgJIHhj9ik4FkiK78eNE1scTECl+dFv/WA=;
 b=34cuFYb08B7Cg6UhgbQ1s+hJzYclL/emcMxvtLNNjeTcja7GBQPc8syeNsIoWsarAXEte0EKGr2TbnFVGOLf7qQkiSzS3a5wd3jMehA3RC7PHbJhM/lGkfODHvgRtKlQt1UOvXk7EL1fdwKPDgSDiojjGRvCNVrh8nygQ63MMxY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB8127.namprd12.prod.outlook.com (2603:10b6:510:292::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Wed, 12 Aug
 2026 08:36:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 08:36:12 +0000
Message-ID: <d9439960-3e65-4fc9-921d-02a6052655c2@amd.com>
Date: Wed, 12 Aug 2026 10:36:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/18] drm/amdgpu: add SVM core header and VM
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
References: <20260804094246.1719318-1-ray.huang@amd.com>
 <20260804094246.1719318-3-ray.huang@amd.com>
 <ee51e993-705e-496e-89f4-c5d0196c8951@amd.com>
 <b12d31fb-f9f2-4e09-a0fe-21f2d6bb7999@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <b12d31fb-f9f2-4e09-a0fe-21f2d6bb7999@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR22CA0013.namprd22.prod.outlook.com
 (2603:10b6:208:238::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB8127:EE_
X-MS-Office365-Filtering-Correlation-Id: dae3c2e6-ba6d-49c6-8cee-08def84cc396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|6133799003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: wCxFBTeoNA66hrd517j/B3H6ZLDj92DjVp8GuT6fIQcR6D72XXXKIFbFrcfswiaLdrQrV8RdVrYXm72nbS7XEIGgP0hUWg99gu0+uyFdbnBhSFFc2060sCahK2lMDjevdF4p567g392LHS/UJE76hdSBgv5XNc4lsNo7ZFzEpVHH6w1jHIhmqkO43Xnqls2flq/AZuWVtVrl8QW0sm9jOeICZP+rIVwrh/G5le03A/Vl4IADW3zC73xUPPXcIktwdHzOASQezvkKxm7xyqaUSulFI/ZShf/yUHTuh00cXetJr9byWdm+QDnuI0hfWbQH67IjQJiNm+gO+YMIfj1DdEvFsWm6Q0GY4LbtusEUNzjA8F2GB/14JKv0miQx51t5hGPE8RE5e2+HacgbUgRBEs8ZBSPnhLyD1jzaxGFYaHPh5D7A0/PqtrSFi7INNneNN2yoH5BeqZcphZIAipCV6193Pa+YEi5WZeSCuhVH+xT0QgRvRSsAjq1IeoXPIq4nicGRvihh1mfV7TALMuRpvIZaUxWl1SmB74u/Kr7o8dIYlSTfPK1Y0ANNKrXiy+I9W9QKN56xlidoYxFN7GMbj/x7PwOddr2/7cKg5wFfu/tH+eaE4WAJSTkUV7EBFezZLh1MSAkrFAxP5hYAp6zSqsGkZbNj2cKg3MincSRKuoc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(6133799003)(56012099006)(4143699003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWpRSDRLdDN2SmREYitnWUo2eVNNQ0tVa0Zrd3VMeHFVRG80QlNjaUNRUHNI?=
 =?utf-8?B?aVMvaXJ2eWlVeDJ0RnZuR1dQdk1nSDJHMmd1Uyt5WTZOeG9BZm9TcTd2cklh?=
 =?utf-8?B?ZmlkRzU1dzB2L0xKS0xnaWZlOUhUeXl4eUpnUkcwZ291Sk50bWJNa0p2T0FP?=
 =?utf-8?B?VzB0b2ZHT0tBTCttUzFoaDBUU1loZlQwaXpPazZaZUVvaCsvdjBLbnlpQUtX?=
 =?utf-8?B?ZjFacWNBMFlpSll0UFYwalM5bXVVSlpCbjNHbkVPR2l2R1podklXV0xtV3h1?=
 =?utf-8?B?Q3cvOHZUTTB2U1hMb2FPSkQ5RTdVdVBKSkNoOEIvNXhjSkFmaXk1bWNrRVZW?=
 =?utf-8?B?R2pzVGJUVU4wUDhMMDd0anF4V1M2UllWa05CWTdaNGJsNjdYVDRRNmZqR2ZT?=
 =?utf-8?B?MVZ6V2I1ZUlaVFNFWlc0NjBuMnU5YmRUYXF6dWlyUnJ1TjVVb0cvQnN2alJ3?=
 =?utf-8?B?dDJoTmJ6anI3ZzdsMGw2ZE9kc3VLeFBpUVI3WjJNWmRTa3NOMUR4QzVnb1BZ?=
 =?utf-8?B?TW1OUUFyd1gwcGRRbWkzVVNiUnMwR3oraExiNDF1Q0pBTURCTHRQUzlrZlZH?=
 =?utf-8?B?OXVJeHZKYjVXR1k5emhoTHp2MDZtbUlkSWpmcTJGc1JERlI3R2RJenljN1Jk?=
 =?utf-8?B?Z293YzdJMis2UHlIa3FsbkRUd3dBekRlSGtxaWk5c1FaRjJRYnBCRTJOdDlF?=
 =?utf-8?B?d3VVZHBnNjFKcC9RWnpYSGlLK09rbGpSZUNqbVBOWjErMlpFam5abTRZRjk3?=
 =?utf-8?B?RjdDbEg4YklubGhqaVNQUjlWbm8vTWNjc2JZaHFoVng4c1htWGY2OFpqMGR6?=
 =?utf-8?B?aUdxbVpreTgyL28xYWNuZ0NSNGVJOXRhUHljWGpzNG1ONDNtcjJ4OEt5SWVQ?=
 =?utf-8?B?TEt6NXRVRXEzYTUzZHdzd1Eyc3dBaGNRNHpUcmNWZ0k1cmRpL3NYdHdReHRl?=
 =?utf-8?B?U25acEVGUU9VRkgzYU5vbjc3ZU9CUWFJOVZoeFhuaGRhVmZYRENuM2Noa1pT?=
 =?utf-8?B?UG4xZTJsVlE1N0RaRGtqN0FPQm53UmNZNk1qWE1BTnBEM09wRDZuQVpCRk14?=
 =?utf-8?B?c1U1QlpmWHEzTXlKeFl0UExjK2RRalpyT0s3T1FHdGN6OFlqSkNYSlFZM1B0?=
 =?utf-8?B?VC9wdmdYYnRPdkN5blBONmkvUHg2Ymt2elpoMVhTREVxSWhJTFZqRFJ0MG1j?=
 =?utf-8?B?R1BRZEl3UTBxUTZRbnVRbEJOVnROZEJzMWhYNkZ5UUFaaCt5N2h2UXdEbGFF?=
 =?utf-8?B?Y0lvaUpUUWZnSTFMMzJSL1pHS2tsTXNBS0Q0UW4zdWYxclIvRlRpWDBNZHha?=
 =?utf-8?B?NXdVVE8ycGJDMXpVNXk0d0JUVHRPNlFZZWxyV2RqNE5uSkxEUXZrR1lQWExD?=
 =?utf-8?B?Z3htYVJKQ2wvZkVhVFgxNldueUQ4cjducThMQkhjS1phby9DL3RIeW03TGdL?=
 =?utf-8?B?UC9oRjJLMjlFY3R3NE9PWVBCd2hUZUg0RHFoVEQrNjRnZm9ycDU3YUdXcklv?=
 =?utf-8?B?cWZhR081eTNyd05TSHc0c2JnNWYrRTI0WHVZVlhQNkFCaHJjdlRuaW5Zdytt?=
 =?utf-8?B?aXBKMXVlZmc2cjMyL1pvQWZrbStibFE0Yk9ic0FlRk94d0w5MUdSM2NERnVI?=
 =?utf-8?B?eUxHdWdWK3lGVkVwb2Y5MzFybmNsY3FsY05ydW55TEFMOEFzQld2TkxwcjEy?=
 =?utf-8?B?MnFZVGkvV0hyRm02T2dZNFE2WURWYVViYmNpOVY5bEQ3dVVYb0VPRnIvNDVC?=
 =?utf-8?B?M3g5c0lWSUlobzZ0R21WOXZ0eDBUWXNXYU5TZWNBYWVVNnc4UkprRFVEbHVV?=
 =?utf-8?B?dFpBdWlHb1JzeDZXQmpJcGIwR1crM0svalR1SjExdzEwa1FtbnFsRW8weHN3?=
 =?utf-8?B?Q1VSb2UxUTNiemZFcDMrMFVzOUljOEJrTks4RHFQd0pCUHUycmx5Wm1YSnRU?=
 =?utf-8?B?eGpMNWNRbXd5R1dOWXVPOURGS3ZjOU1pR2Q3TjczcGYvcm1ZTGRiU1RKTU1U?=
 =?utf-8?B?ckZyUlVxWUM3YW9XTTMzdGd2bk5GTEp4Vk9pelNQdlJQa2wxSXpCSnJzUkpK?=
 =?utf-8?B?MTllL05GVlM2TUZkb0U1NUhmekVZbCsycms1WUlqTERKN2cwemt6ZnU3TjN3?=
 =?utf-8?B?bXJmSnBOUllZcjR3Mnh2Q0Q2bmNJUDlFcUI2U0FyZUh5VTFlclUxSnpYTFRK?=
 =?utf-8?B?Uk92NkpWR3BlUEhWcWpnc05OZXFrQ0huNGVGUzdsZ1JZUVNHVFZGdU1JMjFM?=
 =?utf-8?B?UWVibHhobUxQS2ZIUzBzVVFrVDZkKzFYQTlLbThCRG1CaHBTVXdtN1BkdXgz?=
 =?utf-8?Q?GMBrbCIVv1HZD6vgdC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dae3c2e6-ba6d-49c6-8cee-08def84cc396
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 08:36:12.0512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZH1K0fO1T4O1UiP1XZUOWGaakfEBAXRP0d5wuVzasBofeLj1ThxOabkRAFooGaVp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8127
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

On 8/11/26 16:06, Huang, Honglei wrote:
...
>>> +/*
>>> + * Helpers for amdgpu_svm.svm_lock, the driver_svm_lock registered with GPU SVM.
>>> + * Hold it in write mode around structural GPU SVM updates, including
>>> + * drm_gpusvm_range_find_or_insert() and drm_gpusvm_range_remove().
>>> + */
>>> +static inline void amdgpu_svm_lock(struct amdgpu_svm *svm)
>>> +{
>>> +    down_write(&svm->svm_lock);
>>> +}
>>> +
>>> +static inline void amdgpu_svm_unlock(struct amdgpu_svm *svm)
>>> +{
>>> +    up_write(&svm->svm_lock);
>>> +}
>>> +
>>> +static inline void amdgpu_svm_assert_locked(struct amdgpu_svm *svm)
>>> +{
>>> +    lockdep_assert_held_write(&svm->svm_lock);
>>> +}
>>
>> I'm starting to repeat myself, so once more: This stuff doesn't work like that!
>>
>> The lock the SVM subsystem uses to serialize updates *must* be the amdgpu_vm->eviction_lock and *not* a separate one.
>>
>> So clear NAK to having this functions here.
> 
> 
> I have explained why eviction lock can not be used as svm lock in V8, previous version. And it seems like we have a big gap about it.
> 
> The eviction lock can not be used for svm lcok.
> 
> And the design of svm lock is the core locking design of drmsvm frame work, without this desgin, this framework lost its soul. So I have to explain how to use this lock.
> 
> I believe we are talking about two different locks.

Yeah, that stuff is more than a bit complicated. The key point is that I still don't see any of the mandatory changes to amdgpu_vm.c in this patch set.

> You may treat svm lock as notifier lock. drm_gpusvm has two of them, and the "no allocation while held in the MMU notifier" rule applies
> to the other one, not to driver_svm_lock.
> 
> 1) drm_gpusvm has two distinct locks: drivers/gpu/drm/drm_gpusvm.c
> 
>   - notifier_lock: safeguards the notifier's range RB tree and list, as
>     well as the range's DMA mappings and sequence number. ... This lock
>     corresponds to the driver->update lock mentioned in
>     Documentation/mm/hmm.rst."
And that one here *MUST* be identical to the eviction lock in amdgpu_vm.c

The background is that XE uses a different page table allocation approach than amdgpu and we need to drop this lock in amdgpu to be able to allocate page tables. See function amdgpu_vm_pt_alloc().

With that design here that currently doesn't work at all.

We have two options, either use the drm_gpusvm notifier_lock as eviction_lock in amdgpu_vm.c or re-design amdgpu_vm.c to use the same approach for allocating page tables as XE.

Some engineer from Valve is working on re-designing amdgpu_vm.c, but that will potentially take month if not years.

So my take is that the new SVM code needs to modify amdgpu_vm.c so that the drm_gpusvm notifier_lock is used as eviction lock by the VM code.

Regards,
Christian.


> 
>   - driver_svm_lock: In addition to the locking mentioned above, the
>     driver should implement a lock to safeguard core GPU SVM function
>     calls that modify state, such as drm_gpusvm_range_find_or_insert and
>     drm_gpusvm_range_remove.
> 
>   Two locks, two jobs.
> 
> 2) The lock held in the MMU notifier is notifier_lock, never driver_svm_lock
> 
>   drm_gpusvm_notifier_invalidate():
>         down_write(&gpusvm->notifier_lock);
>         ...
>         gpusvm->ops->invalidate(gpusvm, notifier, mmu_range);
> 
>   The driver invalidate callback runs under notifier_lock only. Per the
>   framework's own notifier example it just unmaps pages
>   and queues the range to the garbage collector no allocation, and it
>   does not take driver_svm_lock:
> 
>         drm_gpusvm_range_unmap_pages(...);
>         drm_gpusvm_range_set_unmapped(...);
>         driver_garbage_collector_add(...);
> 
> 3) driver_svm_lock is by design an allocating, process context lock
> 
>   drm_gpusvm_range_find_or_insert() asserts it and then allocates under it:
> 
>         drm_gpusvm_range_find_or_insert():
>                 drm_gpusvm_driver_lock_held(gpusvm);
>                 ...
>                 range = drm_gpusvm_range_alloc(...);
>                 ... mmu_interval_notifier_insert(), kzalloc
> 
>   drm_gpusvm_range_remove() asserts it and frees. This is only safe
>   because driver_svm_lock is a sleepable, reclaim friendly lock that is
>   never taken from the MMU notifier. Reference counting
>    handles range *lifetime*, but it does not
>   serialize tree insert/remove, which is exactly why the framework still
>   asserts driver_svm_lock on those two entry points regardless of refcount.
> 
> Now the three concrete points:
> 
> A) Why the primary driver_svm_lock is required
> 
>   It is a framework requirement, not an amdgpu invention:
>    - DOC: Locking says the driver "should implement" it.
>    - drm_gpusvm lockdep-asserts it on every structural entry:
>      drm_gpusvm_range_find_or_insert() and drm_gpusvm_range_remove() both
>      call drm_gpusvm_driver_lock_held().
>    - The reference fault handler holds it across the whole fault:
>      GC -> find_or_insert -> migrate -> get_pages -> bind.
> 
>   Xe does exactly this:
>    - xe_svm.c:      drm_gpusvm_driver_set_lock(&vm->svm.gpusvm, &vm->lock);
>    - xe_pagefault.c: down_write(&vm->lock); before dispatching the fault
>    - __xe_svm_handle_pagefault(): lockdep_assert_held_write(&vm->lock);
>      held across GC / find_or_insert / alloc_vram / get_pages / rebind
>    - xe_svm_garbage_collector(): lockdep_assert_held_write(&vm->lock);
> 
>   amdgpu's svm_lock is the same driver_svm_lock, used the same way.
> 
> B) Why eviction_lock cannot be that lock
> 
>> This lock eviction_lock can only be grabbed while updating the mapping range.
> 
>   and that is precisely why it cannot be driver_svm_lock.
>   driver_svm_lock must wrap find_or_insert, migration, and
>   drm_gpusvm_range_get_pages
>   eviction_lock is the opposite by contract:
> 
>    - It is taken with memalloc_noreclaim_save() in
>      amdgpu_vm_begin_critical(), specifically so no reclaim happens while
>      held (to avoid the reclaim -> MMU-notifier deadlock). Holding it
>      across get_pages/migration breaks that.
>    - TTM eviction try-locks it: amdgpu_vm_evictable() does
>      scoped_cond_guard(mutex_try, return false, &vm->eviction_lock) and
>      sets vm->evicting. Long holds starve eviction.
>    - It is a plain mutex that the SVM map path re-enters:
>      amdgpu_svm_range_update_mapping() -> amdgpu_vm_map_range() ->
>      amdgpu_vm_begin_critical() -> mutex_lock(&vm->eviction_lock). If
>      eviction_lock were also the outer SVM lock, this is a self-deadlock.
> 
>   In short, eviction_lock has the contract of notifier_lock , not of
>   driver_svm_lock. This is also why the current split is correct:
>   svm_lock (outer) != eviction_lock (inner). Your own rule - "you can't
>   call the VM code with the lock held, the VM code must take it itself" -
>   is satisfied today only because they are separate: svm_lock is held
>   while calling amdgpu_vm_map_range(), and amdgpu_vm_map_range() takes
>   eviction_lock itself. Merging them is what would violate that rule.
> 
>> No, they Xe vm->lock and eviction_lock are actually identical in the handling.
> 
>   They are not. Xe's vm->lock is a rw_semaphore, the "outer most lock" of
>   the VM , held down_write across the whole fault. amdgpu's
>   eviction_lock is a mutex taken only inside amdgpu_vm_begin_critical()
>   during a PT update, under memalloc_noreclaim. Xe's eviction/reclaim
>   handling is separate from vm->lock. The amdgpu analogue of Xe's vm->lock
>   is svm_lock, not eviction_lock.
> 
> C) Reusing an existing amdgpu_vm lock as the primary lock needs refactor amdgpu VM
> 
>   Xe can register vm->lock because Xe's VM was designed with an outer
>   rw_semaphore held across faults. amdgpu_vm has no such lock: only
>   eviction_lock , the root PD dma_resv , and a few spinlocks.
> 
>   So do it like Xe means introducing a dedicated, outer, sleepable VM
>   lock held across the fault. That lock is exactly svm_lock. Folding it
>   into struct amdgpu_vm as a general vm->lock is a core amdgpu VM refactor.
> 
> Regards,
> Honglei
> 
> 
>>
>> Regards,
>> Christian.
>>
>>> +
>>> +#if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
>>> +void amdgpu_svm_flush_tlb(struct amdgpu_svm *svm);
>>> +
>>> +int amdgpu_svm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>>> +void amdgpu_svm_close(struct amdgpu_vm *vm);
>>> +void amdgpu_svm_fini(struct amdgpu_vm *vm);
>>> +
>>> +void amdgpu_svm_put(struct amdgpu_svm *svm);
>>> +struct amdgpu_svm *amdgpu_svm_lookup_by_pasid(struct amdgpu_device *adev,
>>> +                           uint32_t pasid);
>>> +int amdgpu_svm_handle_fault(struct amdgpu_device *adev, uint32_t pasid,
>>> +                uint64_t fault_page, uint64_t ts,
>>> +                bool write_fault);
>>> +bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm);
>>> +
>>> +int amdgpu_gem_svm_ioctl(struct drm_device *dev, void *data,
>>> +             struct drm_file *filp);
>>> +void amdgpu_svm_clean_queue(struct amdgpu_svm *svm,
>>> +                struct list_head *work_list);
>>> +void amdgpu_svm_sync_work(struct amdgpu_svm *svm);
>>> +int amdgpu_svm_garbage_collector(struct amdgpu_svm *svm);
>>> +int amdgpu_svm_apply_attr_change(struct amdgpu_svm *svm,
>>> +                 const struct amdgpu_svm_attrs *old_attrs,
>>> +                 const struct amdgpu_svm_attrs *new_attrs,
>>> +                 unsigned long start_page,
>>> +                 unsigned long last_page);
>>> +bool amdgpu_svm_devmem_possible(struct amdgpu_svm *svm);
>>> +#else
>>> +static inline int amdgpu_svm_init(struct amdgpu_device *adev,
>>> +                  struct amdgpu_vm *vm)
>>> +{
>>> +    return 0;
>>> +}
>>> +
>>> +static inline void amdgpu_svm_close(struct amdgpu_vm *vm)
>>> +{
>>> +}
>>> +
>>> +static inline void amdgpu_svm_fini(struct amdgpu_vm *vm)
>>> +{
>>> +}
>>> +
>>> +static inline int amdgpu_svm_handle_fault(struct amdgpu_device *adev,
>>> +                      uint32_t pasid,
>>> +                      uint64_t fault_page,
>>> +                      uint64_t ts,
>>> +                      bool write_fault)
>>> +{
>>> +    return -EOPNOTSUPP;
>>> +}
>>> +
>>> +static inline bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm)
>>> +{
>>> +    return false;
>>> +}
>>> +
>>> +static inline int amdgpu_gem_svm_ioctl(struct drm_device *dev, void *data,
>>> +                       struct drm_file *filp)
>>> +{
>>> +    return -EOPNOTSUPP;
>>> +}
>>> +#endif /* CONFIG_DRM_AMDGPU_SVM */
>>> +
>>> +#endif /* __AMDGPU_SVM_H__ */
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> index ec1196d390bb7..30463a83e2e60 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> @@ -43,6 +43,7 @@ struct amdgpu_bo_va;
>>>   struct amdgpu_job;
>>>   struct amdgpu_bo_list_entry;
>>>   struct amdgpu_bo_vm;
>>> +struct amdgpu_svm;
>>>     /*
>>>    * GPUVM handling
>>> @@ -373,6 +374,9 @@ struct amdgpu_vm {
>>>         /* cached fault info */
>>>       struct amdgpu_vm_fault_info fault_info;
>>> +
>>> +    /* SVM experimental implementation */
>>> +    struct amdgpu_svm *svm;
>>>   };
>>>     struct amdgpu_vm_manager {
>>
> 
