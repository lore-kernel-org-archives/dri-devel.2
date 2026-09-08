Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C0EC79FAA
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 05:40:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CF4110E797;
	Tue,  8 Sep 2026 05:40:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eo/KD5RO";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013051.outbound.protection.outlook.com
 [40.93.201.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7193B10E04C;
 Tue,  8 Sep 2026 05:40:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wAxxPduWca7WXA8sOKlLqQhqO8Y+pAqEFemdPUg7998yfaHk2+i0MuvjLrvliH49gRkaVU0zE2UXGHX+5NytHfmQkXAkNKeS45palL6zz75VprDBvfloBi/y0T+CV+nTfjokzXZNrukrl8NMMwBUkyK4NHASl6lHRUPRo5k0PeRta6y7O1DqyJdC8rv4fz63qLvAG43AFzezlwDhj2vFdHkThEMfdY28dLDuBJuv+9Gnuwf4P8w82DEhc7xVWsjFpKjPNRqOwbIeQObnaGtwapYSHCKZy3ZcxkEQDXSMfGf/SB15emXdY25pPxleu3XKM9owMvHAHI4P4Kb8ZLo/Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJCh/fkF7a+HoHLouArve1XWAiTQGsjhmo6l11XILUs=;
 b=P0Ow4Bzymp9UOizsYwX5SBFCqSQbOlABMpnBVwUMNm4VtFo9pBiFdMVmxj8GSnmkbGkuwkgF/YPb+9LajvRgCesytQgH9togsvduSUWYOVf3R4sy9bBH5COtt2H3ZxA4aDmsvnBvP9+I/AK8YLRTUNz5f9RpaNhx2vp1nhyIX8PFldDwNywqKdwKS+hXOKFpITK6e/g361XoOS33q6Ian+3YVthmnT+ODMRDGTP5TD3QjaLy9Cu+i6QwtpjGoIuWK84ptl3ZsQ6vIlMV3TnCACeLj9wqLCQs8NF8Bb3lVg70iKd3p53zTEqd8+lc4ZDgDtPeXzO7OCWvmJkJEt6FnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJCh/fkF7a+HoHLouArve1XWAiTQGsjhmo6l11XILUs=;
 b=eo/KD5ROQj7d4kICd+6SWi6LhGyh+3XUGdNja7LHDwpKKC8wCP5BZfEtyEtWm/ZIqjTP1uBiamftPFiAwq0pqGOPKa4wHMDnxiaEyEiKH7X82UU2lYaC6y64zOu4CiXu9wTE2eAjdh7qAshLPCVzvjpI08IFreMliYMymlt1O14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by SA1PR12MB8857.namprd12.prod.outlook.com (2603:10b6:806:38d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 05:40:23 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 05:40:23 +0000
Message-ID: <d501f120-f029-4382-b8f8-007e042c251d@amd.com>
Date: Tue, 8 Sep 2026 13:40:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] drm/gpusvm: keep an IOVA mapped range dma address
 inline
To: Matthew Brost <matthew.brost@intel.com>
Cc: sima@ffwll.ch, rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com,
 himal.prasad.ghimiray@intel.com, dakr@kernel.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 aliceryhl@google.com, Alexander.Deucher@amd.com, Felix.Kuehling@amd.com,
 Christian.Koenig@amd.com, Ray.Huang@amd.com, Junhua.Shen@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20260905133142.3628027-1-honghuan@amd.com>
 <20260905133142.3628027-7-honghuan@amd.com>
 <ap9+cKNSFqX94F5k@gsse-cloud1.jf.intel.com>
 <ap+FrI7yVa/mSbgP@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <ap+FrI7yVa/mSbgP@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0029.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:5::9)
 To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|SA1PR12MB8857:EE_
X-MS-Office365-Filtering-Correlation-Id: 762466a4-3a81-477c-792f-08df0d6bad38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|366016|10067099003|22082099003|18002099003|4143699003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: In+hF7vOkIkIJehHlUsAuAaAc+KHktkOuHoNMIWAoAgilo1zdw1KuOCftDWxXQRcX84tZ3/C7B1E+HZM+Vc28tuNPuR3BNe4pFdahSWjawUOSRGePxCnBg56tpd1Wm/v4c3NA6MkhPQSRarF55HsaZNqUn+j/uBH3mWILmN2nSkoGymMNslxno4Fs8PBHnP8tToShJ+StlL3STXfEYFhtsmeU88jUjAxdsPkr6lOMw/Y/I4KqPH6KHM6jC+fO1YZ0kjL9eslwN07QIbIlu5EIcRI981VPnOrm26iRvVtvDcYRI+Y6y5nph4IOtiQaLJF2CEWp/QBQ9GErTupKldSCxHgekIpAGaN7TAve0AraM8LQFf2U0h6Nv05+x04JsVIaHsoaA3q/+RhiZOrPXQc1oGL8Yrmnu3aAM6UKZf0qnbfy25X70q+CZVfQYbwZCTel84ULEBpUVoRhRYwg+jCJB4wcw4HLMkeqxVoW+Gaik+BQ8bjCRfDdPPv2g0MqI0pUQswHM4xsnjbnYVT/DjL2UzMVsQHotlqnuXXZWWicxs/BZkBGRxlbyveFHF3Veo+LmnohInQXJlC9RErUlqkjeMrz47kp0ITv8PZaZAkWQwJJyQpB/6ZKAhcmgWlSXsrS4MV6wTW2vEGGbchKZHs9h7T5jwbJ4Inf8xsV9MqwQU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(10067099003)(22082099003)(18002099003)(4143699003)(5023799004)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVkzbjMyWFJ2OEpLUkRoVHIwOEpTWEF3QlN2SDlHaEdxSFVBOGU5MjJTeFVa?=
 =?utf-8?B?aTlXS0NWaDNjemlnL1NjQlZpaVNpZUUreEIxTVZJTE1oaEdqT202bjZtaE1n?=
 =?utf-8?B?Nnc5bHRDMjUxek0rZmh1ZEZvTUVpWnRyZ2xSbWMvNEcxTU1Ic3NvendNVkNT?=
 =?utf-8?B?aG1qWXVKYXZ6OEgrS0hqbFoxSjdrVmpDZEt6NXBJRHVJSDhXUmRuTVNTMWt0?=
 =?utf-8?B?U0NrTEViSDlTcjJuR2czMUpFcnpZTGtCaFhaOWRyTmh0SEZjUXFtZjNQbkdy?=
 =?utf-8?B?Rm5tYWdMMVNZUVFpUGdwQWczc0VkbGhzM3pxVVdQU2NXOGlwVkk4T1pyTzZu?=
 =?utf-8?B?UFBXOXpicTVPTUJ6UTdTaGNpTmpybnFJOHo0ZStPZ3U3SjJlL2tCVSt4WStl?=
 =?utf-8?B?WXBLNHhzZFFsc0dGSlZycXB5elY0eWlocHJQWnRNemxQY21JRFNsWnREWWxM?=
 =?utf-8?B?KzVNNTdCTXRiVEExeHBiQWNYTk4yb2NBSjBxbDR3bm1HRzNpbjFCMUwzSVM3?=
 =?utf-8?B?K1RQY3U4TkdkL2M0VW8vSlpuZ2lQbnJZY20wU2JRZmVqUGZOQTI0VkpvMGkx?=
 =?utf-8?B?RlBjZENLWGpLT1NCWXExM2pJVUp5MFZnV2RUenc5NWF6Y0hxNDNsOGt6Sjdj?=
 =?utf-8?B?NXY3WlJ0V2lTQ01oUjNRcEl5QU5CV3J5cWZMVGUzTVVFNlJ0SlZXZUZ0WVRN?=
 =?utf-8?B?MmRocEZNeGxzT1NVaHFMcDY5cmdIckttS0xzRHJ3b0o5MG03eW4xUzUxWmFm?=
 =?utf-8?B?eU9ZOEF6OVdudHlQYkdZODBqUDdScGI0T0lBME93VTFSN2srb2R4anpzSFkv?=
 =?utf-8?B?Y3JqQm5RbktXOFhHSUlZRjFEc3JwR3F3MGNZT1hWVVRicXZjR09yRjMvUUJu?=
 =?utf-8?B?TzVFa0hoVS91cWVOM0dQd1VNTmZaODhqS1IyR3N2ZUpKcVNEZDdCMmMxdGFs?=
 =?utf-8?B?NUdTTmxzL0tsS0pzQnV4Q3JLTUNKTnF4UzgwS21SUWlhaWZkMzQ5RUFqTHNS?=
 =?utf-8?B?NGN0YWw2aDRMM2UrNXFhWVNSaFIrZUxyZE1rV25jeDZKWjJWVUNYcmUwRmM3?=
 =?utf-8?B?M3hQSUVlSzRWUHdRZUhHbUllSktNclMySTM2aGZBZkh4Q2VhdzAvVWJoang4?=
 =?utf-8?B?OUdvL0NKSWdBbm9rTE1ZWnRUU3BLTkd0YlBidjdOVEtKWDNTMTV4RUNIbmh3?=
 =?utf-8?B?clFpWU5JWXErbEVOT1kwYUpyRFB1My95M2p3Q0E5ZkpkSGdRbmJOazdnQjdO?=
 =?utf-8?B?RFRYMkdTNkpSalJFWDNySm9FRWRZNkpMeUNiSit2UU5ZYzFQeGhhblpMaWE1?=
 =?utf-8?B?aTA3VW9UR2hjWThzdHEwcWpwTDdJYWZVdTk5YklwYndPRHhUL1g5NjFxa1Fo?=
 =?utf-8?B?eWdMYW5JZ2VQaG0yQTdQcytsZzlCL1RXMDdBYWpkcEpIZ1puM3M0TnF4c0tt?=
 =?utf-8?B?N1ZCRjdTUnFqeUhvREt6alZ1RFp2WHQvYlRjcHJXNWUxTDN0blE3MG1oS2tM?=
 =?utf-8?B?UzdveTJ5TmFpanh3R1JJNlRvMDZUTU9OWHlyVDlLY3NlU0duNHpibWNEbm5G?=
 =?utf-8?B?MVJWNWp0QythSTl1RHdFTzlCSldtT0lCVWdTM0pBaDhZRGJUREpqc2VuTnNP?=
 =?utf-8?B?b0xDVk5uQmo0MWRXaENTcEsyMGJoaXlNK0lVcTZrSm5oSjh0MGFYOGtra0NF?=
 =?utf-8?B?WkpMQWNnTEg0ODA2TU5HQ3liMHVzZFFxek9nN1RMckVHWnY1ZFlId0x2NTQy?=
 =?utf-8?B?ZjZnUmJINGtIMUtjVkpNREdYTCtudi82SDc0OC81bjZ0Z1AzQnZNZ0FrWitm?=
 =?utf-8?B?c0d4YlhRZU5ONjVDbkZlbWtFWEVOMlZpM1l2K1JHOWRvMktFUk9zMXh2UjlK?=
 =?utf-8?B?Wkltdm82QmU1UFN5c1laNjNXZmNNTHFpbzRxTVZRQy9zNEpqMXB6d3RQZS9O?=
 =?utf-8?B?SUZzMnk0OXVNOGRrSGNMYVNiZW5wMlJJY0lja3lQR00zMURmNHpZSW5uT29M?=
 =?utf-8?B?NGROSElseURQalY2Y2l1YnhoZHVZa1pMbDF2c1d3L3VhK1ZQYU5iaEgxbzBS?=
 =?utf-8?B?bVhFVThRSENSd0VWV09LMHNQQmVVOE5memFWei92bU4vUDF3ZjhiRWpUZ28v?=
 =?utf-8?B?eWsrWmU5Y3ZSYUM5cFRrK2NubHQ1VlJyd290MVFXSldvN1RNb3l2MlBlVTUv?=
 =?utf-8?B?eFcxRENRN3ZadEpXQnpTNXk5MEZsdUtaQWpSNEMrUFJxaWJZaDd6NFViVG9D?=
 =?utf-8?B?eXFJbXI0YmlxMnJhSEE1OXk0dk5CWjdyRFJJMjg0OEdoL1g4ZFRkY3ljWmdP?=
 =?utf-8?Q?iMYami5ZQ1vGy7PvNp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 762466a4-3a81-477c-792f-08df0d6bad38
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 05:40:23.0500 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E5Ut0EhBiglS/i7JWhPJgSAhcwrq6aZM9nG61HbfWJiOuHDQBAAFuYFDMXUr/0+xjmSMQChJTEEwr/rBImxapw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8857
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



On 9/8/2026 11:49 AM, Matthew Brost wrote:
> On Mon, Sep 07, 2026 at 08:18:08PM -0700, Matthew Brost wrote:
>> On Sat, Sep 05, 2026 at 09:31:42PM +0800, Honglei Huang wrote:
>>> dma_iova_try_alloc() reserves one contiguous IOVA for the whole range and
>>> links each page at the next offset, so the device addresses run
>>> contiguously from entry 0 and one entry describes them all. A 2 MiB range
>>> of 4 KiB pages then drops the same 8 KiB array as a THP backed one.
>>>
>>> Fold only when state_offset covers the full range, which proves no device
>>> page was mapped in between, and only single page entries, so the order
>>> kept is 0 and stays true. Widening it instead would tell a consumer to use
>>> a huge page for npages separate CPU pages, which hangs Vega20 on amdgpu.
>>>
>>> The kept entry no longer bounds the segment, so skip the unmap walk when
>>> it has nothing to do, keyed off dpagemap rather than the flags, which are
>>> not published yet on the error unwind. Consumers need the same
>>> distinction, so drm_gpusvm_pages_first_dma() returns it alongside the
>>> array from one read of the flags; xe passes it to xe_res_first_dma().
>>>
>>
>> Nice trick for IOVA allocs and variabled sized mappings like userptr.
>> Looks good.
>>
>> Going to megre entire series to drm-misc-next shortly. Thanks!
>>
> 
> So small snafu merging - this series won't cleanly apply drm-misc-next
> and won't until 7.4 because of patches in Xe targeted for 7.4. The
> series will cleanly apply to drm-xe-next, so if AMD is ok with this, I
> can merge there. Or I can work through the (minor) conflicts and merge
> this into drm-misc-next (ofc I'll need confirm with the drm-misc
> maintainers that this ok too).

Merging to drm-xe-next is fine for us. Please proceed with the merge there.
And thanks for the review and merging!

Regards,
Honglei

> 
> Matt
> 
>>> Suggested-by: Matthew Brost <matthew.brost@intel.com>
>>
>> Reviewed-by: Matthew Brost <matthew.brost@intel.com>
>>
>>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>>> ---
>>>   drivers/gpu/drm/drm_gpusvm.c       | 41 +++++++++++++++++++++++-------
>>>   drivers/gpu/drm/xe/xe_pt.c         | 23 +++++++++++------
>>>   drivers/gpu/drm/xe/xe_res_cursor.h |  5 ++--
>>>   drivers/gpu/drm/xe/xe_svm.h        |  8 +++---
>>>   include/drm/drm_gpusvm.h           | 13 +++++++++-
>>>   5 files changed, 67 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
>>> index 2c7c4c89dc4..b6c9d3a07dc 100644
>>> --- a/drivers/gpu/drm/drm_gpusvm.c
>>> +++ b/drivers/gpu/drm/drm_gpusvm.c
>>> @@ -1242,7 +1242,7 @@ static void __drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
>>>   			.__flags = svm_pages->flags.__flags,
>>>   		};
>>>   		const struct drm_pagemap_addr *addrs =
>>> -			drm_gpusvm_pages_first_dma(svm_pages);
>>> +			drm_gpusvm_pages_first_dma(svm_pages, NULL);
>>>   		bool use_iova = dma_use_iova(&svm_pages->state);
>>>   
>>>   		/*
>>> @@ -1259,7 +1259,15 @@ static void __drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
>>>   			dma_iova_free(dev, &svm_pages->state);
>>>   		}
>>>   
>>> -		for (i = 0, j = 0; i < npages; j++) {
>>> +		/*
>>> +		 * With IOVA and no device page the unlink above tore every
>>> +		 * entry down, and that is also when the range may be folded
>>> +		 * to one entry, which must not be walked per entry. dpagemap
>>> +		 * is set before the first device_map(), so it is also right
>>> +		 * on the error path, where the flags are not published yet.
>>> +		 */
>>> +		for (i = 0, j = 0;
>>> +		     (!use_iova || dpagemap) && i < npages; j++) {
>>>   			const struct drm_pagemap_addr *addr = &addrs[j];
>>>   
>>>   			if (addr->proto == DRM_INTERCONNECT_SYSTEM) {
>>> @@ -1491,17 +1499,32 @@ static bool drm_gpusvm_pages_valid_unlocked(struct drm_gpusvm *gpusvm,
>>>   
>>>   /**
>>>    * drm_gpusvm_pages_inlinable() - Whether the dma address can be inlined
>>> + * @svm_pages: The SVM pages instance that was just mapped
>>>    * @nentries: Number of entries the mapping loop produced
>>> + * @npages: Number of pages in the CPU range
>>>    *
>>> - * A THP maps as one huge page, so the whole range needs a single device
>>> - * address: the dma_addr array can be freed and the address kept inline,
>>> - * which is where the memory saving comes from.
>>> + * A THP maps as one huge page, and an IOVA reservation links every page of
>>> + * the range at the next offset, so the device addresses run contiguously from
>>> + * entry 0. Either way one entry describes the whole range, so the dma_addr
>>> + * array can be freed and the address kept inline.
>>> + *
>>> + * state_offset advances only on the IOVA branch, so reaching the full range
>>> + * length proves no device page was mapped in between. Only single page
>>> + * entries fold, so the order kept is 0 and describes the range truthfully.
>>> + * Larger chunks, several huge pages among them, stay an array that is
>>> + * already short and that a consumer places with one PTE each.
>>>    *
>>>    * Return: True if the mapping fits in a single drm_pagemap_addr.
>>>    */
>>> -static bool drm_gpusvm_pages_inlinable(unsigned long nentries)
>>> +static bool drm_gpusvm_pages_inlinable(struct drm_gpusvm_pages *svm_pages,
>>> +				       unsigned long nentries,
>>> +				       unsigned long npages)
>>>   {
>>> -	return nentries == 1;
>>> +	if (nentries == 1)
>>> +		return true;
>>> +
>>> +	return nentries == npages && dma_use_iova(&svm_pages->state) &&
>>> +	       svm_pages->state_offset == npages * PAGE_SIZE;
>>>   }
>>>   
>>>   /**
>>> @@ -1656,7 +1679,7 @@ static int drm_gpusvm_dma_map_pages(struct drm_gpusvm *gpusvm,
>>>   	if (pagemap)
>>>   		flags.has_devmem_pages = true;
>>>   
>>> -	if (drm_gpusvm_pages_inlinable(j)) {
>>> +	if (drm_gpusvm_pages_inlinable(svm_pages, j, npages)) {
>>>   		struct drm_pagemap_addr addr = svm_pages->dma_addr[0];
>>>   
>>>   		kvfree(svm_pages->dma_addr);
>>> @@ -1772,7 +1795,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>>>   
>>>   	if (map_dma) {
>>>   		for (p = 0; p < num_pages; ++p) {
>>> -			if (drm_gpusvm_pages_first_dma(&svm_pages[p]))
>>> +			if (drm_gpusvm_pages_first_dma(&svm_pages[p], NULL))
>>>   				continue;
>>>   			svm_pages[p].dma_addr =
>>>   				kvzalloc_objs(*svm_pages[p].dma_addr, npages);
>>> diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
>>> index fa4b29da0b6..7fb2fe1f826 100644
>>> --- a/drivers/gpu/drm/xe/xe_pt.c
>>> +++ b/drivers/gpu/drm/xe/xe_pt.c
>>> @@ -831,9 +831,12 @@ xe_pt_stage_bind(struct xe_tile *tile, struct xe_vma *vma,
>>>   			return -EAGAIN;
>>>   		}
>>>   		if (xe_svm_range_has_dma_mapping(range)) {
>>> -			xe_res_first_dma(xe_svm_range_first_dma(range), 0,
>>> -					 xe_svm_range_size(range),
>>> -					 &curs);
>>> +			const struct drm_pagemap_addr *addr;
>>> +			bool contiguous;
>>> +
>>> +			addr = xe_svm_range_first_dma(range, &contiguous);
>>> +			xe_res_first_dma(addr, 0, xe_svm_range_size(range),
>>> +					 contiguous, &curs);
>>>   			xe_svm_range_debug(range, "BIND PREPARE - MIXED");
>>>   		} else {
>>>   			xe_assert(xe, false);
>>> @@ -865,11 +868,15 @@ xe_pt_stage_bind(struct xe_tile *tile, struct xe_vma *vma,
>>>   		xe_bo_assert_held(bo);
>>>   
>>>   	if (!xe_vma_is_null(vma) && !range && !is_purged) {
>>> -		if (xe_vma_is_userptr(vma))
>>> -			xe_res_first_dma(drm_gpusvm_pages_first_dma
>>> -					 (&to_userptr_vma(vma)->userptr.pages),
>>> -					 0, xe_vma_size(vma), &curs);
>>> -		else if (xe_bo_is_vram(bo) || xe_bo_is_stolen(bo))
>>> +		if (xe_vma_is_userptr(vma)) {
>>> +			const struct drm_pagemap_addr *addr;
>>> +			bool contiguous;
>>> +
>>> +			addr = drm_gpusvm_pages_first_dma(&to_userptr_vma(vma)->userptr.pages,
>>> +							  &contiguous);
>>> +			xe_res_first_dma(addr, 0, xe_vma_size(vma), contiguous,
>>> +					 &curs);
>>> +		} else if (xe_bo_is_vram(bo) || xe_bo_is_stolen(bo))
>>>   			xe_res_first(bo->ttm.resource, xe_vma_bo_offset(vma),
>>>   				     xe_vma_size(vma), &curs);
>>>   		else
>>> diff --git a/drivers/gpu/drm/xe/xe_res_cursor.h b/drivers/gpu/drm/xe/xe_res_cursor.h
>>> index 0522caafd89..c3a037e5f34 100644
>>> --- a/drivers/gpu/drm/xe/xe_res_cursor.h
>>> +++ b/drivers/gpu/drm/xe/xe_res_cursor.h
>>> @@ -233,12 +233,13 @@ static inline void xe_res_first_sg(const struct sg_table *sg,
>>>    * @dma_addr: struct drm_pagemap_addr array to walk
>>>    * @start: Start of the range
>>>    * @size: Size of the range
>>> + * @contiguous: Whether one entry describes the whole range
>>>    * @cur: cursor object to initialize
>>>    *
>>>    * Start walking over the range of allocations between @start and @size.
>>>    */
>>>   static inline void xe_res_first_dma(const struct drm_pagemap_addr *dma_addr,
>>> -				    u64 start, u64 size,
>>> +				    u64 start, u64 size, bool contiguous,
>>>   				    struct xe_res_cursor *cur)
>>>   {
>>>   	XE_WARN_ON(!dma_addr);
>>> @@ -248,7 +249,7 @@ static inline void xe_res_first_dma(const struct drm_pagemap_addr *dma_addr,
>>>   	cur->node = NULL;
>>>   	cur->start = start;
>>>   	cur->remaining = size;
>>> -	cur->dma_seg_size = PAGE_SIZE << dma_addr->order;
>>> +	cur->dma_seg_size = contiguous ? start + size : PAGE_SIZE << dma_addr->order;
>>>   	cur->dma_start = 0;
>>>   	cur->size = 0;
>>>   	cur->dma_addr = dma_addr;
>>> diff --git a/drivers/gpu/drm/xe/xe_svm.h b/drivers/gpu/drm/xe/xe_svm.h
>>> index 7eb80d4d6db..2ef4ef026cc 100644
>>> --- a/drivers/gpu/drm/xe/xe_svm.h
>>> +++ b/drivers/gpu/drm/xe/xe_svm.h
>>> @@ -223,13 +223,14 @@ static inline unsigned long xe_svm_range_size(struct xe_svm_range *range)
>>>   /**
>>>    * xe_svm_range_first_dma() - Resolve the device address array of a SVM range
>>>    * @range: SVM range
>>> + * @contiguous: Where to store whether one entry spans the whole range
>>>    *
>>>    * Return: Pointer to the first device address, NULL if none is populated.
>>>    */
>>>   static inline const struct drm_pagemap_addr *
>>> -xe_svm_range_first_dma(struct xe_svm_range *range)
>>> +xe_svm_range_first_dma(struct xe_svm_range *range, bool *contiguous)
>>>   {
>>> -	return drm_gpusvm_pages_first_dma(&range->pages);
>>> +	return drm_gpusvm_pages_first_dma(&range->pages, contiguous);
>>>   }
>>>   
>>>   void xe_svm_flush(struct xe_vm *vm);
>>> @@ -449,8 +450,9 @@ static inline bool xe_svm_range_is_removed(struct xe_svm_range *range)
>>>   }
>>>   
>>>   static inline const struct drm_pagemap_addr *
>>> -xe_svm_range_first_dma(struct xe_svm_range *range)
>>> +xe_svm_range_first_dma(struct xe_svm_range *range, bool *contiguous)
>>>   {
>>> +	*contiguous = false;
>>>   	return NULL;
>>>   }
>>>   
>>> diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
>>> index aaad5c9b510..9e35584812f 100644
>>> --- a/include/drm/drm_gpusvm.h
>>> +++ b/include/drm/drm_gpusvm.h
>>> @@ -380,12 +380,19 @@ static inline void drm_gpusvm_init_pages(struct drm_gpusvm_pages *svm_pages,
>>>   /**
>>>    * drm_gpusvm_pages_first_dma() - Resolve the device address array
>>>    * @svm_pages: Pointer to the drm_gpusvm_pages.
>>> + * @contiguous: Where to store whether one entry spans the whole range, or NULL
>>>    *
>>>    * drm_gpusvm_pages use unions to optimize the storage of DMA addresses,
>>>    * this function abstracts the access to the first device address. The driver
>>>    * should use this helper instead of reading dma_addr directly to prevent
>>>    * array out of bounds access.
>>>    *
>>> + * @contiguous comes from the same read of the flags as the array itself, so a
>>> + * caller cannot see the two disagree and walk past that single entry into the
>>> + * fields behind it. When it is set the length comes from the range rather than
>>> + * from the order. The order still states what one PTE may cover: the range
>>> + * length for a huge page, PAGE_SIZE for an IOVA mapped range of single pages.
>>> + *
>>>    * Only get_pages() and the free path switch between the two union members.
>>>    * Both hold the notifier lock for read, so taking that lock does not stop
>>>    * them; callers need the driver lock that does, which every reader of the
>>> @@ -396,13 +403,17 @@ static inline void drm_gpusvm_init_pages(struct drm_gpusvm_pages *svm_pages,
>>>    * Return: Pointer to the first device address, NULL if none is populated.
>>>    */
>>>   static inline const struct drm_pagemap_addr *
>>> -drm_gpusvm_pages_first_dma(const struct drm_gpusvm_pages *svm_pages)
>>> +drm_gpusvm_pages_first_dma(const struct drm_gpusvm_pages *svm_pages,
>>> +			   bool *contiguous)
>>>   {
>>>   	struct drm_gpusvm_pages_flags flags = {
>>>   		/* READ_ONCE pairs with the WRITE_ONCE of the flag writers */
>>>   		.__flags = READ_ONCE(svm_pages->flags.__flags),
>>>   	};
>>>   
>>> +	if (contiguous)
>>> +		*contiguous = flags.inline_dma_mapping;
>>> +
>>>   	if (flags.inline_dma_mapping)
>>>   		return &svm_pages->inline_addr;
>>>   
>>> -- 
>>> 2.34.1
>>>

