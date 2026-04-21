Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E20F327CB
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 09:11:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68AA410E84A;
	Tue, 21 Apr 2026 09:11:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cmTw0LhU";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77F6E10E84A;
 Tue, 21 Apr 2026 09:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776762691; x=1808298691;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=mnwpL4y6Mdd42590d3gsQ4oqbDJrrMAz7DPyPqfAXWE=;
 b=cmTw0LhU/BB9L2NFQxDvlNcW2LRiU5bu+Awj8DD3g26YX0cs6t1T4rHy
 g4nFZx8L7d5D/ShRlHh7Z/TX0lSvhMTQzYxpX0zYrMxKxAQdhLqGPg7qy
 l/rLD7w0VccN66FE5Cxpdnrq8GbddZC3cSkN1HpPf70h9F55sTi50IjZK
 E5rzJPhNNZYKbsPLRVfW9ZoTzejDrLX0P4saxdl3K2/zqzM1yYAUd8z/9
 VzihWr7jKIa8j84T+/k2SQ/BVDYrCZDRJvNk4WClPeNRILfkoLTGwI7F6
 FjIyCryYXNL9aEq2LAWDN6lLE3ZjtWMDWxceYygxPAQ8Q3QYG5A81Ucli g==;
X-CSE-ConnectionGUID: oYtkICVcSBmUzbb+q7gB7A==
X-CSE-MsgGUID: jRumMSN0TFKulbY5/cQGBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="88768423"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; d="scan'208";a="88768423"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2026 02:11:31 -0700
X-CSE-ConnectionGUID: V3GEpISJTqK/ISIA5Osw4A==
X-CSE-MsgGUID: 0qykHbosRPGcL7Z7HcF45Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; d="scan'208";a="227347597"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2026 02:11:27 -0700
Date: Tue, 21 Apr 2026 11:11:25 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com, andrealmeid@igalia.com,
 christian.koenig@amd.com, airlied@gmail.com, simona.vetter@ffwll.ch,
 mripard@kernel.org, anshuman.gupta@intel.com,
 badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com
Subject: Re: [PATCH v4 4/4] drm/xe: Handle PUNIT errors by requesting
 cold-reset recovery
Message-ID: <aec_PYDi46m6RmfY@black.igk.intel.com>
References: <20260413133013.560239-6-mallesh.koujalagi@intel.com>
 <20260413133013.560239-10-mallesh.koujalagi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413133013.560239-10-mallesh.koujalagi@intel.com>
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

On Mon, Apr 13, 2026 at 07:00:18PM +0530, Mallesh Koujalagi wrote:
> When PUNIT (power management unit) errors are detected that persist across
> warm resets, mark the device as wedged with DRM_WEDGE_RECOVERY_COLD_RESET
> and notify userspace that a complete device power cycle is required to
> restore normal operation.
> 
> v3:
> - Use PUNIT instead of PMU. (Riana)
> - Use consistent wordingi.
> - Remove log. (Raag)
> 
> v4:
> - Make function static. (Raag)
> 
> Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_ras.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
> index 437811845c01..653be0c67864 100644
> --- a/drivers/gpu/drm/xe/xe_ras.c
> +++ b/drivers/gpu/drm/xe/xe_ras.c
> @@ -5,6 +5,7 @@
>  
>  #include "xe_assert.h"
>  #include "xe_device_types.h"
> +#include "xe_device.h"
>  #include "xe_printk.h"
>  #include "xe_ras.h"
>  #include "xe_ras_types.h"
> @@ -93,6 +94,22 @@ static enum xe_ras_recovery_action handle_compute_errors(struct xe_device *xe,
>  	return XE_RAS_RECOVERY_ACTION_RECOVERED;
>  }
>  
> +/**
> + * xe_punit_error_handler - Handler for Punit errors requiring cold reset
> + * @xe: device instance
> + *
> + * Handles Punit errors that affect the device and cannot be recovered
> + * through driver reload, PCIe reset, etc.
> + *
> + * Marks the device as wedged with DRM_WEDGE_RECOVERY_COLD_RESET method
> + * and notifies userspace that a device cold reset is required.
> + */

I don't believe we need kdoc for static function.

> +static void xe_punit_error_handler(struct xe_device *xe)

There're also some discussions around not using xe_ prefix for static
functions but ofcourse it's a personal preference.

Raag

> +{
> +	xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_COLD_RESET);
> +	xe_device_declare_wedged(xe);
> +}
> +
>  static enum xe_ras_recovery_action handle_soc_internal_errors(struct xe_device *xe,
>  							      struct xe_ras_error_array *arr)
>  {
> @@ -132,7 +149,7 @@ static enum xe_ras_recovery_action handle_soc_internal_errors(struct xe_device *
>  			xe_err(xe, "[RAS]: PUNIT %s error detected: 0x%x\n",
>  			       severity_to_str(xe, common.severity),
>  			       ieh_error->global_error_status);
> -			/** TODO: Add PUNIT error handling */
> +			xe_punit_error_handler(xe);
>  			return XE_RAS_RECOVERY_ACTION_DISCONNECT;
>  		}
>  	}
> -- 
> 2.34.1
> 
