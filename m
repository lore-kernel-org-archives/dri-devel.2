Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A20606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 20:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wb3FK5G3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2919C10FFC0;
	Thu,  5 Nov 2026 20:43:50 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011059.outbound.protection.outlook.com
 [40.93.194.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3A5D10FFC0;
 Thu,  5 Nov 2026 20:43:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJYJ4UsD8cywPq4CgmMxs3Rrqn4nTd1xBA4HI4aGJKdAT0Ep7VfblVDVEJ3Awvl5Chk2YkiIr8bJMDV3gZzUAaeA29LtKNveO55P/U9rJKVQYeh4O0vHvt38VgpMKI7RAd1Xqpsy/UFUJil0il66rzNkeOLKnI8NQrdEwr0Rm0GEUHe9cb4gO+JhH3SIwUFUguB0xQ1LvoWqmOVnoAfFjj0s5r9TCWfazKJl+XJH85Y356lK5ZJvVleuXV8BuafkP93upHWgRFOzoByg/IoctkV+TkaobfD8jbP4XL28ocNuq6ynna23jrIfU/R2ICOwsLcQBNDSpNZJ5GNko7l+vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83WeM8zSsXaPw1F6iAKCvzVWlhuhnJL711+pJJxk+SM=;
 b=oqftj9irgCLWJhvFTfrjAZvvsMInVYoGPxIN0lkcAauZe6SYpjwDIApiP5z89PKupD2ldNXgE9wWrnXJUeLHQ/zJnu+tT9+a0bn1A4jEE1M8+6pmLa2a5W0B28chU170aJKu2Aics0v9CXzKsvPe4R/jgyXG3WPdRpXwT3Ue+TlNCXR6YQqxTpzqftFI41iwUFvVujJpTp0hrlz4GR33YddvK+v1T6ZyeV18LhsKPWZk1Y+jZ6zB0Fug/xqViLR3XDgsiSKzNvgnd8NXrL2OINDN5f6uZPc4YW9BmDg0y/fEnV3wuP4UgCmQe31lgmDnb+QOTQ+4iYE4LhGoDzfFPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83WeM8zSsXaPw1F6iAKCvzVWlhuhnJL711+pJJxk+SM=;
 b=wb3FK5G3gCCuUM3bDHZHNIEJN2haYf+HU05mq873hdvIz7//l/G4nvV2Aet0dgbyVTCaqAuXmN4vWisPoVcjVKTHllFwl9ur2JD4wEg1LcV04yJYouzDhXVc35V3fq6YHPM0AmckpXvWsk6ZFdUdVyyWUExC6WK0Yhvx5iJXPPI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by DS4PR12MB634945.namprd12.prod.outlook.com
 (2603:10b6:8:514::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 20:43:39 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 20:43:39 +0000
Message-ID: <9f0a8e13-4502-442b-83c7-1a02c72c36cd@amd.com>
Date: Thu, 5 Nov 2026 15:43:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Check ownership of device pages for DMA
 mapping
To: sashiko-reviews@lists.linux.dev, matthewkrebs8@gmail.com
Cc: dri-devel@lists.freedesktop.org,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20261105185828.85367-1-felix.kuehling@amd.com>
 <sashiko-outbox-199820@kernel.org>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <sashiko-outbox-199820@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::28) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|DS4PR12MB634945:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e652fd0-f2e9-4917-8419-08df3b7d78c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|6133799003|10067099003|22082099003|18002099003|56012099006|4143699003|11063799006|261022105027099003|261026121527099003|261026140227099003|261022075727099003|261021121427099003|261009223027099003|261028144727099003|261102123227099003|261022113327099003;
X-Microsoft-Antispam-Message-Info: bF+SHrrMSkt1ielj+opEqnA3KRG1zgUfoyy2JHuB3PfXR6IelCrL5ZgBkm6Zy+Ur3Pbao8IY2yVpI1y6+H303O9rziZ8SYVo9u2ig2zSnkJ6MXt0bbnujzRBxg7Q5tg1IiEId6d3ruhFOoiqEBkSsNYTdU3NBe32Xl+I+HQBwM2QuzFN+iAYNPQRXrc55ifZGgiA/P1xjkshNEPxF3sam0/TSiT6YLtm511LU7IyDAXjr1KwErgRoP59+dj+GwQGTMC1N9ngqeZKYezDupNjpgDEHROJ306zOl1KWPAsWkJY/XBuuYoHvDphX9pxRSoXlcLziZenZr3FPKbmBTFHxOkRFDqpzfMrBk4cvcUjHmtIf4jVSgomKdkwp2PIDux+qYqkOIHBBT1iRSBMoTdlTm1y40Yg0+vn/++k5SuY85str6I4Hr54ipZc/+1xVfk0hTTHio5XywRt3LqOwJu9SfjhVO1kBS5UjuALz9KsisIaOpRfhfpGdJUFSHEkfR3CcVz2wzsRRE/dYtWZJZe7v7D2dFOboXxiwhIHNVSUDn8Y6Be/WLfpRvs7LhMX89/5XLb+h6gA3WAhAzVPHl0Mv1tLWp8zFGWgQ8gQsbRvotlgUkIPSN3jKnTHLWNWuUSaw5FYPj0wuoBGFCd94Sh7+cCkFr+zhzb975RLK0T1WLE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(261022105027099003)(261026121527099003)(261026140227099003)(261022075727099003)(261021121427099003)(261009223027099003)(261028144727099003)(261102123227099003)(261022113327099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnhTSHoxS2NHMGM5VUtKZXp5a2VQY2ExOTFsV0N0a2VyWWJMU2JxbHMrWndo?=
 =?utf-8?B?YzhMckxBdElkMlRNSndrZ0t0SlQxWXJqak5RMHc4RXBFZXR4bzRIaHAvNWpJ?=
 =?utf-8?B?WG9ER0dMTVp5N2NtVXlFV0hDNlhtYlhDQWt2VE5JOHhIcC9zVC9VVzZzMkhq?=
 =?utf-8?B?ZmV1TU9JUmROcmZEUGovS0FqdGxhaGFqYi9pd29ETzFsUHFFcjFPbGh3UlBU?=
 =?utf-8?B?dG9nY1pQbVV6S3RDcFd4ZWdHaVVvK1U5aC9yem5sNjFEb0dDcGR5Y2N2WWJU?=
 =?utf-8?B?aVY1bk5zZVVNMm9lZXpyQk9MMzFtd3NkbzN6VDZ0Qyt2R0J5N0JnVU9tSjRR?=
 =?utf-8?B?VzNGZjd1dmlNdzRKam9GTzJuWkttKzhBc0E5Y21WclBER0dacXREYzNBKy9t?=
 =?utf-8?B?enI2Ky8zTzdRL3RxMjYvdUpOYUE5bEFDazBBT1A5WGdBSHJLa0J1OWlUMEhl?=
 =?utf-8?B?YWV1Y3V3R1JDZUdnaUpqREczc0pSV2J3UEVwMHZuK3BpcHhQaFpxTXZSSVVk?=
 =?utf-8?B?NXJaUHFmSXdhejRld2VncXRoNDVQcitLQkx2Y3hSNFI1bmZzMHhvTE4xRUw1?=
 =?utf-8?B?aXVscjBOT1orSzhqRjlzaEl1em1WZFpIbTBlc05TQTR0MkN2SXVZMFBxeFdI?=
 =?utf-8?B?ZldOS2FjSVZjSEZHS3lJaXNFWXNmSHNQakhkNjU1YXdVdU81dXJTYkpja3By?=
 =?utf-8?B?T1dMRW4veitZZHI1MkFhT2JPQ1g4NEp5QzViSnM1cVpDbm5mcWFmSlNMMzV1?=
 =?utf-8?B?L2xxSFFVZnhPSkNPaFJFKzFaYklkc0VaWjRmRmlsMTlvVjg0U0tYUGFob25o?=
 =?utf-8?B?QnBVTUlvZkxxKzhqM3FlK05nSE1EMVhCcmR1ZWNNZDZ4OE9VZVdTbGRpNDhY?=
 =?utf-8?B?S1UxVzh2RVFhMDFhZjdkZ3BjZ0p0TUFkZWY0UTdCWkFGSlJOUzFoUHRqaHpl?=
 =?utf-8?B?dHBQMUlyTkRQb0xIbTF6UzRZRlplNmR6aW1ET2hJTzN6VkFKMUJiMytJMGdL?=
 =?utf-8?B?aHBsTDlWSG1tbjhsME9qQkoySFV0R1grVi81TXB2LzFzZ2RaNDNIeEZYa0Va?=
 =?utf-8?B?V2Y2dzdjZDN4Y3JkNGhaZDlBZU1BK3pVOU56QUhOZytqRTVaQ0pidmtlaDVo?=
 =?utf-8?B?MUV0Sk9xVHBsdk9hMlVnN3ZvMncxZVJncWh3d0RYQVQrYTk4NzQxeGJ2SGpH?=
 =?utf-8?B?aXBpYmROYkZpZE1zb0lUenZibGg1a3pFRkljRE0yd0JwZE05blVjL3g4U253?=
 =?utf-8?B?N0l6RGE4cXRoSmplY2Y0cHE3RTlJaStuamxFck92MUxqNW5URFNSRkVjYkZ5?=
 =?utf-8?B?OGwxVHRlYm42VTBneTNyR25taW1YSndidVdJUHN3Y2hzK0t2U0pBS2RqdWhY?=
 =?utf-8?B?a3c2NVZjRFlRbjlRVHJQMFRNam9HL1E1eGhaUlJYOHEzOE1wbFBTWVhPNkt0?=
 =?utf-8?B?Z2N3dit0MHU5M2JLSCtrYWh4cUpLdEw2TDJvTWdmVys5NjIwVWFNdVBvajNS?=
 =?utf-8?B?QStvTnQwK0prYUJOL1lodzE1R2s4Zzc4WWJ0cmlzL2V3UTJUaS94L3VKM01j?=
 =?utf-8?B?bEhJelBHK2J4M3dIRTlpbmZNYXp6Y1MvWWxoMFk5dUZHVjF2Uzg1WTZjYU5Q?=
 =?utf-8?B?UVFjSm9FNllnb0lMNWx6SlJMU0YyNnF4KytoWkFOMU5LT3pQU0lyd2NQS0Ey?=
 =?utf-8?B?V3VydERxK2o1cnBodmxZN2hNYTNQdmdZenM3NnY3UHNWR1dpRDBtUlY0V05n?=
 =?utf-8?B?RWFZWXlUcC9nWnVhK0gxb3VUUHg4R1dJUUxGd1l4a3R0U1BBdndXNWZhZlp3?=
 =?utf-8?B?RVh6VnI2YU1makxCVTJ3cWJudE56b21wK2NMYlJQNng5NHp5T2F5ck42dVNJ?=
 =?utf-8?B?c0VlN3BDWmt6eE13R1hKZzFCalp1WDJHa3NkQ21lU2JqYzA4VU1oOXI5alg3?=
 =?utf-8?B?OGk3N2JZU1QxRlFBNWUxYVAxc2piWGcrc2RYWHdpb2VQVFVXU05LL3QrZzNI?=
 =?utf-8?B?TUlsN0FjQ1hRMDFjWjVaN1ZJL3Uya0FnRGQ0VnlxQTFTNjN3Nm5rVHNqdXJN?=
 =?utf-8?B?azVETGFQN3hIOHFNakk0emlOYlk5WUdRQU11VG5zNkxwOTNoVUdROXBQUXFo?=
 =?utf-8?B?dThMS2FDaDNXenNuUmVoQ2VlZlpCa0FmcnBFRTR6MEZKeU4rKy9xeXFqSU5u?=
 =?utf-8?B?ay9veW15MUgxN0NnMDFYektsMFlaTDlEY042Q3FiRndWcFJLUFRHSE80cFAr?=
 =?utf-8?B?eDk1MnowMXZLWHJjWlpFaGlMYmh4MCtKMnorZk1YaWh6Rko5WDcyREVTeGFy?=
 =?utf-8?B?RE1YZWxsc25KZUxpNFlIbk9IYzhPRlVFZDF4K2EwU2E4dWE3aUg5Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e652fd0-f2e9-4917-8419-08df3b7d78c2
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 20:43:39.4265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GRzXM+mVWT7//+sOKoj6L0a+nNpyCi+DGOsClhsY+W48v4PxOAh9hv4YorHmBPIkcP7+6eTE2QZVB9IxX3UrLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB634945
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 2026-11-05 14:11, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] drm/amdkfd: foreign same-hive device-private pages fail in svm_range_dma_map_dev()
> - [High] drm/amdkfd: double dma_unmap_page() on error return in svm_range_dma_map_dev()

I'll address these in the next revision.


> - [Medium] drm/amdkfd: calling dma_map_page() on zone_device pages in svm_range_dma_map_dev()

Matthew, I believe this would have applied to your patch "drm/amdkfd: 
Only take the VRAM path for KFD device pages in svm_range_dma_map_dev" 
as well. See details below. So this is probably not a complete solution 
for your problem.

Regards,
   Felix


> --
>
> commit 591a056ad47c1c9d032b2eceed7f51b0bb221d8d
> Author: Felix Kuehling <felix.kuehling@amd.com>
>
> drm/amdkfd: Check ownership of device pages for DMA mapping
>
> This commit checks whether a zone device page belongs to the target SVM
> range via svm_page_is_range_owned() before computing a VRAM domain
> address in svm_range_dma_map_dev(). Device-private pages not owned by
> the range trigger a warning and return -EINVAL, while other non-owned
> pages fall through to dma_map_page().
>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index ed5e3318877be..5807a26d7debf 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -156,6 +156,18 @@ svm_is_valid_dma_mapping_addr(struct device *dev, dma_addr_t dma_addr)
>>   	       !(dma_addr & SVM_RANGE_VRAM_DOMAIN);
>>   }
>>   
>> +static bool svm_page_is_range_owned(struct page *page, struct svm_range *prange)
>> +{
>> +	bool is_owned;
>> +
>> +	mutex_lock(&prange->lock);
>> +	is_owned = is_zone_device_page(page) && prange->ttm_res &&
>> +		page->zone_device_data == prange->svm_bo;
>> +	mutex_unlock(&prange->lock);
>> +
>> +	return is_owned;
>> +}
>> +
>>   static int
>>   svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
>>   		      unsigned long offset, unsigned long npages,
>> @@ -180,7 +192,7 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
>>   			dma_unmap_page(dev, addr[i], PAGE_SIZE, dir);
>>   
>>   		page = hmm_pfn_to_page(hmm_pfns[i]);
>> -		if (is_zone_device_page(page)) {
>> +		if (svm_page_is_range_owned(page, prange)) {
>>   			struct amdgpu_device *bo_adev = prange->svm_bo->node->adev;
>>   
>>   			addr[i] = (hmm_pfns[i] << PAGE_SHIFT) +
>> @@ -189,6 +201,11 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
>>   			addr[i] |= SVM_RANGE_VRAM_DOMAIN;
>>   			pr_debug_ratelimited("vram address: 0x%llx\n", addr[i]);
>>   			continue;
>> +		} else if (WARN_ON_ONCE(is_device_private_page(page))) {
>> +			/* Device private memory from another driver or range.
>> +			 * This should never happen.
>> +			 */
>> +			return -EINVAL;
>>   		}
> [Severity: High]
> Can device-private pages from another SVM range or a parent process on
> the same GPU or XGMI hive reach this branch and trigger WARN_ON_ONCE()
> and -EINVAL?
>
> On GPUs using MEMORY_DEVICE_PRIVATE, kgd2kfd_init_zone_device() sets
> pgmap->owner to SVM_ADEV_PGMAP_OWNER(adev), which is a device-wide or
> hive-wide pointer shared across all processes and all svm_range structs
> on that GPU or hive.
>
> In svm_range_validate_and_map(), owner is computed via
> kfd_svm_page_owner(), which unconditionally returns
> SVM_ADEV_PGMAP_OWNER(pdd->dev->adev) even when prange->ttm_res is NULL
> or prange->svm_bo is a different BO:
>
> drivers/gpu/drm/amd/amdkfd/kfd_svm.c:kfd_svm_page_owner() {
> 	...
> 	return SVM_ADEV_PGMAP_OWNER(pdd->dev->adev);
> }
>
> drivers/gpu/drm/amd/amdkfd/kfd_svm.c:svm_range_validate_and_map() {
> 	...
> 	owner = kfd_svm_page_owner(p, find_first_bit(ctx->bitmap,
> 						MAX_GPU_INSTANCE));
> 	for_each_set_bit(idx, ctx->bitmap, MAX_GPU_INSTANCE) {
> 		if (kfd_svm_page_owner(p, idx) != owner) {
> 			owner = NULL;
> 			break;
> 		}
> 	}
> 	...
> 	r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
> 				       readonly, owner,
> 				       ctx->hmm_range[bitmap_unchanged]);
> }
>
> When amdgpu_hmm_range_get_pages() calls hmm_range_fault(),
> hmm_vma_handle_pte() skips faulting any device-private swap entry whose
> pgmap->owner matches range->dev_private_owner:
>
> mm/hmm.c:hmm_vma_handle_pte() {
> 	...
> 		if (softleaf_is_device_private(entry) &&
> 		    page_pgmap(softleaf_to_page(entry))->owner ==
> 		    range->dev_private_owner) {
> 			cpu_flags = HMM_PFN_VALID;
> 			if (softleaf_is_device_private_write(entry))
> 				cpu_flags |= HMM_PFN_WRITE;
> 			new_pfn_flags = softleaf_to_pfn(entry) | cpu_flags;
> 			goto out;
> 		}
> }
>
> If a process validates an SVM range containing MEMORY_DEVICE_PRIVATE
> pages inherited via fork() or moved via mremap() from another range on
> the same GPU or hive, hmm_range_fault() will not fault those pages back
> to system RAM and will return them in hmm_pfns. When
> svm_range_dma_map_dev() then checks svm_page_is_range_owned(page,
> prange), it returns false because prange->ttm_res is NULL or
> page->zone_device_data != prange->svm_bo, hitting the WARN_ON_ONCE() and
> failing range validation with -EINVAL.
>
> [Severity: High]
> Also, if this -EINVAL path is taken when addr[i] previously held a valid
> system-memory DMA mapping, does it leave a stale DMA address in addr[i]
> that causes a double dma_unmap_page()?
>
> At the start of the loop in svm_range_dma_map_dev(), an existing valid
> mapping is unmapped without clearing addr[i]:
>
> drivers/gpu/drm/amd/amdkfd/kfd_svm.c:svm_range_dma_map_dev() {
> 	...
> 	for (i = 0; i < npages; i++) {
> 		if (svm_is_valid_dma_mapping_addr(dev, addr[i]))
> 			dma_unmap_page(dev, addr[i], PAGE_SIZE, dir);
> }
>
> Prior to this change, every path after dma_unmap_page() overwrote
> addr[i]. Returning -EINVAL before updating or zeroing addr[i] leaves the
> unmapped DMA address in prange->dma_addr[gpuidx], so a later call to
> svm_range_dma_unmap_dev() (or a subsequent svm_range_dma_map_dev() call)
> will see svm_is_valid_dma_mapping_addr(dev, addr[i]) as true and call
> dma_unmap_page() a second time on the same address:
>
> drivers/gpu/drm/amd/amdkfd/kfd_svm.c:svm_range_dma_unmap_dev() {
> 	...
> 	for (i = offset; i < offset + npages; i++) {
> 		if (!svm_is_valid_dma_mapping_addr(dev, dma_addr[i]))
> 			continue;
> 		pr_debug_ratelimited("unmap 0x%llx\n", dma_addr[i] >> PAGE_SHIFT);
> 		dma_unmap_page(dev, dma_addr[i], PAGE_SIZE, dir);
> 		dma_addr[i] = 0;
> 	}
> }
>
>>   		addr[i] = dma_map_page(dev, page, 0, PAGE_SIZE, dir);
>>   		r = dma_mapping_error(dev, addr[i]);
> [Severity: Medium]
> Is it valid to pass non-private ZONE_DEVICE pages (such as DAX pages or
> foreign MEMORY_DEVICE_COHERENT pages) to dma_map_page() here?
>
> When svm_page_is_range_owned(page, prange) and
> is_device_private_page(page) both return false for a ZONE_DEVICE page,
> execution falls through to dma_map_page(), which expands to
> dma_map_page_attrs(). In kernel/dma/mapping.c, dma_map_page_attrs()
> rejects all ZONE_DEVICE pages when CONFIG_DMA_API_DEBUG is enabled:
>
> kernel/dma/mapping.c:dma_map_page_attrs() {
> 	...
> 	if (IS_ENABLED(CONFIG_DMA_API_DEBUG) &&
> 	    WARN_ON_ONCE(is_zone_device_page(page)))
> 		return DMA_MAPPING_ERROR;
> }
>
> Wouldn't mapping DAX memory or coherent device pages from another GPU
> hive trigger this warning and fail with -ENOMEM on kernels with
> CONFIG_DMA_API_DEBUG enabled?
>
