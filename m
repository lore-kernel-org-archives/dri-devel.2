Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5493C43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:27:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1217410EEAE;
	Wed,  1 Jul 2026 10:27:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RmicA40o";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE19D10E281;
 Wed,  1 Jul 2026 10:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782901655; x=1814437655;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=zNJeIKsLVnL7ndDh8qjBKPPHtsxpKuPpkakcaaHvb6o=;
 b=RmicA40ofmMmJnz3w++oeI317mFWiGUG8FHnKyjP8qZkLovtGGgZdSaf
 VBhqo1FlcmXA5RQ/6Tg2yUSwNPyOccl6RTstc31QDTH3pzt8+GfRRDy/q
 Ji3aluf+bfiiSAy2GCNj3SnqCo34EP3xKmrFruzoNrblgBM+RFoNklHh+
 gc7Dr0lZ0uoKEfInhtEtxPVvzV37x0PRq6uoPlbuyalS9DQwUtp19O5KM
 Lmap+IoqEA70lLDqnjhScRqzTvCq12Ryz0dZNnwg2zD5i9SLnWmjqnwDR
 Y9hczqHVMf7cYuLRg0x8UNN5512i+B8ivjR1JpNurJ2ilN7meL7pDGVlS g==;
X-CSE-ConnectionGUID: pOuwBP8bRfieKlmjJuh0kw==
X-CSE-MsgGUID: 5WDJU3gVSLejsGx3jggfwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="87465222"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; d="scan'208";a="87465222"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 03:27:34 -0700
X-CSE-ConnectionGUID: 3c4VXgfJStWXTrhs/5lTAQ==
X-CSE-MsgGUID: j/NAC4i5Sw6AKFEsveLy4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; d="scan'208";a="282603748"
Received: from vpanait-mobl.ger.corp.intel.com (HELO [10.245.244.86])
 ([10.245.244.86])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 03:27:34 -0700
Message-ID: <06860a7f-0df8-4e8d-b4ff-c6ebabc5fa4c@intel.com>
Date: Wed, 1 Jul 2026 11:27:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/xe/display: Avoid using stolen memory for
 framebuffer when media gt exists.
To: Maarten Lankhorst <dev@lankhorst.se>, intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
References: <20260630135523.1775379-1-dev@lankhorst.se>
 <20260630135523.1775379-3-dev@lankhorst.se>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260630135523.1775379-3-dev@lankhorst.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 30/06/2026 14:55, Maarten Lankhorst wrote:
> On systems with media GT, extra latency is added when accessing stolen
> memory when the GT is in MC6.
> 
> Simply disable allocating stolen memory for framebuffers when media gt
> is found.
> 
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7513
> Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
> ---
>   drivers/gpu/drm/xe/display/xe_display_bo.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/display/xe_display_bo.c b/drivers/gpu/drm/xe/display/xe_display_bo.c
> index 8953da0136dcb..677ae3af9ac0c 100644
> --- a/drivers/gpu/drm/xe/display/xe_display_bo.c
> +++ b/drivers/gpu/drm/xe/display/xe_display_bo.c
> @@ -131,6 +131,13 @@ bool xe_display_bo_fbdev_prefer_stolen(struct xe_device *xe, unsigned int size)
>   	if (IS_DGFX(xe))
>   		return false;
>   
> +	/*
> +	 * Avoid stolen memory when the media_gt exists,
> +	 * because a lot of latency is added when media gt is in MC6
> +	 */
> +	if (xe_device_get_root_tile(xe)->media_gt)
> +		return false;
> +
>   	if (XE_DEVICE_WA(xe, 22019338487_display))
>   		return false;

There is also the question for why this WA only applies to LNL, but the 
GT side of the WA applies even to PTL+, which seems highly suspect. 
Might be worth mentioning that in the commit. Also wondering if can now 
just drop 22019338487_display?

Also not sure if should just go with platform check here:

if (info.platform >= LNL)

?

Either way:
Reviewed-by: Matthew Auld <matthew.auld@intel.com>

>   

