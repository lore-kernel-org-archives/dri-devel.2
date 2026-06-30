Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C3E0C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 14:10:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E718010E182;
	Tue, 30 Jun 2026 14:10:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="UR83DQKR";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2530810E182;
 Tue, 30 Jun 2026 14:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782828622; x=1814364622;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Rd+PsWIEELaHNYqU1Dy4fbcTf+7ZD7eJtepTvLG38Ao=;
 b=UR83DQKRk881uINWompwSgjt2nUoBeGHxqXQd1xq3N2ZSUBE5/A1O+fc
 P3F965K50lys06QmlLQVjdIR5jA/O6HR4IcXaAy9/jLRwGGsFZelanDt+
 NKl0oRSecAGPWIaxxhL+H4a7uU8yK+EDoUetj3qT11LOJT1ksjXervqUU
 mXpwYEd1lli8xQiuJUDWFZiUtqSFAK39g+K9eWn/KAJvSLtUN2vNPkVnY
 YfMGnoBQuUv0VwwISE5GZ9u0kV0LId9NerGZ9L2YiEviIo//lgcDb+kn6
 t1GA/4y7yczfTGsb5Sqv8SagYGUHW1W56KQ/vgEGeicDDlf0RQ9FUH9nZ A==;
X-CSE-ConnectionGUID: OgyaZDUGQWC2Xw/fNSy26Q==
X-CSE-MsgGUID: 9HzNrZ1jTAuk9LzfPRTE+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="86092006"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; d="scan'208";a="86092006"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 07:10:21 -0700
X-CSE-ConnectionGUID: bIai5QDATmO/rePK7PSFjw==
X-CSE-MsgGUID: +DbqFH/OSHuVCi95cDCDvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; d="scan'208";a="257185874"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO [10.245.245.175])
 ([10.245.245.175])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 07:10:09 -0700
Message-ID: <55a8612b-65af-4e15-ae5d-a27a55064f84@intel.com>
Date: Tue, 30 Jun 2026 15:10:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/xe: Avoid using stolen memory for DPT.
To: Maarten Lankhorst <dev@lankhorst.se>, intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
References: <20260630135523.1775379-1-dev@lankhorst.se>
 <20260630135523.1775379-2-dev@lankhorst.se>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260630135523.1775379-2-dev@lankhorst.se>
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
> memory when the GT is in MC6. Since we additionally aren't counting how
> much memory is used for stolen and we could in theory fill up the
> entire stolen area with DPT's, avoid using stolen and only use the
> default memory region.
> 
> Additionally, this may also result in random system hangs under load.
> 
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7513
> Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>

Fixes: 775d0adc01a5 ("drm/xe/fbdev: Limit the usage of stolen for LNL+")
Cc: <stable@vger.kernel.org> # v6.12+

?

> ---
>   drivers/gpu/drm/xe/display/xe_fb_pin.c | 33 +++++++-------------------
>   1 file changed, 8 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/display/xe_fb_pin.c b/drivers/gpu/drm/xe/display/xe_fb_pin.c
> index 5f4a0cd8deca0..73469ea5f333d 100644
> --- a/drivers/gpu/drm/xe/display/xe_fb_pin.c
> +++ b/drivers/gpu/drm/xe/display/xe_fb_pin.c
> @@ -164,31 +164,14 @@ static int __xe_pin_fb_vma_dpt(struct drm_gem_object *obj,
>   		dpt_size = ALIGN(intel_rotation_info_size(&view->rotated) * 8,
>   				 XE_PAGE_SIZE);
>   
> -	if (IS_DGFX(xe))
> -		dpt = xe_bo_create_pin_map_at_novm(xe, tile0,
> -						   dpt_size, ~0ull,
> -						   ttm_bo_type_kernel,
> -						   XE_BO_FLAG_VRAM0 |
> -						   XE_BO_FLAG_GGTT |
> -						   XE_BO_FLAG_PAGETABLE,
> -						   pin_params->alignment, false);
> -	else
> -		dpt = xe_bo_create_pin_map_at_novm(xe, tile0,
> -						   dpt_size,  ~0ull,
> -						   ttm_bo_type_kernel,
> -						   XE_BO_FLAG_STOLEN |
> -						   XE_BO_FLAG_GGTT |
> -						   XE_BO_FLAG_PAGETABLE,
> -						   pin_params->alignment, false);
> -	if (IS_ERR(dpt))
> -		dpt = xe_bo_create_pin_map_at_novm(xe, tile0,
> -						   dpt_size,  ~0ull,
> -						   ttm_bo_type_kernel,
> -						   XE_BO_FLAG_SYSTEM |
> -						   XE_BO_FLAG_GGTT |
> -						   XE_BO_FLAG_PAGETABLE |
> -						   XE_BO_FLAG_FORCE_WC,
> -						   pin_params->alignment, false);

Technically this changes the behaviour for dgpu, where it looks like it 
will fall back to system memory? Surprised that would even work though, 
and not get a bunch of pipe errors? I would assume VRAM is a requirement.

Either keeping the same behaviour, or updating the commit to mention 
this change, or splitting that out (maybe needs a separate fixes?),
Reviewed-by: Matthew Auld <matthew.auld@intel.com>

> +	dpt = xe_bo_create_pin_map_at_novm(xe, tile0,
> +					   dpt_size,  ~0ull,
> +					   ttm_bo_type_kernel,
> +					   XE_BO_FLAG_VRAM_IF_DGFX(tile0) |
> +					   XE_BO_FLAG_GGTT |
> +					   XE_BO_FLAG_PAGETABLE |
> +					   XE_BO_FLAG_FORCE_WC,
> +					   pin_params->alignment, false);
>   	if (IS_ERR(dpt))
>   		return PTR_ERR(dpt);
>   

