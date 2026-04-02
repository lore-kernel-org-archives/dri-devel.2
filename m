Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB187CC6B2D
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 08:19:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23C2F10EFC9;
	Thu,  2 Apr 2026 08:19:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Z/EaZFLE";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4D9610E310;
 Thu,  2 Apr 2026 08:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775117966; x=1806653966;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=1d3BmPZrUBlbrz3Z4wSwtGcuhuLTtci9Yk7rgvEG+UY=;
 b=Z/EaZFLE5m23Itpf36hTvfmyG+l5db53ZCWZi3Hata596gd56CUOyRtk
 ssUeqVyEKeeSgbbcX4Afe3Gz5vm6ubpvgbOT6aUtLGQjwtRG9wyWVuiHs
 2c3FFbtO7Bi8lW1R9JRdFT2bCmBjbpA+BwhyGVjZ60RSnluoMGWext4fc
 Miz2duHqD9ceTtzi4dwpQC1uUdc2m18xUm797AaQfkN+Au5E0Nc7nt7XI
 lsKpJsBFrei+CTu11jzsxcfj7sDa1P/L8qDUF8GLo7rcoXq8Y1Q/cYmbz
 GteAUHbLoypPa39/tnbiOuqP+zOgyEKOsryh6S8TEopSStW0dnvNnxs2H g==;
X-CSE-ConnectionGUID: zeHYCX6VQx2ftYuowmrJDA==
X-CSE-MsgGUID: uIWcoGQWQ3uW4IFnBKyNVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="78764391"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="78764391"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 01:19:25 -0700
X-CSE-ConnectionGUID: 1IlHI7kFR/W3lnhiyqIi1g==
X-CSE-MsgGUID: zoC5wpoOSNCgX4ffqQjprg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="226886881"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 01:19:23 -0700
Date: Thu, 2 Apr 2026 10:19:19 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com, andrealmeid@igalia.com,
 christian.koenig@amd.com, airlied@gmail.com, simona.vetter@ffwll.ch,
 mripard@kernel.org, anshuman.gupta@intel.com,
 badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com
Subject: Re: [PATCH v2 4/5] drm/xe: Add handler for power management unit
 errors which require cold-reset
Message-ID: <ac4mh_Izd06T0hUF@black.igk.intel.com>
References: <20260318064016.374656-7-mallesh.koujalagi@intel.com>
 <20260318064016.374656-11-mallesh.koujalagi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318064016.374656-11-mallesh.koujalagi@intel.com>
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

On Wed, Mar 18, 2026 at 12:10:21PM +0530, Mallesh Koujalagi wrote:
> This handler is designed to be called when power management unit errors are
> detected that affect device-level state persisting across warm resets. The
> cold reset recovery method signals to userspace that only a complete device
> power cycle can restore normal operation.
> 
> v2:
> - Add use case: Handling errors from power management unit,
>   which requires a complete power cycle (cold reset)
>   to recover. (Christian)
> 
> Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_hw_error.c | 27 +++++++++++++++++++++++++++
>  drivers/gpu/drm/xe/xe_hw_error.h |  1 +
>  drivers/gpu/drm/xe/xe_ras.c      |  3 ++-
>  3 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_hw_error.c b/drivers/gpu/drm/xe/xe_hw_error.c
> index 2a31b430570e..ca965a2b092c 100644
> --- a/drivers/gpu/drm/xe/xe_hw_error.c
> +++ b/drivers/gpu/drm/xe/xe_hw_error.c
> @@ -5,6 +5,7 @@
>  
>  #include <linux/bitmap.h>
>  #include <linux/fault-inject.h>

Blank line to distinguish between linux and drm includes.

> +#include <drm/drm_drv.h>
>  
>  #include "regs/xe_gsc_regs.h"
>  #include "regs/xe_hw_error_regs.h"
> @@ -542,6 +543,32 @@ static void process_hw_errors(struct xe_device *xe)
>  	}
>  }
>  
> +/**
> + * xe_punit_error_handler - Handler for power management unit errors
> + * @xe: device instance
> + *
> + * Handles power management unit errors that affect the device and cannot
> + * be recovered through driver reload, PCIe reset, etc.
> + *
> + * Marks the device as wedged with DRM_WEDGE_RECOVERY_COLD_RESET method
> + * and notifies userspace that a complete device power cycle is required.
> + */
> +void xe_punit_error_handler(struct xe_device *xe)
> +{
> +	drm_err(&xe->drm, "CRITICAL: PMU error detected\n");
> +	drm_err(&xe->drm, "Recovery: Device cold reset required\n");

The caller is already printing these so we'd want to avoid dmesg spam.

> +	/* Set cold reset recovery method */

Comments are more useful for something that's not obvious from the code,
so we try to make the code as self documenting as possible.

> +	xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_COLD_RESET);
> +
> +	if (xe_device_wedged(xe)) {

We should not be at this point if the device is already wedged, so I
believe this needs to be handled somewhere upstream.

> +		drm_dev_wedged_event(&xe->drm, xe->wedged.method, NULL);
> +	} else {
> +		/* Declare device wedged - will trigger uevent with cold reset method */

Same as above.

Raag

> +		xe_device_declare_wedged(xe);
> +	}
> +}
> +
>  /**
>   * xe_hw_error_init - Initialize hw errors
>   * @xe: xe device instance
> diff --git a/drivers/gpu/drm/xe/xe_hw_error.h b/drivers/gpu/drm/xe/xe_hw_error.h
> index d86e28c5180c..f588320eb94d 100644
> --- a/drivers/gpu/drm/xe/xe_hw_error.h
> +++ b/drivers/gpu/drm/xe/xe_hw_error.h
> @@ -11,5 +11,6 @@ struct xe_tile;
>  struct xe_device;
>  
>  void xe_hw_error_irq_handler(struct xe_tile *tile, const u32 master_ctl);
> +void xe_punit_error_handler(struct xe_device *xe);
>  void xe_hw_error_init(struct xe_device *xe);
>  #endif
> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
> index 777321021391..93257d0eaaa0 100644
> --- a/drivers/gpu/drm/xe/xe_ras.c
> +++ b/drivers/gpu/drm/xe/xe_ras.c
> @@ -10,6 +10,7 @@
>  #include "xe_survivability_mode.h"
>  #include "xe_sysctrl_mailbox.h"
>  #include "xe_sysctrl_mailbox_types.h"
> +#include "xe_hw_error.h"
>  
>  #define COMPUTE_ERROR_SEVERITY_MASK		GENMASK(26, 25)
>  #define GLOBAL_UNCORR_ERROR			2
> @@ -148,7 +149,7 @@ static enum xe_ras_recovery_action handle_soc_internal_errors(struct xe_device *
>  			xe_err(xe, "[RAS]: PUNIT %s error detected: 0x%x\n",
>  			       severity_to_str(xe, common_info.severity),
>  			       ieh_error->error_sources_ieh0.punit);
> -			/** TODO: Add PUNIT error handling */
> +			xe_punit_error_handler(xe);
>  			action = XE_RAS_RECOVERY_ACTION_DISCONNECT;
>  		}
>  	}
> -- 
> 2.34.1
> 
