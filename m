Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C56DFAD413
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 06:10:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17B5010E306;
	Thu, 23 Apr 2026 06:10:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5qRXJ2Gw";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011004.outbound.protection.outlook.com [52.101.57.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A84E10E2FB;
 Thu, 23 Apr 2026 06:10:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOUyGvdw+hE1q1N5fqqBErYKco2GELju+X5QQ7sB5nhCAq0dhUB4fOgvfYMtUkpJgaS8eyGcZIZUvenfMmnKvtneAsEOjiKbua4wXe05qNDe75+1qTESHGXXiX+0rck+c1sflNebnrQs9HjIF0t19LdDI0KF8us1k19DtVnkl+ssxflaX06+mmZnztf7leIXYZ7RYKz4QAVJU6P9+0L0Sj6uowKuIYfgMm1FjwwYIqi/3RchXMOLE0m15IgJvc67kRoMZ70OgWI8+9w7E2WPB7CVob9grQbnvPSrc78sytx54lUl0rQN3j0MeTI45RoQrWzskqtJANORaA+CrZmNEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyHDAVMN0R/jqdAv0w/jeX/0XGQCnov3jhUit0hS45c=;
 b=gjKEBTNtE83N1OLKLNLcz6Ztgqm3MKzVDDx36Env5+LP5ojBF+awiMJmfvOE4rOHpjdA+80krjiENNZl0TvI/XMv5OlK12TD88KRv0Prm8An++Ph63h9Xk3QXfyPRmoDf8FCU6zpUcbV9OEzLO0kg9BYydqjuuOiT0awAly7NnR/B+0aqMW1Un3XFQbRh4Fx170Cgd0ZNpb3rKIaVV+CIHLPEgU/tuspKBXaCx5XLGmhBoVJULdTvHHbeRna+YhlazRY9XM0ZskdyHxZRL/NzhcIUy0T2uhYdBnwIFFg9BgcLLLAUDRo/AfM56TekqP2EYDxpY7G2b2//osMjRPMcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyHDAVMN0R/jqdAv0w/jeX/0XGQCnov3jhUit0hS45c=;
 b=5qRXJ2GwvZjrxsQbsArNIQoRsl9iA5Mrl3SlKcQ9yJooneQYqnJ5jY6u4RKbrUcta3QmBAnvB1DCz4uuOPOuOFreCgi9pTmxfUgqYd1XhtKerytwefinikj7yawwnOpVSc++fNgDYZLuqwhO22mAhvTI73T5y7vKQLXbJUo0aEE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by DS0PR12MB7972.namprd12.prod.outlook.com (2603:10b6:8:14f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 06:10:09 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.20.9846.019; Thu, 23 Apr 2026
 06:10:08 +0000
Message-ID: <a9d979e7-6ff1-47c5-87c5-b905e5c84ded@amd.com>
Date: Thu, 23 Apr 2026 14:09:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/POC PATCH 00/12] POC SVM implementation in AMDGPU based on
 drm_gpusvm
To: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Honglei Huang <honglei1.huang@amd.com>,
 Oak.Zeng@amd.com, Jenny-Jing.Liu@amd.com, Xiaogang.Chen@amd.com,
 Ray.Huang@amd.com, Lingshan.Zhu@amd.com, Junhua.Shen@amd.com,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>
References: <20260317112958.2925370-1-honglei1.huang@amd.com>
 <e21e8e1a-4d2e-40e9-bbb7-2764cf33e760@amd.com>
 <ae5fe946-4756-43b4-848f-3b545ac61ba7@amd.com>
 <abuE0KBPtAZM9Bo0@lstrano-desk.jf.intel.com>
 <098d5d68-f218-4cee-8b73-201e7012a287@amd.com>
 <acDeRhCTh/ehOUyu@lstrano-desk.jf.intel.com>
Content-Language: en-US
From: "Huang, Honglei1" <honghuan@amd.com>
In-Reply-To: <acDeRhCTh/ehOUyu@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0024.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:5::6)
 To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|DS0PR12MB7972:EE_
X-MS-Office365-Filtering-Correlation-Id: 36e8021d-df34-446a-6ffe-08dea0fef85e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18096099003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qAa1P3Vcch26FsXw78VonD3SMtdCrDdwvtBJI/uOMEtGyzEqjsHHBFKzMt4dDN5mLWymz1ri9lbXcthRn85oEv62uSLQkVzqQjEbpyCdcPCbBKxca85DvJZwiRznTl9R+mZ2VaeWAb3dA7IyEhqSWGtbhhZOskPG0KZZPN6sXgCjXbX0uTJkNiYA4IigPYzN1aZEHRu18n2rOBqbeMEzC9HRk/hStaoiip7hwHkBmCioj+I/Oc/4Ru2c/xstPJRHE9VT2ta9tkKjHdVVUDTIN1EkTd4CstaclTjklqgYRqVe4hW63FsNSrNjysbQteF/Khm1cebBfjF5DCRlOCSMrZZbfHEGrShzjGEoKVbWu0i1dHu6a4Z1oJANjHHsFOPAAKd0mz2WOXbiOMRF9DmpcoVdjOr08EdiGog01GWvJmpdrFKeONwYU22R6GSFL12gyTXETdLnzF9yuC9Krzw7cZjc4vycMD32fUQ/wy3cxRxVlaBJr8ofdJ608ajMhN34CZsduc3We+kjCri6BJjNUTA2b2j6PpxI5ag0R2WBUHVjVt3M1xuSYvZeHEY/IFSDJpQ92fzTFb5Sbx9GOyEX13pnuJvWOiHMaXho2ri0CkB/BV5wvoNBKatYM95lQly8TXeB7DiYi/4LdYwmqlPuapau5Vr3ALBfGEzIYCJhMxrXALPuTuwWG7RC4PShbgeq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18096099003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXJFWDhBY3lRM3pISy82Nm9mdGRiQUgrejJacTZoOUVQUlh4ZTg4R3ZtL0l0?=
 =?utf-8?B?RktGR01BL1NZQU0xZUJvZ3JlbnZOMnk4ckFaQlVremdlb1daOG5pbElGUE1s?=
 =?utf-8?B?ODRGbWVLL3ZKME44Y3NKdFFYVHUvMUh2R2s0cHhGdXJwZDZxY1VoWWFjTVVI?=
 =?utf-8?B?Qk44VTY2OTE2VEVROVRiYmRlOGViK0haWFRtV1FnZXpDenNjOXdFY1FhZmFG?=
 =?utf-8?B?TWFHSXNYWmEvc2VQODNod2YvcHBVYVUwL3NZdzBKVWpMMFIvUkw2QVd1TFlz?=
 =?utf-8?B?aEdTLzFxSFR4UHFiTTdFeHdyMmZQcDdHKzdHbm05UUo4cTBFZldOQ25UMnJk?=
 =?utf-8?B?SzhsSStPaGVDOGVodkE3cXhnNzRQQkxsWkZDZEoyLzdXclJhTVI2ZXFGc3NU?=
 =?utf-8?B?MjJhRVJDS2JJK2xSVFRQRUZ1b21ya1hHRDRFak9DeDNPY1pHY0dPa2N6N3pr?=
 =?utf-8?B?dy92RnZZUjRyK01IRkFDNVVJVXZpUmVKSmlYdCs3dVgvUzRxeVMyK2RvV1lY?=
 =?utf-8?B?ZlZTalN0TXBzT3ptc2QwYVF3QXVoZmNnRTNSd043d1F4K2dHZXdVd3dQQ0h4?=
 =?utf-8?B?a0VBcU14WjlJaWYzcjlYeTQvMnh6MGQvQzVEQ043c1JQdkFYNXJURFJWMkR0?=
 =?utf-8?B?KzlQOWI0VnRSdlg2Q3ZXaU5SR1MwcTAvaHJJcHRFdi9FSk9xd1JxWHFiZUlC?=
 =?utf-8?B?L3pIaDBNazd3ZXNiOUVVV1VEUW1ETlNUT0VRb0JTbGhRTEszMXVxcXpyV2l4?=
 =?utf-8?B?ajNjSXo0a1F1cW1BaEsrbTZ4RHAyRWRkWUF5MGJnVjgwSDU4b1hMaXRqaUZy?=
 =?utf-8?B?SWliWDFuazhKbFBPZ28zbHVmVTdHVnNkM3NYWU5Sd2ZuaUNNRUN2N0cxTVNU?=
 =?utf-8?B?OWpHMHJmUE9QQVd0MnFIZXZ4ZmhDNU43REhQMFpISjRuSnhzSjJIUmNpZHU3?=
 =?utf-8?B?dDVBeTlvMzZiUkIyOVowTEM2eTNCMmdQMEJmaE93VHZvb0RMR1Y1YnJaZ25n?=
 =?utf-8?B?cnlhcnBHSUdyZ3pseUY5Rnh3bDBTSEt3N1V6cmV3YXBiSTJRMjNuRi9GbjZP?=
 =?utf-8?B?MURIeUg5ZlNQck44cGxvYUxzdVZ0Ukoyc3V3cWRlWWgxQnE4NytNZDlya2Zz?=
 =?utf-8?B?UjJrSWZMU3dHc3JOMmt5anVsK0V2VTcvN2taVElQcWZESGxuYzJ3Uk5ESHpz?=
 =?utf-8?B?K1hITWRhRnhKaXlnVXdpM0M4YVZKOUNkdlk4WEdCTUFEdXI3T1JsKzRzTXlW?=
 =?utf-8?B?M1JYUGUyc3Y5MDF2bGxWdFFKalBQV3JFb2Z6cWxNRlYrdUVWUHBwMjFzMVB1?=
 =?utf-8?B?Vys2SUdxUlNYcHcxOFU4TFhETkZ6ZWI1bzV5UHBkQTRyRm03OU8rNlRNNU1p?=
 =?utf-8?B?QndRcG1ONEo5L09Lem1pRXlmcm9iZTBRRndqL3c2KzFkYUFvVU1mZWRlNTEz?=
 =?utf-8?B?Y2pmRmhKdjJ4b3ZIUVJqaXRVSUdIdFZBVUFXMDlHeXhkVGkveW9Bb3psZTlj?=
 =?utf-8?B?cTRxVVFoY3JTMy92YWViQnRHdXl2SkExT1kwbThXVjdIeHRnNDdGS1ZMV0xL?=
 =?utf-8?B?V2s0ZTRld09KRm9tQ2s3NVNWSk5TVnRkUjhEVFR5L3JFUnlHazloRGZhVTBp?=
 =?utf-8?B?Y1VUamZabG5xZ05NWEl5UXBkSTFPaWFFN05iVTA1M25WQnNKNURmcnlkckx6?=
 =?utf-8?B?SG13R2JKK1dtMWVya2p5RndadGQvNzYzaVV2Qno2TDdIdDFDWGczRXlxWFRM?=
 =?utf-8?B?RGVLMi9oN0ZadGtFT3l1b2VEZFhJd1BWRjdoSysxUlFGL0crc2VBSFl6Z0JW?=
 =?utf-8?B?NEVUa09LdGNnUzBLQThpQzFJamtMZmlYNENTQ0l0V01BcFEvclRCYVJaUURI?=
 =?utf-8?B?UEhyVVJLazhvUEZGWkxMNXE3ektSbGk1MlJxUDAxQnJyaGxCYkRXYUdkZnY0?=
 =?utf-8?B?MEh5UVNvZGJqWjl0VzhQK1JFbG54akRBd0ZTd3NDZmZvVHFnMEZrUkt5azV6?=
 =?utf-8?B?NDd2aGZDTjNRRGN6SlY3a0ZKeUJqempwV0lnd3R5UlYrcmEvTS80bVdxcmQx?=
 =?utf-8?B?bXp1MXcweHFCeWNRR1VxUXFoTGkrTmsxSC9hZUIvQk9lNHZoVTZrUkFtb0dv?=
 =?utf-8?B?WVNhYzdSVGtDR21JWG1pSVkvNUd2YWM5M1lrU1p1eUZZZENOdTlQZDhyVWxn?=
 =?utf-8?B?dTN3ZTI0Mm42bDZKVXh6MGlCMExKOU04bFNhejMwaXlUWGZibkJoQ0V4cklO?=
 =?utf-8?B?NFdzN05oblFDYVNQWkVLdy9KcG5KQ1F1Smp6bzhVQk5xWHNLS0U3TFYxUEYx?=
 =?utf-8?Q?Sanf8uqntFOVNY420A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e8021d-df34-446a-6ffe-08dea0fef85e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 06:10:08.5865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nH5avzBaLLbmNp+tfVI6ZUZ7IyGpLqzyW+ZwFHsklKgJB/uE4hwRai2Yua0uXoYkaEefoXxbV719r55k+UpEpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7972
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



On 3/23/2026 2:31 PM, Matthew Brost wrote:
> On Thu, Mar 19, 2026 at 10:17:36PM +0800, Honglei Huang wrote:
>>
>>
>> On 3/19/26 13:08, Matthew Brost wrote:
>>> On Wed, Mar 18, 2026 at 04:59:31PM +0800, Honglei Huang wrote:
>>>>
>>>
>>> Disclaimer I haven't look at any code in this series yet.
>>>
>>>>
>>>> On 3/17/26 19:48, Christian König wrote:
>>>>> Adding a few XE and drm_gpuvm people on TO.
>>>>>
>>>>> On 3/17/26 12:29, Honglei Huang wrote:
>>>>>> From: Honglei Huang <honghuan@amd.com>
>>>>>>
>>>>>> This is a POC/draft patch series of SVM feature in amdgpu based on the
>>>>>> drm_gpusvm framework. The primary purpose of this RFC is to validate
>>>>>> the framework's applicability, identify implementation challenges,
>>>>>> and start discussion on framework evolution. This is not a production
>>>
>>> +1. Open to any ideas. Given this was designed originally for Xe we very
>>> well could have missed other drivers requirements.
>> Hi Matt,
>>
>> Thank you for the openness. And thank you so much for the incredibly
>> detailed and patient response. I really appreciate you taking the time to
>> walk through each point.
>>
> 
> I'm here to help.
> 
>> Actually I am still a learner when it comes to the drm_gpusvm framework and
>> GPU SVM design in general. Some of my descriptions below may not be entirely
>> accurate. But I really want to bring drm_gpusvm into amdgpu and make it work
>> well.
> 
> I appreciate another driver jumping in and using this framework—it
> becomes easier to validate as more users adopt it.
> 
>>
>>>
>>>>>> ready submission.
>>>>>>
>>>>>> This patch series implements basic SVM support with the following features:
>>>>>>
>>>>>>      1. attributes sepatarated from physical page management:
>>>>>>
>>>>>>        - Attribute layer (amdgpu_svm_attr_tree): a driver side interval
>>>>>>          tree that stores SVM attributes. Managed through the SET_ATTR,
>>>>>>          and mmu notifier callback.
>>>
>>> Can you explain the mmu notifier callback interaction here? See below in
>>> Xe the attribute tree is existing VMA tree (gpuvm).
>>>
>>
>> Let me try to explain, apologies if the description is not fully
>> precise.
>>
>> In current implementation, the MMU notifier callback interacts with the attr
>> tree only in the munmap path remove the corresponding attribute
>> entries from the attr tree so that stale attributes do not persist for
>> freed address space.
>>
> 
> Ah, yes. We reset our attributes upon munmap too. We actually don't this
> 100% correct quite either and series in flight to fix [1].
> 
> [1] https://patchwork.freedesktop.org/series/161815/

Hi matt,

It seems like you are tring to modify the implementation into remove the 
attributes when munmap.

Actuall we have a discussion internally that does the driver need to 
remove the attributes when munmap.

So there servel ideas:

1. attribute need keep: attributes may be needed again when a new VMA 
appears or on subsequent faults.
2.attribute need keep: attributes can be set independent of whether 
memory is currently mapped; attributes persist and are modified 
explicitly via ioctl, not implicitly by notifier callbacks.
3. attribute need remove: casue VMA is gone, driver can do nothing 
without VMA.

and I saw xe_svm set default attribute in the previous version, this is 
also a option.

Can you please help to give some information that why xe_svm is turing 
to remove the attribute when munmap? And does keeping attribute is a 
valid way?


Regards,
Honglei

> 
>>>>>>
>>>>>>        - Physical page layer (drm_gpusvm ranges): managed by the
>>>>>>          drm_gpusvm framework, representing actual HMM backed DMA
>>>>>>          mappings and GPU page table entries.
>>>>>>
>>>>>>         This separation is necessary:
>>>>>>           -  The framework does not support range splitting, so a partial
>>>>>>              munmap destroys the entire overlapping range, including the
>>>>>>              still valid parts. If attributes were stored inside drm_gpusvm
>>>>>>              ranges, they would be lost on unmapping.
>>>>>>              The separate attr tree preserves userspace set attributes
>>>>>>              across range operations.
>>>
>>> Yes, in Xe the divide is at the VMA level (set by user space) via VM
>>> bind (parts of VM may be mappings BOs, parts could be setup for SVM) or
>>> madvise IOCTLs which reflect user space attributes on current SVM
>>> mappings or future ones.
>>>
>>> The SVM range tree reflects mappings that have been faulted into the
>>> device and contain pages. This is an intentional choice.
>>
>> That makes a lot of sense. Thank you for clarifying the design intent. I
>> think the current adopt the same principle: the drm_gpusvm range tree only
>> reflect actual faulted in mappings.
>>
>>>
>>>>>
>>>>> Isn't that actually intended? When parts of the range unmap then that usually means the whole range isn't valid any more.
>>>
>>>
>>> Yes, this was an intentional design choice to not support partial unmap,
>>> and instead rely on the driver to recreate a new range.
>>>
>>> The reasoning is:
>>>
>>> - In practice, this should be rare for well-behaved applications.
>>>
>>> - With THP / large device pages, if a sub-range is unmapped, the entire
>>> GPU mapping is invalidated anyway due to the page size change. As a
>>> result, the cost of creating a new range is minimal, since the device
>>> will likely fault again on the remaining pages.
>>>
>>> So there is no need to over-engineer the common code.
>>>
>>> FWIW, to even test partial unmaps in Xe, I had to do things I doubt
>>> anyone would ever do:
>>>
>>> ptr = mmap(SZ_2M);
>>> /* fault in memory to the device */
>>> munmap(ptr, SZ_1M);
>>> /* touch memory again on the device */
>>>
>>
>> Thank you for this explanation and the concrete example. After further
>> discussion internally with Christian, we are now aligned with same position
>> partial unmap. Will remove rebuild on partial unmap logic in the next
>> version and handle it as only partially backed range.
>>
>>>>
>>>>
>>>> It is about partial unmap, some subregion in drm_gpusvm_range is still valid
>>>> but some other subregion is invalid, but under drm_gpusvm, need to destroy
>>>> the entire range.
>>>>
>>>> e.g.:
>>>>
>>>>             [---------------unmap region in mmu notifier-----------------]
>>>> [0x1000 ------------ 0x9000]
>>>> [  valid ][     invalid    ]
>>>>
>>>> see deatil in drm_gpusvm.c:110 line
>>>> section:Partial Unmapping of Ranges
>>>>
>>>>
>>>>>
>>>>>>
>>>>>>           -  drm_gpusvm range boundaries are determined by fault address
>>>>>>              and pre setted chunk size, not by userspace attribute boundaries.
>>>>>>              Ranges  may be rechunked on memory changes. Embedding
>>>>>>              attributes in framework ranges would scatter attr state
>>>>>>              across many small ranges and require complex reassemble
>>>>>>              logic when operate attrbute.
>>>>>
>>>>> Yeah, that makes a lot of sense.
>>>>>
>>>>>>
>>>>>>      2) System memory mapping via drm_gpusvm
>>>>>>
>>>>>>         The core mapping path uses drm_gpusvm_range_find_or_insert() to
>>>>>>         create ranges, drm_gpusvm_range_get_pages() for HMM page fault
>>>>>>         and DMA mapping, then updates GPU page tables via
>>>>>>         amdgpu_vm_update_range().
>>>>>>
>>>>>>      3) IOCTL driven mapping (XNACK off / no GPU fault mode)
>>>>>>
>>>>>>         On XNACK off hardware the GPU cannot recover from page faults,
>>>>>>         so mappings must be established through ioctl. When
>>>>>>         userspace calls SET_ATTR with ACCESS=ENABLE, the driver
>>>>>>         walks the attr tree and maps all accessible intervals
>>>>>>         to the GPU by amdgpu_svm_range_map_attr_ranges().
>>>
>>> Can you expand on XNACK off / GPU no faults? Is this to the share GPU
>>> between 3D (dma-fences) and faulting clients? We have something similar
>>> in Xe, but it isn't an explicit IOCTL rather we switch between on demand
>>> as 3D client submits and then resumes page faults when all dma-fences
>>> have signaled.
>>>
>>> I see below you mention page tables are modified during quiesce KFD
>>> queues? I'm not sure that is required - you just need to guarnette
>>> faulting clients won't trigger page faults when dma-fence is in flight.
>>>
>>> Maybe give me an explaination of exactly what the requirement from AMD
>>> are here so I have better picture.
>>
>> Thank you for the patience, let me try to explain our situation, though
>> I may not get every detail right.
>>
>> XNACK off means hardware that does not have GPU page fault capability (or
>> turned off)
>>
>> So for these GPUs, ALL page table entries must be fully populated before
>> the GPU can access the memory. This is why we need the ioctl driven
>> mapping path, when userspace calls SET_ATTR with ACCESS=ENABLE, need
>> walk the attribute tree and eagerly map all accessible ranges into the
>> GPU page tables. This is functionally similar to what you describe as
>> prefetch IOCTLs / VM bind in Xe.
>>
>> Regarding queue quiesce during page table modification: on XNACK off
>> hardware, because the GPU cannot fault, we must ensure the GPU is
>> completely stopped before modifying any PTE it might be accessing.
>> Otherwise the GPU could access a partially updated page table and hang.
>> The quiesce/resume is the mechanism to guarantee this.
>>
>> I hope that helps clarify the picture.
>>
> 
> This clarifies a lot. This is what we’d call in Xe “preemption fence”
> mode for a VM. Anytime memory is moved, we trigger a GPU preemption and
> resume. We don’t actually support SVM in this case; instead, we use
> “userptr binds,” which are built on gpusvm for page collection. However,
> we don’t support migrating memory to the device—though we could.
> 
> I’d look at how we converted 'userptr' to be based on GPU SVM [2]. In
> this case, don’t maintain a range tree, as those—as you suggest—are more
> of an on-demand fault driver concern. Instead, just embed 'struct
> drm_gpusvm_pages' in the VMA struct defined by the IOCTLs..
> 
> We could extend this to support migrating 'userptr', but we just haven’t
> done that yet—this may be what you want to do in “XNACK off..
> 
> [2] https://patchwork.freedesktop.org/series/146553/
> 
>>
>>>
>>>>>>
>>>>>>      4) Invalidation, GC worker, and restore worker
>>>>>>
>>>>>>         MMU notifier callbacks (amdgpu_svm_range_invalidate) handle
>>>>>>         three cases based on event type and hardware mode:
>>>>>>           - unmap event: clear GPU PTEs in the notifier context,
>>>>>>             unmap DMA pages, mark ranges as unmapped, flush TLB,
>>>>>>             and enqueue to the GC worker. On XNACK off, also
>>>>>>             quiesce KFD queues and schedule rebuild of the
>>>>>>             still valid portions that were destroyed together with
>>>>>>             the unmapped subregion.
>>>>>>
>>>>>>           - evict on XNACK off:
>>>>>>             quiesce KFD queues first, then unmap DMA pages and
>>>>>>             enqueue to the restore worker.
>>>>>
>>>>> Is that done through the DMA fence or by talking directly to the MES/HWS?
>>>>
>>>> Currently KFD queues quiesce/resume API are reused, lookig forward to a
>>>> better solution.
>>>>
>>>
>>> +1
>>>
>>>> Regards,
>>>> Honglei
>>>>
>>>>>
>>>>> Thanks,
>>>>> Christian.
>>>>>
>>>>>>
>>>>>>           - evict on XNACK on:
>>>>>>             clear GPU PTEs, unmap DMA pages, and flush TLB, but do
>>>>>>             not schedule any worker. The GPU will fault on next
>>>>>>             access and the fault handler establishes the mapping.
>>>>>>
>>>>>> Not supported feature:
>>>>>>      - XNACK on GPU page fault mode
>>>>>>      - migration and prefetch feature
>>>>>>      - Multi GPU support
>>>>>>
>>>>>>      XNACK on enablement is ongoing.The GPUs that support XNACK on
>>>>>>      are currently only accessible to us via remote lab machines, which slows
>>>>>>      down progress.
>>>>>>
>>>>>> Patch overview:
>>>>>>
>>>>>>      01/12 UAPI definitions: DRM_AMDGPU_GEM_SVM ioctl, SVM flags,
>>>>>>            SET_ATTR/GET_ATTR operations, attribute types, and related
>>>>>>            structs in amdgpu_drm.h.
>>>>>>
>>>>>>      02/12 Core data structures: amdgpu_svm wrapping drm_gpusvm with
>>>>>>            refcount, attr_tree, workqueues, locks, and
>>>>>>            callbacks (begin/end_restore, flush_tlb).
>>>>>>
>>>>>>      03/12 Attribute data structures: amdgpu_svm_attrs, attr_range
>>>>>>            (interval tree node), attr_tree, access enum, flag masks,
>>>>>>            and change trigger enum.
>>>>>>
>>>>>>      04/12 Attribute tree operations: interval tree lookup, insert,
>>>>>>            remove, and tree create/destroy lifecycle.
>>>>>>
>>>>>>      05/12 Attribute set: validate UAPI attributes, apply to internal
>>>>>>            attrs, handle hole/existing range with head/tail splitting,
>>>>>>            compute change triggers, and -EAGAIN retry loop.
>>>>>>            Implements attr_clear_pages for unmap cleanup and attr_get.
>>>>>>
>>>>>>      06/12 Range data structures: amdgpu_svm_range extending
>>>>>>            drm_gpusvm_range with gpu_mapped state, pending ops,
>>>>>>            pte_flags cache, and GC/restore queue linkage.
>>>>>>
>>>>>>      07/12 PTE flags and GPU mapping: simple gpu pte function,
>>>>>>            GPU page table update with DMA address, range mapping loop:
>>>>>>            find_or_insert -> get_pages -> validate -> update PTE,
>>>>>>            and attribute change driven mapping function.
>>>>>>
>>>>>>      08/12 Notifier and invalidation: synchronous GPU PTE clear in
>>>>>>            notifier context, range removal and overlap cleanup,
>>>>>>            rebuild after destroy logic, and MMU event dispatcher
>>>>>>
>>>>>>      09/12 Workers: KFD queue quiesce/resume via kgd2kfd APIs, GC
>>>>>>            worker for unmap processing and rebuild, ordered restore
>>>>>>            worker for mapping evicted ranges, and flush/sync
>>>>>>            helpers.
>>>>>>
>>>>>>      10/12 Initialization and fini: kmem_cache for range/attr,
>>>>>>            drm_gpusvm_init with chunk sizes, XNACK detection, TLB
>>>>>>            flush helper, and amdgpu_svm init/close/fini lifecycle.
>>>>>>
>>>>>>      11/12 IOCTL and fault handler: PASID based SVM lookup with kref
>>>>>>            protection, amdgpu_gem_svm_ioctl dispatcher, and
>>>>>>            amdgpu_svm_handle_fault for GPU page fault recovery.
>>>>>>
>>>>>>      12/12 Build integration: Kconfig option (CONFIG_DRM_AMDGPU_SVM),
>>>>>>            Makefile rules, ioctl table registration, and amdgpu_vm
>>>>>>            hooks (init in make_compute, close/fini, fault dispatch).
>>>>>>
>>>>>> Test result:
>>>>>>      on gfx1100(W7900) and gfx943(MI300x)
>>>>>>      kfd test: 95%+ passed, same failed cases with offical relase
>>>>>>      rocr test: all passed
>>>>>>      hip catch test: 20 cases failed in all 5366 cases, +13 failures vs offical relase
>>>>>>
>>>>>> During implementation we identified several challenges / design questions:
>>>>>>
>>>>>> 1. No range splitting on partial unmap
>>>>>>
>>>>>>      drm_gpusvm explicitly does not support range splitting in drm_gpusvm.c:122.
>>>>>>      Partial munmap needs to destroy the entire range including the valid interval.
>>>>>>      GPU fault driven hardware can handle this design by extra gpu fault handle,
>>>>>>      but AMDGPU needs to support XNACK off hardware, this design requires driver
>>>>>>      rebuild the valid part in the removed entire range. Whichs bring a very heavy
>>>>>>      restore work in work queue/GC worker: unmap/destroy -> rebuild(insert and map)
>>>>>>      this restore work even heavier than kfd_svm. In previous driver work queue
>>>>>>      only needs to restore or unmap, but in drm_gpusvm driver needs to unmap and restore.
>>>>>>      which brings about more complex logic, heavier worker queue workload, and
>>>>>>      synchronization issues.
>>>
>>> Is this common in the workload you are running? I'm also wondering if
>>> your restore logic / KFDs design is contributing to this actally the
>>> problem.
>>>
>>
>> Honestly, you raise a fair point.
>>
>> We will redesign the logic about the partial munap， which should eliminate
>> most of this complexity.
>>
>>
> 
> +1, yes test but do optimize for.
> 
>>>>>>
>>>>>> 2. Fault driven vs ioctl driven mapping
>>>>>>
>>>>>>      drm_gpusvm is designed around GPU page fault handlers. The primary entry
>>>>>>      point drm_gpusvm_range_find_or_insert() takes a fault_addr.
>>>>>>      AMDGPU needs to support IOCTL driven mapping cause No XNACK hardware that
>>>>>>      GPU cannot fault at all
>>>
>>> I think we refer to these as prefetch IOCTLs in Xe. Ideally, user space
>>> issues these so the device does not fault (e.g., prefetch creates a set
>>> of SVM ranges based on user input). In Xe, prefetch IOCTLs are simply
>>> specific VM bind operations.
>>>
>>
>> That is a very helpful way to think about it. Yes, our ioctl driven
>> mapping(xnack off) is essentially equivalent to a prefetch operation. We are
>> trying to improve it.
>>
> 
> See above wrt 'userptr'.
> 
>>
>>>>>>
>>>>>>      The ioctl path cannot hold mmap_read_lock across the entire operation
>>>>>>      because drm_gpusvm_range_find_or_insert() acquires/releases it
>>>>>>      internally. This creates race windows with MMU notifiers / workers.
>>>
>>> This is a very intentional choice in the locking design: mmap_read_lock
>>> is held only in very specific parts of GPU SVM, and the driver should
>>> never need to take this lock.
>>>
>>> Yes, notifiers can race, which is why the GPU fault handler and prefetch
>>> handler are structured as retry loops when a notifier race is detected.
>>> In practice, with well-behaved applications, these races should be
>>> rare—but they do occur, and the driver must handle them.
>>>
>>> __xe_svm_handle_pagefault implements the page fault retry loop. VM bind
>>> prefetch has similar logic, although it is more spread out given that it
>>> is part of a deeper software pipeline.
>>>
>>> FWIW, holding locks to avoid races was rejected by Sima because we
>>> reasoned it is essentially impossible to guarantee the absence of races
>>> by holding a lock. CPU page fault handlers are also effectively just
>>> large retry loops.
>>>
>>> So this is one point I believe you will need to fixup driver side.
>>>
>>
>> Understood. Thank you for the detailed explanation and for pointing to
>> __xe_svm_handle_pagefault as a reference. We will restructure both our
>> fault handler and ioctl path to a betterretry loop pattern with sequence
>> number race detection.
>>
> 
> Yes, the typical pattern is:
> 
> - Try to migrate once
> - If you hit a race, give up, evict all memory back to system memory, and bind it
> 
> Atomics make this tricky because memory must move, but I’m not sure
> “XNACK off” applies here. However, GPU SVM provides a timeslice
> mechanism to ensure the CPU can’t move memory while the GPU needs to
> execute something.
> 
>>>>>>
>>>>>> 3. Multi GPU support
>>>>>>
>>>>>> drm_gpusvm binds one drm_device to one instance. In multi GPU systems,
>>>>>> each GPU gets an independent instance with its own range tree, MMU
>>>>>> notifiers, notifier_lock, and DMA mappings.
>>>>>>
>>>
>>> This is a part I am absolutely open to fixing. Right now, each
>>> drm_gpusvm_range has a single set of drm_gpusvm_pages. I am open to
>>> decoupling a GPU SVM instance from a single device, allowing each
>>> drm_gpusvm_range to have multiple sets of drm_gpusvm_pages (one per
>>> device).
>>>
>>> This would give drivers the flexibility to use one GPU SVM instance per
>>> VM/device instance (as in Xe), or to maintain a single GPU SVM per CPU
>>> MM.
>>>
>>
>> That would be wonderful! Looking forward to your patch very much!
>>
> 
> I can't say I'll code this but we thought about is as options and very
> open patches which refactor the object model for multiple use cases.
> 
>>
>>>>>> This may brings huge overhead:
>>>>>>        - N x MMU notifier registrations for the same address range
>>>
>>> The notifier overhead is a real concern. We recently introduced two-pass
>>> notifiers [1] to speed up multi-device notifiers. At least in Xe, the
>>> TLB invalidations—which are the truly expensive part—can be pipelined
>>> using the two=pass approach. Currently, [1] only implements two-pass
>>> notifiers for userptr, but Xe’s GPU SVM will be updated to use them
>>> shortly.
>>>
>>> [1] https://patchwork.freedesktop.org/series/153280/
>>>
>>
>> Thank you for the pointer to two-pass notifiers. Will study this
>> series.
>>
>>>>>>        - N x hmm_range_fault() calls for the same page (KFD: 1x)
>>>
>>> hmm_range_fault is extremely fast compared to the actual migration.
>>> Running hmm_range_fault on a 2MB region using 4KB pages takes less
>>> than 1µs. With THP or large device pages [2] (merged last week), it’s
>>> around 1/20 of a microsecond. So I wouldn’t be too concerned about this.
>>>
>>> [2] https://patchwork.freedesktop.org/series/163141/
>>>
>>
>> That is very helpful data. Perhaps worry too much.
>>
>>>>>>        - N x DMA mapping memory
>>>
>>> You will always have N x DMA mapping memory if the pages are in system
>>> memory as the dma-mapping API is per device.
>>
>> Totally agreed.
>>
>>>
>>>>>>        - N x invalidation + restore worker scheduling per CPU unmap event
>>>>>>        - N x GPU page table flush / TLB invalidation
>>>
>>> I agree you do not want serialize GPU page table flush / TLB
>>> invalidations. Hence two-pass notifiers [1].
>>
>> Yes, will learn it.
>>
>>>
>>>>>>        - Increased mmap_lock hold time, N callbacks serialize under it
>>>>>>
>>>>>> compatibility issues:
>>>>>>        - Quiesce/resume scope mismatch: to integrate with KFD compute
>>>>>>          queues, the driver reuses kgd2kfd_quiesce_mm()/resume_mm()
>>>>>>          which have process level semantics. Under the per GPU
>>>>>>          drm_gpusvm model, maybe there are some issues on sync. To properly
>>>>>>          integrate with KFD under the per SVM model, a compatibility or
>>>>>>          new per VM level queue control APIs maybe need to introduced.
>>>>>>
>>>
>>> I thought the idea to get rid of KFD and move over to AMDGPU? I thought
>>> Christian mentioned this to me at XDC.
>>>
>>
>>>>>> Migration challenges:
>>>>>>
>>>>>>      - No global migration decision logic: each per GPU SVM
>>>>>>        instance maintains its own attribute tree independently. This
>>>>>>        allows conflicting settings (e.g., GPU0's SVM sets
>>>>>>        PREFERRED_LOC=GPU0 while GPU1's SVM sets PREFERRED_LOC=GPU1
>>>>>>        for the same address range) with no detection or resolution.
>>>>>>        A global attribute coordinator or a shared manager is needed to
>>>>>>        provide a unified global view for migration decisions
>>>
>>> Yes, this is hole in the Xe API too. We have told UMDs if they setup
>>> individual VMs with conflict attributes for a single CPU address space
>>> the behavior is undefined. Our UMD implement madvise is basically loop
>>> over al GPU VMs setting the same attributes.
>>
>> Will follow the same approach for now, the UMD is responsible for setting
>> consistent attributes across GPU VMs.
>>
> 
> +1
> 
>>>
>>>>>>
>>>>>>      - migrate_vma_setup broadcast: one GPU's migration triggers MMU
>>>>>>        notifier callbacks in ALL N-1 other drm_gpusvm instances,
>>>>>>        causing N-1 unnecessary restore workers to be scheduled. And
>>>
>>> My feeling is that you shouldn’t reschedule restore workers unless you
>>> actually have to invalidate page tables (i.e., you have a local SVM
>>> range within the notifier). So the first migration to an untouched
>>> region may trigger notifiers, but they won’t do anything because you
>>> don’t have any valid SVM ranges yet. Subsequent mappings of the migrated
>>> region won’t trigger a notifier unless the memory is moved again.
>>>
>>
>> That is a very good point. We should check whether we actually have
>> valid SVM ranges before scheduling restore workers. If there is nothing
>> to invalidate, the notifier callback should be a no-op. We will review
>> our notifier callback logic to ensure we are not doing unnecessary work
>> here. Thank you for pointing this out.
>>
>>>>>>        creates races between the initiating migration and the other
>>>>>>        instance's restore attempts.
>>>
>>> Yes, if multiple devices try to migrate the same CPU pages at the same
>>> time, that will race. That’s why in Xe we have a module-level
>>> driver_migrate_lock. The first migration runs in read mode; if it
>>> detects a race and aborts, it then takes driver_migrate_lock in write
>>> mode so it becomes the only device allowed to move memory / CPU pages.
>>> See xe_svm_alloc_vram() for how this is used.
>>>
>>> I’m not sure this approach will work for you, but I just wanted to point
>>> out that we identified this as a potential issue.
>>>
>>
>> Thank you for sharing the driver_migrate_lock approach and pointing to
>> xe_svm_alloc_vram(). Will explore whether a similar lock pattern can work
>> for our case.
>>
>>>>>>
>>>>>>      - No cross instance migration serialization: each per GPU
>>>>>>        drm_gpusvm instance has independent locking, so two GPUs'
>>>>>>        "decide -> migrate -> remap" sequences can interleave. While
>>>>>>        the kernel page lock prevents truly simultaneous migration of
>>>>>>        the same physical page, the losing side's retry (evict from
>>>>>>        other GPU's VRAM -> migrate back) triggers broadcast notifier
>>>>>>        invalidations and restore workers, compounding the ping pong
>>>>>>        problem above.
>>>>>>
>>>
>>> See the driver_migrate_lock above.
>>
>> Acknowledged, thank you.
>>>
>>>>>>      - No VRAM to VRAM migration: drm_pagemap_migrate_to_devmem()
>>>>>>        hardcodes MIGRATE_VMA_SELECT_SYSTEM (drm_pagemap.c:328), meaning
>>>>>>        it only selects system memory pages for migration.
>>>>>>
>>>
>>> I think this is fixed? We did find some core MM bugs that blocked VRAM
>>> to VRAM but those have been worked out.
>>>
>>> The code I'm looking at:
>>>
>>>    517 int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
>>>    518                                   struct mm_struct *mm,
>>>    519                                   unsigned long start, unsigned long end,
>>>    520                                   const struct drm_pagemap_migrate_details *mdetails)
>>>    521 {
>>>    522         const struct drm_pagemap_devmem_ops *ops = devmem_allocation->ops;
>>>    523         struct drm_pagemap *dpagemap = devmem_allocation->dpagemap;
>>>    524         struct dev_pagemap *pagemap = dpagemap->pagemap;
>>>    525         struct migrate_vma migrate = {
>>>    526                 .start          = start,
>>>    527                 .end            = end,
>>>    528                 .pgmap_owner    = pagemap->owner,
>>>    529                 .flags          = MIGRATE_VMA_SELECT_SYSTEM | MIGRATE_VMA_SELECT_DEVICE_COHERENT |
>>>    530                 MIGRATE_VMA_SELECT_DEVICE_PRIVATE | MIGRATE_VMA_SELECT_COMPOUND,
>>>    531         };
>>>
>>
>> Thank you for checking! I am using v6.18 for this POC, missed the fix, will
>> rebase to the latest.
>>
>>
>>>>>>      - CPU fault reverse migration race: CPU page fault triggers
>>>>>>        migrate_to_ram while GPU instances are concurrently operating.
>>>>>>        Per GPU notifier_lock does not protect cross GPU operations.
>>>
>>> No, again retry loop as discussed above.
>>
>> Understood.
>>
>>>
>>>>>>
>>>>>> We believe a strong, well designed solution at the framework level is
>>>>>> needed to properly address these problems, and we look forward to
>>>>>> discussion and suggestions.
>>>
>>> Let's work together to figure out what is missing here.
>>
>> Thank you so much, Matt. Your feedback has been incredibly valuable and
>> has given us a much clearer picture of the framework's design.
>> Ireally appreciate the effort you put into building drm_gpusvm as a
>> shared framework. Will incorporate your suggestions into our next
>> revision and look forward to continuing the collaboration.
>>
> 
> No problem. Happy to help.
> 
> Matt
> 
>> Regards,
>> Honglei
>>
>>
>>>
>>> Matt
>>>
>>>>>>
>>>>>> Honglei Huang (12):
>>>>>>      drm/amdgpu: add SVM UAPI definitions
>>>>>>      drm/amdgpu: add SVM data structures and header
>>>>>>      drm/amdgpu: add SVM attribute data structures
>>>>>>      drm/amdgpu: implement SVM attribute tree operations
>>>>>>      drm/amdgpu: implement SVM attribute set
>>>>>>      drm/amdgpu: add SVM range data structures
>>>>>>      drm/amdgpu: implement SVM range PTE flags and GPU mapping
>>>>>>      drm/amdgpu: implement SVM range notifier and invalidation
>>>>>>      drm/amdgpu: implement SVM range workers
>>>>>>      drm/amdgpu: implement SVM core initialization and fini
>>>>>>      drm/amdgpu: implement SVM ioctl and fault handler
>>>>>>      drm/amdgpu: wire up SVM build system and fault handler
>>>>>>
>>>>>>     drivers/gpu/drm/amd/amdgpu/Kconfig            |   11 +
>>>>>>     drivers/gpu/drm/amd/amdgpu/Makefile           |   13 +
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |    2 +
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c       |  430 ++++++
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h       |  147 ++
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c  |  894 ++++++++++++
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h  |  110 ++
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 1196 +++++++++++++++++
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h |   76 ++
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |   40 +-
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |    4 +
>>>>>>     include/uapi/drm/amdgpu_drm.h                 |   39 +
>>>>>>     12 files changed, 2958 insertions(+), 4 deletions(-)
>>>>>>     create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
>>>>>>     create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
>>>>>>     create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
>>>>>>     create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
>>>>>>     create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
>>>>>>     create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
>>>>>>
>>>>>>
>>>>>> base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
>>>>>
>>>>
>>

