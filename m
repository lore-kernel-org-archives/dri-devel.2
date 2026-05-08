Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 577D8CD3445
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 13:53:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2C2F10F4D4;
	Fri,  8 May 2026 13:53:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="okxX4MWs";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011052.outbound.protection.outlook.com [52.101.52.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C51B810F4D0;
 Fri,  8 May 2026 13:53:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQSMKvh4t9K0u6nIupgUnPhFW9Dy/BXp6WzWXejqqGLqvXLCVNGX3DW8CUBQzwXDe5UHtGNATp5fyNMwyccClNpFIUnTQ9G4pTPz7utRlQQ3r2yyYT3yiujeMj7eSHI7HQwOjoZLQsQODdsKezo/x33UXzJOFEJYHBpjiJJjGVQXr2wfIH+1DiZpmIV69hUNM78gTEqERENteLrWjlCsLRIJvSMQ41MlOW6dKpfN13zBDRIu6GtgmPvjQMJ37t70fFEL4lLy2mlN8KEVFfsIrDgUV18+wMnI74Yoo+FDvufLpmmGiKsgTp/sZmAnI0E8PntHcsPMU7A8lEKYTpmByw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9nQA7OSmz8t6oAlaWJHAXojZRLwt+Ww/Q1A6XhOWE0=;
 b=KfBUL2qKh/3zMKUAEtB2J+90x4nAaz21Q7cSd4GJOWBA6KO0RybAjhqDJqMTM0cxUw3l1VnGD7h0NZolo8eI4D2wRT7OyoEwrqf/QMpWjC9TAigY9jDpXWHvPW2tvjRM4H1L5YqZiZz0EiflmNwZbkAdsmZhLQD/BpR/qrDNoK0rwanswLYLntVlPq0rMiVP2UkXJFrFsf3Bo80roY1ESlgR/3vTpmXiQXGm/pNlrt8sMCfzdxfefL0yxy+EdDzNlh87I7pToEAR8MP4Oj897M5BQI4xRSPTrmPhLv00Ah0sgj/LUWj7IY7iIV7ApK8hBWHE//fmopM6yuSEyN0ebQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9nQA7OSmz8t6oAlaWJHAXojZRLwt+Ww/Q1A6XhOWE0=;
 b=okxX4MWsYDU2/GirLwdG9fc86Zs9BqufVADAwb2UXduRN20ajZagvyOEECYH97ySYi65iSB7QNc1rvu+5yjeGZDNlbvhTJILaCn4vV+mNOJmmD1uMFrkNlmMFaRRxY+n1g22n1pPFsDkHja/ZHBX/GCvwBM+/ov2dwhNw2DKw+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12)
 by CY5PR12MB6429.namprd12.prod.outlook.com (2603:10b6:930:3b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Fri, 8 May
 2026 13:53:22 +0000
Received: from PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::8434:dc50:a68d:7bdd]) by PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::8434:dc50:a68d:7bdd%2]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 13:53:21 +0000
Message-ID: <6d65ee6a-47ec-4065-ab50-dab223e9a34b@amd.com>
Date: Fri, 8 May 2026 19:23:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] drm/buddy: Integrate lockdep annotations for gpu buddy
 manager
To: Tejas Upadhyay <tejas.upadhyay@intel.com>, intel-xe@lists.freedesktop.org
Cc: matthew.auld@intel.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Matthew Brost <matthew.brost@intel.com>
References: <20260508065544.4049240-2-tejas.upadhyay@intel.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <20260508065544.4049240-2-tejas.upadhyay@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0121.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::11) To PH8PR12MB7301.namprd12.prod.outlook.com
 (2603:10b6:510:222::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7301:EE_|CY5PR12MB6429:EE_
X-MS-Office365-Filtering-Correlation-Id: c08192b4-1f03-4cd5-3c98-08dead092a73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 7Q1eTqTxkbEejb1aL+hlP3+bAugrvg/NjAZS7rvpPHbJgR8LTTCoESExEKCLuxp+10bb17BbnwtV2m3Qt0v/Ul4hJns7JYXwJZgSGoMlovjWaeDoFrPuHrKjQ3gkizUvdI/Kc0hls6WXU4x0hRZkDh6QPXafLr0lMGm5+DJwJDiAiH0uNJu5DiUREv1m9ynnuyuQ2JsbvdbAt96TS6T5jY+tyA0lAh8Lz9sBDyfpsv6aOoL23JjxqbcSgqRGn7eouvpmLe+l2BDEBxxDt9WZSwv8hBsyLah5ntf8YblJtEBK6Kka5CCb+bhhgFtJ0UTRvjmYK/AymnfQeHe9DIK3+J7IUxcsD2z2QFjc4s2WIBMd/xF5BQMnv0DOu6XcvVMCM4tIxTMh0N0aHa3uw+RTo8PZfvQ5TzpcrhBrBQekY/5XgxLWUXWi4mM2LhX7aUzt4CHMR8CTBNhCP/0B87VubPBvSY4hVcttoOg447iWetqpMtmbwNNSv8DFxDEze9ksohY+p2QUPf9tnYO8omXZo9MwvvkQ6QxYsJ86Bp/UWg5hY7UCf6jUG/PRioiRsU52Uj628acKKPev1sAjys7Jn8ubX2ND3B9knmzdcyTnlrmRiY/VNpBC+7EElMy+QXK3SDbB1EdgW6ViIVjwoA2EB1yGQ/lTMjoH4GjvpQoEIwLBTRKn3d3e1+f/uua5DxL2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7301.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yjc2QkNzd0h4SnQ0bGVQOUpOVXdBNzZaL2h5M01Oa08yU1dSR1VYZnRZcmxp?=
 =?utf-8?B?SVd2NURzZ1NQQkNmcFlIT1FDNVo0K2RydDUycHlhMmxjT3BpY2lCNFN4NDY3?=
 =?utf-8?B?eWZXN3FXd1VuTnMzOHp3L3RneUlKU202bkxDdkFmdTBrN3gzREFTamlTM01Z?=
 =?utf-8?B?eVBLME8zWlV5N3JnT3NhZGJ1RWxuWXAzcS93eUtFcWI2NGxzbUJqVWMvdmtZ?=
 =?utf-8?B?eklGS1dYdXRETEZ4N05ielNsWXlsQ1RTQ0lyeFBOTXJRQ1F1OTRBSlNuaUhz?=
 =?utf-8?B?aFRjdExiVWFyNTF4VGxLWHhGSFVIN2xLZzA0SUh5VUxmMDU2cVJvOGFvajhB?=
 =?utf-8?B?Q0lQbTEwRzc4RWVEK2RXdTlTZzhkVWhXTDNZQWZEN05HZUJ4YytJem1USFdj?=
 =?utf-8?B?cGVKV3p2VkNVeHZ0bFljQTBsU1BRVk50SnkvbGsxK05yNXNpS25TdXNxWUIy?=
 =?utf-8?B?eGNGWDIwcUo0dk9iV3NQYXlMcU5pRTNFWlZiK3JFdGhFSUpYNDhQSlhySkkr?=
 =?utf-8?B?d0YrUTZQVGhJWGRPdEkrVitoa0pObENLQjZ0a2FzTEptNW9ma2JiZ1ZmbHAz?=
 =?utf-8?B?MWwyNGhZRXBMWFJDaVFOQ01ybGdxa082NkVVTG51ak5sZG1BV2g0aENRaFMr?=
 =?utf-8?B?Ykd4WGNtcW16eDRFRVp2Z3lsYVhjRXBsa1AyajZ1eWJvcFEyNHhCd2dXcmtm?=
 =?utf-8?B?blUvWEVOMXJxYVJvQ1dQV3RhK043K1o0S1JTWW5vanRBSXJETUZPNnhxaVY1?=
 =?utf-8?B?aXU0VHNkc3pBT1BSYVBVd2NzYW8rbVc2OVlVdUxEZFR3bUllbkhTUHRybnFU?=
 =?utf-8?B?L0Z1b2ZRTGVsbHZCbXJ0bEhsOXpBMDV6T01MbzltaitESUlmMzR3Sm5YbHhr?=
 =?utf-8?B?ekRnZFZuWUJBTU1PSE1ucTFLclVzeFNkUEJjTXIybnBhSGVOMGdnU05RcEE1?=
 =?utf-8?B?L28zNmRBanVVZzBuV1BXYXdEdS9JRHFZVCtmNEs5bU9DUW1JY2tuVi9sa1Iy?=
 =?utf-8?B?K1ZTQ2hsVWpwSEg3M01pODB6bnJtdnUrZWtQMzNXMDRaMmVrNWVvTlBSZC9t?=
 =?utf-8?B?TVhQZnlxSDFib0daSzNUdzFKc3NzV3BUOGIvWlB2eUxwbjhPcFhSaGFseFFj?=
 =?utf-8?B?VXp3YUtYYk1qNlhpMGcwWEJGMklNUEJSSnVqOVdFV1RKS0pGSTg1SEVmMFVR?=
 =?utf-8?B?N3hPOUFGaVhQb2ptbGRqU1d4RU5hcUIxdy9NWjJoM0o3TnlkWVBLQ3dNQnF6?=
 =?utf-8?B?RGdhYi9UQjhkOEM4b01pRjU2bnVEMVduRURFcEJHS2ovVmIwcDRCQ1E0dDBH?=
 =?utf-8?B?eVVHVXhVc0paaDlzcm15ZHhBOFZwbkJjbkhXVWwwWUhqd1VMa3BpNmZ6ejlW?=
 =?utf-8?B?aVhqNC93SHBkWm0vM00xZjY5SHBIdHRZTkZxT1R2UTFrU3dHaFVETUlDUU0w?=
 =?utf-8?B?d2k4STI1QmFLRzk2bS85OUxxSERLMmFxUjVDaVFsVDFhR2FCUnJMV25LaFc1?=
 =?utf-8?B?S0F5NXcyV2NLVjU5SlYvcndaUm5kRm1zUVRpUCs5VkRMUDRXY1V5UHp3SkIw?=
 =?utf-8?B?RngyWUlEVGIzL0N6N2FoYTV0MGc5a2x4R0V4UGVYV05oaE16clpxN3BqTkUr?=
 =?utf-8?B?ZlkrcXpScTlEekdRb1FKK1NvcG9LQTF1R1BaejVWNzlZRkxHbnUzekEvc3JM?=
 =?utf-8?B?K0tzOEt3bUc1WmtIaGljbUVUMHF1eHYzMTNpamYrYVRyYXJhNU1CaENrZytS?=
 =?utf-8?B?UThwaTBscmMvLzVjTXl3NlRpb3ZLbWh4cDNvNTErc01CcklZQTEzTGxQK2dS?=
 =?utf-8?B?NVk3bk90ckRHK1pOMnBQK21uSzJnWFpBVktDY21RcUh4dllJTG1FWGo4dW9B?=
 =?utf-8?B?UlJjajYwZ25iaHoycXdNTW9pZDJlWjhTTnF1UGIxcEpVVE9zUTVJemxoYitT?=
 =?utf-8?B?a0RhWFZwS0NHMFJrWE8za1NxYlIxNTBLSisxTnhZK29GcXVkUFpDcnc1YVc3?=
 =?utf-8?B?b2x0RHhuZmlpMXVMd1RUWXVnakh1T0hYOURIc2pjSTdzQ1kzWXFrQU5aOUE4?=
 =?utf-8?B?bzFIZ1JVdnBDTnpldk1BVHpRejNlNzJMTUtpYTltbTZCODBSTEp6MGkrOWFl?=
 =?utf-8?B?T0JiUXFMSWhkTUFxNnBsWDFCNlNkR1pPeVh4VERTOUJIYWRKL2d5L3FHYVFG?=
 =?utf-8?B?QkRPdTBpSDlkUXhrbjJvaGpwWm54YzA2SnRkaHRkZkJnT2JlMDdCc0V1UytJ?=
 =?utf-8?B?UTdMbjlaWngwZ0FFNDhGNXpnTGNBWDNOdkZiOUlMQlUwZk1qNXdDenYyL3F2?=
 =?utf-8?B?em8vTTNMU2s1SUx3YVhMdnN2Vm1UQjZxeWdmcndMdDU4NWtxemN1QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c08192b4-1f03-4cd5-3c98-08dead092a73
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7301.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 13:53:21.6694 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XDDJKI7Eo/YE2PB3HQf8L4ikC86AaXucvY+X81MKNTwuj+1l89kl3zvfuh5GgLTE6O9z3OT1hCYq8gnegGt38g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6429
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

I merged this patch into drm-misc-next branch.

Thanks,
Arun.

On 5/8/2026 12:25 PM, Tejas Upadhyay wrote:
> gpu_buddy APIs are expected to be called with the driver-provided lock
> held, but there is no runtime enforcement of this contract. Add lockdep
> annotations to catch locking violations early.
>
> Introduce gpu_buddy_driver_set_lock() for the driver to register the
> lock that protects the buddy manager. Add gpu_buddy_driver_lock_held()
> assertions to all exported gpu_buddy and drm_buddy APIs that
> access/modify the manager state. The lock_dep_map field is only compiled
> in when CONFIG_LOCKDEP is enabled, adding zero overhead to production
> builds.
>
> Wire up xe_ttm_vram_mgr to register its mutex with the buddy manager
> after initialization.
>
> Assisted-by: Copilot:claude-opus-4.6
> Suggested-by: Matthew Brost <matthew.brost@intel.com>
> Signed-off-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
> ---
>   drivers/gpu/buddy.c                  | 11 ++++++++
>   drivers/gpu/drm/drm_buddy.c          |  1 +
>   drivers/gpu/drm/xe/xe_ttm_vram_mgr.c |  1 +
>   include/linux/gpu_buddy.h            | 41 ++++++++++++++++++++++++++++
>   4 files changed, 54 insertions(+)
>
> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index 52686672e99f..eb1457376307 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c
> @@ -437,6 +437,9 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 size, u64 chunk_size)
>   		root_count++;
>   	} while (size);
>   
> +#ifdef CONFIG_LOCKDEP
> +	mm->lock_dep_map = NULL;
> +#endif
>   	return 0;
>   
>   out_free_roots:
> @@ -538,6 +541,7 @@ void gpu_buddy_reset_clear(struct gpu_buddy *mm, bool is_clear)
>   	unsigned int order;
>   	int i;
>   
> +	gpu_buddy_driver_lock_held(mm);
>   	size = mm->size;
>   	for (i = 0; i < mm->n_roots; ++i) {
>   		order = ilog2(size) - ilog2(mm->chunk_size);
> @@ -580,6 +584,7 @@ EXPORT_SYMBOL(gpu_buddy_reset_clear);
>   void gpu_buddy_free_block(struct gpu_buddy *mm,
>   			  struct gpu_buddy_block *block)
>   {
> +	gpu_buddy_driver_lock_held(mm);
>   	BUG_ON(!gpu_buddy_block_is_allocated(block));
>   	mm->avail += gpu_buddy_block_size(mm, block);
>   	if (gpu_buddy_block_is_clear(block))
> @@ -633,6 +638,7 @@ void gpu_buddy_free_list(struct gpu_buddy *mm,
>   {
>   	bool mark_clear = flags & GPU_BUDDY_CLEARED;
>   
> +	gpu_buddy_driver_lock_held(mm);
>   	__gpu_buddy_free_list(mm, objects, mark_clear, !mark_clear);
>   }
>   EXPORT_SYMBOL(gpu_buddy_free_list);
> @@ -1172,6 +1178,8 @@ int gpu_buddy_block_trim(struct gpu_buddy *mm,
>   	u64 new_start;
>   	int err;
>   
> +	gpu_buddy_driver_lock_held(mm);
> +
>   	if (!list_is_singular(blocks))
>   		return -EINVAL;
>   
> @@ -1287,6 +1295,8 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
>   	unsigned long pages;
>   	int err;
>   
> +	gpu_buddy_driver_lock_held(mm);
> +
>   	if (size < mm->chunk_size)
>   		return -EINVAL;
>   
> @@ -1475,6 +1485,7 @@ void gpu_buddy_print(struct gpu_buddy *mm)
>   {
>   	int order;
>   
> +	gpu_buddy_driver_lock_held(mm);
>   	pr_info("chunk_size: %lluKiB, total: %lluMiB, free: %lluMiB, clear_free: %lluMiB\n",
>   		mm->chunk_size >> 10, mm->size >> 20, mm->avail >> 20, mm->clear_avail >> 20);
>   
> diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
> index 841f3de5f307..faa025498de4 100644
> --- a/drivers/gpu/drm/drm_buddy.c
> +++ b/drivers/gpu/drm/drm_buddy.c
> @@ -42,6 +42,7 @@ void drm_buddy_print(struct gpu_buddy *mm, struct drm_printer *p)
>   {
>   	int order;
>   
> +	gpu_buddy_driver_lock_held(mm);
>   	drm_printf(p, "chunk_size: %lluKiB, total: %lluMiB, free: %lluMiB, clear_free: %lluMiB\n",
>   		   mm->chunk_size >> 10, mm->size >> 20, mm->avail >> 20, mm->clear_avail >> 20);
>   
> diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
> index 6ba47996bc7c..9f67df646955 100644
> --- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
> +++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
> @@ -322,6 +322,7 @@ int __xe_ttm_vram_mgr_init(struct xe_device *xe, struct xe_ttm_vram_mgr *mgr,
>   	if (err)
>   		return err;
>   
> +	gpu_buddy_driver_set_lock(&mgr->mm, &mgr->lock);
>   	ttm_set_driver_manager(&xe->ttm, mem_type, &mgr->manager);
>   	ttm_resource_manager_set_used(&mgr->manager, true);
>   
> diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
> index 5fa917ba5450..71941a039648 100644
> --- a/include/linux/gpu_buddy.h
> +++ b/include/linux/gpu_buddy.h
> @@ -154,6 +154,7 @@ struct gpu_buddy_block {
>    * @avail: Total free space currently available for allocation in bytes.
>    * @clear_avail: Free space available in the clear tree (zeroed memory) in bytes.
>    *               This is a subset of @avail.
> + * @lock_dep_map: Annotates gpu_buddy API with a driver provided lock.
>    */
>   struct gpu_buddy {
>   /* private: */
> @@ -179,8 +180,48 @@ struct gpu_buddy {
>   	u64 size;
>   	u64 avail;
>   	u64 clear_avail;
> +#ifdef CONFIG_LOCKDEP
> +	struct lockdep_map *lock_dep_map;
> +#endif
>   };
>   
> +#ifdef CONFIG_LOCKDEP
> +/**
> + * gpu_buddy_driver_set_lock() - Set the lock protecting accesses to GPU BUDDY
> + * @mm: Pointer to GPU buddy structure.
> + * @lock: the lock used to protect the gpu buddy. The locking primitive
> + * must contain a dep_map field.
> + *
> + * Call this to annotate gpu_buddy APIs which access/modify gpu_buddy manager
> + */
> +#define gpu_buddy_driver_set_lock(mm, lock) \
> +	do { \
> +		struct gpu_buddy *__mm = (mm); \
> +		if (!WARN(__mm->lock_dep_map, "GPU BUDDY MM lock should be set only once.")) \
> +			__mm->lock_dep_map = &(lock)->dep_map; \
> +	} while (0)
> +#else
> +#define gpu_buddy_driver_set_lock(mm, lock) do { (void)(mm); (void)(lock); } while (0)
> +#endif
> +
> +#ifdef CONFIG_LOCKDEP
> +/**
> + * gpu_buddy_driver_lock_held() - Assert GPU BUDDY manager lock is held
> + * @mm: Pointer to the GPU BUDDY structure.
> + *
> + * Ensure driver lock is held.
> + */
> +static inline void gpu_buddy_driver_lock_held(struct gpu_buddy *mm)
> +{
> +	if (mm->lock_dep_map)
> +		lockdep_assert(lock_is_held_type(mm->lock_dep_map, 0));
> +}
> +#else
> +static inline void gpu_buddy_driver_lock_held(struct gpu_buddy *mm)
> +{
> +}
> +#endif
> +
>   static inline u64
>   gpu_buddy_block_offset(const struct gpu_buddy_block *block)
>   {

