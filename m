Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127E0CD98D2
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 12:26:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 507F610EED5;
	Thu, 11 Jun 2026 12:26:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dXcd3/Z0";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010044.outbound.protection.outlook.com [52.101.201.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A53210EED0;
 Thu, 11 Jun 2026 12:25:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylM7d//N8JAkt1TfOgNhyIHexB9SojwBU7yJms/moO7DLhWAytf6iueig9Nrj8On/D1QTip+gw8AJPja/l3RtkGXiD9dzcgtqPWhwQv65Qqp5QbIfofBXxkPY1hXjBqqi+1/WobqoMMZkGcewMb98RSxFfmiLAItkGNz5nvI9cSbacpThf5KvPnUq/PU+P7dpkEoVPbUxqA+NwKfiqNkW2QRA3eRawIpWnMvTZCekWcRgp3P+2OpaI6ZU+flf3C8jdjA5rNUga4qEzo0vngvn+cj+TDcFfAPJrMtKYOhPJGDA8RdkL3X18shlGL3+eM4Yww+4SPyaeNT2F5lyNJq2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQ4I+V20bBL0k/r6zskWidSRYP/260ZQs5RMUUtwUOA=;
 b=whTEhvEN6hVbjZxBW0yTWypUEOjc3VpuCu+QSsof8OTKU5C6xsIX7/0ztWC/0DOOUqwi2uES2UTq6ffzWxea9vUO1GIZMVjU7BWxrci2rK9iurNgODqdy4mibC5oZKrdUbkCCK1UkIMZ4krDQryH7FS/BxqCNHNsnhvEuxzAXAqzjNVtU3hFYFZK+0cIE+ZMgsQ7ky8s6YKlVosQiNtYvfAiVwQx4zv38omrheiuWVuNdEEhBMWBV/7ZvzrGon7tp0wx9MWSx07wKZ2QI94QCluDppwvVQaxLYJPFWrAhHNi5Q2X810f9tdgR16VNJhlqF9lBHrh712BEgKRwxSs4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQ4I+V20bBL0k/r6zskWidSRYP/260ZQs5RMUUtwUOA=;
 b=dXcd3/Z0YjrHflJc1UL6KRf3mXYbTi7qjbZ2bcWgCH8ZL8Vo7JOSRdtg2rumIbeJH9Duew9YiwkNufZxt30/44rpoy/7zF2b1i1VLHUc99WwapHdBuPwDYe5YGxLQz0PljVZXNAF7nuppuyVb5OhEFRLUzWABUEx6L9Pjglojgw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from EAYPR12MB999132.namprd12.prod.outlook.com
 (2603:10b6:303:2c2::11) by CH3PR12MB9025.namprd12.prod.outlook.com
 (2603:10b6:610:129::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 12:25:51 +0000
Received: from EAYPR12MB999132.namprd12.prod.outlook.com
 ([fe80::7798:60c4:e3f0:d3f8]) by EAYPR12MB999132.namprd12.prod.outlook.com
 ([fe80::7798:60c4:e3f0:d3f8%4]) with mapi id 15.21.0071.011; Thu, 11 Jun 2026
 12:25:51 +0000
Message-ID: <936bd98c-93e9-469a-9c9e-bf1eb1cd08ea@amd.com>
Date: Thu, 11 Jun 2026 17:55:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V11 03/12] drm/gpu: Add gpu_buddy_allocated_addr_to_block
 helper
To: Tejas Upadhyay <tejas.upadhyay@intel.com>, intel-xe@lists.freedesktop.org
Cc: matthew.auld@intel.com, matthew.brost@intel.com,
 thomas.hellstrom@linux.intel.com, himal.prasad.ghimiray@intel.com,
 dri-devel@lists.freedesktop.org
References: <20260605123839.236021-14-tejas.upadhyay@intel.com>
 <20260605123839.236021-17-tejas.upadhyay@intel.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <20260605123839.236021-17-tejas.upadhyay@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0179.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::22) To EAYPR12MB999132.namprd12.prod.outlook.com
 (2603:10b6:303:2c2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EAYPR12MB999132:EE_|CH3PR12MB9025:EE_
X-MS-Office365-Filtering-Correlation-Id: 70165c0d-a01c-42b1-8e6d-08dec7b49207
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: GCi1pjW3RUpFuHTZrdzEz7qa0vr6/+IHKJdhiCQONUTeXX1UwI9TM4jM5OFWpYgJDXyTtZlFd5zntZ9LxKkdh8V9xCuXgt2xwmhBKJc4Y6IJ2REM/XKG36ggnETleusgNZsdbD6nWwQdKDb7EX1OgQUhBpxe3c9rcLL0V4hNuejkkkWJ/g2W4AjHlFKaPn/oWRa3I8cFwcXCEbXA5kx44Y7vJgofWXMpJQbGlLNS3RF9TAI7qiPccT0zdAozLR87a3/ZXce3K5+1GUl9fpDGzmz1/WHpClawem7fKe/Kksq0d+fnl5YC+jfBEqAuG1ECUOPjkYsvXcU1SncFo5XzRriG2/sj9k638i2Xay80s3MdNxChQDRNlF8eY7TkhSd5AP2kogy5BpMGo6p/P/eCm1wK4S9rSVqEAr6WdPp8LFCWr9iWhxSQUSYs6ByDk4mENIb12CVjMujpAB17AQMbFB3Be/sldseVw8lGdw/+lAvieg6GyD+eG6ySyMAj/4q3FcWAc8nfoRyrZxkfABGG2mhzOyZyQO0QRVvcotodcegoz6o60TcW7fSVLXfag6PHXQYZJqoMcQwEsL9p9rGToRAN4tXUCrLZ2ZFiic0aYMztf1rDfApqapqrYqU1cBOOLv2Hx5kKwHZUiLWqGA9Z8h5Vr4lPXAH2whMU2phED33k8+fBk6bCdyI/Nt1Q/dq8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EAYPR12MB999132.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z01pNnN0QnkydUxOa0tJb2R0bThob0NrdWNxZmVHTVVmblliV1luSEgzTlcz?=
 =?utf-8?B?WnJjZjRURnpwRWlsQWxpNmhoU25HNFdod2V5U05kaVkreDNtbUkrUkNmaXdI?=
 =?utf-8?B?MERaTHc3RFNWeHFBMXI4ak1zeVZjY1lRNk9lQWc1TzRYaDBSYWRMRjRMcWpG?=
 =?utf-8?B?T2s0eEx2TkVibm9hbnZ5V0VCQ1FBYktQZHNoa3pJb280S0RGRUV6ZExYcU5q?=
 =?utf-8?B?YmxRbE5LRDZCVFl5aktFWE52WklpTFZGbzZzNzVwR2pHdlhML2RrS210QWpV?=
 =?utf-8?B?TDUvNlNuMlR4N3J5dSsxSnV5cmd2KzdZRE1yMDcxNEFiOTYzekV5L25Fa3Nj?=
 =?utf-8?B?dnUzeFJIM01WaDVweDlPR3hOenVtV3l6UzZZNGRoNEc4Wk5KQnBRTEFxSSsy?=
 =?utf-8?B?RjFWK0FLUXVmcjRVQlF4TzZFbEN2NkxRVVpDOFlOeW03ZDAvdkNIbFlwSldq?=
 =?utf-8?B?bTVKYXZHNjM1U2lNTDVEUUQ5aGFzMGQxNkI2UGhiVXRuRzlOQ2drbHk4TlFX?=
 =?utf-8?B?eUVQakFoV1R1dXh2VzBJQmpncTQ5UmFKdW16M29IRDV5UC8ycXlBM3ZRQjFW?=
 =?utf-8?B?ZTJPeWRFcHFGK3VGaDRxVjhIcGhDclRQaEJka2RRUld5QllnWXZ4TGRiQXNT?=
 =?utf-8?B?ZXB2eGZOZjRjUHZnam5lL0JYQTRvTXI5Z3c4MmJEcXlpNTBkaldScGI2THJL?=
 =?utf-8?B?Y1NwblZqTGNzTlE2eU96NDFMNGQ5TmZLUGwrSkloRFlQRGxlVmZEWFJKUlZZ?=
 =?utf-8?B?a0FvZW1OMzZmREhDM1prUVFBMmhITG1BTXBrRENKMmhMMGEwTTZ5TmF0Mk5v?=
 =?utf-8?B?MU5KU3Z4em11dUpnYkFXN2dyR3d3czRIM1prTTlwNEhMb0ZzUGtqeEt1T3pH?=
 =?utf-8?B?aklWY2RyejR6MW44b0VqZFFPS200Nk1NUHNOeFRRN0J2QTVXNDRsOHRHQlpk?=
 =?utf-8?B?TlFqR09PWUFtcGpnYzFxNnBZY2J4WG1mYWdCRnpqYXovYlVPS21vU2lEbUtN?=
 =?utf-8?B?azIrQnFzTi83VTV3Q3VDamQzbEUxbW5DNjkrbEVlbVdqU1F4MlZ3NzJ3TzRh?=
 =?utf-8?B?aFZTVkdQbkozTWlOUDRJWEpvSXFoeUF5N1ZxcFpqRmRKdHB6MEFadjZPeXhw?=
 =?utf-8?B?OThxb29MU0NnSDRNVmYyVHV2blEyWjFzcVczMGRqUHkwb1B1KzVyWlU0QXN6?=
 =?utf-8?B?SVdJYnZ4QXpJbFN2MUo0TXlxVy9RdzJQOUw0V09UQXhBLzF6eXhpTFpFVzVr?=
 =?utf-8?B?U2xabGNQOHI2b2YvVGdjMVI2UVVma0hSY1Z5T2o2RyswWTZyUXJxQUdSQmw0?=
 =?utf-8?B?dDU4SWxKbHY0U1ZkRjlNSnRSczNxdXozM2dNaGdaYkFQdmVTbXZHMkREcjNT?=
 =?utf-8?B?R2x0SURBcWNscDlhVkkxTE5SWVVvRDdRUHFuUnA4SEk2YnE4RFkvNitGTkpa?=
 =?utf-8?B?UG1RdkFLS1p5YkZ2ZjF4eXpLeWxaUFM0NzlCV003bFJNVFhqZFc0Z1c5TlRz?=
 =?utf-8?B?RjFrdjJKbjNJdm04WmpTOWlvV2pVdllFZGtieDFyUi95M1hadWFPT0NYeHMv?=
 =?utf-8?B?dWhEM2hLb0hqWmRRWlZoWndwakhHN3NVQkFqWUFNZWU4STlVdlZ0TEFJNkRR?=
 =?utf-8?B?VHNOVTNiVjhaOUtHb1hRVFY0NDE3cTFST1BzVWNrV21DQm9rNTlybTM1UVdR?=
 =?utf-8?B?cGJPOFcvSGNkcGhUeHBydUhXdDNKV2c5OFVlU1pqOHdsenBWdVFMbzEzMFJy?=
 =?utf-8?B?eHgwSUlMSTFyOVh2aU82dHpTcnlKZmdzdXlaczZid2NxQmxGQ25vbjkzeHky?=
 =?utf-8?B?a3dHRlo4NGh0VFBjeVVHdENGY0hCbTd6YWJsMEE3V3RlNytLUkVOR2Y5SjZv?=
 =?utf-8?B?UFlpRkM4aFhabTdmdDU4TVdlRlhQZElCWnpZR3NuOHVDTFY3UEhkNE9aT2la?=
 =?utf-8?B?UmhhREtlZ0kwWDlacHppUUdrMVRZS3I2b2pHcXJRcWV5bERtZVNQeUxhWEJQ?=
 =?utf-8?B?WmFkazJIWkwrSjNKUjVJczhrdmxqNjZFUGFaaDVJcVBORkNqQ1VwU2puU284?=
 =?utf-8?B?eU9KTnF0SlE5c3g2MW5xOHFKWit6Vi9TT21hQTZKMkZrTWZISm8vRkw2V3h3?=
 =?utf-8?B?ZUVSejNKblBHVndEdUNGeDBLZ2hDM0JvWTJXNEE3MENEZnhGMGZqNU9XT3d3?=
 =?utf-8?B?TEtsT2JiUnV0MGtVam9HYk9aM2pUVlZjbG5mRHkxQktIbStqUkozMEU0d0NC?=
 =?utf-8?B?aEMvU0NOckVvRnlNcmZoUVVWRjRmTEw1MGIvZ05uNGhJS2cwRkc5NUJ5ZURt?=
 =?utf-8?B?UUtteEpFa0JKL2hRV0RRdlRNU3JnKzhsSHM2T0VRbDM5MEljMDVMQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70165c0d-a01c-42b1-8e6d-08dec7b49207
X-MS-Exchange-CrossTenant-AuthSource: EAYPR12MB999132.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 12:25:50.4716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywf/WlhYwHC8OldXUFjGdLLc6OWfSEN6cGHF+Pn87frSOiSRCx8wIIs5m+HmiWIKCOtXoZH0gnXm0tkCd0C8tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9025
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



On 6/5/2026 6:08 PM, Tejas Upadhyay wrote:
> Add helper with primary purpose is to efficiently trace a specific
> physical memory address back to its corresponding TTM buffer object.
>
> v3:
> - use mm->chunk_size minimum allocation granularity (Arun)
> v2:
> - %s/gpu_buddy_addr_to_block/gpu_buddy_allocated_addr_to_block(MattA)
> - remove clear->avail and split nodes check(MattA)
> - Adapt lockdep(MattB)
>
> Signed-off-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
> Cc: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
> Cc: dri-devel@lists.freedesktop.org
> ---
>   drivers/gpu/buddy.c       | 53 +++++++++++++++++++++++++++++++++++++++
>   include/linux/gpu_buddy.h |  2 ++
>   2 files changed, 55 insertions(+)
>
> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index eb1457376307..315f860f4346 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c
> @@ -594,6 +594,59 @@ void gpu_buddy_free_block(struct gpu_buddy *mm,
>   }
>   EXPORT_SYMBOL(gpu_buddy_free_block);
>   
> +/**
> + * gpu_buddy_allocated_addr_to_block - given relative address find the allocated block
> + *
> + * @mm: GPU buddy manager
> + * @addr: Relative address
> + *
> + * Returns:
> + * gpu_buddy_block on success, NULL or error code on failure
> + */
> +struct gpu_buddy_block *gpu_buddy_allocated_addr_to_block(struct gpu_buddy *mm, u64 addr)
> +{
> +	struct gpu_buddy_block *block;
> +	LIST_HEAD(dfs);
> +	u64 end;
> +	int i;
> +
> +	gpu_buddy_driver_lock_held(mm);
> +
> +	end = addr + mm->chunk_size - 1;
> +	for (i = 0; i < mm->n_roots; ++i)
> +		list_add_tail(&mm->roots[i]->tmp_link, &dfs);
> +
> +	do {
> +		u64 block_start;
> +		u64 block_end;
> +
> +		block = list_first_entry_or_null(&dfs,
> +						 struct gpu_buddy_block,
> +						 tmp_link);
> +		if (!block)
> +			break;
> +
> +		list_del(&block->tmp_link);
> +
> +		block_start = gpu_buddy_block_offset(block);
> +		block_end = block_start + gpu_buddy_block_size(mm, block) - 1;
> +
> +		if (!overlaps(addr, end, block_start, block_end))
> +			continue;
> +
> +		if (gpu_buddy_block_is_allocated(block))
> +			return block;
> +		else if (gpu_buddy_block_is_free(block))
> +			return NULL;
> +
> +		list_add(&block->right->tmp_link, &dfs);
> +		list_add(&block->left->tmp_link, &dfs);
> +	} while (1);
> +
> +	return ERR_PTR(-ENXIO);
> +}
> +EXPORT_SYMBOL(gpu_buddy_allocated_addr_to_block);
> +
>   static void __gpu_buddy_free_list(struct gpu_buddy *mm,
>   				  struct list_head *objects,
>   				  bool mark_clear,
> diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
> index 71941a039648..e7e22fa05ee2 100644
> --- a/include/linux/gpu_buddy.h
> +++ b/include/linux/gpu_buddy.h
> @@ -272,6 +272,8 @@ void gpu_buddy_reset_clear(struct gpu_buddy *mm, bool is_clear);
>   
>   void gpu_buddy_free_block(struct gpu_buddy *mm, struct gpu_buddy_block *block);
>   
> +struct gpu_buddy_block *gpu_buddy_allocated_addr_to_block(struct gpu_buddy *mm, u64 addr);
> +
>   void gpu_buddy_free_list(struct gpu_buddy *mm,
>   			 struct list_head *objects,
>   			 unsigned int flags);
Reviewed-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

