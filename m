Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37596C5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:16:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 821A310EF78;
	Wed, 12 Aug 2026 12:16:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pyq/BP2F";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011026.outbound.protection.outlook.com [52.101.52.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8163A10E3BC;
 Wed, 12 Aug 2026 12:16:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qmCWGeLE9z8RRozRL28NdsDChrhEKjMnNDPDuTRSJB4P3/eByfI7PPnQI3y9vGqGB7nLvK+wFGOPMMGJ13PGCq1/qoUpO98RJbtXeLwZ+uQGNBFQJ+LVKfvopXG4SO7Udc8+QeRj/5mFtQjur9ll7AAeDNCwYAZDb3BcPrvH4Slm+EevYSGagJ8wfqt2CWXFHOGCjDxbXQstYPX2oqws3ZeJIQ/Gr2o/NNsk+P26jXlLjJFjCbl1rMPZpdzhjaWmbwtdA2dB7ZMVSiNw142iajEDEmbA9lmE/EMZi2Bh0uhu7zPYZfwp/J8wK9FFu6fiLo3YY8JpYwW1aNjW7oMv8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4LD5jfsmdDj3T4swA3+4pnoTpKkAKhGNA+GaVpUv33g=;
 b=nQU/0OHb1K337qqCD1jFVqrv7PqiMmSvc6xEq9npz2J34FXj+oNLCbaVabXUrvrUbJRNY2A8Q00GQI7xaBZgxi9Jd78jgxfww3edKD+2k8YDx2W+9eJs/erRPpwsZhsh0C+0b9bR4I7Qww3J3HnbP2ym/bdlTSwZaoIT//z+kqFjlrY2B1IrggG2FqMUeVmMDVzOnH83JAPsJIfhIvAUC/smK+o/dRABe1jqXzigcmaBsa2a4erG+cxPFcYsnaoUmVX5TBe6af2+fAmET3AjeOP2xSy5QzpFP5UTW30IXX8rUy/DyGM9LDtaoEVPKQL7MWUdoRYUuw2QSnGXLmCtjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LD5jfsmdDj3T4swA3+4pnoTpKkAKhGNA+GaVpUv33g=;
 b=Pyq/BP2Fx8TrdztECtXGjrX7ItBa30bcpFYYjotILEc0MLrBYD8Lh09DHpPIlhCmfRokzkHkEANgQyDbkCl22YfIqZVAAE4DHKmoQwPRd4EfX3mSrXZcv0kdGkFGDkc4EGYNja4VWksY+PwEUw0tNMXRVKsXb60mHB5U3A0qVDU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB8322.namprd12.prod.outlook.com (2603:10b6:8:ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 12:16:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 12:16:09 +0000
Message-ID: <ffda865c-2f2f-4b5c-a21d-6d0ef7c1b10a@amd.com>
Date: Wed, 12 Aug 2026 14:16:03 +0200
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
 <d9439960-3e65-4fc9-921d-02a6052655c2@amd.com>
 <e4e1acc6-c8f6-47af-b3e2-cd4bb396bbde@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <e4e1acc6-c8f6-47af-b3e2-cd4bb396bbde@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0157.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: 1505ebab-82f0-4006-face-08def86b7e01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|56012099006|11063799006|4143699003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: G60urFM8Qzc5I0i0UTcQuyOGlAWWPKEn+RvS5NOBGTlwPdJiaO/gouWmNulB4bMkSppB3Y2qsrmuBpKxUk6UjG+3Xrb31A1CG9EuWWpVJsbobtyqLdb4TVw7KA/kHuVDeQknLE4dXhhBA2/UChPDkOJEk8BOhkP6mNW9Ymks77dI7IghGO7UZbRHyo5MJWnWWJWZ9KeGw5qIfEipnzc2GCFBHTmqRleIXeFxz/V9o3mWRUFmeR1tIaVjTdS/K1JdKRP546GCojaeO02WygbYnmaeg0T4nqMq42iF9S2xCZcznBZbKQTT5Iw6cZuCgKqH8aDdFSd9IIl1rNW7oZGi7S9jTAvqGH6fguZYupwawiO5iAmkkckhrtx1ri6Q8mHwTjEKqZ/QczyJOUcjBhNVfFceSxAdt+nZxTqpEj0v4G6LyicZ93SY7mrZHWTvtRZxtqPi6WVHlh1hf+61bg1DG7ODY5bAdyElKYx09M9luSUGuwn1RnOy3C8yC4Lj3xrSsi7lorPIVvXBzzC3NcAt7iZnXEGGR2jgBMaoab1no9Z3NLGPI2//7TxlrLAAEF0kKoBlKmfbCV0pw5EehziJ7Xhf9kuZYfEc8TyjgoX6Gam/DUAWel2VBaO4C9drP3KhbDWB0XQoD4o9b7lENU2YU40zHonRL72i00NngJATuAU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVdJOTgwemIwZGpjd3FUZjZidVJxb0IyVVM2TlFPQzNKZlBTcGluMnhUV3dq?=
 =?utf-8?B?dExDczRMQTltOENXL0NjdUpHZ25FMzlhVjgrbEJ4MlgwOFd6QVRLM1AzVXpS?=
 =?utf-8?B?VXpzTzQyM0p5Rk1XNTlTR1B5UHE4UkxzMmJRT3I5MU9ndkw3ZVhrMU0xQUdO?=
 =?utf-8?B?dklFQlVKblpBSkN3Y3FLbnNrdkROUU5OZzVhc1dmeWZTeHB0WWVJbHJvUmRX?=
 =?utf-8?B?YU96Y2Z5RW1laWxTSFgxME0rbmM3RlRjaitkRy9FRzVvMmlpYlN2T3FLeWs5?=
 =?utf-8?B?NG51Vk9rTHhpd1hmb0NQTG94bzQ2YzgzSThFeDNsM09sNEJLL01VR1RQS0FH?=
 =?utf-8?B?MGRMWHloWm1NYlJGc3VwK1BRa05qNE95cFlneGNzQjAxNndSWk5QSmxEVmhx?=
 =?utf-8?B?a0d0S3pXbkFBMXN0SHRIVFFMUTJ3S1RWdEkvODdPYmlYc0QvWEg4VS9pUlNS?=
 =?utf-8?B?bXgyeFpocWlPbjhBNXBiZ2tsMHd1QkxWRlJoL0FVNEdsVXZyVjlnbU54STQ2?=
 =?utf-8?B?TGt4WVRZeng0ZS9hK2lCQkxxYlNCUURBNllwRFNVQXdFTFdPYUZYSWEwYkdQ?=
 =?utf-8?B?TUlKd0pYSnlGY2ptblRPU25nYkxYbGE4bThEcmtUR3RSVWVwdW0za2g0ZmtU?=
 =?utf-8?B?SXJJbVR3UFRsVmJlaUhsYTJVWmtnbHBVM0YxSHQ0K1pkeFRkb3dOckI0ZFBD?=
 =?utf-8?B?WVdJTjVER294dDhvM3FQY0hBVU1LSlp2TVBBVE5CNjU3UzZHUkhzRkt6L2Jl?=
 =?utf-8?B?ME9JQ2dqTEcrSzdrUitIeXhtK00wTlZ6cm9WZkpCdG1VT1pGT3ExTVBXSEhU?=
 =?utf-8?B?b0VVY09LYmxwK0M5TFdreU85RWo1N2J5SHlnSTc0OENaNWJneTlKbTQ5Zkdp?=
 =?utf-8?B?MTdCdGIrc0RjWkp0ZmVaaGw3NjdxYUhiMkFueVRNZTl4YmpTNkJKU1lIZEJT?=
 =?utf-8?B?aFVKZk15RzYyZm5RTzlRWldOdkxCbkpIcXJmZFJWTE1WaGlsRnVvTWJaT21z?=
 =?utf-8?B?OWVHRDNGL21iVGdUOXJiVzB0MU9wZ2F0NjI1SHBaMTMyQ0ZUak9Ma052SmRQ?=
 =?utf-8?B?UCtpQWt3NXdPWXZUYm41cUcvNkg1WnRtR01xWWlwTXgvREZsKzhvMjVSSlU4?=
 =?utf-8?B?TjI0a2JyYVpnS3pKYXBIVzNWQVYrVHBXRFlmRGpYdEs5ZnVua2g3cjZRMTk2?=
 =?utf-8?B?N1ZiaWowNFNVN3dSSUNrdVRGM2pVSElFZU5zSFBWVXljVDNIaXRGbmxUT0NV?=
 =?utf-8?B?VkdKTXR5Z2F6ZDdzcUFUNHhkNUhoVGd6NzUzazJGSVcxRjVJSENZUnhvME9K?=
 =?utf-8?B?L0FpVkx4bVdMY1NwWWlBMUJraEZVNWJ4WWdRdGhUSEIvUTNLb0NGb21yam02?=
 =?utf-8?B?LzF6MUhqK3ZtKzIzQ1gzNUNzNFdYRjB2NGI2YmlEb0tuNVc1Qlc4NWlPeG84?=
 =?utf-8?B?UVl3SkhsdEdxejNzbEVwVmMyVnZyMTRkYVhPY1pHREJ0S0xFUk1HNzBFcCtD?=
 =?utf-8?B?dnJwQVNGeTA4dGlXZ0lWQytXcURZMDl3Wmc4UGFub3JIY2lkK0RkbTFhV0VS?=
 =?utf-8?B?ZzRYZ292ZW10NjB6aStzSkNwRVZXbWsxMHV1YVBWeDNUTk1GREhBZmVxSi9l?=
 =?utf-8?B?SHhzUzFuZ1AxRng5TGhhLzFWRTI1bjlqdis1d3NMMXNqL0RGUnh0aDFrOHcy?=
 =?utf-8?B?VmhHUGFjSnBrcGNYMkNzQ1BRNkpCb1FITDZEYnlrdE8xeDlPRXNEY05heUhU?=
 =?utf-8?B?aWFKYlExNGVUbGhCN0o4ODZ2d2RBUU1kY3BtWE91UllVVmlPc3VRSG9PdzEx?=
 =?utf-8?B?VndzYnJvSzJiVlJMRlkzRExuTzFkN0x5dmZrUjdMMXJ6Vm9haEFWRGR3TlIz?=
 =?utf-8?B?OWFUYnVLQ3VOSUkvRndoaFFESGM2ZjRwVTMzUmVGTHZzcFRCZ2J1VS9teWFK?=
 =?utf-8?B?QU1mZGwxZ2kvNE15clQzaitFeUJuaG1DMUFyL0liRTBBeDFmNGh5L3NyVmFx?=
 =?utf-8?B?ZUNiSTN6eFJvMXVwUXp4QUpjRXU0eWJXZTdMdmRmdlFQTEtVay9DNit3TFRC?=
 =?utf-8?B?MXhRUkM1WFpUQ1FwL0FCNzRJcEs3NXQ0ekpMQ3RwcGUwdTNGVlVjVG1HdWlz?=
 =?utf-8?B?WXZIUjYrZTlQbDcvMHVzaW1ubUNtQ1ZqVEoyTmkwSEZWdGhYMmN1NWdEVVdM?=
 =?utf-8?B?ZEViblI4Qlk4VWJJS09ock9DaGkvdVdrU202M2llZHpnYjhTVnN2RnpncWpP?=
 =?utf-8?B?aHMyQmpHVFl4dGZtWWJqNFp5eEc1UnVDRFBHRXpMZDVWcnp2WUdCZDFSSElB?=
 =?utf-8?Q?tC6SZvTQA3QeiHtdo5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1505ebab-82f0-4006-face-08def86b7e01
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 12:16:09.5397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ux3NMqplMHINz/iD7WjRKiTwFHde4SQoDy0iPPrPuQPE9VB62DElQbElE8Dy09F5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8322
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

On 8/12/26 11:55, Huang, Honglei wrote:
> On 8/12/2026 4:36 PM, Christian König wrote:
>> On 8/11/26 16:06, Huang, Honglei wrote:
>> ...
>>>>> +/*
>>>>> + * Helpers for amdgpu_svm.svm_lock, the driver_svm_lock registered with GPU SVM.
>>>>> + * Hold it in write mode around structural GPU SVM updates, including
>>>>> + * drm_gpusvm_range_find_or_insert() and drm_gpusvm_range_remove().
>>>>> + */
>>>>> +static inline void amdgpu_svm_lock(struct amdgpu_svm *svm)
>>>>> +{
>>>>> +    down_write(&svm->svm_lock);
>>>>> +}
>>>>> +
>>>>> +static inline void amdgpu_svm_unlock(struct amdgpu_svm *svm)
>>>>> +{
>>>>> +    up_write(&svm->svm_lock);
>>>>> +}
>>>>> +
>>>>> +static inline void amdgpu_svm_assert_locked(struct amdgpu_svm *svm)
>>>>> +{
>>>>> +    lockdep_assert_held_write(&svm->svm_lock);
>>>>> +}
>>>>
>>>> I'm starting to repeat myself, so once more: This stuff doesn't work like that!
>>>>
>>>> The lock the SVM subsystem uses to serialize updates *must* be the amdgpu_vm->eviction_lock and *not* a separate one.
>>>>
>>>> So clear NAK to having this functions here.
>>>
>>>
>>> I have explained why eviction lock can not be used as svm lock in V8, previous version. And it seems like we have a big gap about it.
>>>
>>> The eviction lock can not be used for svm lcok.
>>>
>>> And the design of svm lock is the core locking design of drmsvm frame work, without this desgin, this framework lost its soul. So I have to explain how to use this lock.
>>>
>>> I believe we are talking about two different locks.
>>
>> Yeah, that stuff is more than a bit complicated. The key point is that I still don't see any of the mandatory changes to amdgpu_vm.c in this patch set.
>>
>>> You may treat svm lock as notifier lock. drm_gpusvm has two of them, and the "no allocation while held in the MMU notifier" rule applies
>>> to the other one, not to driver_svm_lock.
>>>
>>> 1) drm_gpusvm has two distinct locks: drivers/gpu/drm/drm_gpusvm.c
>>>
>>>    - notifier_lock: safeguards the notifier's range RB tree and list, as
>>>      well as the range's DMA mappings and sequence number. ... This lock
>>>      corresponds to the driver->update lock mentioned in
>>>      Documentation/mm/hmm.rst."
>> And that one here *MUST* be identical to the eviction lock in amdgpu_vm.c
> 
> Actually I have a question about this,
> 
> The notifier lock protects the CPU pages tables, it prevents the migration/swap ... from MM logic.
> 
> And the eviction lock protects the GPU VM page table, it prevents gpu page table changes from TTM logic.
> 
> They have different jobs,

No, exactly that is what we have gotten wrong in the existing KFD SVM implementation.

> 
> when doing a GPU mapping in SVM, cpu page table can not change, casue it
> may change the cpu dma addr -> gpu mapping. So must hold it, it is done in current code, and it is must required by drm gpu svm frame work.
> 
> And at the same time the eviciton lock must hold also, casue the GPU page tables may change by TTM logic.
> 
> Those two locks are all need be hold, no conflict, this is just my thought.

Originally the notifier_lock only made sure that the CPU page table updates where done in order and originally the eviction lock made sure that the GPU page table updates where done in order, but essentially we need the order for both.

The point is that the updates need to be serialized. In other words when one CPU is doing a mapping operation and another CPU is doing an unmap through an MMU notifier we somehow need to make sure that the coresponding GPU page table updates execute in the correct order.

So essentially those two locks need to be the same one, and we need to drop the lock to allocate page tables and when we re-acquire it we need to double check the sequence number to make sure that no unmap operation happened concurrently.

And yeah I know that this makes things much much more complicated, but it is definately necessary.

Regards,
Christian.

> 
> Regards,
> Honglei
> 
>>
>> The background is that XE uses a different page table allocation approach than amdgpu and we need to drop this lock in amdgpu to be able to allocate page tables. See function amdgpu_vm_pt_alloc().
>>
>> With that design here that currently doesn't work at all.
>>
>> We have two options, either use the drm_gpusvm notifier_lock as eviction_lock in amdgpu_vm.c or re-design amdgpu_vm.c to use the same approach for allocating page tables as XE.
>>
>> Some engineer from Valve is working on re-designing amdgpu_vm.c, but that will potentially take month if not years.
>>
>> So my take is that the new SVM code needs to modify amdgpu_vm.c so that the drm_gpusvm notifier_lock is used as eviction lock by the VM code.
>>
> 
>> Regards,
>> Christian.
>>
>>
>>>
>>>    - driver_svm_lock: In addition to the locking mentioned above, the
>>>      driver should implement a lock to safeguard core GPU SVM function
>>>      calls that modify state, such as drm_gpusvm_range_find_or_insert and
>>>      drm_gpusvm_range_remove.
>>>
>>>    Two locks, two jobs.
>>>
>>> 2) The lock held in the MMU notifier is notifier_lock, never driver_svm_lock
>>>
>>>    drm_gpusvm_notifier_invalidate():
>>>          down_write(&gpusvm->notifier_lock);
>>>          ...
>>>          gpusvm->ops->invalidate(gpusvm, notifier, mmu_range);
>>>
>>>    The driver invalidate callback runs under notifier_lock only. Per the
>>>    framework's own notifier example it just unmaps pages
>>>    and queues the range to the garbage collector no allocation, and it
>>>    does not take driver_svm_lock:
>>>
>>>          drm_gpusvm_range_unmap_pages(...);
>>>          drm_gpusvm_range_set_unmapped(...);
>>>          driver_garbage_collector_add(...);
>>>
>>> 3) driver_svm_lock is by design an allocating, process context lock
>>>
>>>    drm_gpusvm_range_find_or_insert() asserts it and then allocates under it:
>>>
>>>          drm_gpusvm_range_find_or_insert():
>>>                  drm_gpusvm_driver_lock_held(gpusvm);
>>>                  ...
>>>                  range = drm_gpusvm_range_alloc(...);
>>>                  ... mmu_interval_notifier_insert(), kzalloc
>>>
>>>    drm_gpusvm_range_remove() asserts it and frees. This is only safe
>>>    because driver_svm_lock is a sleepable, reclaim friendly lock that is
>>>    never taken from the MMU notifier. Reference counting
>>>     handles range *lifetime*, but it does not
>>>    serialize tree insert/remove, which is exactly why the framework still
>>>    asserts driver_svm_lock on those two entry points regardless of refcount.
>>>
>>> Now the three concrete points:
>>>
>>> A) Why the primary driver_svm_lock is required
>>>
>>>    It is a framework requirement, not an amdgpu invention:
>>>     - DOC: Locking says the driver "should implement" it.
>>>     - drm_gpusvm lockdep-asserts it on every structural entry:
>>>       drm_gpusvm_range_find_or_insert() and drm_gpusvm_range_remove() both
>>>       call drm_gpusvm_driver_lock_held().
>>>     - The reference fault handler holds it across the whole fault:
>>>       GC -> find_or_insert -> migrate -> get_pages -> bind.
>>>
>>>    Xe does exactly this:
>>>     - xe_svm.c:      drm_gpusvm_driver_set_lock(&vm->svm.gpusvm, &vm->lock);
>>>     - xe_pagefault.c: down_write(&vm->lock); before dispatching the fault
>>>     - __xe_svm_handle_pagefault(): lockdep_assert_held_write(&vm->lock);
>>>       held across GC / find_or_insert / alloc_vram / get_pages / rebind
>>>     - xe_svm_garbage_collector(): lockdep_assert_held_write(&vm->lock);
>>>
>>>    amdgpu's svm_lock is the same driver_svm_lock, used the same way.
>>>
>>> B) Why eviction_lock cannot be that lock
>>>
>>>> This lock eviction_lock can only be grabbed while updating the mapping range.
>>>
>>>    and that is precisely why it cannot be driver_svm_lock.
>>>    driver_svm_lock must wrap find_or_insert, migration, and
>>>    drm_gpusvm_range_get_pages
>>>    eviction_lock is the opposite by contract:
>>>
>>>     - It is taken with memalloc_noreclaim_save() in
>>>       amdgpu_vm_begin_critical(), specifically so no reclaim happens while
>>>       held (to avoid the reclaim -> MMU-notifier deadlock). Holding it
>>>       across get_pages/migration breaks that.
>>>     - TTM eviction try-locks it: amdgpu_vm_evictable() does
>>>       scoped_cond_guard(mutex_try, return false, &vm->eviction_lock) and
>>>       sets vm->evicting. Long holds starve eviction.
>>>     - It is a plain mutex that the SVM map path re-enters:
>>>       amdgpu_svm_range_update_mapping() -> amdgpu_vm_map_range() ->
>>>       amdgpu_vm_begin_critical() -> mutex_lock(&vm->eviction_lock). If
>>>       eviction_lock were also the outer SVM lock, this is a self-deadlock.
>>>
>>>    In short, eviction_lock has the contract of notifier_lock , not of
>>>    driver_svm_lock. This is also why the current split is correct:
>>>    svm_lock (outer) != eviction_lock (inner). Your own rule - "you can't
>>>    call the VM code with the lock held, the VM code must take it itself" -
>>>    is satisfied today only because they are separate: svm_lock is held
>>>    while calling amdgpu_vm_map_range(), and amdgpu_vm_map_range() takes
>>>    eviction_lock itself. Merging them is what would violate that rule.
>>>
>>>> No, they Xe vm->lock and eviction_lock are actually identical in the handling.
>>>
>>>    They are not. Xe's vm->lock is a rw_semaphore, the "outer most lock" of
>>>    the VM , held down_write across the whole fault. amdgpu's
>>>    eviction_lock is a mutex taken only inside amdgpu_vm_begin_critical()
>>>    during a PT update, under memalloc_noreclaim. Xe's eviction/reclaim
>>>    handling is separate from vm->lock. The amdgpu analogue of Xe's vm->lock
>>>    is svm_lock, not eviction_lock.
>>>
>>> C) Reusing an existing amdgpu_vm lock as the primary lock needs refactor amdgpu VM
>>>
>>>    Xe can register vm->lock because Xe's VM was designed with an outer
>>>    rw_semaphore held across faults. amdgpu_vm has no such lock: only
>>>    eviction_lock , the root PD dma_resv , and a few spinlocks.
>>>
>>>    So do it like Xe means introducing a dedicated, outer, sleepable VM
>>>    lock held across the fault. That lock is exactly svm_lock. Folding it
>>>    into struct amdgpu_vm as a general vm->lock is a core amdgpu VM refactor.
>>>
>>> Regards,
>>> Honglei
>>>
>>>
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> +
>>>>> +#if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
>>>>> +void amdgpu_svm_flush_tlb(struct amdgpu_svm *svm);
>>>>> +
>>>>> +int amdgpu_svm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>>>>> +void amdgpu_svm_close(struct amdgpu_vm *vm);
>>>>> +void amdgpu_svm_fini(struct amdgpu_vm *vm);
>>>>> +
>>>>> +void amdgpu_svm_put(struct amdgpu_svm *svm);
>>>>> +struct amdgpu_svm *amdgpu_svm_lookup_by_pasid(struct amdgpu_device *adev,
>>>>> +                           uint32_t pasid);
>>>>> +int amdgpu_svm_handle_fault(struct amdgpu_device *adev, uint32_t pasid,
>>>>> +                uint64_t fault_page, uint64_t ts,
>>>>> +                bool write_fault);
>>>>> +bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm);
>>>>> +
>>>>> +int amdgpu_gem_svm_ioctl(struct drm_device *dev, void *data,
>>>>> +             struct drm_file *filp);
>>>>> +void amdgpu_svm_clean_queue(struct amdgpu_svm *svm,
>>>>> +                struct list_head *work_list);
>>>>> +void amdgpu_svm_sync_work(struct amdgpu_svm *svm);
>>>>> +int amdgpu_svm_garbage_collector(struct amdgpu_svm *svm);
>>>>> +int amdgpu_svm_apply_attr_change(struct amdgpu_svm *svm,
>>>>> +                 const struct amdgpu_svm_attrs *old_attrs,
>>>>> +                 const struct amdgpu_svm_attrs *new_attrs,
>>>>> +                 unsigned long start_page,
>>>>> +                 unsigned long last_page);
>>>>> +bool amdgpu_svm_devmem_possible(struct amdgpu_svm *svm);
>>>>> +#else
>>>>> +static inline int amdgpu_svm_init(struct amdgpu_device *adev,
>>>>> +                  struct amdgpu_vm *vm)
>>>>> +{
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +static inline void amdgpu_svm_close(struct amdgpu_vm *vm)
>>>>> +{
>>>>> +}
>>>>> +
>>>>> +static inline void amdgpu_svm_fini(struct amdgpu_vm *vm)
>>>>> +{
>>>>> +}
>>>>> +
>>>>> +static inline int amdgpu_svm_handle_fault(struct amdgpu_device *adev,
>>>>> +                      uint32_t pasid,
>>>>> +                      uint64_t fault_page,
>>>>> +                      uint64_t ts,
>>>>> +                      bool write_fault)
>>>>> +{
>>>>> +    return -EOPNOTSUPP;
>>>>> +}
>>>>> +
>>>>> +static inline bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm)
>>>>> +{
>>>>> +    return false;
>>>>> +}
>>>>> +
>>>>> +static inline int amdgpu_gem_svm_ioctl(struct drm_device *dev, void *data,
>>>>> +                       struct drm_file *filp)
>>>>> +{
>>>>> +    return -EOPNOTSUPP;
>>>>> +}
>>>>> +#endif /* CONFIG_DRM_AMDGPU_SVM */
>>>>> +
>>>>> +#endif /* __AMDGPU_SVM_H__ */
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>> index ec1196d390bb7..30463a83e2e60 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>> @@ -43,6 +43,7 @@ struct amdgpu_bo_va;
>>>>>    struct amdgpu_job;
>>>>>    struct amdgpu_bo_list_entry;
>>>>>    struct amdgpu_bo_vm;
>>>>> +struct amdgpu_svm;
>>>>>      /*
>>>>>     * GPUVM handling
>>>>> @@ -373,6 +374,9 @@ struct amdgpu_vm {
>>>>>          /* cached fault info */
>>>>>        struct amdgpu_vm_fault_info fault_info;
>>>>> +
>>>>> +    /* SVM experimental implementation */
>>>>> +    struct amdgpu_svm *svm;
>>>>>    };
>>>>>      struct amdgpu_vm_manager {
>>>>
>>>
> 

