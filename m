Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C29CD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 13:06:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07A8510E42F;
	Mon, 15 Jun 2026 13:06:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wCW34trL";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012008.outbound.protection.outlook.com [40.107.209.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE52710E406;
 Mon, 15 Jun 2026 13:06:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNmH0u7cC1vkAVEnGXcDPzhsjACfBpSJpDnArHEuD3tPYWY9sc9Ci2GxjAVFTz1M2WV8UvkFzvaE5veLiC3Q1eOpLAnrMbfn/Yafx1KWTszyKBWd6zw9PT43fx+MmAHhKfANeyApgdAJUXEERyBT1SKqq0BJ0riyIF8gzwLy38kqUfRg3oOVqeK7/dnX7duUak9LPGxXBjKLhQCtjYTSAk6XX8OdWSNTjV9goB1l3iLt46yeTK9MJ0l/g19D4O7tFazg5EQZ+MxcmjcgjB/GLShMHw6SzXQtDYptgXS49NtWKPjvfITqhPRag8wqjR3Lbl+V0939se3s+ny40izs2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0m+ubhX/+msGjHyW189KIfjz+KlJHTWw9PvVuj4JnM=;
 b=Rh5q16SXUOSJO/ra5SyHcTCAxow4NCxB4GL414sqZEEp4EbY43WWlkQFlRk9LagEuXS2WAFv2rdMLlqHbfiOJ5DdOBN8rf1jcwe8zXcGlOqJX2nscUOTEdGhe8vS7ThXh+QcNpulIehrGOYN4yQEuHgQz7a9NLVwufZ7adGW0rMZXh74M0om4AM3UtOf8sn5dS1pfYuZWGjLDLIXsECUpM/49siQXmkMYewIN2HiU+px45pGEt33OIQLRN+3Cqrbf62VN0T1VPnbxnZ82coLs/t/j6Z9GRvv3k7X0JPvq0XICk0KJt3ShEblHSS94ydQgsUGdMqyQoy/PMdOly9qAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0m+ubhX/+msGjHyW189KIfjz+KlJHTWw9PvVuj4JnM=;
 b=wCW34trLfN28MSlyKssSSghqYK9Dk425v9DBzxlipQTBFZdpZDulLxsCqaqmc07WVvFZoz5rlXhkbE+5A6zWsib4s2UVhAagZCiIrT5ScHDQ6G8hq/MPAe4CLYhmZaMbhGAmnF9Dm7IZcj+mJUcARITbIux6jJQrDYQ+gKtFL3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by PH7PR12MB7913.namprd12.prod.outlook.com (2603:10b6:510:27b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 13:06:23 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.21.0113.013; Mon, 15 Jun 2026
 13:06:23 +0000
Message-ID: <9b146323-4f3e-4da6-9728-dee837ded076@amd.com>
Date: Mon, 15 Jun 2026 21:06:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/18] drm/amdgpu: add SVM core header and VM
 integration
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
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
 <c946b8ac-77c2-4366-8d73-938f4b2277ff@amd.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <c946b8ac-77c2-4366-8d73-938f4b2277ff@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU1PR03CA0005.apcprd03.prod.outlook.com
 (2603:1096:802:18::17) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|PH7PR12MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: ccad0ccf-fe0c-4137-8f7f-08decadee656
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|18002099003|22082099003|11063799006|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: lG7kRZJYbtu4hFEcD9EPAgJjxOKHdGSBJ7HzNlWiTMeVAmbORSZeCGYWQUzRMpFxRISjJWfPPqQXvl1YwZoncY7vt7oJmHD3wb1gH7ywLgQze0GHlSu7LK2ZDM8OmS2OqoNdO2rtWbSaHFRnGNOWl0eOIdAQkAa3ybxzQPKwG45SGUDUP1hFaCpMVZ/0JyqVPtV2+flAYA4nvZ8+fUFCaU/GydYCCB5qndDYP/1L+HB6rQpLtrzu+aESM3L/HHRGVmAqVBQdcKfV+V5HNJhdKmD0MUgutDEvzgHuAQvakZTf8n5yYzskLsTKAKvedsZuitRzgbNJO9i4AEFzbR47DFzhu6g6Xchb/DfbbYmc0i9AF9bi1X1VENwbbmsntOcUEpxjPYuEMNE/fvMDCbFxgRqhUuHmXwi2jxaI6y3/HjQm74gAeweSwPm0Nqlhtn+VBoy1bWYs9iRpZKen9K7FD5C/hjKdS9ZttUzko4HiCOf5zBhc4xZCTyFHdsZsxWndMT5drlf/5Td3G7LpmqVUJGl9ewI9mkDh5HV0jMMhlxGN0mndyG31vMvAlVM9fQHhJbkqZYOlbAlvsnu1Jzb2h8oHAZZYy6il0BSEsNWOGmDAOUI5gF33RfJbdPndJ2BgkPq7ZdcE7GvfacB7xH0kCXWyBvfrJQJzh4yoViIWejcL5Y5O37iT5Q+FOw9uYgnE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVdtTVcwSUxMOCtSMnpSeERPZVBweU5HbnNCbDdlK1Z1eTdtbTI1dW5zTW9C?=
 =?utf-8?B?UGg4VXdSRkJjRjM4bXlxNUJpZW9keUUwdjNWY3Z2R2tPRkpScEVmbDJNZEd0?=
 =?utf-8?B?VUIwc3JtNCtIZ1gyZm5aRUJ1T1lmTDZId2tsZXZnWWhIdURnLy9mVkJONEgz?=
 =?utf-8?B?RUVkdHRsS25kZFpJQTdNNVIvMFlHMDJGSEFiWFZBakdCS0Z2Z2ZDY2k0YVc5?=
 =?utf-8?B?cWg5am00UHBhVmlKdExrK1BHTmxqL1l6dWMrV1FENk1Pb2NjTW1IVWcwcTVv?=
 =?utf-8?B?c1hkdnR2Vzg2Mm9xUC9RdkwvZk41VnJ5NmJZKzY3b0xzdSs3UlM1NUxnRmZr?=
 =?utf-8?B?TlZ5M2hlckZlbFhrb25EOUQxSEN4K1dCbXRTU1RpRERvK2IzTnBaZUFyTjlN?=
 =?utf-8?B?ZHpzWi9rczhwbFgzWWlwZW1JNjdRTGZMaVdTNUc0MEF4UkdIT2RyQ0FGZkNy?=
 =?utf-8?B?ZTJvS1ZSWXZldWVJYWh2Um1YVGI3Q3YvOGxwWE1Nd2s4UjFvc3F2VnR3UGh0?=
 =?utf-8?B?cHptOURGeFg2MFdQNW9GUm5NL2tOWTlPV1pER1dZZ3RGbGRFK3YrbkJQb2ti?=
 =?utf-8?B?bUJ6U3AwRTB6bDdQZ3d3UDlUb3ZzRmFyaldkNnJFcml6WFgzSkxtdDdZVGgw?=
 =?utf-8?B?Q2t5Z2llc0kwQnk4ZVQydFRPQTJud2dkRGhEMkl6R3ByWEpLYlVPUWdpcmNh?=
 =?utf-8?B?VmVkUy9VOFFLaGY2dHo2Z1RmajdpT2xjU1phR1kwR2VWRWNUN2UzazVXWnhH?=
 =?utf-8?B?VkdGdTJreUlFZ2FTSUt0ZGhMUCtZbjg2clQ0WnI2Y3pHUlFleWJSUHRzYU9J?=
 =?utf-8?B?RVFuNml1SWphUnZ6cTlYZURoWjl0NWoxUFJrajgySi9MVUJZNFhNNmhBYWdW?=
 =?utf-8?B?cjhoc3lNbkpsZ3pBQVJyNzJlOVRqWnM4R3F2bUs5ZldFMk1hZDdhWU12U2pK?=
 =?utf-8?B?QmNDdmJieFRwclNMTGFjY0l4QWdwM2w3aXhSdjlJcHJpK1pEemtOV09mTDRv?=
 =?utf-8?B?RFZ1bEVtNUJMaTN2YTlKOEphandOT1pHQ21ia3hydnA2OTR4SWZLVTdkazBp?=
 =?utf-8?B?cElEYVRIcTE5OVBhb3RsTDVzUGt2aXpmK2xrS3hhVXdIbzg3S3d2TjRBZkwv?=
 =?utf-8?B?a2RTMjRJWHcveWM1aS9MNEpFekxTY3RWKzJtVjRTeExiT3dzZXpQd3pVdFFy?=
 =?utf-8?B?MW9nck1GN3ZWRjh0WnNuWWlFeXRBZXhIK2l6NEJoaVZiMWJxdjlNaEJ5ZEp2?=
 =?utf-8?B?WDUvaWg5ZHNxdjlWV0tUOGFCaXpZbTNsRTB4UE1CRDhMMUl0Yi85YVp0Z2FN?=
 =?utf-8?B?YndQcWpBMUVQRm13RTlOaGlVdCtjR3BFbGRKd1hyQWZWUDR1cE1pT1gxT3FQ?=
 =?utf-8?B?dTNydTJWTWpZa1V4ZG5yY3JnMEpEZEwvU0tlSk4xcmNsQytvVFJ3dGtWWTRv?=
 =?utf-8?B?RUFuZU92M2svRmFMVkRwUWE2YVFpSHY1UGRWbm9WZWg2c29NT2xOUnNKY2N0?=
 =?utf-8?B?cktGVW5IZW81dU1LMDdxcFdEd1dkUFpxcG5oZmJwa3ZHNFpTK0EwQ3hUZWoy?=
 =?utf-8?B?TjAvNnlaRXo5RTR5L1oxWWYwQTdDdW1URHR5bldhVzRHaDBUd1hSYWNFY3Bs?=
 =?utf-8?B?cmpwamU5T09pYnZlOWtOK2U0Z1ZGZDlNbFo4Q2lRdkd5TFBJVnU3c0hOLzdG?=
 =?utf-8?B?enNHc2JYbjRFZHpFM3RiOFUrVnpSUHpKTCtwTHUwNkI5Rlg0WjBKQlVhWVY1?=
 =?utf-8?B?RVJHK0E4cVFhaTZ3M2pEczR0RnNYS0VRcU1wZ3oraHJMcFM1YkVFa3VlS285?=
 =?utf-8?B?MGZqbCsvMUdKaFlqTTdJQlN5SUFGZjNWTUNVWGV1ZmVTYmd6WWl4Z1YwT2hn?=
 =?utf-8?B?bG9wUE5KTW1CK1dheG1tSnVtcDNqbnBxY0libHIzNEtxZUJDSWRWSzJQSE1s?=
 =?utf-8?B?YXFRd1h5ODZhTGEzMVp4WmZmWVF1VXBLLzcvNEN6MElsY1VhZks3djNRbEJr?=
 =?utf-8?B?Q0F6QThsRVNGd0dBTzNCS3JxVmVidTNuWVdabTdwKzAydC95WmdCTzI0LzRD?=
 =?utf-8?B?WFNweXRibnF3eGx6ajdDL0ZzeXVpR2g0ZkVuOHBndDFxUUliU1JQT2kyUTQy?=
 =?utf-8?B?QWk3dTl6YW9aWTl3aUR5c1dWcllZc2M5YXR6NGllNThjZXFRTUdJTlBndW1Y?=
 =?utf-8?B?dE1pVlFVZjZBUnYyR0paWk9lWkJ0eE1NY010bUhzRlVEMTJHaTgvdDMzQ2g5?=
 =?utf-8?B?MHdHc05uZXc5K1B1cHR1WWVjbWJCcDlqWjRDL2pDejRYZ2VmemdmNHBLM3c4?=
 =?utf-8?Q?YwuX+IVJvZejHsURU6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccad0ccf-fe0c-4137-8f7f-08decadee656
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 13:06:23.3764 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v1q912NDnlvvQfok9GM8HwyEqDIrXtBsPqFIUzcVlB5A3FwyZiZ4DjzMqdTv6ZIPvnCY0O/pXI3xE8ZNC5ilVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7913
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



On 6/15/2026 8:43 PM, Christian König wrote:
> On 6/15/26 14:31, Huang, Honglei wrote:
>> On 6/15/2026 7:49 PM, Christian König wrote:
>>> On 6/15/26 11:36, Huang, Honglei wrote:
>>>>
>>>>
>>>> On 6/15/2026 4:08 PM, Christian König wrote:
>>>>> On 6/12/26 15:20, Huang, Honglei wrote:
>>>>>> On 6/12/2026 8:02 PM, Christian König wrote:
>>>>>>> On 6/12/26 11:09, Huang Rui wrote:
>>>>>>>> From: Honglei Huang <honghuan@amd.com>
>>>>> ...
>>>>>>>> +static inline void amdgpu_svm_assert_locked(struct amdgpu_svm *svm)
>>>>>>>> +{
>>>>>>>> +    lockdep_assert_held_write(&svm->svm_lock);
>>>>>>>> +}
>>>>>>>
>>>>>>> What exactly is that lock protecting?
>>>>>>>
>>>>>>
>>>>>> this lock is the driver_svm_lock required by the drm_gpusvm framework
>>>>>> It is registered by drm_gpusvm_driver_set_lock(), and drm_gpusvm lockdep asserts it on every structural entry point, e.g.
>>>>>> drm_gpusvm_range_find_or_insert() / drm_gpusvm_range_remove().
>>>>>>
>>>>>> Per amdgpu_svm it serializes the write/commit side against the fault
>>>>>> handler: range/notifier tree insert+remove, attribute changes, and the
>>>>>> garbage collector.
>>>>>>
>>>>>> This is the same thing xe does, in drivers/gpu/drm/xe/xe_svm.c:
>>>>>>
>>>>>> drm_gpusvm_driver_set_lock(&vm->svm.gpusvm, &vm->lock);
>>>>>
>>>>> This is clearly incorrect in that case. Our equivalent in amdgpu is vm->eviction_lock.
>>>>>
>>>>> That was already completely incorrect in the old KFD implementation, please don't use that one as blueprint.
>>>>
>>>> I really want to use vm->eviction_lock as SVM primary lock,
>>>> but it seems like in Xe, Xe uses vm->lock as an outer VM lock by design rwsem instead of mutex lock to broad VM ownership, not an eviction lock, they are semantically different.
>>>
>>> No, they are actually identical in the handling.
>>>
>>>>
>>>> I tried to replace the svm lock with eviction lock locally, ABBA dead lock encountered:
>>>>
>>>> amdgpu_svm_handle_fault
>>>>     amdgpu_svm_lock (A: eviction_lock)
>>>
>>> That's nonsense. This lock can only be grabbed while updating the mapping range.
>>>
>>>>       fault_map_range
>>>>         amdgpu_svm_range_update_mapping
>>>>                drm_gpusvm_notifier_lock (B)
>>>>
>>>>
>>>> drm_gpusvm_notifier_invalidate
>>>>      down_write(B - notifier_lock)
>>>
>>> Same here. You simply can't call the VM code with the lock held.
>>>
>>> The VM code itself must take it as appropriate.
>>
>>
>> I think the core gap is what exactly does SVM lock (drm_gpusvm_driver_set_lock) do in the framework
>>
>> I checked xe svm, in xe_svm.c:1209:__xe_svm_handle_pagefault() the very first thing is:
>>
>> lockdep_assert_held_write(&vm->lock);
>>
>> The lock is already held on entry and stays held across the entire fault progress:
>>
>> xe_svm_garbage_collector(vm)
>> xe_svm_range_find_or_insert(...)
>> xe_svm_alloc_vram(...) (possible migration)
>> xe_svm_range_get_pages(...)
>> xe_vm_range_rebind(...) (the actual bind)
>>
>> they are not grabbed while updating the mapping range.
>>
>> And the drm_gpusvm framework itself requires the driver lock to be held at the structural entry points:
>>
>>
>> drm_gpusvm_range_find_or_insert()
>>      ...
>>      drm_gpusvm_driver_lock_held(gpusvm);
>>      ...
>>
>> drm_gpusvm_range_remove()
>>      ...
>>      drm_gpusvm_driver_lock_held(gpusvm);
>>      ...
>>
>> The garbage collector and unmap paths hold the same lock in write mode:
>>
>> xe_svm_garbage_collector()
>>      ...
>>      lockdep_assert_held_write(&vm->lock);
>>      ...
>>      __xe_svm_garbage_collector
>>      ...
>>
>> xe_svm_unmap_address_range
>>      
>>      ...
>>      lockdep_assert_held_write
>>      __xe_svm_garbage_collector
>>      drm_gpusvm_range_put
>>      ...
>>
>> These codes indicate that this lock needs to be held on the outer layer to protect the data structure of SVM, rather than just during GPU mapping.
> 
> In that case that is a major bug in the drm_svm handling. The lock *must* be held only during GPU mapping and all other data structures lifetime handled by reference counting.
> 
> That is a core requirement of the SVM handling because you can't allocate much memory in the MMU notifier and so you also can't allocate memory under that lock when it is held in the MMU notifier.

Will discuss this issue with drm gpu svm maintainer.
But at least under current code structure of drmgpu svm, use 
eviction_lock can not make SVM functional, there are many assert in 
drmgpu_svm framwork APIs, block the calling sequence/lock order in 
amdgpu SVM.

Will discuss about maintainer about how to handle this condition in 
drmgpu svm framework.And keep current lock unchanged before we have a 
solid design.

Regards,
Honglei

> 
> Regards,
> Christian.
> 
>>
>> Making eviction lock the main lock of SVM will indeed block the functionality of SVM and also violate the design philosophyof drmgpu svm
>> as far as I ca see, at least I can not make the SVM functional under this conditions.
>>
>> I am not a expert of drmgpu svm, how about ask maintainer of drmgpu svm
>> to ask how to use the drm_gpusvm_driver_set_lock, and can eviction lock be used for drm_gpusvm_driver_set_lock.
>>
>> Regards,
>> Honglei
>>
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>>>         amdgpu_svm_invalidate
>>>>            amdgpu_svm_range_invalidate
>>>>               amdgpu_svm_range_notifier_event_begin
>>>>                 amdgpu_svm_range_zap_ptes
>>>>                   amdgpu_vm_update_range
>>>>                      amdgpu_vm_eviction_lock (A: eviction_lock)
>>>>
>>>>
>>>> the current SVM side can switch its registered driver lock at any time easily as you wish, but doing so safely is not just an amdgpu SVM local change.
>>>>
>>>> The issue is that change lock / change lock registration is easy, while lock semantics are not. SVM execution paths like fault handling, invalidation, mapping updates, garbage collection, notifier callbacks... are coupled with VM locking and update flows follow the xe svm style. If we switch SVM to a different VM lock now, we can introduce lock recursion, ABBA lock...
>>>>
>>>> SVM can technically switch lock registration now.
>>>> But make all stack works and pass all tests maybe needs amdgpu VM refactoring.
>>>>
>>>> Regards,
>>>> Honglei
>>>>
>>>>
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>
>>>
>>
> 

