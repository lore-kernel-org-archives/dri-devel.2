Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5413C5CFDB
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 09:55:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B16810EF3D;
	Wed, 12 Aug 2026 09:55:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GBvhAI89";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010037.outbound.protection.outlook.com
 [52.101.193.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8339D10EF3A;
 Wed, 12 Aug 2026 09:55:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=faHIrQ2VVvZQPpzmpzdCKtquTXdHECTJuIXa5wkFAG20TmbJCNQlEgAR10i949aCJUyH8DyW5jRioYhkQp4xO7Dw0fx7XGkqulupS7dogstNQVHDjnZEkGyJYr4C2ElUmyhDW+eEZIOqgcarmNNVZm5QlDK429SdWbkhY6qNSuyTpDs1h3HBTVYLIPsPuuVFF5DoizhPpIoslKT3wBcJhUVMsa3Vs5haJWF/YujsyKwYqQnM8RvDtDO4Agf8PhDs+ZGR4nRYLVmo9t7mZhMVnkd92hxzTKIdj9lCcCPIrqZDFdENujqW8CmyHQ7IUby16UBkyt1AnuPyibis8NW2QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJJTPB0EBVLeO7KEozuW9PMaXBEWFtjm61isY4JwOVI=;
 b=KmBpoJJichOqqphrakoTlZTyNRfI+TZRyT4jb9eb8W+N1Q2B4ELJMrIFoW/jbrS4INPpg4JhxEZ8Uh+qUOd22Ea0PiogGKoNEMf8FHCMXnDRBxEHV3zyyIz16U+Cg9J2D6CCD5BLloLMkQt5zLox9EpSoBlbkA+TYy76UXLvAXk8Ga6JiMFCxzSxHNdmH4ervpfF4AygQxqmjUdCgXBJwREVWhxwp4q0m3oIdTVLZ2XqvtnD+2dX993Jrw1qORDHwJ/B6SmsE5BL5LPCbzwvwiplFcYQlZO9u5tq1AwieS53j17nCQwLREEduT2GkQ30mDMowDYhhdSt1pnwVt5Mgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJJTPB0EBVLeO7KEozuW9PMaXBEWFtjm61isY4JwOVI=;
 b=GBvhAI89h05oCtOdMmnXLhqjx0KQPgzf3ut6FPMb/nr3M0pkvRiHbsiFUi0krbIiw7GnhzFY92ZWSwohUgGE+BKFqYSuwBTcoQwO2zooguEKaEkChP7uvLMZOXrmPtUjIoxwWhAwFNonFSH6J1vqAghWOJUcWqg4xjn1NRPe3Rc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by IA0PR12MB8351.namprd12.prod.outlook.com (2603:10b6:208:40e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 09:55:38 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%6]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 09:55:38 +0000
Message-ID: <e4e1acc6-c8f6-47af-b3e2-cd4bb396bbde@amd.com>
Date: Wed, 12 Aug 2026 17:55:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/18] drm/amdgpu: add SVM core header and VM
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
References: <20260804094246.1719318-1-ray.huang@amd.com>
 <20260804094246.1719318-3-ray.huang@amd.com>
 <ee51e993-705e-496e-89f4-c5d0196c8951@amd.com>
 <b12d31fb-f9f2-4e09-a0fe-21f2d6bb7999@amd.com>
 <d9439960-3e65-4fc9-921d-02a6052655c2@amd.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <d9439960-3e65-4fc9-921d-02a6052655c2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::18)
 To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|IA0PR12MB8351:EE_
X-MS-Office365-Filtering-Correlation-Id: c0e1392a-e78d-480b-7b1b-08def857dc88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|6133799003|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: kHwCsh8lLqQi+SJ0aHdXfyMWgXmO8UtR0nhqCUmT3vZJ7iGfI42seiTdv+cS6A5W1e/rTRUuhCN/ywcXdP8oOxBmLIpPtgGMJIuj6WQRu3GeswOK9iLkOnZwi9D7tccY3OWfuBte6C9pCp49sxhZHU28ADRDD9BG1ZoQvQ4UBcZF0cRFjJi8sAoQGYEdsN4nnh4J4cVlvcipZW3GAMM+X16OOd7CsdM24p4lOlrq9CXDLLdfcL/M7inFwqc/ESyS7WSA1BpSGfKDeZVCd+svSMD+1f4rhZ25kykNpzslubfXn+JvPlPVhpkoikLvZe26A0WxJ2XpCPJTNs0EUnvURmnVZwOcnFmcXsMg8uX7qVMHGFzuXbkHr+x+EulwcqEKR/IDuc6dZlkU+jlzyOY8n1Fh9+ZNRQRJd6a0J5UO3OhnXQWy1O3UZloX36X8VnA9nlGN9fSyUjXSezIgyqUhWgHh2y78vZK9kXe+LEhbFnCu2WOupjOlb5/4AIwIEUhwS/NRDEpgAO6svyL0LTefAsKhI472DY8FPjuIFnDFVjk1mrcnIEquMcrzsM0GhYq1pop9ZCmVhMwiK9Sh1OSkyt1vuBAZGDt0zLMC5FaUGBl7Grl+KXgDHOUpiS1u+pQYbzrWlhjen3/CsGmjm854Ojncml1TTUOaLFFssmWNwGo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE5ONC9UcDErV01kQWhwbHNoMGRVM3dOc2hlZ1B2Q1FDZWp1M2lCa2QwODlx?=
 =?utf-8?B?UmJFakRlWC9peEIvZzQ3MGZCbmM4eCsxa2J6ejk5ZXNpT0d6bElycEc0VWk1?=
 =?utf-8?B?aVYrSjZUWFNZYUU0TnNWaHRIRURGNW1xSysxbmE5R2RBNXN2MWZwUWxodjVz?=
 =?utf-8?B?bjc5SXViMFU0RzkrNEMrdCtac2wzaUwvUGtyRHdIK3A3bmF5blJyZzJHV0ZN?=
 =?utf-8?B?dDl0SGUwakROTlNwZmtMZ3ZGNEU3MkN0eUJkSkhLcVlPNlFzZS90dUkzUnZk?=
 =?utf-8?B?bmlnYzA3N0Y5ZDRIbU8yem9MZUtrWDVRQ0p4Z0o3bFVEdzIwVzgzSlBwSmk0?=
 =?utf-8?B?WVEzcXJmTHJmeFNUNE45aTJ6Tk9hSDNYelNHNlNXQytEOXZDNllYTGV3MXFz?=
 =?utf-8?B?VmM3UzNlSS9GYUZ2T0JlYjByOUJ6NUYzV0JRcTRyV0E2R2RQRkhXc2NhUDF3?=
 =?utf-8?B?K1VUcVNtNVFDSWJVaW9icEc4RnhmZlo5ZTlubFI2Z0FyKytxWnZ0Q1F3ZDAv?=
 =?utf-8?B?OWM0VVhTOVczRmhkT2haNUtrMHB5bWpMWmRyYkMxb0h2Q01NWXc2ZUF1aE1p?=
 =?utf-8?B?SEZiVVhnVHJqblBRcVJDajlzc2RZbTZOdW9IUmJWL3VqUnA0SzVTT1VnNU53?=
 =?utf-8?B?WUp5azNMYTBrYnAzc2tRRytMM0JjZzJ1WjllY0xIN3lDYVo5NTIxc3VGTEUw?=
 =?utf-8?B?cDVvZVhyRlg2Y1d1MjBYRFlPS29BU1E3TVVnVEpnSlNTT2E2MjFKZWQwcGF1?=
 =?utf-8?B?WDBGakljS2d4dGdhUVFraCtLcXc2VUI3bEZtd3VUaDQzWTQrRjU3Q0pCdWpv?=
 =?utf-8?B?d3BhcndYeDQ0dEZWTHhRYzkxT29ET0FDMWRXNDk1QTd6Sk1ES1NobzhRYmlx?=
 =?utf-8?B?T2YwYzY1M25kWVJTKzVrVkluMEIzc0RLdm9jL0lvNm81a2wrdjl4a0gyK3dF?=
 =?utf-8?B?SWJiZDd4anlkSk1RQWkxTnJZMlg1dE5aa3ZTeXYvQjZtQmdpT2llVEtvbjYy?=
 =?utf-8?B?eWF0MEVCWnZ4R0ZGNUYrNTNyY1hXWjMxYXhMVFhoTW1FSEVmSkx3TDdDTG1N?=
 =?utf-8?B?SlZCVTEzcVhJbGFScTdSOXhkTFNGS2FLN1pXU0I2UTc1cWE0eWE2Q2xDVENu?=
 =?utf-8?B?QjMvL2t2Ymc0alZveWJoVjlpc1pEVFIzM2NZSE1KamZRbFBOSmVJSFZlLzF4?=
 =?utf-8?B?MVpiUFIyV1hscTJjZ3pnODRGem0wNWJpa0RWOXluM0FERGF4TWprNkVhWEZP?=
 =?utf-8?B?ak5GL2Q2UnkyMnRpdUp0NStXdG9XTE5MWG5JVTFhVEIvNGFZdmRNK09kclFy?=
 =?utf-8?B?UFFwMy9TVG0zbE14T1A0c2E3YUNrdldkTGUwbG9KNFM0RVVHUTBOK1pLb3U4?=
 =?utf-8?B?RlNrSlZmdU1xZUc4MHptWjBBVUMrbjNZVmtYWEN4UEpHbTFoK1dFLytFTFVX?=
 =?utf-8?B?LzFYNHlGTGt1ZHVWYm56eDRqQXdoM0w2RWR4YmlIQzMydkt2OXhNNVZma3VF?=
 =?utf-8?B?a3B4em9KRUp6TS9IZ1hGSXJyaWxUQVlUeG9FNWJOQi81UmNnTkg5MW5CVThp?=
 =?utf-8?B?eDhGOUo2YStRaFNjTml3VkhmRUx1UHFYc3pHUENUcEdheWhWRDk2b0hxMjJt?=
 =?utf-8?B?Y28wM21JZU9ROElwYUJ5dytVa2JvR1QvbVpqdjVZZnR6Qk9QcTZENElob1Fm?=
 =?utf-8?B?VGZKVnNNcjVpdnl0cktxRnZKTHROR2hveDAyaGpUSms0bjMxSnFzTmoyVUw1?=
 =?utf-8?B?NkJlQXp6b1pEWEt2eFBndGFsVk51RlJ2TE41V29GYy9aTFZQa0tkNjFRa0tF?=
 =?utf-8?B?cXh0SXM4d1h1Tm9sVEhXblFSM1JpR1RVVCtFNzkzZFh1c3dmYVlXUDhXMDBz?=
 =?utf-8?B?SmRCYy9MeVlVY0tRcCs1Vm96N2l6WXJ5RkRpTFUzQ29DKzlCakpsdkQ0YkFG?=
 =?utf-8?B?UzBkeE43OVQrMS9rNkZIcUFnbGlsY0Z1YWdhdTJWU3N0T081aGcvb25LMEJU?=
 =?utf-8?B?QlZOaE9JVEJFQVd3cS9UV1pUOGp4dW81ZzR2MTk5NVdaeUFMckxGR1Nxa0tm?=
 =?utf-8?B?ZXlhL2NBUjhzb01wRFc3K0NHSG1LTThHdWZvbURwUHpORlZMaWRCcTF4c3BZ?=
 =?utf-8?B?eGRmMHZ4QlNOODRxZ250azBnYnRvdDhOeHlTVEYrQ0k0N21Mc0Jtd05BZHFm?=
 =?utf-8?B?M2svOUQ3Mm1rUEFMZnBIVGNmdHFxZ2MrWncxN1N2WVdIaHJVWkduTkEwbjFz?=
 =?utf-8?B?dDJURGdmT0ZHdDZKdDVPNnNLMDBZRG5tNGJiVS9qVy9KV0QybWJRZStJcjIr?=
 =?utf-8?B?SCtzUEVtanAyT1Ywa3d2am5UdzcxeWxYUWllcVV5OWsxUnBPWGtVZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e1392a-e78d-480b-7b1b-08def857dc88
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 09:55:38.2163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D0DEz8ohSBdmAfQdWDvTO+nkD0KnHZIvBcj0LRSVrY/TNcuUXvc59XMnbCaX/FHkiqPezord1pP6xuxp6wQrKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8351
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



On 8/12/2026 4:36 PM, Christian König wrote:
> On 8/11/26 16:06, Huang, Honglei wrote:
> ...
>>>> +/*
>>>> + * Helpers for amdgpu_svm.svm_lock, the driver_svm_lock registered with GPU SVM.
>>>> + * Hold it in write mode around structural GPU SVM updates, including
>>>> + * drm_gpusvm_range_find_or_insert() and drm_gpusvm_range_remove().
>>>> + */
>>>> +static inline void amdgpu_svm_lock(struct amdgpu_svm *svm)
>>>> +{
>>>> +    down_write(&svm->svm_lock);
>>>> +}
>>>> +
>>>> +static inline void amdgpu_svm_unlock(struct amdgpu_svm *svm)
>>>> +{
>>>> +    up_write(&svm->svm_lock);
>>>> +}
>>>> +
>>>> +static inline void amdgpu_svm_assert_locked(struct amdgpu_svm *svm)
>>>> +{
>>>> +    lockdep_assert_held_write(&svm->svm_lock);
>>>> +}
>>>
>>> I'm starting to repeat myself, so once more: This stuff doesn't work like that!
>>>
>>> The lock the SVM subsystem uses to serialize updates *must* be the amdgpu_vm->eviction_lock and *not* a separate one.
>>>
>>> So clear NAK to having this functions here.
>>
>>
>> I have explained why eviction lock can not be used as svm lock in V8, previous version. And it seems like we have a big gap about it.
>>
>> The eviction lock can not be used for svm lcok.
>>
>> And the design of svm lock is the core locking design of drmsvm frame work, without this desgin, this framework lost its soul. So I have to explain how to use this lock.
>>
>> I believe we are talking about two different locks.
> 
> Yeah, that stuff is more than a bit complicated. The key point is that I still don't see any of the mandatory changes to amdgpu_vm.c in this patch set.
> 
>> You may treat svm lock as notifier lock. drm_gpusvm has two of them, and the "no allocation while held in the MMU notifier" rule applies
>> to the other one, not to driver_svm_lock.
>>
>> 1) drm_gpusvm has two distinct locks: drivers/gpu/drm/drm_gpusvm.c
>>
>>    - notifier_lock: safeguards the notifier's range RB tree and list, as
>>      well as the range's DMA mappings and sequence number. ... This lock
>>      corresponds to the driver->update lock mentioned in
>>      Documentation/mm/hmm.rst."
> And that one here *MUST* be identical to the eviction lock in amdgpu_vm.c

Actually I have a question about this,

The notifier lock protects the CPU pages tables, it prevents the 
migration/swap ... from MM logic.

And the eviction lock protects the GPU VM page table, it prevents gpu 
page table changes from TTM logic.

They have different jobs,

when doing a GPU mapping in SVM, cpu page table can not change, casue it
may change the cpu dma addr -> gpu mapping. So must hold it, it is done 
in current code, and it is must required by drm gpu svm frame work.

And at the same time the eviciton lock must hold also, casue the GPU 
page tables may change by TTM logic.

Those two locks are all need be hold, no conflict, this is just my thought.

Regards,
Honglei

> 
> The background is that XE uses a different page table allocation approach than amdgpu and we need to drop this lock in amdgpu to be able to allocate page tables. See function amdgpu_vm_pt_alloc().
> 
> With that design here that currently doesn't work at all.
> 
> We have two options, either use the drm_gpusvm notifier_lock as eviction_lock in amdgpu_vm.c or re-design amdgpu_vm.c to use the same approach for allocating page tables as XE.
> 
> Some engineer from Valve is working on re-designing amdgpu_vm.c, but that will potentially take month if not years.
> 
> So my take is that the new SVM code needs to modify amdgpu_vm.c so that the drm_gpusvm notifier_lock is used as eviction lock by the VM code.
> 

> Regards,
> Christian.
> 
> 
>>
>>    - driver_svm_lock: In addition to the locking mentioned above, the
>>      driver should implement a lock to safeguard core GPU SVM function
>>      calls that modify state, such as drm_gpusvm_range_find_or_insert and
>>      drm_gpusvm_range_remove.
>>
>>    Two locks, two jobs.
>>
>> 2) The lock held in the MMU notifier is notifier_lock, never driver_svm_lock
>>
>>    drm_gpusvm_notifier_invalidate():
>>          down_write(&gpusvm->notifier_lock);
>>          ...
>>          gpusvm->ops->invalidate(gpusvm, notifier, mmu_range);
>>
>>    The driver invalidate callback runs under notifier_lock only. Per the
>>    framework's own notifier example it just unmaps pages
>>    and queues the range to the garbage collector no allocation, and it
>>    does not take driver_svm_lock:
>>
>>          drm_gpusvm_range_unmap_pages(...);
>>          drm_gpusvm_range_set_unmapped(...);
>>          driver_garbage_collector_add(...);
>>
>> 3) driver_svm_lock is by design an allocating, process context lock
>>
>>    drm_gpusvm_range_find_or_insert() asserts it and then allocates under it:
>>
>>          drm_gpusvm_range_find_or_insert():
>>                  drm_gpusvm_driver_lock_held(gpusvm);
>>                  ...
>>                  range = drm_gpusvm_range_alloc(...);
>>                  ... mmu_interval_notifier_insert(), kzalloc
>>
>>    drm_gpusvm_range_remove() asserts it and frees. This is only safe
>>    because driver_svm_lock is a sleepable, reclaim friendly lock that is
>>    never taken from the MMU notifier. Reference counting
>>     handles range *lifetime*, but it does not
>>    serialize tree insert/remove, which is exactly why the framework still
>>    asserts driver_svm_lock on those two entry points regardless of refcount.
>>
>> Now the three concrete points:
>>
>> A) Why the primary driver_svm_lock is required
>>
>>    It is a framework requirement, not an amdgpu invention:
>>     - DOC: Locking says the driver "should implement" it.
>>     - drm_gpusvm lockdep-asserts it on every structural entry:
>>       drm_gpusvm_range_find_or_insert() and drm_gpusvm_range_remove() both
>>       call drm_gpusvm_driver_lock_held().
>>     - The reference fault handler holds it across the whole fault:
>>       GC -> find_or_insert -> migrate -> get_pages -> bind.
>>
>>    Xe does exactly this:
>>     - xe_svm.c:      drm_gpusvm_driver_set_lock(&vm->svm.gpusvm, &vm->lock);
>>     - xe_pagefault.c: down_write(&vm->lock); before dispatching the fault
>>     - __xe_svm_handle_pagefault(): lockdep_assert_held_write(&vm->lock);
>>       held across GC / find_or_insert / alloc_vram / get_pages / rebind
>>     - xe_svm_garbage_collector(): lockdep_assert_held_write(&vm->lock);
>>
>>    amdgpu's svm_lock is the same driver_svm_lock, used the same way.
>>
>> B) Why eviction_lock cannot be that lock
>>
>>> This lock eviction_lock can only be grabbed while updating the mapping range.
>>
>>    and that is precisely why it cannot be driver_svm_lock.
>>    driver_svm_lock must wrap find_or_insert, migration, and
>>    drm_gpusvm_range_get_pages
>>    eviction_lock is the opposite by contract:
>>
>>     - It is taken with memalloc_noreclaim_save() in
>>       amdgpu_vm_begin_critical(), specifically so no reclaim happens while
>>       held (to avoid the reclaim -> MMU-notifier deadlock). Holding it
>>       across get_pages/migration breaks that.
>>     - TTM eviction try-locks it: amdgpu_vm_evictable() does
>>       scoped_cond_guard(mutex_try, return false, &vm->eviction_lock) and
>>       sets vm->evicting. Long holds starve eviction.
>>     - It is a plain mutex that the SVM map path re-enters:
>>       amdgpu_svm_range_update_mapping() -> amdgpu_vm_map_range() ->
>>       amdgpu_vm_begin_critical() -> mutex_lock(&vm->eviction_lock). If
>>       eviction_lock were also the outer SVM lock, this is a self-deadlock.
>>
>>    In short, eviction_lock has the contract of notifier_lock , not of
>>    driver_svm_lock. This is also why the current split is correct:
>>    svm_lock (outer) != eviction_lock (inner). Your own rule - "you can't
>>    call the VM code with the lock held, the VM code must take it itself" -
>>    is satisfied today only because they are separate: svm_lock is held
>>    while calling amdgpu_vm_map_range(), and amdgpu_vm_map_range() takes
>>    eviction_lock itself. Merging them is what would violate that rule.
>>
>>> No, they Xe vm->lock and eviction_lock are actually identical in the handling.
>>
>>    They are not. Xe's vm->lock is a rw_semaphore, the "outer most lock" of
>>    the VM , held down_write across the whole fault. amdgpu's
>>    eviction_lock is a mutex taken only inside amdgpu_vm_begin_critical()
>>    during a PT update, under memalloc_noreclaim. Xe's eviction/reclaim
>>    handling is separate from vm->lock. The amdgpu analogue of Xe's vm->lock
>>    is svm_lock, not eviction_lock.
>>
>> C) Reusing an existing amdgpu_vm lock as the primary lock needs refactor amdgpu VM
>>
>>    Xe can register vm->lock because Xe's VM was designed with an outer
>>    rw_semaphore held across faults. amdgpu_vm has no such lock: only
>>    eviction_lock , the root PD dma_resv , and a few spinlocks.
>>
>>    So do it like Xe means introducing a dedicated, outer, sleepable VM
>>    lock held across the fault. That lock is exactly svm_lock. Folding it
>>    into struct amdgpu_vm as a general vm->lock is a core amdgpu VM refactor.
>>
>> Regards,
>> Honglei
>>
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>>> +
>>>> +#if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
>>>> +void amdgpu_svm_flush_tlb(struct amdgpu_svm *svm);
>>>> +
>>>> +int amdgpu_svm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>>>> +void amdgpu_svm_close(struct amdgpu_vm *vm);
>>>> +void amdgpu_svm_fini(struct amdgpu_vm *vm);
>>>> +
>>>> +void amdgpu_svm_put(struct amdgpu_svm *svm);
>>>> +struct amdgpu_svm *amdgpu_svm_lookup_by_pasid(struct amdgpu_device *adev,
>>>> +                           uint32_t pasid);
>>>> +int amdgpu_svm_handle_fault(struct amdgpu_device *adev, uint32_t pasid,
>>>> +                uint64_t fault_page, uint64_t ts,
>>>> +                bool write_fault);
>>>> +bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm);
>>>> +
>>>> +int amdgpu_gem_svm_ioctl(struct drm_device *dev, void *data,
>>>> +             struct drm_file *filp);
>>>> +void amdgpu_svm_clean_queue(struct amdgpu_svm *svm,
>>>> +                struct list_head *work_list);
>>>> +void amdgpu_svm_sync_work(struct amdgpu_svm *svm);
>>>> +int amdgpu_svm_garbage_collector(struct amdgpu_svm *svm);
>>>> +int amdgpu_svm_apply_attr_change(struct amdgpu_svm *svm,
>>>> +                 const struct amdgpu_svm_attrs *old_attrs,
>>>> +                 const struct amdgpu_svm_attrs *new_attrs,
>>>> +                 unsigned long start_page,
>>>> +                 unsigned long last_page);
>>>> +bool amdgpu_svm_devmem_possible(struct amdgpu_svm *svm);
>>>> +#else
>>>> +static inline int amdgpu_svm_init(struct amdgpu_device *adev,
>>>> +                  struct amdgpu_vm *vm)
>>>> +{
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static inline void amdgpu_svm_close(struct amdgpu_vm *vm)
>>>> +{
>>>> +}
>>>> +
>>>> +static inline void amdgpu_svm_fini(struct amdgpu_vm *vm)
>>>> +{
>>>> +}
>>>> +
>>>> +static inline int amdgpu_svm_handle_fault(struct amdgpu_device *adev,
>>>> +                      uint32_t pasid,
>>>> +                      uint64_t fault_page,
>>>> +                      uint64_t ts,
>>>> +                      bool write_fault)
>>>> +{
>>>> +    return -EOPNOTSUPP;
>>>> +}
>>>> +
>>>> +static inline bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm)
>>>> +{
>>>> +    return false;
>>>> +}
>>>> +
>>>> +static inline int amdgpu_gem_svm_ioctl(struct drm_device *dev, void *data,
>>>> +                       struct drm_file *filp)
>>>> +{
>>>> +    return -EOPNOTSUPP;
>>>> +}
>>>> +#endif /* CONFIG_DRM_AMDGPU_SVM */
>>>> +
>>>> +#endif /* __AMDGPU_SVM_H__ */
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>> index ec1196d390bb7..30463a83e2e60 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>> @@ -43,6 +43,7 @@ struct amdgpu_bo_va;
>>>>    struct amdgpu_job;
>>>>    struct amdgpu_bo_list_entry;
>>>>    struct amdgpu_bo_vm;
>>>> +struct amdgpu_svm;
>>>>      /*
>>>>     * GPUVM handling
>>>> @@ -373,6 +374,9 @@ struct amdgpu_vm {
>>>>          /* cached fault info */
>>>>        struct amdgpu_vm_fault_info fault_info;
>>>> +
>>>> +    /* SVM experimental implementation */
>>>> +    struct amdgpu_svm *svm;
>>>>    };
>>>>      struct amdgpu_vm_manager {
>>>
>>

