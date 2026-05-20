Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D877DCD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 08:54:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B174510EF79;
	Wed, 20 May 2026 08:54:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1ngouSCY";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010022.outbound.protection.outlook.com
 [52.101.193.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F22D510EFA6;
 Wed, 20 May 2026 08:54:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4PzcPrv4Lks5iaZEln6Tq2JLlaCqPpLGp4XrN6F1CbTMNaPEuYzozIodiYkSFuj0kNnc0zExKMcbKG1U4pkPoAIIrX3t+emg5CG+CntnKRTst4GQEtrvxHnes2VlM3w5SwTLrJwn7nVMg0dm8WAZrP6FHUQtfJ5gMs61z0Uk0ljLAAlTi5MgshwHTe4S6SZIhbvkwC281ETfslgHWpBjwqJ5NLxcQYByS+3nfanVvCT015dYb1GDvtL3/yxSwt8WeIYWKswv/Qks9i/rMAVqmEkkEZlA/GoQcZCMyDWfn8jzZbOL+AoFJfhlblSKbg+u5LsixO+6euqX5VSEP2t5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVbDmARiNE1/vTFulBFQs8YvkZ9d5bchnmlj0CYvtYc=;
 b=CVoTZdCV8Sx6wMYEvTGXExLkZ8DwfFq2CfayL3yvBJB7O58hc+dtSLmREWJ4OoucC+eCSZcnWz0507S1kz5c7iOTpqzPeFYd2z2En9fVTsBZXzEpiqyYb1Pj+3NCowT54ySzrD8cljJc0dMxooUSoIZVaC9j1lBUQIn6+72fnzNRxWcEUPliC3yPz+/Bnfu9cq/IslzZDt/o+6M6nw45vn2tAggqP4CNAc3YUDxnm4Qv4rYGkDlQ/aOr05SGcmCRZT4S1c5TMtXMN4y/y60xLgb0mIg9GkR++XVzIWS8qq3kAX+plGQeKl1Oj000vXy0lP1neuA8Gy7D8+bJJJtNiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVbDmARiNE1/vTFulBFQs8YvkZ9d5bchnmlj0CYvtYc=;
 b=1ngouSCYk0A78F+EbaunUqOdIMJvr3ZW1QJpcifz7GYiYTsNZrei/Iw/i124GGKyMA0E9w/A9HuqQZS0DGVRHlznzIFIYZ2OYWNpuJHzvAM3fnGsIszr3eWGJS6dMldl61DqWdKXd5kHph+VvXce1P3GT9XdnL+HIORbZjORWvA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from EAYPR12MB999132.namprd12.prod.outlook.com
 (2603:10b6:303:2c2::11) by CH3PR12MB7596.namprd12.prod.outlook.com
 (2603:10b6:610:14b::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 08:54:16 +0000
Received: from EAYPR12MB999132.namprd12.prod.outlook.com
 ([fe80::7798:60c4:e3f0:d3f8]) by EAYPR12MB999132.namprd12.prod.outlook.com
 ([fe80::7798:60c4:e3f0:d3f8%4]) with mapi id 15.20.9891.021; Wed, 20 May 2026
 08:54:15 +0000
Message-ID: <835d204d-0c2a-4a81-8c60-9d047809f6ef@amd.com>
Date: Wed, 20 May 2026 14:24:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V10 03/10] drm/gpu: Add gpu_buddy_allocated_addr_to_block
 helper
To: Tejas Upadhyay <tejas.upadhyay@intel.com>, intel-xe@lists.freedesktop.org
Cc: matthew.auld@intel.com, matthew.brost@intel.com,
 thomas.hellstrom@linux.intel.com, himal.prasad.ghimiray@intel.com,
 dri-devel@lists.freedesktop.org
References: <20260519122817.45770-12-tejas.upadhyay@intel.com>
 <20260519122817.45770-15-tejas.upadhyay@intel.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <20260519122817.45770-15-tejas.upadhyay@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0064.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b7::11) To EAYPR12MB999132.namprd12.prod.outlook.com
 (2603:10b6:303:2c2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EAYPR12MB999132:EE_|CH3PR12MB7596:EE_
X-MS-Office365-Filtering-Correlation-Id: e30d6e08-37f7-4bc2-719e-08deb64d5e23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: IpgDGpFtQ0MbLbDdnDwvRlqgEnGMLOo97qWb/bghC6t7HDGlzwAtbi5q8L6X+Xl6RmSYPGq8KwKaa/TExBbLDZKv7eyhWstSIQ4h5bkUoZe2i1cqRhx4PsuD1VKoZz8q9ZMhYvsytKGhALznwrwlkyg5PeMlrGp2XULf7eiRRj5XNyqSYshM7Kuw5NILtaeRQsmHu/rd1Z9Hb4RGalwUuyk8ZK/kh3w7sCWdQf9PWcGDCJFT7VE9W9U9UOXHBAkbbBWd9gDAnwmgcIkPq9GChDpzb92TckXYGXMz/iZaWDANG1aHDSf3PZgEuru4jndSnLag5N7+qC+31DZMlnADOyXSBAzdta5svY4stMYtF27ojtjJZvvrSvXF1i7LzSdgnQc1/NYflW5C2FL9aOR44bowJ8hqHwnjGFtXXGsgr4Hz2jDuFxq0xkfObfBJLvgxdlNlpjjo/vpt9eUB8HXpgNYkgFU8TKIzLjsGlyzv3z0Ex709APfVbgay+F2tqjtkYOLgQc3dcJ9H/JyOSQYH6m1sqnQwxnfMmj0MXH8e4BJpMnfHqcZYco11KBcMPS5pxn6cFPAtmSeEUpUuLltDynAZ76YxuE7aix1dX24vYnuWOI1jS8OJQxHBciMfEuPkqz78q1rchF0A/HTWVoLGjAnj30csR4C8IRTT0o+JfUJbESYE23HNX5/9V/txoSZc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EAYPR12MB999132.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTg1eU9RdFR0aDVLSEp2MmF3bEdNNEJSditITjU0NVEwNW43N2RmSDNyZjlq?=
 =?utf-8?B?cGJvbW9zT0xZOG9oU0FEaDlUU3JWMlcrb1Z6YmVoSTZnRVhsRXV0c3pjYnBV?=
 =?utf-8?B?cll2b2Q3aEc1dW9kMnlNYnpxY3dZcnpDQW9ZaTBRQVgxZnY2dEx4ekJLV3Fi?=
 =?utf-8?B?V1NCYjg2ZjNmS1ZDeDVDQVNtdGhnRzBPZjQ4V1prdVN1RkUyODFvSjBGQTc3?=
 =?utf-8?B?R20vMnR3T2pRemxGL0hXSlFNNlVkYTVjUkdCSGt3cHV3M1VTbUdBQXcyUEEy?=
 =?utf-8?B?bDVQd1VWSHEraUxpRzVEQWV0VEtmWW83ZnQyVGxjejl5UTExbEV3U0NGeGlH?=
 =?utf-8?B?OGZYM1pDMFRKS3ZucEloRXUrVmhJWWtnNno2dlF0elhGaERZd09PTWhwS093?=
 =?utf-8?B?MVVJeEt6R20xaTZQN05FTmc2eUhGa1JjRCs4RW1oNTdsdDhVdFVHZG5janZC?=
 =?utf-8?B?OXNxbFVlQkRUbTQ5TzcvRG1LWmcxaUpmTStheG9VNHd1MDdCY2h0M1RUcDdt?=
 =?utf-8?B?c1BMaWEwTEUwRHk4SlBhcnJnMFZ6emJiUGZkbWRRU002OVh5M1pPRTFnVUdw?=
 =?utf-8?B?bGdSdDYxVzhqbC9XMWt3WWljcURzL3hQUDROd3BweGRoVGgvUXk3d2pWOWpH?=
 =?utf-8?B?RDAybWptQk9xSDA4ZFhmZ2czdWxyS2RQVXJ5QmFKL01CNTB5S3kwRUU1MmZm?=
 =?utf-8?B?Tk1vV2RMTjBsQ2NCREZTTmdYOHFRV3R0cnhBanRWdlFkWVJYM3FqcjZsSlFQ?=
 =?utf-8?B?VUJJQmo1QkFQcWNCenFBZkdyV3hkNE1VZnRLSUoyanYwWlNLYWtNd0o0R09P?=
 =?utf-8?B?N0EwQlZoZ3BDNE1OYTZHNW5GUFZsNHBQWXJwV3MvdEg4MzY4RHFUSnMyVWVV?=
 =?utf-8?B?K1ErM29qbk1VY0xUZTRKU3RVbUN0SjNYRG1sb25CSVNOZG5QK0QwTStXY2hn?=
 =?utf-8?B?M0tBOEhNMXZzRXVLeURHWituc2JhaE1rOUdNam9uSFlyV2taYmRXZ3dIRDFx?=
 =?utf-8?B?V05Pdk1YZGhGTWx6cFQwdStCZU1IZzlIMXNoaEpRYy9jNGkyOS82K1N6TjNJ?=
 =?utf-8?B?MHIvWVBMTlNGSlJucjFmOXdSME9CM2xqb1Y2TmZQc29BRE12TU1iRDdPdUFo?=
 =?utf-8?B?VUk5RG1taUZyRGJqQTdTSTFBcytvYjBONkVtSXp2SStGYkFYeGVlM3Z0Qm5V?=
 =?utf-8?B?RXd1MlVURnlQajQ0M0s0Vy9VbHRlSUJIZEt6N0NVQ1oySW50SlNWWmxremd0?=
 =?utf-8?B?TU5rZzJvSFRKejk4S0p4ZHdSUGNFZlpBZlpWVlJxaUF2dFN4WEY1OGc4akVj?=
 =?utf-8?B?cWJjeWtTNDdMam5qaWVzUmRteEsxNCtKenBHbXZzVDA3VUZYRFJDS0FxcmFL?=
 =?utf-8?B?NXJhSHlBOFhFbFkrWnVjamlYTlR6OTVGV1dKWWowYU14azVwSk9LRDNDRlpQ?=
 =?utf-8?B?R214eUtZMzVXM0JSWVBrM0VTUDVGUWcxMTF0RXRWZ2dEcmIyTWFqNkU1U0pt?=
 =?utf-8?B?V2x0MVF2UUE0YS9Cd3g4d1NZVElHR0d1Ky93MXZHOG5hR1JhZC9XRVdJY00r?=
 =?utf-8?B?OUN3Q1Mvc2ZtenZFa05FMkp6eTUwQ3pPVUk1MTFkZm1yWityK2NWRjlWNmZO?=
 =?utf-8?B?T1k4Y0g5ZTUxdWEyMWl4ZFJvM3ZJVUU3aHd4Rkd6eVplRDVrVEdGR0taalJC?=
 =?utf-8?B?T0ZiRVFjRkRhRTBZSFRwN3JibHdpd2lPSy8xWE9wc2dTdGNQYzM3TjFhanN4?=
 =?utf-8?B?MHFWWU9pZXMvSEdVLytXa25sUkNHdUxlVVFQcjdvbVk0RTZ0dXBMak9jT0FE?=
 =?utf-8?B?SENWTFdHQTFhYVFxcERSQTFOWTVzU2RXMnNLMWxOT2trTjU0WFdHWWtFY1dx?=
 =?utf-8?B?N0ViUmlUeFR6UXpaRlo5V3lyU0hKYWliTjdydDB4R1R6OWZKeTlKUGI2aG9B?=
 =?utf-8?B?eW0wUWNxYlZla2QrblVnVWpJZkwwWnhPaEpiME1RdlptQk05QVh3a1B1ZzFU?=
 =?utf-8?B?ZE5oRGhwV0lDRXpBV2x1NFl0eDUvZm1ZaVNWeFBLWGs4MzhRQ0JQd29kd3lt?=
 =?utf-8?B?RjhTdWJKaGE0UDIyb1FaMUdISWFqWFlYTHpGSVM2a1lHZzBHTVRBUXo2N2p5?=
 =?utf-8?B?UkpJcUZFV0RHanZyTHZDWCs0TDdKSUpJYTBNTDBIMjdjN0tQM0dUL0I3YVJX?=
 =?utf-8?B?K1BHSFFHVThJQVZYU2dJY0xPazAzWGRQaC93dXh2bGRCeW1JZ2xiT0lrUVR1?=
 =?utf-8?B?TURKRERpTE13d09zNkRtUUFud2daMVlYNHZ5MGdFKzZKZ0dhcFl6ZWJUTlpi?=
 =?utf-8?B?NEtXTUFkWHpTSGQvelJXeDZEaitiaysyVTI4L2d1L3ZVVE9SRUZMUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e30d6e08-37f7-4bc2-719e-08deb64d5e23
X-MS-Exchange-CrossTenant-AuthSource: EAYPR12MB999132.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 08:54:15.5517 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NxmmKrhLBqNo+asMIj0GeBMrRSx+TFvf9ZvdvXQZU5nLXRDOdIFnWdWOp0Zkj0/9v5zbJ1R0PNUgcxiaxQy2yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7596
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



On 5/19/2026 5:58 PM, Tejas Upadhyay wrote:
> Add helper with primary purpose is to efficiently trace a specific
> physical memory address back to its corresponding TTM buffer object.
>
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
> index eb1457376307..9de9872294a6 100644
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
> +	end = addr + SZ_4K - 1;
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
Could you please clarify where we plan to use this helper function in 
the code path? I do not see any callers added in the current patch series.

Regards,
Arun.
> +
>   void gpu_buddy_free_list(struct gpu_buddy *mm,
>   			 struct list_head *objects,
>   			 unsigned int flags);

