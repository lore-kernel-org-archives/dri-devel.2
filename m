Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58102CD4F3D
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 07:22:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B054210F4CE;
	Fri, 22 May 2026 07:22:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FwSd9hFl";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010011.outbound.protection.outlook.com [52.101.61.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 436B710E0A9;
 Fri, 22 May 2026 07:22:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gAWNtF/UlSzqlKTYKNgD3Z+QTrG5xxl3Ogk2YpA5UKXkHqTHUjQXJ9dTdvhf2HwWakEjJkwrqdPiUmyeiGW0A17BiTt2RF60kSJTbXk6Dxa2MmQiDeNxA7grdVNiotXlI4L7r/Y04atXU5zB8RiWGTsjeLUXcgH6OQ/4wxSdXjOn6t7nduylwGgV2EUHF45zvxjUwIOHyzxJHRyu0qULSmBlWcoD4/yiHcM4N0IFiWDTiIWrGV8WwoRP5TjHZSbFsF2wKEq+i9rU7WhS1r8pJ/YWcqN8ZcgHImzFicwWe7oHz2HQh+shzCdUrNgAeogvcDOCpWyMDmIAPUSqe7hTMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+gv3Wj/q0/a275l/H6uQVMAdPrjzjOiKjYJT+hYUkx8=;
 b=eo63/zbjE9ba2Lq3bpRXAmAnL75HeOaxjTMMDe+I/OWTAd79oywL1L4+nhwzwojqP/dQpuRJlAe9R61YcWSevL2ZmS0gKFmHto68euiyJjRYfjbLFW55+4kz7+eo/7xjDiEqJU+SpGMfoo0CQoDybXlhIzRXYZq/DG1DXPQNZN4Iy3tTnGbIgYEMAWMhpgJnHru1a+aAlqH42vAucxyWZkX727xZXmXSL3w+thJLoVhWNybvmZ5pDcm45bLACLrW3PgDYihqcDeyMg1hZAG74AN+ecHL1cRZfV9bDOE/VDBY1v0WSNQuh06lfrNDFyIDSFLoKDzTy59rPs5iZeFIzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+gv3Wj/q0/a275l/H6uQVMAdPrjzjOiKjYJT+hYUkx8=;
 b=FwSd9hFlk8e3iMZkBUPnTfIN47uku8T4cyu+Pv/EwMcPHBK4nO0DoSkaENYxlAk4OwiKrRF5GiFQEonL728R42hZmRf+CTAfBVKgzMMQoyUDfBJch71upfsJTN7XBc3Yt1KXEX9q+snLRJmXrEhofl/UaceFveOEapR4Sa/ooTw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from EAYPR12MB999132.namprd12.prod.outlook.com
 (2603:10b6:303:2c2::11) by DS5PPFC9877909A.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::661) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 22 May
 2026 07:22:46 +0000
Received: from EAYPR12MB999132.namprd12.prod.outlook.com
 ([fe80::7798:60c4:e3f0:d3f8]) by EAYPR12MB999132.namprd12.prod.outlook.com
 ([fe80::7798:60c4:e3f0:d3f8%4]) with mapi id 15.20.9891.021; Fri, 22 May 2026
 07:22:46 +0000
Message-ID: <468b9064-9eed-4651-b54a-4a15c7c4400f@amd.com>
Date: Fri, 22 May 2026 12:52:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V10 03/10] drm/gpu: Add gpu_buddy_allocated_addr_to_block
 helper
To: "Upadhyay, Tejas" <tejas.upadhyay@intel.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
Cc: "Auld, Matthew" <matthew.auld@intel.com>,
 "Brost, Matthew" <matthew.brost@intel.com>,
 "thomas.hellstrom@linux.intel.com" <thomas.hellstrom@linux.intel.com>,
 "Ghimiray, Himal Prasad" <himal.prasad.ghimiray@intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <20260519122817.45770-12-tejas.upadhyay@intel.com>
 <20260519122817.45770-15-tejas.upadhyay@intel.com>
 <835d204d-0c2a-4a81-8c60-9d047809f6ef@amd.com>
 <DS0PR11MB871852B659D0736A9582D23081012@DS0PR11MB8718.namprd11.prod.outlook.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <DS0PR11MB871852B659D0736A9582D23081012@DS0PR11MB8718.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0047.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:175::9) To EAYPR12MB999132.namprd12.prod.outlook.com
 (2603:10b6:303:2c2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EAYPR12MB999132:EE_|DS5PPFC9877909A:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a93fb05-7512-493d-4951-08deb7d2ebaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: FpWsGmEn8QyDylBgNnSmedVmdVfS9rCWcXHc7ayHzS3rJUnlZxR7Ga+qmcwt9HhYKiePHNQLwNVd+SKHfCmfJje+g8z2OlpvRtGz0XRUL4Y6jpTtgIbVHj2LAY/Lpc7hInrYEeYsV4URJz2yzX7tpJxZYeXLfCSsqLpLxm3eEBnZLeGVilWQPSr8++iuSZKioa2G+TQdoxSqfwje2nlB7paO4Zx3XpMePc6OIPJZCkDPaAMa/otlGYx3NFVjGM9mPTWTo3DT6UpTmPYVpg38INm3krYv/T9aTVSwxCXnd6kpmBjH5NfOgRnEdvDbyOvFF2DF0qjqmfx2GNP3ywPQwrjNvz74wqYmlu0zKXBC0CREo3kjMpPjEp187uuFsdJTrM4r1caTnywEFVA6D59Byr67BC+bBbBVt3v1oNrNAvpmqW9DcHyx/7KXOY5wrbQ3vN+xmBT5knZu2GMjypaxZl+iq4fBGSXY5i1Y+ztOz1zLWDZR7GwPoBq/GNQmq1rCZvI42za9pLM2NTX69vOnDXrQ+ahIm3RsQDx0TGrSM4g2LohlMO6+qxB2Sp2meZySw4d3WovGBNrnZZNDKGmUn1FrNBd+KnV56m/G8oSwWcXTx1DtpFRe7B1p2TTipbiJoedh3bLtNKOlTc0rfBJVJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EAYPR12MB999132.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXEwTXI0eUJkQkF6Qkx2aGNvd2pGNHpNWjZGMXZ6bUdTdkc4RSs5dm5wWVBG?=
 =?utf-8?B?eDRrb0hvVzhnUmtrUlRKL1I3YzdjM1RXYW53QzRwZS84YktHTXJLVEdyUzBO?=
 =?utf-8?B?Qm8wQTM3aVBLN2hMRGkvTnBEMCthTFJsYWRrMjFDMkdqWUdmSm5yUGtQUG02?=
 =?utf-8?B?UkVzWU40MHZ5cWJ5U21DME14NUpUSVkwMVhKcDcvd3o2dUd5UGtIb0w0L2Rx?=
 =?utf-8?B?OXYwcW1YMlNJNjVQVkU5dXM2THhUb0QxZmRNYlBmTEd5UHV3aTVzUm5mZDNI?=
 =?utf-8?B?N2FmbTFFWlJ2UDNTeUlTaDExN28zUjEyanVmQ2lHNkVHRDI0ZitKNW04a1pP?=
 =?utf-8?B?Si9WV1dzdjJVbW42dVdSMi9tNE1hY1kzNC9mTmFmd2dsSWY4QVlhdlVIKzE4?=
 =?utf-8?B?eHVMdkM4azlDWWVDS3dCTHNYeS9sbEpWd3pIcGp4WEsvdlRYSmVHbTByVkRv?=
 =?utf-8?B?TDFaSEM3TnluZjN6SFJzSFpFMlEwZ2JqTjhlclNXU3I3RC9rZ0VXd1Z4Vmpa?=
 =?utf-8?B?RmVHcGJ2MW5wQ3N2cmFhUmZId2RHQU5USjgrQjNpdUp0Rk9LRWs5dVdnMmlw?=
 =?utf-8?B?aXoyOW9hSW9hVDNlcGhPUDRJV25HV1NMdGlNVW9FNE9uVlQ2S0lHYmFXN3By?=
 =?utf-8?B?K0xOOWtNTGlrV0pyYnZGM0dTbjRxVENDZ1RRNGF4RkhlRFpDdnpqOVdxMFYy?=
 =?utf-8?B?WitaaktDTWZYK3l3UEEyZXQrOHRKb204ZmI0REZkb1ZIUGFKNjhoZzJSeHZU?=
 =?utf-8?B?dlJMUG83R0N4TUJOMEQzSkxWd0VLUDMzVHZBOEVqWG9HTituVDlQaTYvL2tQ?=
 =?utf-8?B?bFFNaDVZY1h1TjZGa0gvdnk2b0EyM2NQeUJvRmlQMlAyY2VmV200NUZWRmVj?=
 =?utf-8?B?MURwTWdkajM5RFlrSjkyRkNnZjNYYXpjUm5WK0pxZUJLcHFlS3RtcHl1TjdY?=
 =?utf-8?B?cGpvSE9BL0NqTENvdmNOUmNpRjR0d2Q3bTJLTFZvL3ZCYUFFNnI0cFZaUkwr?=
 =?utf-8?B?SlRabjBWeG1CdW9Ta05uWUdTMzhmQk5jTEhzWW1JR01tUzZId3JpRjcxUFFU?=
 =?utf-8?B?bUZFUkZDUHpNWGVTdEZPUno2Q3hMWXA3SG5FdktrWlJyNjNXUkkyY3gwQ24v?=
 =?utf-8?B?ZTBxclIrK2lWY1ptbnhMdWxkK0huWE8vOG9oNUtuTkdBMlZ5YVR0TjdnOWZX?=
 =?utf-8?B?eFVRblNoSWp4cC8rekF0UWZIS09ramFPU3VpdGxOZFdnQ2xBTEQ5NlR2VGJh?=
 =?utf-8?B?MDE4aWVLNkJYMmd2REI3YVVIdTJ2Q0VhVEs2MDVRc2M2b1ZLdHQyTmJRbjFQ?=
 =?utf-8?B?NlhMc3RnZHpZOUpPSXhWYXYzOXZ5dHJKc1ltZFBUb0puWXFPeEpsSk5ZSXJL?=
 =?utf-8?B?ejBNWHVEUHhBczFveG5BNFdOK1Y4NmdRMzQra2Ftd1RRbEIvUS9ma0VZNzUx?=
 =?utf-8?B?T05mbHlJK3laRENIWTZOME1MNWc1aEExT01oODlmTlhiMTZoc2g3Q2R4Rk5k?=
 =?utf-8?B?WHVHTkhzRm4wWXRRb2ZTTTd6ZEkwcnAwNWc3b2dqM3VFWjYrZjFRbUtzcHp0?=
 =?utf-8?B?SGZlUFpjNjh3cUFJaHFsNjl3TGQzUmdnKzRHd2JNOUFjWGRqaElDcXZGUVVO?=
 =?utf-8?B?MU9YUHdoemFQdkFWM3J4b1JSOWQwYjVPZU1sSG90ZFI2S3ZadGxkVm5lVXl4?=
 =?utf-8?B?MTRmdEFPdWdUdXllTmx4bzBUcHJGSVl6UlhMT3ZuRWtqVEw0SW5sQlpuNEZs?=
 =?utf-8?B?VUxGb0RObFU5a2FUQklKTWcrd1g3ZlVGVThzeGxUK1NEejJrNmt3NkJkTzJj?=
 =?utf-8?B?VldSWHpvcDdGcDNDVTJwQy9zUXZ4dVFrRmNWNU5IMldJU2NickN5OGZBQXBP?=
 =?utf-8?B?RDA2Q09Sb05DTTkwbzF3QkFvQ1lkOWtFRUF2NExqeTJSL3piSlZqTldxbnF3?=
 =?utf-8?B?Z2UvRlNvZ01kL1diSm54ZlFLVVdMejRLc29nV1ZVdHBLRmJXM2paSDBoc0ZK?=
 =?utf-8?B?OG9LcW9GMDNiTFBxSWZxdDY1VnJDUS85ZG03bTdxQWpXZnVkVDNWMHlXYlFB?=
 =?utf-8?B?V3pQU0lnVE1GeVRDNUJDNmR4K0dqeEphb0tVMnlFWWduQ3N6UkxsdnlHaWVG?=
 =?utf-8?B?VjNHRVJWN2JnZUJTZGcyZnVtRVFLUjAzbUJYTnVpOVRyOG1MMHhsZ1lSWUFO?=
 =?utf-8?B?enFzYkxKKzFyQ0VRU0pQVUEyQisyUXFtNE9OTmtmYTBXd1lOcGtBSjRFT0M0?=
 =?utf-8?B?dEYyaGdaYjZQb3lPNTMwVkU0TG8yQWc2dlNiT3JDODBwOUVUUk1hK2ZZbmZN?=
 =?utf-8?B?a2xYY2tHVER1eG53TUlHcFgvdHBRai8rbkl5eVZjUDBwMm9OT3RUdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a93fb05-7512-493d-4951-08deb7d2ebaa
X-MS-Exchange-CrossTenant-AuthSource: EAYPR12MB999132.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 07:22:46.6049 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5KWDFNowEzhBimHEOUswpBIyEHmTC4huxh7koHzz2Jl5W/qcSl8fSYcbdbn7HkUzg5DFb/0d/Msu1LW/IuEHmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFC9877909A
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



On 5/20/2026 3:52 PM, Upadhyay, Tejas wrote:
>
>> -----Original Message-----
>> From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
>> Sent: 20 May 2026 14:24
>> To: Upadhyay, Tejas <tejas.upadhyay@intel.com>; intel-
>> xe@lists.freedesktop.org
>> Cc: Auld, Matthew <matthew.auld@intel.com>; Brost, Matthew
>> <matthew.brost@intel.com>; thomas.hellstrom@linux.intel.com; Ghimiray,
>> Himal Prasad <himal.prasad.ghimiray@intel.com>; dri-
>> devel@lists.freedesktop.org
>> Subject: Re: [PATCH V10 03/10] drm/gpu: Add
>> gpu_buddy_allocated_addr_to_block helper
>>
>>
>>
>> On 5/19/2026 5:58 PM, Tejas Upadhyay wrote:
>>> Add helper with primary purpose is to efficiently trace a specific
>>> physical memory address back to its corresponding TTM buffer object.
>>>
>>> v2:
>>> -
>> %s/gpu_buddy_addr_to_block/gpu_buddy_allocated_addr_to_block(MattA)
>>> - remove clear->avail and split nodes check(MattA)
>>> - Adapt lockdep(MattB)
>>>
>>> Signed-off-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
>>> Cc: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
>>> Cc: dri-devel@lists.freedesktop.org
>>> ---
>>>    drivers/gpu/buddy.c       | 53
>> +++++++++++++++++++++++++++++++++++++++
>>>    include/linux/gpu_buddy.h |  2 ++
>>>    2 files changed, 55 insertions(+)
>>>
>>> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c index
>>> eb1457376307..9de9872294a6 100644
>>> --- a/drivers/gpu/buddy.c
>>> +++ b/drivers/gpu/buddy.c
>>> @@ -594,6 +594,59 @@ void gpu_buddy_free_block(struct gpu_buddy
>> *mm,
>>>    }
>>>    EXPORT_SYMBOL(gpu_buddy_free_block);
>>>
>>> +/**
>>> + * gpu_buddy_allocated_addr_to_block - given relative address find
>>> +the allocated block
>>> + *
>>> + * @mm: GPU buddy manager
>>> + * @addr: Relative address
>>> + *
>>> + * Returns:
>>> + * gpu_buddy_block on success, NULL or error code on failure  */
>>> +struct gpu_buddy_block *gpu_buddy_allocated_addr_to_block(struct
>>> +gpu_buddy *mm, u64 addr) {
>>> +	struct gpu_buddy_block *block;
>>> +	LIST_HEAD(dfs);
>>> +	u64 end;
>>> +	int i;
>>> +
>>> +	gpu_buddy_driver_lock_held(mm);
>>> +
>>> +	end = addr + SZ_4K - 1;
The lookup range is defined using SZ_4K, while the allocator itself 
operates in units of chunk_size.
This works when chunk_size == 4K, but it creates a mismatch if the 
allocator is configured differently (e.g. larger chunk sizes).
Should this helper be tied to allocator granularity (i.e. use 
mm->chunk_size) instead?

Regards,
Arun.
>>> +	for (i = 0; i < mm->n_roots; ++i)
>>> +		list_add_tail(&mm->roots[i]->tmp_link, &dfs);
>>> +
>>> +	do {
>>> +		u64 block_start;
>>> +		u64 block_end;
>>> +
>>> +		block = list_first_entry_or_null(&dfs,
>>> +						 struct gpu_buddy_block,
>>> +						 tmp_link);
>>> +		if (!block)
>>> +			break;
>>> +
>>> +		list_del(&block->tmp_link);
>>> +
>>> +		block_start = gpu_buddy_block_offset(block);
>>> +		block_end = block_start + gpu_buddy_block_size(mm, block) -
>> 1;
>>> +
>>> +		if (!overlaps(addr, end, block_start, block_end))
>>> +			continue;
>>> +
>>> +		if (gpu_buddy_block_is_allocated(block))
>>> +			return block;
>>> +		else if (gpu_buddy_block_is_free(block))
>>> +			return NULL;
>>> +
>>> +		list_add(&block->right->tmp_link, &dfs);
>>> +		list_add(&block->left->tmp_link, &dfs);
>>> +	} while (1);
>>> +
>>> +	return ERR_PTR(-ENXIO);
>>> +}
>>> +EXPORT_SYMBOL(gpu_buddy_allocated_addr_to_block);
>>> +
>>>    static void __gpu_buddy_free_list(struct gpu_buddy *mm,
>>>    				  struct list_head *objects,
>>>    				  bool mark_clear,
>>> diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
>>> index 71941a039648..e7e22fa05ee2 100644
>>> --- a/include/linux/gpu_buddy.h
>>> +++ b/include/linux/gpu_buddy.h
>>> @@ -272,6 +272,8 @@ void gpu_buddy_reset_clear(struct gpu_buddy
>> *mm,
>>> bool is_clear);
>>>
>>>    void gpu_buddy_free_block(struct gpu_buddy *mm, struct
>>> gpu_buddy_block *block);
>>>
>>> +struct gpu_buddy_block *gpu_buddy_allocated_addr_to_block(struct
>>> +gpu_buddy *mm, u64 addr);
>> Could you please clarify where we plan to use this helper function in the code
>> path? I do not see any callers added in the current patch series.
> Sure, it is getting called in API xe_ttm_vram_reserve_page_at_addr() at https://patchwork.freedesktop.org/patch/726252/?series=161473&rev=10
>
> Tejas
>> Regards,
>> Arun.
>>> +
>>>    void gpu_buddy_free_list(struct gpu_buddy *mm,
>>>    			 struct list_head *objects,
>>>    			 unsigned int flags);

