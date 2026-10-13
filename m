Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67283CC6B0F
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 14:32:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5AEC10F88F;
	Tue, 13 Oct 2026 14:32:19 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013060.outbound.protection.outlook.com
 [40.93.196.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74F9810E812;
 Tue, 13 Oct 2026 14:32:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=th3vVSRLRZkdPPA8ZXe4b6inxUUQgN38lwLM7S+85JJi2onZGsGETQEu/EMflVVX7kjf0D5wZi+O0/PR11Iyh/FeSY7kJdUkA5aoXTbhCKUiyKPDmLbWTujr0vdxtMfXXRmTzTT3q9xmQoz8yHH9fdK63X9KaNOu/BXk727setNb3cf5168CjAf9linszgkSsw8tyBGOaWj1+JqYTFvbAC38RKah4uoAOYugexTqZ4A9aubyww8pntCb2HFk0+ANQU56ksgQ0cGy561ubuGFeYJEBQkihFe9fZ7qG/O2V5b0Y4+P/UJHX+/IYUmI/E4jpq9DgkSG3ncmJPJvCHj2vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRVtO5UxhRo6t5NffG/LKkGj3itFqu9iu6Y9+ZSeTuc=;
 b=SrgcnnaIsykKISsrS94I84wvN9UAvpx/NA9kuHVFqNP0+5/c74NU+M1b0J4IJa+W6Q/Ny8QMXdx8ATOUcPB2c17HhPY2GG5dmKIDQXushJPDwLl1L+Eq9AhjJ0RwnJ7CzB9YILBDsWzp3m9xJ2RKYlmOpzb08tZk/x+OdSP+PB8qrm6ProM4mn0Cip2R5s6HPaHj9FuoJ7CjmmYWXkrHdggaTmHheFXsqmUoo1Q//3A3uwX93UQ0GuPAztnlc9i/odKbyfifwksOIDkVb07ZRAaR8Z8Ls/5PpRH388JKz3vzGHx8Xcmp9wrE2FXcA/ixDz4TSgL2rkUCSGEvDkmDtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRVtO5UxhRo6t5NffG/LKkGj3itFqu9iu6Y9+ZSeTuc=;
 b=Xl4M3pdcqcZjElUdIPT7cbfoDPSM3QvQowZWS854H1UWVpIXyFm2kqtdwPXKOHJpCwcyYpfB0UjrsbhzmLuJPm5Nxc1jDrkZvL+pFgU62bI/tHZvJBRt3uCYsfAoUH+BTxYdRdvIRttWfsccw6B6SEjrAmU0H0St8CoB0E2LdWY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18)
 by IA0PR12MB8424.namprd12.prod.outlook.com (2603:10b6:208:40c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 14:32:07 +0000
Received: from DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d]) by DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d%4]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 14:32:06 +0000
Message-ID: <3e16b7d9-b1d6-4d6c-8f58-f6716fff71a6@amd.com>
Date: Tue, 13 Oct 2026 20:01:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] gpu/buddy: restore two-pass clear/dirty guard for
 range-biased allocation
To: matthew.auld@intel.com, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com,
 Anand.Raghavendra@amd.com
References: <20261009100546.1103622-1-arunpravin.paneerselvam@amd.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <20261009100546.1103622-1-arunpravin.paneerselvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0286.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21b::12) To DM4PR12MB5039.namprd12.prod.outlook.com
 (2603:10b6:5:38a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:EE_|IA0PR12MB8424:EE_
X-MS-Office365-Filtering-Correlation-Id: 18a78013-45c8-4d08-5f86-08df2936c19a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: RdAwtimY+LXXPnHRzkPziTp8qSVt1Q+ydvyJR6hiFZC79yY1QOHW8tKReUi+K9XTky3cKaOQNNklTy0sum1g+AJHGja8W5JmGgy74aCpHKyAJ4aZWYw5yobdDXtl6VkpQ20A/58rPjY6mvHiGu/tHUdBPhyzfsxDXsD8YL3rz7Xk+E99ipUXj3gVWrpf5MhGg5qyZuVO3dZrTZA54rrAH+4vkzeAdPGVdvHKxeR0L678V7kuGVbVwwraR6xPrquo6Wy4vlMwiBmU6vT+j2gx8scL7q1kmz/oqr427a+T2Tf8J1Mp+2dr2QKFipP1mibyD8DXRUgJgrEuJ78sBvn9+U5miQw0qQJSdoNs9C/qpBl1GLovwfuQegevu3Zxu+KSNUrD7LgEyFE8/XChcNudBI4/oSW9K9jeJqGWTkeGEo/WOkOBcKSItiGt+ifiuSR3bFfW7c09a9jWpH8gks6C3hiOBt3RrQmMo3X1A7tBMt9rCDVD1rcg4EvbsDlkXqq2N4iGi+QAUNjOImjqxCIUsPtlodSNIaBqzm8AD8HU0rF9WGSRZFeA2w+kJdOVz1MvEX2nPZG6sPmD4xuE8vVxsKk96PIi0ZjpODNdl6RKcNnfNJp+hEwG3JmC3VX0CGJgjsuqE0xTWhqcsCFzRz31j7KkdWRc1262HMiSwrEI5Ws=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5039.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1pid2FnSS9SaGxYclBNTTF2c3dQa3UySGdaTVFqTG9DVW1Ga2VEYUhwalBi?=
 =?utf-8?B?K3hQQXNtM3dYb3E3S3RRU1hrNEl0VG9aeHlWbHhQZUZPUTM4OVI2VTFra2RV?=
 =?utf-8?B?M0NoeENiYzlnOUZOREJ6ZWRCUEdsajBqaFJXVy92bWtSSUhrckRqWlFNa01v?=
 =?utf-8?B?VkZhQU1IRXlabkt4bDlHczRQU0Z3VUNwbFRTbXJzTDNSelBUZXovazR6b2xl?=
 =?utf-8?B?aDNmaGU3aGNpZ1pYeDBRTTV3dndpL3NDa1p0eHh1Y2Q3cFM2S2dZRUw0QktO?=
 =?utf-8?B?SHB6enJzTVJHRmhFTitqWENmQXpFT1JFak5ZRFpkMDlRcFJJOVZZRmVSd1ln?=
 =?utf-8?B?RitpcGVBR3VCWU5mZlVhT2JpY1h3czFqQWw1Mm1iSTVScFdySDduVlpHVjNa?=
 =?utf-8?B?a2E4WGpTTHozdFBEV25EcDlBRHpxbXNqTDJWQXI4em9RdlVPRU5ITUJ4aUZV?=
 =?utf-8?B?a2ZNUWJYSmJITWlkcTdtTEhHUmpjeXhuaTNWVlA0UFBiLzliaUhNZWlua3lK?=
 =?utf-8?B?S2xyWkc5ckZHNjB6QlFXNnBlN0dMWUJKK25rc2toUWVWKzZQQk82SzlzTlFF?=
 =?utf-8?B?Mm1XWGFYeHZKek55NWZiUUM3Q3N6UWF0ajBmRVhkQUgwSFRWdUpwS1h0UHk2?=
 =?utf-8?B?UjQwNFdKTmtpMzVmdVV2dnJyVDVQTGxhWUIyaHM1R25IZDZqWnNGSjd4emV5?=
 =?utf-8?B?WDlyVmFWVGMyVnp4WElsWmxXU2huTjhDQll4UnlCRGFuTi9CMEpaRDZxK3Fm?=
 =?utf-8?B?SlJXejhyYkNNbzJsNk9Id3Qwdkw2NWlBUEI1ZE1ZTjZGRkFubVJyR2RXSGZX?=
 =?utf-8?B?R0tzR2hBYzFEMGtBa2xoSkxFK2JWcEdiemhCVE5KaURraG5DbzdybElYd1o1?=
 =?utf-8?B?aUI0QzBEdXBHaENPaFhBejA3YU5OWmlZV2VacERsOURLQkxKZ0h3UmFhRnJR?=
 =?utf-8?B?SEZ0eWxEL0dXWngvdnFnQkFOWXZrSitsNmJVQnpBTGJOOG5iSW5EaUN6Wmtm?=
 =?utf-8?B?T0V0RkIralhqalgyUnVCMjFWTXRsWlhEY25JTVk4MG4zdVN0eGF5Z1hWMFhz?=
 =?utf-8?B?ZVk2RU1sQWd6Ky9GaDNKdFNONkI3Yi9BTklMRGRWSXJ0bDF4NzA3b0JFRnV5?=
 =?utf-8?B?ckJvVjBrMkh1cVdmNGpqOVV3TjlIZTBzeUh0bXBTcVVCQ0NHNnpVZ2lVcTBy?=
 =?utf-8?B?MHlUVjNwQXBSNGZJZFRDekpWelkwc0QzSmMrRHBTNjVWMElpNytRMHpKRmE2?=
 =?utf-8?B?R2RLMHc2UVRzUkI2RTFXcVZIMXNNS3JSdGJoOGdtcngrcksrOXRFOWxjU3k2?=
 =?utf-8?B?Q0lNZ085SmdYUUdBOXZUN2VuN083QSswVlliTkZjY2NIMVFDK0xZcktvdTR5?=
 =?utf-8?B?VTdHTU1kd2hWR2p0eElzd0FrcXp2SjZwODV5cmQyNGNuTHpnUElvSk5GQ3NF?=
 =?utf-8?B?NThWN3grZnNGaW1Qb2x1U0tEMzFqcTZJR29MczdKeGJLMXk4Z1J1Zy95NitH?=
 =?utf-8?B?QXpGS2JPT0VuakgzWFhOajZ1c1F3KzA2ZlpBZnR3MjdzbXdSNlgybHhJamlz?=
 =?utf-8?B?WlJqbi9QSFBSd1JpS2FMcTFycG9LK2ZKanAyWStmZ29LZkRnZm92VmJWc3hp?=
 =?utf-8?B?WldoWTUzazlPYjdsZUQraVpSUkhqaTZOb2VTSVRSZXlLZllvdDB1akVrVEpN?=
 =?utf-8?B?Z2xiaCtodGljWFVycGxHa0hhelVmK08rMWJWQ2wzbFBscERScTkwSGNEMGx3?=
 =?utf-8?B?NFRSNWZlM1FCQitGZlhBMXM0OEMxSFJqZ2Z0TnlBSVNBQ0lLZW41dXI3eUVN?=
 =?utf-8?B?dW5DeVhQdVpUSFZEMml4Q0F5RzUxTytOVnJPVjVLcG5IMTEvc2JRWXFycHFK?=
 =?utf-8?B?a1FzSjFpWmdLQUd0NUdFVEVMaWNBTGpnRVZJc05veTZQQm1Cd004akozZlNo?=
 =?utf-8?B?MHdVcW9UdFpXaExIamtud0pWc3gyYjhvb0NlcXJnSEdOaXJ5TzV3VkoxSUFv?=
 =?utf-8?B?OHBiME5Jb016b0ZlYUFvMkhHcnJ5QzJFZ1hISnZoUTFyYzNpbjRta1Z5Z0NJ?=
 =?utf-8?B?S28wb05MUjhHWVlPRjRwckhHcnZ6VmVBMjNJMElZSzN5cU0rQkozdnNmWUZR?=
 =?utf-8?B?STdaenBudHY4MDZ3eDlBeUxwRXJwOGZDOWZOcXZhb3FRTnZYdUYwTGhxZWd4?=
 =?utf-8?B?WTFmOGlud3MzUGQ0NnVWdExlQWE2dWRHbTYzSDZmZW5mZkR1cGlMSzh6N3U4?=
 =?utf-8?B?RXBEWjRkL2VlWmFqZm5YWDFSaUNML2RZaElDRTdQOXVpcGhlY0NpYktZZ2la?=
 =?utf-8?Q?zSLs8ZNTDSO/kGMle2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a78013-45c8-4d08-5f86-08df2936c19a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5039.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 14:32:06.4148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WyiBA+3sShK6Si86mY/Uad+VWjn0InEJTc6Wl3OwGw26TPJWqECKakr/YVH6yK94fl6rc8Z+9kVMlI6QSiXAUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8424
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

Hi Matthew,
Could you please review the v4.

Thanks,
Arun.

On 10/9/2026 3:35 PM, Arunpravin Paneer Selvam wrote:
> From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>
> Range-restricted allocations (the visible-VRAM aperture) skip
> dirty_steer_window() and reach __alloc_range_bias() with no clear/dirty
> eligibility guard, so a dirty allocation freely splits clear extents (and
> vice versa), interleaving the two classes until no large same-class run
> survives and a 4K scanout pin fails with -ENOSPC. Use a two-pass range
> search instead: block_incompatible() rejects opposite-class blocks in the
> strict pass and relaxes only when the strict pass returns -ENOSPC, so a
> request still succeeds when only opposite-class space remains. A KUnit
> regression test covers the interleaving pattern and fails without the
> guard.
>
> Fixes: 1ad5e807f716 ("gpu/buddy: replace dual-tree/force_merge with decoupled dirty tracker")
> Assisted-by: LLM
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>   drivers/gpu/buddy.c                | 71 ++++++++++++++----------------
>   drivers/gpu/tests/gpu_buddy_test.c | 65 +++++++++++++++++++++++++++
>   2 files changed, 99 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index 2f2aaadafe35..6566bad4fef1 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c
> @@ -1240,11 +1240,19 @@ static void __gpu_buddy_undo_splits(struct gpu_buddy *mm,
>   	}
>   }
>   
> +static bool block_incompatible(struct gpu_buddy_block *block, unsigned int flags)
> +{
> +	bool needs_clear = flags & GPU_BUDDY_CLEAR_ALLOCATION;
> +
> +	return needs_clear != gpu_buddy_block_is_clear(block);
> +}
> +
>   static struct gpu_buddy_block *
>   __alloc_range_bias(struct gpu_buddy *mm,
>   		   u64 start, u64 end,
>   		   unsigned int order,
> -		   unsigned long flags)
> +		   unsigned long flags,
> +		   bool fallback)
>   {
>   	u64 req_size = mm->chunk_size << order;
>   	struct gpu_buddy_block *block;
> @@ -1258,9 +1266,7 @@ __alloc_range_bias(struct gpu_buddy *mm,
>   	 * This range-constrained search hands back the highest/right-most
>   	 * address that satisfies the request: the roots are seeded high-to-low
>   	 * and the right (higher-address) child is descended first, making
> -	 * top-down the default placement here. A non-top-down clear request is
> -	 * the only exception, where the descent is biased towards clear or
> -	 * clear-containing subtrees to satisfy the clear preference.
> +	 * top-down the default placement here.
>   	 */
>   	for (i = mm->n_roots - 1; i >= 0; --i)
>   		list_add_tail(&mm->roots[i]->tmp_link, &dfs);
> @@ -1298,6 +1304,9 @@ __alloc_range_bias(struct gpu_buddy *mm,
>   				continue;
>   		}
>   
> +		if (!fallback && block_incompatible(block, flags))
> +			continue;
> +
>   		if (contains(start, end, block_start, block_end) &&
>   		    order == gpu_buddy_block_order(block)) {
>   			/*
> @@ -1315,38 +1324,8 @@ __alloc_range_bias(struct gpu_buddy *mm,
>   				goto err_undo;
>   		}
>   
> -		/*
> -		 * Top-down is a strict address-placement policy, so when it is
> -		 * requested we ignore clear steering and simply descend the
> -		 * right (higher-address) child first. Only a non-top-down clear
> -		 * request biases the descent towards clear/has_clear subtrees.
> -		 */
> -		if ((flags & GPU_BUDDY_CLEAR_ALLOCATION) &&
> -		    !(flags & GPU_BUDDY_TOPDOWN_ALLOCATION)) {
> -			struct gpu_buddy_block *prefer;
> -
> -			if (gpu_buddy_block_is_clear(block->right))
> -				prefer = block->right;
> -			else if (gpu_buddy_block_is_clear(block->left))
> -				prefer = block->left;
> -			else if (block->right->has_clear)
> -				prefer = block->right;
> -			else if (block->left->has_clear)
> -				prefer = block->left;
> -			else
> -				prefer = block->right;
> -
> -			if (prefer == block->right) {
> -				list_add(&block->left->tmp_link, &dfs);
> -				list_add(&block->right->tmp_link, &dfs);
> -			} else {
> -				list_add(&block->right->tmp_link, &dfs);
> -				list_add(&block->left->tmp_link, &dfs);
> -			}
> -		} else {
> -			list_add(&block->left->tmp_link, &dfs);
> -			list_add(&block->right->tmp_link, &dfs);
> -		}
> +		list_add(&block->left->tmp_link, &dfs);
> +		list_add(&block->right->tmp_link, &dfs);
>   	} while (1);
>   
>   	return ERR_PTR(-ENOSPC);
> @@ -1361,6 +1340,24 @@ __alloc_range_bias(struct gpu_buddy *mm,
>   	return ERR_PTR(err);
>   }
>   
> +static struct gpu_buddy_block *
> +__gpu_buddy_alloc_range_bias(struct gpu_buddy *mm,
> +			     u64 start, u64 end,
> +			     unsigned int order,
> +			     unsigned long flags)
> +{
> +	struct gpu_buddy_block *block;
> +	bool fallback = false;
> +
> +	block = __alloc_range_bias(mm, start, end, order,
> +				   flags, fallback);
> +	if (IS_ERR(block))
> +		return __alloc_range_bias(mm, start, end, order,
> +					  flags, !fallback);
> +
> +	return block;
> +}
> +
>   /* Return the highest-address free block of at least @order. */
>   static struct gpu_buddy_block *
>   get_maxblock(struct gpu_buddy *mm,
> @@ -1924,7 +1921,7 @@ __gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
>   
>   	if (flags & GPU_BUDDY_RANGE_ALLOCATION) {
>   		/* Allocate traversing within the range */
> -		block = __alloc_range_bias(mm, start, end, order, flags);
> +		block = __gpu_buddy_alloc_range_bias(mm, start, end, order, flags);
>   		if (!IS_ERR(block) || !steered)
>   			return block;
>   
> diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_buddy_test.c
> index b75d32ca6ca0..3eaa261571bf 100644
> --- a/drivers/gpu/tests/gpu_buddy_test.c
> +++ b/drivers/gpu/tests/gpu_buddy_test.c
> @@ -1597,6 +1597,70 @@ static int gpu_buddy_suite_init(struct kunit_suite *suite)
>   	return 0;
>   }
>   
> +static void gpu_test_buddy_alloc_range_clear_guard(struct kunit *test)
> +{
> +	const unsigned long chunk = SZ_1M, mm_size = SZ_4M;
> +	struct gpu_buddy_block *block;
> +	LIST_HEAD(high_clear_a);
> +	LIST_HEAD(high_clear_b);
> +	LIST_HEAD(low_dirty);
> +	struct gpu_buddy mm;
> +	LIST_HEAD(barrier);
> +	LIST_HEAD(result);
> +
> +	KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_init(&mm, mm_size, chunk),
> +			       "buddy_init failed\n");
> +
> +	/*
> +	 * Lay out a 4 MiB aperture as three regions:
> +	 *
> +	 *   [0,  1M)   dirty free
> +	 *   [1M, 2M)   allocated  (barrier, keeps the two halves un-mergeable)
> +	 *   [2M, 4M)   clear free (one naturally aligned 2 MiB extent)
> +	 *
> +	 * A dirty (non-clear) range allocation must take the low dirty block
> +	 * and leave the large clear extent intact. Without the guard the
> +	 * top-down search cuts the higher clear extent instead and returns a
> +	 * clear block -- the interleaving that fragments the aperture and
> +	 * ultimately fails a large same-class scanout allocation.
> +	 */
> +	KUNIT_ASSERT_FALSE_MSG(test,
> +			       gpu_buddy_alloc_blocks(&mm, 0, chunk, chunk, chunk,
> +						      &low_dirty, GPU_BUDDY_RANGE_ALLOCATION),
> +			       "alloc [0, 1M) failed\n");
> +	KUNIT_ASSERT_FALSE_MSG(test,
> +			       gpu_buddy_alloc_blocks(&mm, chunk, 2 * chunk, chunk, chunk,
> +						      &barrier, GPU_BUDDY_RANGE_ALLOCATION),
> +			       "alloc [1M, 2M) failed\n");
> +	KUNIT_ASSERT_FALSE_MSG(test,
> +			       gpu_buddy_alloc_blocks(&mm, 2 * chunk, 3 * chunk, chunk, chunk,
> +						      &high_clear_a, GPU_BUDDY_RANGE_ALLOCATION),
> +			       "alloc [2M, 3M) failed\n");
> +	KUNIT_ASSERT_FALSE_MSG(test,
> +			       gpu_buddy_alloc_blocks(&mm, 3 * chunk, 4 * chunk, chunk, chunk,
> +						      &high_clear_b, GPU_BUDDY_RANGE_ALLOCATION),
> +			       "alloc [3M, 4M) failed\n");
> +
> +	/* [2M, 4M) coalesces into one aligned clear extent; [0, 1M) stays dirty. */
> +	gpu_buddy_free_list(&mm, &low_dirty, 0);
> +	gpu_buddy_free_list(&mm, &high_clear_a, GPU_BUDDY_CLEARED);
> +	gpu_buddy_free_list(&mm, &high_clear_b, GPU_BUDDY_CLEARED);
> +
> +	KUNIT_ASSERT_FALSE_MSG(test,
> +			       gpu_buddy_alloc_blocks(&mm, 0, mm_size, chunk, chunk,
> +						      &result, GPU_BUDDY_RANGE_ALLOCATION),
> +			       "dirty range alloc failed\n");
> +
> +	block = list_first_entry(&result, struct gpu_buddy_block, link);
> +	KUNIT_EXPECT_FALSE_MSG(test, gpu_buddy_block_is_clear(block),
> +			       "dirty range alloc cut the clear extent (offset=%llx)\n",
> +			       gpu_buddy_block_offset(block));
> +
> +	gpu_buddy_free_list(&mm, &result, 0);
> +	gpu_buddy_free_list(&mm, &barrier, 0);
> +	gpu_buddy_fini(&mm);
> +}
> +
>   static struct kunit_case gpu_buddy_tests[] = {
>   	KUNIT_CASE(gpu_test_buddy_alloc_limit),
>   	KUNIT_CASE(gpu_test_buddy_alloc_optimistic),
> @@ -1606,6 +1670,7 @@ static struct kunit_case gpu_buddy_tests[] = {
>   	KUNIT_CASE(gpu_test_buddy_alloc_clear),
>   	KUNIT_CASE(gpu_test_buddy_alloc_range),
>   	KUNIT_CASE(gpu_test_buddy_alloc_range_bias),
> +	KUNIT_CASE(gpu_test_buddy_alloc_range_clear_guard),
>   	KUNIT_CASE_SLOW(gpu_test_buddy_fragmentation_performance),
>   	KUNIT_CASE_SLOW(gpu_test_buddy_dirty_tracker_performance),
>   	KUNIT_CASE(gpu_test_buddy_alloc_exceeds_max_order),
>
> base-commit: f146c6086b792cb2c6b3ce5106f0cce62e408df8

