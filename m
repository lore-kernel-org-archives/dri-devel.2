Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB13CDE008
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 09:05:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A6E110E348;
	Fri, 26 Jun 2026 09:05:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UKQT6rGh";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010032.outbound.protection.outlook.com [52.101.61.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B11C10E347;
 Fri, 26 Jun 2026 09:05:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FqgqK7D9NBjqb41YT0qcN++uCMgqq0AwS0DnrY4fYqPUogwVHo9T49E4KhkYdUEj1zj8D8peqo1rRjd02TqUfKtZgnyNuGcPzr3eFBn3iOLnA3hpZbq6WbMSTUcFiSB2T45uP8W26fWJzOEtBG551Z41YayVujBLLAsQyFDQQPyNxsQK9dLncDYd03t/3VAj2mFPRYpi4+YOknn5zSrjSfMLI1A4QgDhDBKu9ZIHesXGEJ/RkKxxcdHA3fjzGZXM1btB2EoOh/snyqIY5f2aB7e17aW8zz4tV5kTANGJ02FPhIn9tVKKdO8/kInZ+UxFKlDd8eTUgJA8QIpFILmXrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdRoqd/WeCrvtXC3FQkhx0Hqzb/5xmD+Rg+c8Ix6kO0=;
 b=knazWJbWxPrCBvwKLQexXUxio/Yfr1LMhrWsx+9Cj+Kn5BVqEnfPLO3JbNXhwn24blWRyxFef/iFNDP9BKRVaVU/D1kq4q7RWp+LOX1DeEG2xRdoM3vv8D/DgGInEwGX3wvLl6249SLmzdTwZ9VU7cGsZ3KOHjknSMIaBXKspBxymnmEpwF0BPtEpwIxEsO+wT+p9AHniXMujywynxJm0amIxMtrDZNEHbvoL9nGYbln37YtrCU4htAuJodcRXvoH6JLetUus1QfI+fnYDeAgUeJubtJrrZVGYmVL6tr4LZMc5F/I3rZfxxG0ndekYI3EYckcrhREgETfGUbif4jeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdRoqd/WeCrvtXC3FQkhx0Hqzb/5xmD+Rg+c8Ix6kO0=;
 b=UKQT6rGhIaMMShcEDZADvooYaxNVUw+brE/OXv+EWC9+T229HMHYwGsg0JCi2/qtDtmzDTTIJWbRb+yOc8t9pWdnlutZnBF8+2M6iEvs7PzkOJlPxLem4YhdSPN67u1wx8xrbbasSw5VrQD84s6lj5FmLKWq2rsVEIjjcDpUMkg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by BY5PR12MB4273.namprd12.prod.outlook.com (2603:10b6:a03:212::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Fri, 26 Jun
 2026 09:04:58 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 09:04:58 +0000
Message-ID: <22abdc3c-57f0-4a2d-a4f3-5a369cfa5d6e@amd.com>
Date: Fri, 26 Jun 2026 17:04:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] drm/gpusvm: embed struct drm_device into
 drm_gpusvm_pages
To: Matthew Brost <matthew.brost@intel.com>
Cc: sima@ffwll.ch, rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com,
 dakr@kernel.org, aliceryhl@google.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Christian.Koenig@amd.com, Oak.Zeng@amd.com,
 Jenny-Jing.Liu@amd.com, Philip.Yang@amd.com, Xiaogang.Chen@amd.com,
 Ray.Huang@amd.com, Lingshan.Zhu@amd.com, Junhua.Shen@amd.com,
 Yiru.Ma@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Honglei Huang <honglei1.huang@amd.com>
References: <20260618080902.1527255-1-honglei1.huang@amd.com>
 <20260618080902.1527255-3-honglei1.huang@amd.com>
 <aj462A8UYxZov7ID@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <aj462A8UYxZov7ID@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0056.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:3::7)
 To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|BY5PR12MB4273:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ad0a5f0-53b1-467d-a3ef-08ded361ff86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: b0f1lYb8FiEIvpCq3lFWYOqeWT+eqPN05W+bj7lg6mxPHRhcNZOhPk3WTMSmUJE/Jr8VRhGk4WZ3a+09qYKXYqN1lx20mkoJc7INNJdR7jgM+PD/bbVCUOK1wmv1vWX9f4YBtYl1FQZ7ou3wxTbOs7tmkmfzqSICiLjHSqWU0hQU8aABpJmal75fjjl+BS+X75OnT73IDL36SDPuUug0SxYUoO/oSd5A9yTC+CxmJREjlRnkcG/+SlByg8QdlESKB87a50WvJxGDH79nZpAnM/KyFw194Quz72k7hEVYedoX6SSQE+XwHBaukSj9xCXhOuIeoYqKwJ6qdKabORW04GgCSDPMVLXZ8aVTP4cx8PUoXMysUrRX5ooHiUd6zRupDJtntSzEQMmKXkYN+j3E09GpseysxKshXaxFfqsaMK/bw7oE1Qbp359ezOCS9xnxc/9CWaacxo1dJmiI4bmAIoZUh3LZBC5l1xnupLIf5MvYNIMcnhAA/zT+/sywSxWZf7mKndYNEqVgcnvs5v+qu82CruFE4L4U387yiZaV8sfSTh83GBBmDYk6DSkb0km7mT+NexeRJYTfMW8/6aLeNC6OxsTWAc4zYFsr+EYGjpOuDwxu9XxOt9vCBotG3KGrdaz60Eg1wHfYvAq+3xkzIK1hvZlSTlKyQgPCEPn5UpI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0N5Zi9nSlZjZWEyTlZRWmVpVjJSRGF6RUp0cUtsajNVZ3krUHczVURtTGJJ?=
 =?utf-8?B?TjdjbjkzeGRVQzMrNzBtYVRDSVhla0FZYm1WdTF0K0dUR2NYV3VDYS9zRWlH?=
 =?utf-8?B?NDBsd3N2ZlZ3OGgyclorVWFQbVduZCtHdEcxbnZTTGJpenR3bG5tL3FHVkIw?=
 =?utf-8?B?cHczR2dHVGhSNFBKNnZsN0g2Z0ZKbkJ5VUk5clJsbGt1Rmczb0U5MThoeldi?=
 =?utf-8?B?NGkxYWJEbTFDZ283alRueGdQS1JWRkVCeElIWkFSdzI5T3g3MGJHdzVqdmZr?=
 =?utf-8?B?OE10Z2tSUXNsbEpDaVpkMUJOS2g3b1lFME1uWEV6Nlg4aXVnMTVNQXBtT1l2?=
 =?utf-8?B?Q2ZuZmlqSTNzL1NUM1FXVlA2ZU1yaXNCK3NDUGI1c0Y2a1B4b3R2NjZKNTBQ?=
 =?utf-8?B?VEFxMG8rNWRyVlNQcUtoUHJpakFHTHdBcSsraXBFNkZqWmYyVmswS2MyUzB0?=
 =?utf-8?B?ZFgwR3J3aWowOGloRWZYc291L0xaZ0wzVTlQMTZEZFRRUTVXZ2tJSmtPQXpy?=
 =?utf-8?B?cWF3ZjhDdUtlMUVJMTFNVEtTcnRiSC9lcmVtZElmR3RMTkR1RDdNNFp3QUta?=
 =?utf-8?B?UldMU0JINnZvWWhBcDBZd3BwSWRBS0VOYk1lVVNtRHdNSHFzc0R3dWpvRTBy?=
 =?utf-8?B?TlVxVHJGUUtKME5NeFFhbGNjUVNlb3hhMElHUnFjQzY0dGcrOGhsR1FEajlQ?=
 =?utf-8?B?Ky9OZHJiMkFkWmNYeEs5b2VUeFBlQ0NGanFWdUIvWEJqdUxoRUE2NTVUd0JJ?=
 =?utf-8?B?dzVHUmdCUXlZRzdOL09lbFlwQzNSNWZuaWhTM2x3UVVZTzU0S1VSZC9Icm5w?=
 =?utf-8?B?ZkhrcnNQQjdoVWpXMDFvb0JQZ01hVkFsUTZrWVlUVExqTVBTSEJzTjUrWkpu?=
 =?utf-8?B?a0ZIdm1rbE0wdWhURkl3dnB3TTBHZU1KZ2dlbUNua29lcW9sZE85OUZNWG1m?=
 =?utf-8?B?cDloeUlDWCtDckFza0haR1JLNUFBaXY3dXBHdWlkY3ZtSThmRGh6b3o5U1l3?=
 =?utf-8?B?YjNnZWszUXlrU1NnM29rMC9mNDY0WFNFbjIwbmdEeWNWeThQZWxBZE9TbVZj?=
 =?utf-8?B?akNTcjlYNm1PQnkzTS9rWjIwcDQ2OFhFRmw3b2VkNEwxaWxTSisyUjJOZEww?=
 =?utf-8?B?T21qa2s3OGppSEwxNTR6SEVyQU5hdTJGRWtIVnEyUGF0MjY5UHdObWtTU1NZ?=
 =?utf-8?B?RXdoS0lIUittQlQzSVYreGJsNWJucTNFL081cE9xUjNLYndOQS8vQTgvdklK?=
 =?utf-8?B?L0V5cWszb3NrUlNNQVV4dGd6bURxOVVqY3M4a0l3V1grMjdQV1UwZXdPQ2Iv?=
 =?utf-8?B?bG9OdXNDSHNOZ0FQY3p0QVJCOXRpRFl1RWEzcGZNMitpWEFzV0l6ajY2S002?=
 =?utf-8?B?ckVybnVyMS9VOThRY0lCV0NVbFMwZnJoNDFlUnVVQ3A1TTBTbldYbnRtdDNO?=
 =?utf-8?B?QzJvbklsUFpMUTlrRCtDTElqNlVFay9JWVZIbWFqK284OFVRcEFwV2cxeGFu?=
 =?utf-8?B?bUhvenlTWHBPay9pRnhXRmJScmdqeDZKd3dHRFhVaVV5UVN5SXFncC95dGNt?=
 =?utf-8?B?YjBHb1ZMZXNKOTRxTjFodDJhQmJBbi93MUlzVXRRcURoWXN5bURhZHUrdVpz?=
 =?utf-8?B?RHVRbUZiQkQ2azRQbEQvaE4zeDdVODE2NUsxU2ZuQ0N0VE1HU3hTdEpZNjY5?=
 =?utf-8?B?ZUtFUXVJYVVOQ0U3T2NtYUZjeHNhcWl2aTNtQk45bFQ1d2I4ZVhSOGNFNGN4?=
 =?utf-8?B?Zm5JSnQ2YkRkZGpjd1EwVCsySTVWM1JWWG1VZVNleCtNVFN5QlA0aEpGaFFR?=
 =?utf-8?B?RTFqLzZvWU5XeTl2S3RYUDluOUV1bmdUZzd1bmQ1ZWtGWXo1S3lKcVAxTXNQ?=
 =?utf-8?B?NWc5UERBQzFGUEhobzQ1ckRsWTlxc0lKODVQbHp2cjFpOFJTd3AzNlZpMUFq?=
 =?utf-8?B?NGFSbk9SZXFCQTdCTms2ejQzcGkzdmpaVmJRK05pYWxBQzJieDVMTVgvaW9U?=
 =?utf-8?B?Vk1YRW1MT1pNdjFSRlM3ZlZXUWRvN3UwM21GVWh3eGVlcjlQZ0xBQW1HOXZo?=
 =?utf-8?B?LzFWaklDQzkxQUtJS0pUUyt4c2ZyU1VzMjFhV1F2Mkx0UXZjdlkrTERZTE1q?=
 =?utf-8?B?MEVhaE9RK3RTdDJhZmVUQ1IySGJScVBXTUtPVXk1RnRqajdtb2JjWmE1djNk?=
 =?utf-8?B?MlZzRXJHU0NaS0ZrNEs1Y25UMjRaSUxidk5HSHBwazY1c1dMdHpjMFJiNGVk?=
 =?utf-8?B?dUpSb0M4QVk0UDJZVWtqS3lvL2ZIdHY2a2UvVVlKeCtadmU2VVJkbVFwcllN?=
 =?utf-8?Q?XJNsNGYsMbrljxuhMM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad0a5f0-53b1-467d-a3ef-08ded361ff86
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 09:04:58.7178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sN7MvhvUWiXpRKKGVyvq3C2yDMVtOr2nxOHIdEY053iridHP6PDb+A1rkN7T3BZiqGd7o+82sEH7wNNwnxAJ7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4273
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



On 6/26/2026 4:39 PM, Matthew Brost wrote:
> On Thu, Jun 18, 2026 at 04:08:59PM +0800, Honglei Huang wrote:
>> From: Honglei Huang <honghuan@amd.com>
>>
>> drm_gpusvm_pages is the layer that actually represents physical
>> pages/mappings it owns the dma_addr array, the dma_iova_state...
>> With the previous patch, so drm_gpusvm_pages is now strictly about
>> physical pages and their DMA view.
>>
>> Since now the drm_gpusvm_pages instance is inherently bound to one
>> specific drm_device, make that ownership explicit by giving
>> drm_gpusvm_pages its own drm_device handle, and drive all DMA through
>> it instead of through the gpusvm:
>>
>>    - Add drm to struct drm_gpusvm_pages and route all DMA in
>>      drm_gpusvm_get_pages() / __drm_gpusvm_unmap_pages() through
>>      svm_pages->drm instead of gpusvm->drm.
>>    - Bind svm_pages->drm where the pages object is initialised
>>      (drm_gpusvm_range_alloc() and the xe userptr setup) and require
>>      it to be set on entry to drm_gpusvm_get_pages(); the dma device
>>      is immutable for the lifetime of the pages instance. A later
>>      patch introduces drm_gpusvm_init_pages() to centralise this.
>>
>> Suggested-by: Matthew Brost <matthew.brost@intel.com>
> 
> I think both sashiko issues are raised here are valid, but pre-existing
> so I don't think it fair to hold up this patch, but these should be
> fixed. If you have time, feel free post fixes or I'll circle around to
> fixing the issues.

Got it, will fix the pre-existing issues ASAP.

Regards,
Honglei

> 
> So with that:
> Reviewed-by: Matthew Brost <matthew.brost@intel.com>
> 
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> ---
>>   drivers/gpu/drm/drm_gpusvm.c    | 30 ++++++++++++++++++++----------
>>   drivers/gpu/drm/xe/xe_userptr.c |  2 ++
>>   include/drm/drm_gpusvm.h        |  2 ++
>>   3 files changed, 24 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
>> index df900553f21..155e3c2e703 100644
>> --- a/drivers/gpu/drm/drm_gpusvm.c
>> +++ b/drivers/gpu/drm/drm_gpusvm.c
>> @@ -641,6 +641,7 @@ drm_gpusvm_range_alloc(struct drm_gpusvm *gpusvm,
>>   	range->itree.last = ALIGN(fault_addr + 1, chunk_size) - 1;
>>   	INIT_LIST_HEAD(&range->entry);
>>   	range->pages.notifier_seq = LONG_MAX;
>> +	range->pages.drm = gpusvm->drm;
>>   	range->flags.migrate_devmem = migrate_devmem ? 1 : 0;
>>   
>>   	return range;
>> @@ -1135,11 +1136,16 @@ static void __drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
>>   				     unsigned long npages)
>>   {
>>   	struct drm_pagemap *dpagemap = svm_pages->dpagemap;
>> -	struct device *dev = gpusvm->drm->dev;
>> +	struct device *dev;
>>   	unsigned long i, j;
>>   
>>   	lockdep_assert_held(&gpusvm->notifier_lock);
>>   
>> +	if (!svm_pages->drm)
>> +		return;
>> +
>> +	dev = svm_pages->drm->dev;
>> +
>>   	if (svm_pages->flags.has_dma_mapping) {
>>   		struct drm_gpusvm_pages_flags flags = {
>>   			.__flags = svm_pages->flags.__flags,
>> @@ -1421,6 +1427,9 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>>   							   DMA_BIDIRECTIONAL;
>>   	struct dma_iova_state *state = &svm_pages->state;
>>   
>> +	if (!svm_pages->drm)
>> +		return -EINVAL;
>> +
>>   retry:
>>   	if (time_after(jiffies, timeout))
>>   		return -EBUSY;
>> @@ -1520,7 +1529,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>>   
>>   				pagemap = page_pgmap(page);
>>   				dpagemap = drm_pagemap_page_to_dpagemap(page);
>> -				if (drm_WARN_ON(gpusvm->drm, !dpagemap)) {
>> +				if (drm_WARN_ON(svm_pages->drm, !dpagemap)) {
>>   					/*
>>   					 * Raced. This is not supposed to happen
>>   					 * since hmm_range_fault() should've migrated
>> @@ -1532,10 +1541,10 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>>   			}
>>   			svm_pages->dma_addr[j] =
>>   				dpagemap->ops->device_map(dpagemap,
>> -							  gpusvm->drm->dev,
>> +							  svm_pages->drm->dev,
>>   							  page, order,
>>   							  dma_dir);
>> -			if (dma_mapping_error(gpusvm->drm->dev,
>> +			if (dma_mapping_error(svm_pages->drm->dev,
>>   					      svm_pages->dma_addr[j].addr)) {
>>   				err = -EFAULT;
>>   				goto err_unmap;
>> @@ -1555,11 +1564,11 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>>   			}
>>   
>>   			if (!i)
>> -				dma_iova_try_alloc(gpusvm->drm->dev, state,
>> +				dma_iova_try_alloc(svm_pages->drm->dev, state,
>>   						   0, npages * PAGE_SIZE);
>>   
>>   			if (dma_use_iova(state)) {
>> -				err = dma_iova_link(gpusvm->drm->dev, state,
>> +				err = dma_iova_link(svm_pages->drm->dev, state,
>>   						    hmm_pfn_to_phys(pfns[i]),
>>   						    svm_pages->state_offset,
>>   						    PAGE_SIZE << order,
>> @@ -1570,11 +1579,11 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>>   				addr = state->addr + svm_pages->state_offset;
>>   				svm_pages->state_offset += PAGE_SIZE << order;
>>   			} else {
>> -				addr = dma_map_page(gpusvm->drm->dev,
>> +				addr = dma_map_page(svm_pages->drm->dev,
>>   						    page, 0,
>>   						    PAGE_SIZE << order,
>>   						    dma_dir);
>> -				if (dma_mapping_error(gpusvm->drm->dev, addr)) {
>> +				if (dma_mapping_error(svm_pages->drm->dev, addr)) {
>>   					err = -EFAULT;
>>   					goto err_unmap;
>>   				}
>> @@ -1590,7 +1599,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>>   	}
>>   
>>   	if (dma_use_iova(state)) {
>> -		err = dma_iova_sync(gpusvm->drm->dev, state, 0,
>> +		err = dma_iova_sync(svm_pages->drm->dev, state, 0,
>>   				    svm_pages->state_offset);
>>   		if (err)
>>   			goto err_unmap;
>> @@ -1640,7 +1649,8 @@ int drm_gpusvm_range_get_pages(struct drm_gpusvm *gpusvm,
>>   			       struct drm_gpusvm_range *range,
>>   			       const struct drm_gpusvm_ctx *ctx)
>>   {
>> -	return drm_gpusvm_get_pages(gpusvm, &range->pages, gpusvm->mm,
>> +	return drm_gpusvm_get_pages(gpusvm, &range->pages,
>> +				    gpusvm->mm,
>>   				    &range->notifier->notifier,
>>   				    drm_gpusvm_range_start(range),
>>   				    drm_gpusvm_range_end(range), ctx);
>> diff --git a/drivers/gpu/drm/xe/xe_userptr.c b/drivers/gpu/drm/xe/xe_userptr.c
>> index 6761005c0b9..1b540e62af6 100644
>> --- a/drivers/gpu/drm/xe/xe_userptr.c
>> +++ b/drivers/gpu/drm/xe/xe_userptr.c
>> @@ -390,6 +390,7 @@ int xe_userptr_setup(struct xe_userptr_vma *uvma, unsigned long start,
>>   		     unsigned long range)
>>   {
>>   	struct xe_userptr *userptr = &uvma->userptr;
>> +	struct xe_vm *vm = xe_vma_vm(&uvma->vma);
>>   	int err;
>>   
>>   	INIT_LIST_HEAD(&userptr->invalidate_link);
>> @@ -402,6 +403,7 @@ int xe_userptr_setup(struct xe_userptr_vma *uvma, unsigned long start,
>>   		return err;
>>   
>>   	userptr->pages.notifier_seq = LONG_MAX;
>> +	userptr->pages.drm = &vm->xe->drm;
>>   
>>   	return 0;
>>   }
>> diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
>> index 251a7266a73..842353afb27 100644
>> --- a/include/drm/drm_gpusvm.h
>> +++ b/include/drm/drm_gpusvm.h
>> @@ -129,6 +129,7 @@ struct drm_gpusvm_pages_flags {
>>   /**
>>    * struct drm_gpusvm_pages - Structure representing a GPU SVM mapped pages
>>    *
>> + * @drm: The DRM device that owns the dma mappings
>>    * @dma_addr: Device address array
>>    * @dpagemap: The struct drm_pagemap of the device pages we're dma-mapping.
>>    *            Note this is assuming only one drm_pagemap per range is allowed.
>> @@ -138,6 +139,7 @@ struct drm_gpusvm_pages_flags {
>>    * @flags: Flags for the range; see &struct drm_gpusvm_pages_flags
>>    */
>>   struct drm_gpusvm_pages {
>> +	struct drm_device *drm;
>>   	struct drm_pagemap_addr *dma_addr;
>>   	struct drm_pagemap *dpagemap;
>>   	struct dma_iova_state state;
>> -- 
>> 2.34.1
>>

