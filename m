Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81152C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:16:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8127810E002;
	Thu, 13 Aug 2026 09:16:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zU6PEXuC";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010038.outbound.protection.outlook.com [52.101.85.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A8EC10E002;
 Thu, 13 Aug 2026 09:16:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IoJVuDIgebGMDccqiuRO5+T6yLY0lq0clziBa0oXc1Ldo02osZ7trxhQAy4N4bkZzWWy1mpRTvIJbI72rSIEzsFKLGgubdNu1LGYFGI+jTB1iA9s+kZEqNbRrLiq2L+u8V+ZKI+I7klY63Kffqi/99fH8ZZ55Vm3bEhljEqAw7c8MuLtchyHcOZOwWCQCtM7dvEPTXLeTeo1lWXE6mM94ZGcEDYwXQx++ooC28WhUFOYx23c0g6c/Eg/PalMPmJ0Bf6swGA7zf+qS2HU7C+4B3fPGdq28jPqcaayhQRuNFYIWNBHNl+nqC7filc90gSIuSD8u8VvlkNsn4vjgbEPrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pr01VPl7cUAPahSl4aVy0pcPeovr542ydgyG4HwTYs=;
 b=ekpJu6agtshE08TNvqClLImvp5CoMbOXD56C5hiojHPg9ofebwIUnpdWIM0/QiY9FrDH6w4nj7q3UyBsIp6Oe7IQgvJtX8axTD2qRT314Ldb8A9oKZrdXUpD/t1lPiMKFZLqEvFeh9qvfvPYr9FZ+RFO1SLFuy6YKH3FnFkzSitl1b4cJ5E9w92rCA9r9QRgzmM58isD2ZbVa1wVBEsNQ3DxbRkBk6rSiIchrPkJ2uMCyiT6pC99bSr1F52sz7XV87QKH8pvLGax/2vz5r2OMakInUfBswZ6uL6g61wer1RyX0P75xSqAN4IEkQQJC3KxGnHCZ393XwBMl2/U3JQYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pr01VPl7cUAPahSl4aVy0pcPeovr542ydgyG4HwTYs=;
 b=zU6PEXuC9G9MqpMWPymmH70ZNa3BuiL3cIATgNsuGnwYm+xWOhzNObbOInHlsWVS1m9nA19NUbFoyM2oli/CV/dFoRXoj0wPbon+D3l0xziimF/CIz4zQccbL9dYD+HW06r78tjKF0NNhEHoNxSs1wUQA6gYjwqKWC8egpMfkBA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by MN6PR12MB8490.namprd12.prod.outlook.com (2603:10b6:208:470::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 09:16:24 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%6]) with mapi id 15.21.0315.012; Thu, 13 Aug 2026
 09:16:24 +0000
Message-ID: <bef7c6cc-d3b7-492f-abef-bf87e49c6b3e@amd.com>
Date: Thu, 13 Aug 2026 17:16:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/18] drm/amdgpu: add SVM core header and VM
 integration
To: Christian KKKnig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>
Cc: Philip Yang <Philip.Yang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Jenny Liu <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>,
 Yiru Ma <yiru.ma@amd.com>, Simona Vetter <simona@ffwll.ch>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Thomas Hellstrrrm <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260804094246.1719318-1-ray.huang@amd.com>
 <20260804094246.1719318-3-ray.huang@amd.com>
 <ee51e993-705e-496e-89f4-c5d0196c8951@amd.com>
 <b12d31fb-f9f2-4e09-a0fe-21f2d6bb7999@amd.com>
 <d9439960-3e65-4fc9-921d-02a6052655c2@amd.com>
 <e4e1acc6-c8f6-47af-b3e2-cd4bb396bbde@amd.com>
 <ffda865c-2f2f-4b5c-a21d-6d0ef7c1b10a@amd.com> <anx29y9NdLSrkkBk@amd.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <anx29y9NdLSrkkBk@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0038.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::15) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|MN6PR12MB8490:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eb4c668-f22d-46d1-c2ac-08def91b8bc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: TbCIxy/HKK+WoqSIGyOB9VBGifYYtdVPlrEGyzXMTqu9bh6XYbv6HThuQv25KifxY76cjYtgju1teluyQRiNahSmXa78q3wb7YDdtCJVD64UI+sEkRLXZst65zpraPkEjJOnGh7KlT7psstvh5l8Mt9TkGDsaO5K2Z8HeJd9g7aNP3CMJZS8stwT3aS4/ZxDPvxX8WWe4hjcQicFY9BME5ZG4iHGpkobCqCU0abFHUO5U4aUol97DZnUWBcWGcVDwInQaR/frCDdfqsPZ2GMXedgSBqrg6tgjArK7edJ3yLaEkLjb1eKbAJIInpMdhxIDJdVLaDzVl9qA/eQ9joV7PB7KYNLffvcmjU0s5tbjwLYOnJ5PYOwVOaxt9CHwn8MfWzHUqKWG/xx/No0Q/DreDLqeVC5wxmdo7mC3hfDmYfuHXIB1lJiD/ZIAbB94Man5ZT4sTBZvSkckdWNTZFFVKkCrMMQeqLQ7G/I5I8l9MdIpo3vxxrPzki5hNEbChCY6rzpOtQP0LlEx9Uvc8usMY+v1AwPaVBrPLVwPKBWRUSxcoBlB0ozZgQWvHCSlh585+8a1Uia9pbN4TDxXBDgo3UUvJNSeGrwzKWsDWHQo3rnzWJZSrwg38nrFs/DJeYdFAHZNMsoO999wMqUlkS7nUgROVxRCQS6CIELqL6wTm0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TncydFJKK3Z2KzZabG5wSWtrRS96anZJMm9rejJRTGdXek1mdHVtOFQyZzBr?=
 =?utf-8?B?WWJxZWRPMXpTU1JGY1JkTTdJSFNFKzF1VXRPV3lxaWVLNVM2dGtxQTJzTDQ4?=
 =?utf-8?B?K1c0cXExdTVwUDhYWmVsSmdvY3l5NGJUMFFSTmN1bHE1QXQ1OUJqVXE2VVZY?=
 =?utf-8?B?VVJ3YW01cC9SNTRpV2pYREZ1N0JYU200UXBYQUdYVG5NQ1lRZDVta1E0RExx?=
 =?utf-8?B?ZzZxTjNXSTRlTlgzMVROcTd0QVhkd2NPN3l2ME1IRGpzM2J3akd5QmgzaHBy?=
 =?utf-8?B?eStORFZwd0Mrb1Z0QVZIMUYzRW9NSW1LNDdOQXNLOXA5RmdQcW9wRnVmSjcv?=
 =?utf-8?B?OUZrejdLOWRUZ0lvbGM3b2hmdDVWQ3A3UkRYRWNZVjdGbVhMYXJkS3BFenZB?=
 =?utf-8?B?VG5EaXJ0UnFObE80WWs0TFA5dmpDZWJVR3g3SGRaYjRHVzFKaFovVTFJYlc5?=
 =?utf-8?B?YWgyR1djTmJTeW5UZDR0NHBPVG5YRXpHSG8zOXZZanVUZytIZk9xSmhJWHNt?=
 =?utf-8?B?TzJVRTgzdE5iSTRnY2ZyWDB2a3FpQ0JTbDF1L05hRWhpUUIxVGZDUFlKeExP?=
 =?utf-8?B?eFUwZUt3RXJOblRhWElJd0xLS00zM0dLZHAxbFM0Zi9YZVN3MDhXZW5oK05u?=
 =?utf-8?B?YzRsdXNOYTdHVWdKV1gwTWQ4VzRCQWFQeVpkM0ZjQnBub2RjZ3VpYzdrOVRp?=
 =?utf-8?B?TU1ZZzdWZXhwQ1VuMjh1U0Q2WHgwNFd3dTRGYlFWaTdBVXFMQVp4UkwvRCtl?=
 =?utf-8?B?VHU5Vlh0VE5UK0c1Zkhkam92dkJkMVAvaWN3c0ZMa2VGN0FYNXo1bTA5YWpO?=
 =?utf-8?B?b2Nua2puQTJ6NFZzWWxTUWxXS2JGdHVhTGJEQnNmb3dxcE1xOTlDUCtWeXkv?=
 =?utf-8?B?aVMrY3NQOFJsS0lneXBZMVp0QStFRW55VkxJZ0xJeGZNdFpPUlE4eS9Bdkw1?=
 =?utf-8?B?ZUt5TGZTSnJjUWNQR2RGTFpDelJqTnl2VTJZb3hmNHViQmpmNUF0S2Flcm9M?=
 =?utf-8?B?a2RTTStrZjI0OEF0bDVoekJ4d1JaOWNHK3RxNkFqd0w2Z0ZySjRwdm1MbEdW?=
 =?utf-8?B?OFZnaE9ZVm8yZGUvWWZLOU1CbU94TDVpZGJvVHRXZXhXSU1kRmdIa3lXT2Z0?=
 =?utf-8?B?bjRnd1lHN2I4WUpvUSs2VHAzQWc3cWtJckE3OE9Rc2k2WTNtb0c3T2NGVGdt?=
 =?utf-8?B?RnVkT3J2czU1UldNZ09rNDJMRXNYZHZ1UCs4UWptakhaUEN6aTFab0Jla09w?=
 =?utf-8?B?YzhTNUYrZE90Qm5nR1E5amJKaW1MR1c4Q1o3QUVMeGE4Mk55cU5wUFBZQXNK?=
 =?utf-8?B?SXZHeFJHV3pPcEdvNTJhd1p6bzZxWko0cndvMU1kQnAyUHZwWkRmaXlURGJp?=
 =?utf-8?B?dXlZekRPQmVHQXI2RDV6WWV4Q3M0TjlwSElycWhBdVFxZFNiVFBKU3BmcjRQ?=
 =?utf-8?B?YUNJTXFieHlFcVNuUWdCbDRwdXlFU0lUdDdGaHBNTjZEcGR6Uzc2QjFEVmJu?=
 =?utf-8?B?VklURXhtcWpybTlWOUYxb0JDMVB6bnVWSk52R29uaDFyaDFxSU9zdU1QVlU5?=
 =?utf-8?B?QnIvS01BK3ltelgzZzJlcTJvN2lOd3ptN0RZaUZ1dU1OV0lROTVHdnd0VGhJ?=
 =?utf-8?B?ZWF2aFdBckhObVFTLysybENneVVmUTkyWnVKR1V5QVBPSmZMK3p0WHpQNXc0?=
 =?utf-8?B?MHZnYkJpc2ZVOXhYL0hxRkNIV2ZKemZHNmFSbDdQWklaQWZ0OXNHWE1FQ2V0?=
 =?utf-8?B?NFFkVU9YZGFGeGlhSHdjTHZvWExWMzdreGRwRGpvdkE2RHE2Z1cvOHBrdkRi?=
 =?utf-8?B?WGUwQXhGNUlmOVRJY3hqR3l4OFZhcVM5YSs2Sm9XUmdWZ0FDYmZDbC9wUkNI?=
 =?utf-8?B?VHdjUm0yM293MVAzUTRBS1Z4MlV0YWtoWUJDL2xIdlU4N215RUpucngzQ09t?=
 =?utf-8?B?U3lBRDBzQkNtdk5iaTg5Q0J6ckR0SVRsazdRVUpjSVE5Y2RUWDhjVy9TVldv?=
 =?utf-8?B?ajltL0EzVEwrTzhTRFJMZlF4ZWNhMkhTV2gySjhyVzNWRS9YQ0t4UktDTGZF?=
 =?utf-8?B?a0kzVVRiM2JkQnZQaTJGOXc2YkE3L3R5VFI0TDQ4Z2FvSXVITWNPTzZ5TUJr?=
 =?utf-8?B?RkdURzFkeGJIcXJlSloxOHVub0JaR0NBVitYUE9pU09NSjRNVTNUR1hTeEpH?=
 =?utf-8?B?dmw1VUhuWjBJd3M2NDk4SlYvZk1qWW5kcHVsTjNSaWlvWjRGYy9RWDNJSG1R?=
 =?utf-8?B?emF4NHdhTkZUelB5L2RPQmpXMzhDcUJ5TUdpc0Q0L2kwZDFiK1NoUzNzNVdr?=
 =?utf-8?B?ZjZLUGE3NTM1K3R2SkhtOXBVYWpPOGpnYy82allWZy9HYUhneWlGdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb4c668-f22d-46d1-c2ac-08def91b8bc5
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 09:16:23.9065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ti4nhD/Ht6Xnp4s8N7UCiBuo3OeHQFivYYNt07JaPAGGRd7JMfCJXOE/4YPn/3As6lkLiwmSN5ums6jlRPGs9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8490
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



On 8/12/2026 9:36 PM, Huang Rui wrote:
> On Wed, Aug 12, 2026 at 02:16:03PM +0200, Christian KKKnig wrote:
>> On 8/12/26 11:55, Huang, Honglei wrote:
>>> On 8/12/2026 4:36 PM, Christian König wrote:
>>>> On 8/11/26 16:06, Huang, Honglei wrote:
>>>> ...
>>>>>>> +/*
>>>>>>> + * Helpers for amdgpu_svm.svm_lock, the driver_svm_lock registered with GPU SVM.
>>>>>>> + * Hold it in write mode around structural GPU SVM updates, including
>>>>>>> + * drm_gpusvm_range_find_or_insert() and drm_gpusvm_range_remove().
>>>>>>> + */
>>>>>>> +static inline void amdgpu_svm_lock(struct amdgpu_svm *svm)
>>>>>>> +{
>>>>>>> +    down_write(&svm->svm_lock);
>>>>>>> +}
>>>>>>> +
>>>>>>> +static inline void amdgpu_svm_unlock(struct amdgpu_svm *svm)
>>>>>>> +{
>>>>>>> +    up_write(&svm->svm_lock);
>>>>>>> +}
>>>>>>> +
>>>>>>> +static inline void amdgpu_svm_assert_locked(struct amdgpu_svm *svm)
>>>>>>> +{
>>>>>>> +    lockdep_assert_held_write(&svm->svm_lock);
>>>>>>> +}
>>>>>>
>>>>>> I'm starting to repeat myself, so once more: This stuff doesn't work like that!
>>>>>>
>>>>>> The lock the SVM subsystem uses to serialize updates *must* be the amdgpu_vm->eviction_lock and *not* a separate one.
>>>>>>
>>>>>> So clear NAK to having this functions here.
>>>>>
>>>>>
>>>>> I have explained why eviction lock can not be used as svm lock in V8, previous version. And it seems like we have a big gap about it.
>>>>>
>>>>> The eviction lock can not be used for svm lcok.
>>>>>
>>>>> And the design of svm lock is the core locking design of drmsvm frame work, without this desgin, this framework lost its soul. So I have to explain how to use this lock.
>>>>>
>>>>> I believe we are talking about two different locks.
>>>>
>>>> Yeah, that stuff is more than a bit complicated. The key point is that I still don't see any of the mandatory changes to amdgpu_vm.c in this patch set.
>>>>
>>>>> You may treat svm lock as notifier lock. drm_gpusvm has two of them, and the "no allocation while held in the MMU notifier" rule applies
>>>>> to the other one, not to driver_svm_lock.
>>>>>
>>>>> 1) drm_gpusvm has two distinct locks: drivers/gpu/drm/drm_gpusvm.c
>>>>>
>>>>>     - notifier_lock: safeguards the notifier's range RB tree and list, as
>>>>>       well as the range's DMA mappings and sequence number. ... This lock
>>>>>       corresponds to the driver->update lock mentioned in
>>>>>       Documentation/mm/hmm.rst."
>>>> And that one here *MUST* be identical to the eviction lock in amdgpu_vm.c
>>>
>>> Actually I have a question about this,
>>>
>>> The notifier lock protects the CPU pages tables, it prevents the migration/swap ... from MM logic.
>>>
>>> And the eviction lock protects the GPU VM page table, it prevents gpu page table changes from TTM logic.
>>>
>>> They have different jobs,
>>
>> No, exactly that is what we have gotten wrong in the existing KFD SVM implementation.
>>
>>>
>>> when doing a GPU mapping in SVM, cpu page table can not change, casue it
>>> may change the cpu dma addr -> gpu mapping. So must hold it, it is done in current code, and it is must required by drm gpu svm frame work.
>>>
>>> And at the same time the eviciton lock must hold also, casue the GPU page tables may change by TTM logic.
>>>
>>> Those two locks are all need be hold, no conflict, this is just my thought.
>>
>> Originally the notifier_lock only made sure that the CPU page table updates where done in order and originally the eviction lock made sure that the GPU page table updates where done in order, but essentially we need the order for both.
>>
>> The point is that the updates need to be serialized. In other words when one CPU is doing a mapping operation and another CPU is doing an unmap through an MMU notifier we somehow need to make sure that the coresponding GPU page table updates execute in the correct order.
>>
>> So essentially those two locks need to be the same one, and we need to drop the lock to allocate page tables and when we re-acquire it we need to double check the sequence number to make sure that no unmap operation happened concurrently.
>>
>> And yeah I know that this makes things much much more complicated, but it is definately necessary.
>>
> 
> So, if I understand your point correctly, the best way to solve the
> serialization issue between these two locks is to turn them into a single
> lock. Given that a full re-design of amdgpu_vm could take a significant
> amount of time, it seems that using drm_gpusvm's notifier_lock as a
> replacement for eviction_lock in amdgpu_vm would be the more practical
> short-term solution.
> 
> Please correct me if I've misunderstood your position.
> 
> Thanks,
> Ray


Hi Christian,

I made some changes based on your modification to unify the locking,
only use the notifier lock when svm is enabled,
instead of using notifier lock and eviciton lock at the same time.

see diff below, not sure if it is correct, so confirming with you：


  static inline int amdgpu_vm_begin_critical(struct 
amdgpu_vm_update_params *p)
  {
-	mutex_lock(&p->vm->eviction_lock);
+	struct amdgpu_vm *vm = p->vm;
+
+	if (vm->svm)
+		down_read(&vm->svm->gpusvm.notifier_lock);
+	else
+		mutex_lock(&vm->eviction_lock);
      p->saved_flags = memalloc_noreclaim_save();
-	if (p->vm->evicting)
+	if (vm->evicting)
          return -EBUSY;
      if (p->hmm_range && !amdgpu_hmm_range_valid(p->hmm_range))
          return -EAGAIN;
@@ -174,8 +181,13 @@ static inline int amdgpu_vm_begin_critical(struct 
amdgpu_vm_update_params *p)
   */
  static inline void amdgpu_vm_end_critical(struct 
amdgpu_vm_update_params *p)
  {
+	struct amdgpu_vm *vm = p->vm;
+
      memalloc_noreclaim_restore(p->saved_flags);
-	mutex_unlock(&p->vm->eviction_lock);
+	if (vm->svm)
+		up_read(&vm->svm->gpusvm.notifier_lock);
+	else
+		mutex_unlock(&vm->eviction_lock);
  }


if above is valid, I have a question that
some places still not using begin/end critical, using vm->eviction_lock 
directly, do thoes places need to be changed?
amdgpu_vm_evictable():
	scoped_cond_guard(mutex_try, return false, &vm->eviction_lock)

amdgpu_vm_validate():
	scoped_guard(mutex, &vm->eviction_lock)

amdgpu_vm_ready()
	scoped_guard(mutex, &vm->eviction_lock)

Regards,
Honglei

> 
>> Regards,
>> Christian.
>>
>>>
>>> Regards,
>>> Honglei
>>>
>>>>
>>>> The background is that XE uses a different page table allocation approach than amdgpu and we need to drop this lock in amdgpu to be able to allocate page tables. See function amdgpu_vm_pt_alloc().
>>>>
>>>> With that design here that currently doesn't work at all.
>>>>
>>>> We have two options, either use the drm_gpusvm notifier_lock as eviction_lock in amdgpu_vm.c or re-design amdgpu_vm.c to use the same approach for allocating page tables as XE.
>>>>
>>>> Some engineer from Valve is working on re-designing amdgpu_vm.c, but that will potentially take month if not years.
>>>>
>>>> So my take is that the new SVM code needs to modify amdgpu_vm.c so that the drm_gpusvm notifier_lock is used as eviction lock by the VM code.
>>>>
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>
>>>>>
>>>>>     - driver_svm_lock: In addition to the locking mentioned above, the
>>>>>       driver should implement a lock to safeguard core GPU SVM function
>>>>>       calls that modify state, such as drm_gpusvm_range_find_or_insert and
>>>>>       drm_gpusvm_range_remove.
>>>>>
>>>>>     Two locks, two jobs.
>>>>>
>>>>> 2) The lock held in the MMU notifier is notifier_lock, never driver_svm_lock
>>>>>
>>>>>     drm_gpusvm_notifier_invalidate():
>>>>>           down_write(&gpusvm->notifier_lock);
>>>>>           ...
>>>>>           gpusvm->ops->invalidate(gpusvm, notifier, mmu_range);
>>>>>
>>>>>     The driver invalidate callback runs under notifier_lock only. Per the
>>>>>     framework's own notifier example it just unmaps pages
>>>>>     and queues the range to the garbage collector no allocation, and it
>>>>>     does not take driver_svm_lock:
>>>>>
>>>>>           drm_gpusvm_range_unmap_pages(...);
>>>>>           drm_gpusvm_range_set_unmapped(...);
>>>>>           driver_garbage_collector_add(...);
>>>>>
>>>>> 3) driver_svm_lock is by design an allocating, process context lock
>>>>>
>>>>>     drm_gpusvm_range_find_or_insert() asserts it and then allocates under it:
>>>>>
>>>>>           drm_gpusvm_range_find_or_insert():
>>>>>                   drm_gpusvm_driver_lock_held(gpusvm);
>>>>>                   ...
>>>>>                   range = drm_gpusvm_range_alloc(...);
>>>>>                   ... mmu_interval_notifier_insert(), kzalloc
>>>>>
>>>>>     drm_gpusvm_range_remove() asserts it and frees. This is only safe
>>>>>     because driver_svm_lock is a sleepable, reclaim friendly lock that is
>>>>>     never taken from the MMU notifier. Reference counting
>>>>>      handles range *lifetime*, but it does not
>>>>>     serialize tree insert/remove, which is exactly why the framework still
>>>>>     asserts driver_svm_lock on those two entry points regardless of refcount.
>>>>>
>>>>> Now the three concrete points:
>>>>>
>>>>> A) Why the primary driver_svm_lock is required
>>>>>
>>>>>     It is a framework requirement, not an amdgpu invention:
>>>>>      - DOC: Locking says the driver "should implement" it.
>>>>>      - drm_gpusvm lockdep-asserts it on every structural entry:
>>>>>        drm_gpusvm_range_find_or_insert() and drm_gpusvm_range_remove() both
>>>>>        call drm_gpusvm_driver_lock_held().
>>>>>      - The reference fault handler holds it across the whole fault:
>>>>>        GC -> find_or_insert -> migrate -> get_pages -> bind.
>>>>>
>>>>>     Xe does exactly this:
>>>>>      - xe_svm.c:      drm_gpusvm_driver_set_lock(&vm->svm.gpusvm, &vm->lock);
>>>>>      - xe_pagefault.c: down_write(&vm->lock); before dispatching the fault
>>>>>      - __xe_svm_handle_pagefault(): lockdep_assert_held_write(&vm->lock);
>>>>>        held across GC / find_or_insert / alloc_vram / get_pages / rebind
>>>>>      - xe_svm_garbage_collector(): lockdep_assert_held_write(&vm->lock);
>>>>>
>>>>>     amdgpu's svm_lock is the same driver_svm_lock, used the same way.
>>>>>
>>>>> B) Why eviction_lock cannot be that lock
>>>>>
>>>>>> This lock eviction_lock can only be grabbed while updating the mapping range.
>>>>>
>>>>>     and that is precisely why it cannot be driver_svm_lock.
>>>>>     driver_svm_lock must wrap find_or_insert, migration, and
>>>>>     drm_gpusvm_range_get_pages
>>>>>     eviction_lock is the opposite by contract:
>>>>>
>>>>>      - It is taken with memalloc_noreclaim_save() in
>>>>>        amdgpu_vm_begin_critical(), specifically so no reclaim happens while
>>>>>        held (to avoid the reclaim -> MMU-notifier deadlock). Holding it
>>>>>        across get_pages/migration breaks that.
>>>>>      - TTM eviction try-locks it: amdgpu_vm_evictable() does
>>>>>        scoped_cond_guard(mutex_try, return false, &vm->eviction_lock) and
>>>>>        sets vm->evicting. Long holds starve eviction.
>>>>>      - It is a plain mutex that the SVM map path re-enters:
>>>>>        amdgpu_svm_range_update_mapping() -> amdgpu_vm_map_range() ->
>>>>>        amdgpu_vm_begin_critical() -> mutex_lock(&vm->eviction_lock). If
>>>>>        eviction_lock were also the outer SVM lock, this is a self-deadlock.
>>>>>
>>>>>     In short, eviction_lock has the contract of notifier_lock , not of
>>>>>     driver_svm_lock. This is also why the current split is correct:
>>>>>     svm_lock (outer) != eviction_lock (inner). Your own rule - "you can't
>>>>>     call the VM code with the lock held, the VM code must take it itself" -
>>>>>     is satisfied today only because they are separate: svm_lock is held
>>>>>     while calling amdgpu_vm_map_range(), and amdgpu_vm_map_range() takes
>>>>>     eviction_lock itself. Merging them is what would violate that rule.
>>>>>
>>>>>> No, they Xe vm->lock and eviction_lock are actually identical in the handling.
>>>>>
>>>>>     They are not. Xe's vm->lock is a rw_semaphore, the "outer most lock" of
>>>>>     the VM , held down_write across the whole fault. amdgpu's
>>>>>     eviction_lock is a mutex taken only inside amdgpu_vm_begin_critical()
>>>>>     during a PT update, under memalloc_noreclaim. Xe's eviction/reclaim
>>>>>     handling is separate from vm->lock. The amdgpu analogue of Xe's vm->lock
>>>>>     is svm_lock, not eviction_lock.
>>>>>
>>>>> C) Reusing an existing amdgpu_vm lock as the primary lock needs refactor amdgpu VM
>>>>>
>>>>>     Xe can register vm->lock because Xe's VM was designed with an outer
>>>>>     rw_semaphore held across faults. amdgpu_vm has no such lock: only
>>>>>     eviction_lock , the root PD dma_resv , and a few spinlocks.
>>>>>
>>>>>     So do it like Xe means introducing a dedicated, outer, sleepable VM
>>>>>     lock held across the fault. That lock is exactly svm_lock. Folding it
>>>>>     into struct amdgpu_vm as a general vm->lock is a core amdgpu VM refactor.
>>>>>
>>>>> Regards,
>>>>> Honglei
>>>>>
>>>>>
>>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>> +
>>>>>>> +#if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
>>>>>>> +void amdgpu_svm_flush_tlb(struct amdgpu_svm *svm);
>>>>>>> +
>>>>>>> +int amdgpu_svm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>>>>>>> +void amdgpu_svm_close(struct amdgpu_vm *vm);
>>>>>>> +void amdgpu_svm_fini(struct amdgpu_vm *vm);
>>>>>>> +
>>>>>>> +void amdgpu_svm_put(struct amdgpu_svm *svm);
>>>>>>> +struct amdgpu_svm *amdgpu_svm_lookup_by_pasid(struct amdgpu_device *adev,
>>>>>>> +                           uint32_t pasid);
>>>>>>> +int amdgpu_svm_handle_fault(struct amdgpu_device *adev, uint32_t pasid,
>>>>>>> +                uint64_t fault_page, uint64_t ts,
>>>>>>> +                bool write_fault);
>>>>>>> +bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm);
>>>>>>> +
>>>>>>> +int amdgpu_gem_svm_ioctl(struct drm_device *dev, void *data,
>>>>>>> +             struct drm_file *filp);
>>>>>>> +void amdgpu_svm_clean_queue(struct amdgpu_svm *svm,
>>>>>>> +                struct list_head *work_list);
>>>>>>> +void amdgpu_svm_sync_work(struct amdgpu_svm *svm);
>>>>>>> +int amdgpu_svm_garbage_collector(struct amdgpu_svm *svm);
>>>>>>> +int amdgpu_svm_apply_attr_change(struct amdgpu_svm *svm,
>>>>>>> +                 const struct amdgpu_svm_attrs *old_attrs,
>>>>>>> +                 const struct amdgpu_svm_attrs *new_attrs,
>>>>>>> +                 unsigned long start_page,
>>>>>>> +                 unsigned long last_page);
>>>>>>> +bool amdgpu_svm_devmem_possible(struct amdgpu_svm *svm);
>>>>>>> +#else
>>>>>>> +static inline int amdgpu_svm_init(struct amdgpu_device *adev,
>>>>>>> +                  struct amdgpu_vm *vm)
>>>>>>> +{
>>>>>>> +    return 0;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static inline void amdgpu_svm_close(struct amdgpu_vm *vm)
>>>>>>> +{
>>>>>>> +}
>>>>>>> +
>>>>>>> +static inline void amdgpu_svm_fini(struct amdgpu_vm *vm)
>>>>>>> +{
>>>>>>> +}
>>>>>>> +
>>>>>>> +static inline int amdgpu_svm_handle_fault(struct amdgpu_device *adev,
>>>>>>> +                      uint32_t pasid,
>>>>>>> +                      uint64_t fault_page,
>>>>>>> +                      uint64_t ts,
>>>>>>> +                      bool write_fault)
>>>>>>> +{
>>>>>>> +    return -EOPNOTSUPP;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static inline bool amdgpu_svm_is_enabled(struct amdgpu_vm *vm)
>>>>>>> +{
>>>>>>> +    return false;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static inline int amdgpu_gem_svm_ioctl(struct drm_device *dev, void *data,
>>>>>>> +                       struct drm_file *filp)
>>>>>>> +{
>>>>>>> +    return -EOPNOTSUPP;
>>>>>>> +}
>>>>>>> +#endif /* CONFIG_DRM_AMDGPU_SVM */
>>>>>>> +
>>>>>>> +#endif /* __AMDGPU_SVM_H__ */
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>>>> index ec1196d390bb7..30463a83e2e60 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>>>> @@ -43,6 +43,7 @@ struct amdgpu_bo_va;
>>>>>>>     struct amdgpu_job;
>>>>>>>     struct amdgpu_bo_list_entry;
>>>>>>>     struct amdgpu_bo_vm;
>>>>>>> +struct amdgpu_svm;
>>>>>>>       /*
>>>>>>>      * GPUVM handling
>>>>>>> @@ -373,6 +374,9 @@ struct amdgpu_vm {
>>>>>>>           /* cached fault info */
>>>>>>>         struct amdgpu_vm_fault_info fault_info;
>>>>>>> +
>>>>>>> +    /* SVM experimental implementation */
>>>>>>> +    struct amdgpu_svm *svm;
>>>>>>>     };
>>>>>>>       struct amdgpu_vm_manager {
>>>>>>
>>>>>
>>>
>>

