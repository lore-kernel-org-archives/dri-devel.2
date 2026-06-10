Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DD6CD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 10:40:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 282CC10E458;
	Wed, 10 Jun 2026 10:40:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bJ6tIPLn";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7909810E458;
 Wed, 10 Jun 2026 10:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781088054; x=1812624054;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=KJFwkgycpuQeR/HDhxldSBlJ4HoX051kOdsKVAUQJlg=;
 b=bJ6tIPLnhtxMNfE+AP/REX1FnlIyb+15VVZmRveAi0f4qXaLWc3Mujf8
 iNHvSdhxf+FztsVPKJw0ffWoZZlIt3vSsmuLUAXuiEjzT3v3tu5ljuvlm
 NdVNLELGkDOTI+bV7N90sGv2kuCZV2JU10v36P9ScXnA8PgYlwLcZOl9d
 qHd6W+/kmYOP/JPWUxPyPDKKTup6xgRcU7ZmYUKYcKVC6NLeFyJfJnmy7
 /x3LSfgSLnp1hvhAqFvp7TOi6JMZM8Lk03gPL+RIqqZyFHUP94/A5fpXB
 j+OmTUTpevvBpQKDrY3xd/OStXA38FNVPc7rTS50d2lAQoVGX/mZQktLZ g==;
X-CSE-ConnectionGUID: voOseavDQTCXkNWx2J/0bA==
X-CSE-MsgGUID: MMjlKM4CTrKBHfaPGZcZTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="99454947"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="99454947"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 03:40:53 -0700
X-CSE-ConnectionGUID: uCinmPnIThujjQWiXkzufg==
X-CSE-MsgGUID: cmVg/vSOT2WNGgi6gquovQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="269818587"
Received: from amilburn-desk.amilburn-desk (HELO [10.245.244.17])
 ([10.245.244.17])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 03:40:51 -0700
Message-ID: <44287c42-3248-4c3e-b8d5-6e58afa4c6b7@intel.com>
Date: Wed, 10 Jun 2026 11:40:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/xe/ggtt: hold FORCEWAKE while updating GGTT PTEs
 on LNL
To: Nikolay Mikhaylov <sonny@milton.pro>, intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
References: <20260520194426.1334262-1-sonny@milton.pro>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260520194426.1334262-1-sonny@milton.pro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi,

On 20/05/2026 20:44, Nikolay Mikhaylov wrote:
> GGTT PTEs are written through GSM using MMIO writes. On Lunar Lake
> systems affected by the referenced issue, hangs have been observed around
> GGTT update paths while the GT may be entering RC6 under GuC control.
> 
> The GGTT modify paths currently rely on xe_pm_runtime_get_noresume() for
> power management protection. That prevents the device from entering D3,
> but does not keep the GT out of RC6 while the device is otherwise runtime
> PM active.
> 
> Hold GT FORCEWAKE across the observed GGTT PTE write batches:
> 
>    - xe_ggtt_insert_node_transform() and __xe_ggtt_insert_bo_at(),
>      covering the display framebuffer pin path observed as the primary
>      trigger on LNL/Wayland systems
>    - xe_ggtt_clear(), covering the GGTT node removal/unpin path
> 
> This keeps the change limited to the paths where the hang has been
> observed. The exact code shape submitted here has been tested by multiple
> LNL users, including several weeks of uptime without reproducing the hang.
> 
> Boot-time xe_ggtt_initial_clear() is also covered by the xe_ggtt_clear()
> wrap. That is incidental and not the primary load-bearing path for the
> reported issue.
> 
> The insert-path FORCEWAKE wrapping was originally proposed by Márton Vigh
> (@mrtnvgh):
> https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7513#note_3418761
> 
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7513
> Tested-by: Nikolay Mikhaylov <sonny@milton.pro>
> Signed-off-by: Nikolay Mikhaylov <sonny@milton.pro>

I went through the specs, WAs and the only thing I could come up with 
was a potential miss in the implementation of WA 22019338487_display, 
which is relevant for LNL, and could be related since this is in the fb 
pin path, but it's still a long shot. The WA seems to want the driver to 
limit host side (over the BAR) writes to stolen memory. The GT side of 
the WA 22019338487, looks to try to "rate limit" GGTT host side writes, 
since GGTT also lives in stolen, and we ofc can't outright disable it 
(see ggtt_update_access_counter).

Patch is here: 
https://lore.kernel.org/intel-xe/20260609171002.380499-2-matthew.auld@intel.com/

I don't know if this will actually solve your particular issue, but 
regardless I think we should still land that anyway.

For your patch, assuming the other patch doesn't help, I think maybe 
tweak it such that it is limited only to LNL, with FIXME that we still 
need to figure out the proper root cause, but in the meantime this has 
been shown to resolve the hang?

> ---
>   drivers/gpu/drm/xe/xe_ggtt.c | 39 ++++++++++++++++++++++++++++--------
>   1 file changed, 31 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_ggtt.c b/drivers/gpu/drm/xe/xe_ggtt.c
> index a351c578b170..c048bad70ebf 100644
> --- a/drivers/gpu/drm/xe/xe_ggtt.c
> +++ b/drivers/gpu/drm/xe/xe_ggtt.c
> @@ -20,6 +20,8 @@
>   #include "regs/xe_regs.h"
>   #include "xe_assert.h"
>   #include "xe_bo.h"
> +#include "xe_device.h"
> +#include "xe_force_wake.h"
>   #include "xe_gt_printk.h"
>   #include "xe_gt_types.h"
>   #include "xe_map.h"
> @@ -272,9 +274,18 @@ static void xe_ggtt_clear(struct xe_ggtt *ggtt, u64 start, u64 size)
>   	else
>   		scratch_pte = 0;
>   
> -	while (start < end) {
> -		ggtt->pt_ops->ggtt_set_pte(ggtt, start, scratch_pte);
> -		start += XE_PAGE_SIZE;
> +	/*
> +	 * GSM (mapped at tile->mmio.regs + SZ_8M) is not in an always-on
> +	 * power domain. Hold FORCEWAKE for the PTE write batch to keep
> +	 * the GT awake; on LNL GuC autonomously enters RC6 via
> +	 * GUCRC_FIRMWARE_CONTROL and writeq() to GSM hangs if the GT
> +	 * is asleep.
> +	 */
> +	xe_with_force_wake(fw_ref, gt_to_fw(ggtt->tile->primary_gt), XE_FW_GT) {
> +		while (start < end) {
> +			ggtt->pt_ops->ggtt_set_pte(ggtt, start, scratch_pte);
> +			start += XE_PAGE_SIZE;
> +		}
>   	}
>   }
>   
> @@ -769,10 +780,19 @@ struct xe_ggtt_node *xe_ggtt_insert_node_transform(struct xe_ggtt *ggtt,
>   	if (ret)
>   		goto err_unlock;
>   
> -	if (transform)
> -		transform(ggtt, node, pte_flags, ggtt->pt_ops->ggtt_set_pte, arg);
> -	else
> -		xe_ggtt_map_bo(ggtt, node, bo, pte_flags);
> +	/*
> +	 * Hold FORCEWAKE for the PTE write batch. xe_pm_runtime_get_noresume()
> +	 * upstack only prevents D3, not RC6: GuC may have placed the GT into
> +	 * RC6 autonomously (GUCRC_FIRMWARE_CONTROL on LNL), and writeq() to
> +	 * GSM hangs if the GT is asleep. Triggers most often from the display
> +	 * framebuffer pin path on LNL/Wayland.
> +	 */
> +	xe_with_force_wake(fw_ref, gt_to_fw(ggtt->tile->primary_gt), XE_FW_GT) {
> +		if (transform)
> +			transform(ggtt, node, pte_flags, ggtt->pt_ops->ggtt_set_pte, arg);
> +		else
> +			xe_ggtt_map_bo(ggtt, node, bo, pte_flags);
> +	}
>   
>   	mutex_unlock(&ggtt->lock);
>   	return node;
> @@ -844,7 +864,10 @@ static int __xe_ggtt_insert_bo_at(struct xe_ggtt *ggtt, struct xe_bo *bo,
>   		u16 pat_index = xe_cache_pat_idx(tile_to_xe(ggtt->tile), cache_mode);
>   		u64 pte = ggtt->pt_ops->pte_encode_flags(bo, pat_index);
>   
> -		xe_ggtt_map_bo(ggtt, bo->ggtt_node[tile_id], bo, pte);
> +		/* See xe_ggtt_insert_node_transform()/xe_ggtt_clear() */
> +		xe_with_force_wake(fw_ref, gt_to_fw(ggtt->tile->primary_gt), XE_FW_GT) {
> +			xe_ggtt_map_bo(ggtt, bo->ggtt_node[tile_id], bo, pte);
> +		}
>   	}
>   	mutex_unlock(&ggtt->lock);
>   

