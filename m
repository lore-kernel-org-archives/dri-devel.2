Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D372CA5FED
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 07:14:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17E1A10FEE1;
	Fri,  9 Oct 2026 07:14:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pej6/JOU";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012054.outbound.protection.outlook.com [52.101.53.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D19C10FEEC;
 Fri,  9 Oct 2026 07:14:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AyRBxFn67mt7aH6fWecX7faFAmhUdPKuJu+a6VsrQgU9zWDNKitZUFi0DdwgkS7Y2dXQvdoK+X6JjEkP79haPWhGimDlU5jKIPXEWsQIG1gMuK25fn82T4w9znoVD9lmsMiCmc/eaoHJdp150iQ3hh22J626OZfS3E2ZBMcLavuIkv13aL/RzSDxwtxCV0g+5PHwtGUHZaKCzCAYbKojdGfdCcqxhEaqjhFYONxEY11ER9LAhk9F7lvwDvogR4VPxjDBTJMZcHh6IauE9LcsR99uDbY9tZAQ5KzQafTzjsUTHq0a/ZDEw5srWsdRbK0yXtJhp677+VcH1PWzNOr3vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7tqPLwIyv66xHM0sOsQjN48WMNd0QxEbj+g4xsISuQ=;
 b=bl4zCRYKjU5aA9xUdtlso9RPMxeWlrIwP0qJs6tdSvFZ+mufNPQf0S8ucVnQNoJsxN5h2sVIdMDjhTNTq+DHOPxB1bXMTVoMz9ChukAD6no3TECzDDK9HeJZUiGZpWboBSra5i3AAlW/dzp3u3yAt9Agjl5wIM7C7Vk5YrCXQUUpjmPqg4zTMJxZDKIFKCc1hp+i/LWBgY7DctLRiCOr43aj71KaE+r8ob+jyrfLAgPzboTllgOy8RiDuuklM2LS598DS/lHUZoOCBEehaUFyy+OsxC1UpIWKCezwe4tzdWYbbeMLaveCGF2SB577hnE1uBIAa03/9d4x+juVawqhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7tqPLwIyv66xHM0sOsQjN48WMNd0QxEbj+g4xsISuQ=;
 b=pej6/JOUUd/J0BiQ6vvup0lyI3yk/zxPqk1YPzcdZ3AwsOMd4Z+r70SEf5HGUs9Fa8YHu/S5epCMLjibuyqiJmY7WL6MPp/cC72poRKrFyJoc/okJtyOjG55XKKnXOw4Sux4xFPX2bB8aYQu34viQRF3SQVk2BYACV2OkRysqKY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB8418.namprd12.prod.outlook.com (2603:10b6:8:e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Fri, 9 Oct
 2026 07:14:19 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 07:14:11 +0000
Message-ID: <894d90fc-613e-4454-95b1-7f75fb74e121@amd.com>
Date: Fri, 9 Oct 2026 09:14:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ttm: return an error when kmapping a BO without pages
To: Jesse Zhang <Jesse.Zhang@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
References: <20261009011952.3925146-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261009011952.3925146-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0428.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB8418:EE_
X-MS-Office365-Filtering-Correlation-Id: 986ffa82-9906-4102-451d-08df25d4eae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|22082099003|10067099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: WPCcRzXNVwuWYKQkoNpY7jUc3rKto2iejbLSGLaZqISKZBM04o279Mq+y7qwZwLpLpmy6EACr27M4ndDK+K9pxpZY1JtMRopS6xct8BUE2mfQQjTpCZneIxsVPuS/UyPF+NCULQ7KfivuauTI2aFITJUjgL6y5x8tIVtfuPkpVgzPa+2GRJmjCO84d15fo5+8T9bX0VaHqpNbdfW2X5yMh3DvmalEVRxA2ewVztifrRU4dKGsjO3T1gGJVYSWqnyZYOMLQ4IryakZGy+bPQMivwcTR5yla9wgc60MmXK7yfp+0sPpNa6WmXwSC07sertnNJI6blZoFqvQaFq6o5toL9K54jN1+PAqedBRQj6S4BZez0ZrgOqrvNSh8hIO+ffQMtMkL0N+Q3BiKLJlEaYNkY45N8ScLrgIjzr8RyjxcHAwK2OSFIjnBQHo/Iur0f5AKA+Maj3MSFlNqrFeogUOMu+2hpdCKLA9tLgQP0XboIKG69wbcyYRe91LTjTBYhyjp3AcLwYzbqORgqJxse9NTKufet4c51WuGfiw0YStlIjEXEkhRmo3cmSBt+Y3hi7Hk0rI+VkGAtYH/kWY2/pGOL/AoyKgXIh9Wv2qcN6bjUn+l+YwrMFa7UDQU6yM113EG6lkxC2/F2dynmvZXoXUamAdhEUhPb1o4lhSxUuCF8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(10067099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFRVL0NWVEtiaFZvZU0xQ1EzZVByQ01WN25Vczk5UmpWQnNXTENJU3d1VnBa?=
 =?utf-8?B?K3IyVXhYYUYvSVh2bFB0VWhsMmdXL1ZaU1BxaEV1cENrcms2Y2cyVXVnUFdD?=
 =?utf-8?B?TDVkVEVXTWNPeWozVkNEcENlMlo1QTN4YXQ3cXZjQUxsYytvWXcvK1V0S2Fw?=
 =?utf-8?B?Tll0NTRxVWhpWHZqTUJzZk1UQks2WHNrT25CMGVBZjZTQVFtenNUcDVPK0Jt?=
 =?utf-8?B?RFJFZHdmYVYyUUhCSlpZRisyMkg2VHhyQkN2TE92K0d0TW5IS0lDK3V0a0tF?=
 =?utf-8?B?MFI4MTAwWEx2Y1plOTArSWwrN1ZmRkZXMWdnWVBjdS9ZVEhvcjJCdzlXbVZE?=
 =?utf-8?B?cWNsOXFtY29KZWpBeGwrSHNnNTJGNWxUdjVuMkRxRW9MOElsRnQ3M0hwVVRF?=
 =?utf-8?B?T1BPanlZNTlJQ0xLanBEZjE1WlFmYVhuMXNEanRHT3RoUGpEajltU0hTU0NX?=
 =?utf-8?B?dThlS3NOb0pwSHlwZFlmZThMaTREcnhlRHpQVXdHSTVmQmxKOXNNRGliaGJp?=
 =?utf-8?B?RlUzVjVaZ3Awck5tbUV5dkE2c3l3ZVYzOGtiOCttQXMraXByeDdCczFPK3dl?=
 =?utf-8?B?VFhkelcxdkJBamVYOUE4UDFOTnNQNkpaOTJ2MFFNbkVLdzJNMVVUazlDM0xv?=
 =?utf-8?B?UHYrZDE2ZnV5STRxendYd2hzM0k2MmV4Q05saHJ3ZTk3Ty9VSDFJU1hLRDJy?=
 =?utf-8?B?cmtGZWN1NU9MNklKTjhTeityTmpSYnJFSVJESGhPcnE2MWtQMDFmUGVkdVVK?=
 =?utf-8?B?czlYY2xHNi9QZGZId2kvRzVxQ2UyUHB1cTN4K1JrOStic0J5c0RjNlZocVdX?=
 =?utf-8?B?aVkveElqSy93ZG1Ua0V1aTJnSkFMVCthbUlrcTVpam5DZlJ6TmcxaXZsWFRU?=
 =?utf-8?B?aXVYZzQ0SWdhTXJ1U0RQL3ZEUFhWc0Q3dDFBb01kZ25Fa3JLbDdibG1kQzNz?=
 =?utf-8?B?cEZJazBjUTYxNE95ZEw3b1dwS2R4TEpYSGJmZTBTM3pHMjI3TFYzNzkzcXZs?=
 =?utf-8?B?eU5JSk9qcDhHRDEzR3p4SDhQVWIydlVyRnV3Q0tURE1qWUV0azFNOStoT3JG?=
 =?utf-8?B?a3F5S1UvbWFEZXh1c0gvUFRIbVhaN2FJODBFSVljVHByZ1ZKdDV2dUJQV0oz?=
 =?utf-8?B?OGlsbzlKVzRIeXFVT2RZbkhCR1p2dlBVR08yMStLYXZzWEQ2WXBiSytuY0g3?=
 =?utf-8?B?QjRXVis5dDZTZkJQZUE1OUVrUnJ6NkxRZ1o5VXZzcFRGTTByMEV0dFhKN09l?=
 =?utf-8?B?eVRRNVZCQXhBcWtieXZOZ1FIWWRxNGNSemJSL0t1R1gvQkEvaXdSbXpqNWlr?=
 =?utf-8?B?d1pUcmtvQmp3MUMxTitFcmxzNGpZTFlHRmVHdmJrdEhpbFN3STZGUkMxRHBp?=
 =?utf-8?B?d21KMHJjNk84cm9jaDVjTW5USElTQjVCcGVqT2pyYnAxNTYwN0JTa0Erc0xs?=
 =?utf-8?B?ZVA3SjBYOWdoTEplU2JkdGFiczBBOFYxK0t0MnBJNlhxdHlsSVpJWXFmbnIr?=
 =?utf-8?B?dDhjbGZFYUtucmtPRWFZUnFmMFl1OGxDc2NuUDNOWCtMUEM3cDM5THBOWVMr?=
 =?utf-8?B?ZEtiTzJyWnVtOU1FWmczZ1dFSG1EbGtZR2Z3TTlXWXJtOUJ4aDl2Sy9wbC9M?=
 =?utf-8?B?dkJwdldOM3c3UnRkNzR0WHQ3UXRsRlh3dU5hV3hUQXdqT0psbkZkVUg2UEJR?=
 =?utf-8?B?d1RkMXVRcGJnalBvWWV6TTVjYk1FWnFsNjdDNG5pYXdoWnYrOHpFNFJ3VXQ0?=
 =?utf-8?B?NU5ESWRoUGJNK3JuR3B3NDRIMWYwRjFzK1dQVzRXWUJUMVV0S25ZTmZ2a1BW?=
 =?utf-8?B?S0NyUzVaam9xYUErVm5ZRVdHWXFSVThqbUxnb2NsOEdweE8vL3l5SXNmb2xT?=
 =?utf-8?B?a2F6Tzh1eTl1VDJuVkg0bUpNS1ZDM3NXRmNBdzB0TFhkNW4rVk1McFFOVGVw?=
 =?utf-8?B?WDhmWkdrdlNvZ1FsZUJCL1VOUmJ2SklZMXB2dUNNa1gwMllSK0RQblUwa1dn?=
 =?utf-8?B?SXlEbkwwT1hTZXVYY1EvczJjQjd3QUtIckwxWExUdGZYcmlpWXlhOW1YSWFG?=
 =?utf-8?B?VHhJajRsT1d3cmk2aUFVSVFsRmNyK0Y1ckdEWVlxOG9ZbjY5REdzbkxWVjhU?=
 =?utf-8?B?QTU2MjFMNVpTVFRGNzl6c3RQSWhnVjRUb05KSjdOa21FK21lY256ckJacU9r?=
 =?utf-8?B?WUowSHduaTdUM3FpTXJ2Qzh0V1FjTVBZM0F6cmkySXd4VEErZm1KTXdWRHNL?=
 =?utf-8?B?cERwbStBQTNqb0QyWGpHNEZxTE85dXZxRHFPMVpKZFpwbG85VFZrTGxOQ1Ba?=
 =?utf-8?Q?xIK0f/00jSsJXafgCz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 986ffa82-9906-4102-451d-08df25d4eae0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 07:14:11.5792 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3pPW2bkmuK87rC6GO7GfHUItm1xHmIY5QL9CaMmg0OaNfHCNIEWPEGZGca0lm4xF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8418
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

You need to add Natalie and Arun as well, they are the new TTM maintainers.

On 10/9/26 03:18, Jesse Zhang wrote:
> ttm_tt objects for imported sg tables (ttm_bo_type_sg, set up by
> ttm_sg_tt_init() with TTM_TT_FLAG_EXTERNAL) only have DMA addresses and
> no pages array. ttm_bo_kmap() and ttm_bo_vmap() still dereference
> ttm->pages for them, so a driver that tries to CPU map such a BO oopses
> instead of getting an error:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   RIP: 0010:ttm_bo_kmap+0x26c/0x300 [ttm]
>   Call Trace:
>    amdgpu_bo_kmap+0x89/0xb0 [amdgpu]
>    amdgpu_userq_fence_read_wptr+0x116/0x170 [amdgpu]
>    amdgpu_userq_signal_ioctl+0x3fe/0xbb0 [amdgpu]
> 
> Return -EINVAL in that case, like ttm_bo_kmap_try_from_panic() already
> checks for a missing pages array.
> 
> Fixes: 75a57669cbc8 ("drm/ttm: add ttm_sg_tt_init")
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

CC: stable?

Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

> ---
>  drivers/gpu/drm/ttm/ttm_bo_util.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
> index 3e3c201a0222..83142bfa3bc1 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> @@ -356,6 +356,10 @@ static int ttm_bo_kmap_ttm(struct ttm_buffer_object *bo,
>  	if (ret)
>  		return ret;
>  
> +	/* Imported sg tables only come with DMA addresses, no pages to map. */
> +	if (!ttm->pages)
> +		return -EINVAL;
> +
>  	if (num_pages == 1 && ttm->caching == ttm_cached &&
>  	    !(man->use_tt && (ttm->page_flags & TTM_TT_FLAG_DECRYPTED))) {
>  		/*
> @@ -419,7 +423,7 @@ EXPORT_SYMBOL(ttm_bo_kmap_try_from_panic);
>   *
>   * Returns
>   * -ENOMEM: Out of memory.
> - * -EINVAL: Invalid range.
> + * -EINVAL: Invalid range or the BO has no pages to map.
>   */
>  int ttm_bo_kmap(struct ttm_buffer_object *bo,
>  		unsigned long start_page, unsigned long num_pages,
> @@ -493,7 +497,7 @@ EXPORT_SYMBOL(ttm_bo_kunmap);
>   *
>   * Returns
>   * -ENOMEM: Out of memory.
> - * -EINVAL: Invalid range.
> + * -EINVAL: Invalid range or the BO has no pages to map.
>   */
>  int ttm_bo_vmap(struct ttm_buffer_object *bo, struct iosys_map *map)
>  {
> @@ -537,6 +541,9 @@ int ttm_bo_vmap(struct ttm_buffer_object *bo, struct iosys_map *map)
>  		if (ret)
>  			return ret;
>  
> +		if (!ttm->pages)
> +			return -EINVAL;
> +
>  		/*
>  		 * We need to use vmap to get the desired page protection
>  		 * or to make the buffer object look contiguous.

