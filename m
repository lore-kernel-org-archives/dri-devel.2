Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E540C43602
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:33:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6681D10EEB7;
	Wed,  1 Jul 2026 10:33:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ECoaTzTp";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AF8410EEB7;
 Wed,  1 Jul 2026 10:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782902035; x=1814438035;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=l2X9mO+zhcfhMk+7+AdQB+baUA2fHIBJYRO5p3euPV4=;
 b=ECoaTzTpLv61AkmKVg/rPv1iEGpHNxS3I28HlDphix3djpafYuqHh7W4
 RK9MmnW7C6h+MkZMQqzu2RKNPrcP2KGLfwkL+xvVAM36HijRBq4lfGU9y
 yrYzWa52lrJxaPIRnaX7hbUdCpK5ANKbVqJyIkrQo47GsTt4k0Q6CM4U7
 EgcuqCqG8qBTegM/p9UEGugfxEDOONJ/uk2P4vbOPauj/3JsoIuVXGBSG
 1YxDwURCF+MRU/lM/z5c0Kg3YsjeFq99/U894jQJttUieDU1AF/yhSb/R
 ZcrfTnrR/LgSTOARkcMk+iycDLS3PKFx8mR1vFLk+Y1lQz+4ODVvsgvn8 w==;
X-CSE-ConnectionGUID: lmYaMwaxQbmH3XU2UtRp3g==
X-CSE-MsgGUID: SXD/WDJkRuWDL/yegHGUWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="101173570"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; d="scan'208";a="101173570"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 03:33:55 -0700
X-CSE-ConnectionGUID: CA6BjeK4SwayZv4nf/dPEg==
X-CSE-MsgGUID: QwXRXagXRoWrHw6oYLeDpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; d="scan'208";a="246172846"
Received: from vpanait-mobl.ger.corp.intel.com (HELO [10.245.244.86])
 ([10.245.244.86])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 03:33:54 -0700
Message-ID: <9c677ba6-eb09-443e-8fbe-7bfc4efae913@intel.com>
Date: Wed, 1 Jul 2026 11:33:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/xe/display: Do not allocate into stolen for new
 framebuffers.
To: Maarten Lankhorst <dev@lankhorst.se>, intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
References: <20260630135523.1775379-1-dev@lankhorst.se>
 <20260630135523.1775379-4-dev@lankhorst.se>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260630135523.1775379-4-dev@lankhorst.se>
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
> Prefer to use system memory for global framebuffers, and reserve
> the space for FBC use only.
> 
> Now that multiple CRTC's can use FBC's, the simple heuristic
> of using less than half of stolen is no longer sufficient.

I think worth mentioning that we have major issues around stolen + CPU 
access on xe2+?

> 
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7513
> Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>

Reviewed-by: Matthew Auld <matthew.auld@intel.com>

> ---
>   drivers/gpu/drm/xe/display/xe_display_bo.c | 33 ++++------------------
>   1 file changed, 6 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/display/xe_display_bo.c b/drivers/gpu/drm/xe/display/xe_display_bo.c
> index 677ae3af9ac0c..04d4204b37a53 100644
> --- a/drivers/gpu/drm/xe/display/xe_display_bo.c
> +++ b/drivers/gpu/drm/xe/display/xe_display_bo.c
> @@ -154,33 +154,12 @@ static struct drm_gem_object *xe_display_bo_fbdev_create(struct drm_device *drm,
>   	struct xe_device *xe = to_xe_device(drm);
>   	struct xe_bo *obj;
>   
> -	obj = ERR_PTR(-ENODEV);
> -
> -	if (xe_display_bo_fbdev_prefer_stolen(xe, size)) {
> -		obj = xe_bo_create_pin_map_novm(xe, xe_device_get_root_tile(xe),
> -						size,
> -						ttm_bo_type_kernel,
> -						XE_BO_FLAG_FORCE_WC |
> -						XE_BO_FLAG_STOLEN |
> -						XE_BO_FLAG_GGTT,
> -						false);
> -		if (!IS_ERR(obj))
> -			drm_info(&xe->drm, "Allocated fbdev into stolen\n");
> -		else
> -			drm_info(&xe->drm, "Allocated fbdev into stolen failed: %li\n", PTR_ERR(obj));
> -	} else {
> -		drm_info(&xe->drm, "Allocating fbdev: Stolen memory not preferred.\n");
> -	}
> -
> -	if (IS_ERR(obj)) {
> -		obj = xe_bo_create_pin_map_novm(xe, xe_device_get_root_tile(xe), size,
> -						ttm_bo_type_kernel,
> -						XE_BO_FLAG_FORCE_WC |
> -						XE_BO_FLAG_VRAM_IF_DGFX(xe_device_get_root_tile(xe)) |
> -						XE_BO_FLAG_GGTT,
> -						false);
> -	}
> -
> +	obj = xe_bo_create_pin_map_novm(xe, xe_device_get_root_tile(xe), size,
> +					ttm_bo_type_kernel,
> +					XE_BO_FLAG_FORCE_WC |
> +					XE_BO_FLAG_VRAM_IF_DGFX(xe_device_get_root_tile(xe)) |
> +					XE_BO_FLAG_GGTT,
> +					false);
>   	if (IS_ERR(obj)) {
>   		drm_err(&xe->drm, "failed to allocate framebuffer (%pe)\n", obj);
>   		return ERR_PTR(-ENOMEM);

