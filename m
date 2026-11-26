Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FF2606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 00:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OfmokbOi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C3F110E399;
	Thu, 26 Nov 2026 00:21:40 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1D5310E088;
 Thu, 26 Nov 2026 00:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795652495; x=1827188495;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=hkiJGiwRcXnb4w74LW9UpBFzaihb56D3fn4wXyGoIBc=;
 b=OfmokbOi/sf0mDYlyS0gMiHweWvHrVeMLaAT++mF3pOxk2CYMT+c5OPU
 Q4E4OWUo6dhHGDsHer5dHSdEgH84mWNXMXXFbNuCpI94oOQPM1VPm1itd
 3okr5BEDHtOclj2nXrOtgkX0OHG+P/BdZkDGmN0H7shapMB5y3w8pabRp
 cA4Dz/sv/EXIC4ljOriuhHlhgXy/lwm/OI718My75iEb2RBztyer526y3
 esJ6yOFCikH9MShoXov9wXSbMsHDhC5w2MZBu0yw5ceoQCVCkHPBGfnMS
 p4tlj5M8kk1+HUKu5kc3hV67CNm9W5Q3Bsvzp40qIHf9bSgy1qTZQXlSm Q==;
X-CSE-ConnectionGUID: AwVlfAzVT+uB7Qxw0TU3Bg==
X-CSE-MsgGUID: ENtKQeArSwqGE/VsSQlOtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4451216"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4451216"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 16:21:34 -0800
X-CSE-ConnectionGUID: JJRyaS/4SKGzGuiNoL9Dsw==
X-CSE-MsgGUID: HzGLjwP6SsarKapxUwJPTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; d="scan'208";a="12047621"
Received: from inaky-mobl1.amr.corp.intel.com (HELO localhost)
 ([10.245.244.100])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 16:21:31 -0800
Date: Thu, 26 Nov 2026 02:21:27 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Hanson Wang <hanson.wang@ugreen.com>
Cc: intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
 rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
 tursulin@ursulin.net, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/i915/display: Refresh global state after
 non-atomic sanitization
Message-ID: <awd7hxapYj36Muid@intel.com>
References: <20261118033312.902366-1-hanson.wang@ugreen.com>
 <20261124142627.4082596-1-hanson.wang@ugreen.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261124142627.4082596-1-hanson.wang@ugreen.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 10:26:27PM +0800, Hanson Wang wrote:
> Hardware state readout accounts firmware planes in the global bandwidth
> state before sanitization. skl_dbuf_sanitize() may subsequently disable
> those planes through intel_plane_disable_noatomic(), which clears the
> CRTC-local plane data but leaves the global bandwidth entries unchanged.
> A later atomic check can see identical, already cleared old and new
> CRTC-local inputs and skip the global update. The stale data rate and
> plane count then remain part of the QGV bandwidth check.
> 
> The issue was reproduced on an N5105 system running mainline.
> After DBUF sanitization had cleared pipe B's local plane state,
> the global bandwidth state still accounted for 196000 kB/s and
> one plane.
> 
> Add intel_display_update_hw_state() to group the existing bandwidth,
> DBUF bandwidth and CDCLK state updates. Keep the initial update after
> hardware readout, and repeat it after intel_wm_sanitize(), once the
> non-atomic CRTC and plane sanitization is complete. Update DBUF bandwidth
> before CDCLK, which derives a minimum clock requirement from that state.
> 
> Also refresh the global state after intel_initial_plane_config(): failure
> to reconstruct a BIOS framebuffer can disable a primary plane after the
> main sanitization sequence has finished.
> 
> Reuse the existing accounting helpers so logically enabled but inactive
> CRTCs retain their memory bandwidth reservations.
> 
> Fixes: 15512021eb39 ("drm/i915: Workaround broken BIOS DBUF configuration on TGL/RKL")
> Suggested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Link: https://lore.kernel.org/intel-gfx/20261118033312.902366-1-hanson.wang@ugreen.com
> Signed-off-by: Hanson Wang <hanson.wang@ugreen.com>

Patchwork looks to be hopelessly confused about this series.
Please resend this again, not as a reply-to. Maybe then
patchwork will pick it up correctly and we can get CI to
test it.

> ---
> Changes in v2:
> - Add intel_display_update_hw_state() as suggested by Ville, reusing
>   the existing BW, DBUF bandwidth and CDCLK update helpers.
> - Refresh global accounting after the complete modeset sanitization
>   sequence, including intel_wm_sanitize(), instead of adding per-CRTC
>   update helpers to intel_plane_disable_noatomic().
> - Also cover non-atomic plane disable on BIOS framebuffer takeover
>   failure in intel_initial_plane_config().
> - Preserve the initial readout update and the existing intermediate
>   CRTC-disable bookkeeping used during sanitization.
> - Add a Fixes tag for the DBUF sanitization path.
> 
> Testing:
> - W=1 compilation of both changed C files for i915 and Xe display.
> - Strict checkpatch passed.
> - Boot-tested v2 on an affected N5105 system with HDMI connected,
>   based on 666539eecdf4 (7.4.0-rc3+). The original DBUF sanitization
>   path was reproduced, and pipe B's global accounting changed from
>   196000 kB/s and one plane to 0 kB/s and zero planes after
>   intel_wm_sanitize().
> - Post-boot inspection confirmed that pipe B contributed no bandwidth
>   or planes to the global BW and DBUF bandwidth states. Subsequent
>   QGV checks no longer included the stale contribution.
> - This was a v1-to-v2 boot test, not an unpatched-versus-patched
>   comparison.
> - The original high-bandwidth workload, HDMI hotplug, suspend/resume,
>   cold boot, enabled-but-inactive transitions and BIOS framebuffer
>   reconstruction failure were not tested with v2.
> 
>  .../drm/i915/display/intel_initial_plane.c    |  4 ++++
>  .../drm/i915/display/intel_modeset_setup.c    | 24 ++++++++++++++++---
>  .../drm/i915/display/intel_modeset_setup.h    |  1 +
>  3 files changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_initial_plane.c b/drivers/gpu/drm/i915/display/intel_initial_plane.c
> index 7427f41e4d7e..022798baf7e0 100644
> --- a/drivers/gpu/drm/i915/display/intel_initial_plane.c
> +++ b/drivers/gpu/drm/i915/display/intel_initial_plane.c
> @@ -15,6 +15,7 @@
>  #include "intel_fb.h"
>  #include "intel_frontbuffer.h"
>  #include "intel_initial_plane.h"
> +#include "intel_modeset_setup.h"
>  #include "intel_parent.h"
>  #include "intel_plane.h"
>  
> @@ -237,4 +238,7 @@ void intel_initial_plane_config(struct intel_display *display)
>  
>  		plane_config_fini(display, plane_config);
>  	}
> +
> +	/* Failure to reconstruct the BIOS framebuffer may disable a plane. */
> +	intel_display_update_hw_state(display);
>  }
> diff --git a/drivers/gpu/drm/i915/display/intel_modeset_setup.c b/drivers/gpu/drm/i915/display/intel_modeset_setup.c
> index 6aed88173770..bb8f3acd3595 100644
> --- a/drivers/gpu/drm/i915/display/intel_modeset_setup.c
> +++ b/drivers/gpu/drm/i915/display/intel_modeset_setup.c
> @@ -14,6 +14,7 @@
>  #include "i9xx_wm.h"
>  #include "intel_atomic.h"
>  #include "intel_bw.h"
> +#include "intel_cdclk.h"
>  #include "intel_cmtg.h"
>  #include "intel_color.h"
>  #include "intel_crtc.h"
> @@ -37,6 +38,22 @@
>  #include "intel_wm.h"
>  #include "skl_watermark.h"
>  
> +/**
> + * intel_display_update_hw_state - synchronize global display accounting
> + * @display: display instance
> + *
> + * Update the global state from the current CRTC and plane state during
> + * hardware state setup, with atomic commits excluded. Call this again
> + * after non-atomic sanitization has changed the local state.
> + */
> +void intel_display_update_hw_state(struct intel_display *display)
> +{
> +	intel_bw_update_hw_state(display);
> +	/* CDCLK requirements depend on the DBUF bandwidth state. */
> +	intel_dbuf_bw_update_hw_state(display);
> +	intel_cdclk_update_hw_state(display);
> +}
> +
>  static void intel_crtc_disable_noatomic_begin(struct intel_crtc *crtc,
>  					      struct drm_modeset_acquire_ctx *ctx)
>  {
> @@ -877,9 +894,7 @@ static void intel_modeset_readout_hw_state(struct intel_display *display)
>  	if (DISPLAY_VER(display) >= 9)
>  		intel_wm_get_hw_state(display);
>  
> -	intel_bw_update_hw_state(display);
> -	intel_dbuf_bw_update_hw_state(display);
> -	intel_cdclk_update_hw_state(display);
> +	intel_display_update_hw_state(display);
>  
>  	intel_pmdemand_init_pmdemand_params(display, pmdemand_state);
>  }
> @@ -995,6 +1010,9 @@ void intel_modeset_setup_hw_state(struct intel_display *display,
>  		intel_wm_get_hw_state(display);
>  	intel_wm_sanitize(display);
>  
> +	/* Sanitization may have disabled planes without an atomic commit. */
> +	intel_display_update_hw_state(display);
> +
>  	for_each_intel_crtc(display, crtc) {
>  		struct intel_crtc_state *crtc_state =
>  			to_intel_crtc_state(crtc->base.state);
> diff --git a/drivers/gpu/drm/i915/display/intel_modeset_setup.h b/drivers/gpu/drm/i915/display/intel_modeset_setup.h
> index f5e6f3ae9572..28a9165f7fca 100644
> --- a/drivers/gpu/drm/i915/display/intel_modeset_setup.h
> +++ b/drivers/gpu/drm/i915/display/intel_modeset_setup.h
> @@ -9,6 +9,7 @@
>  struct drm_modeset_acquire_ctx;
>  struct intel_display;
>  
> +void intel_display_update_hw_state(struct intel_display *display);
>  void intel_modeset_setup_hw_state(struct intel_display *display,
>  				  struct drm_modeset_acquire_ctx *ctx);
>  
> 
> base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
> -- 
> 2.34.1

-- 
Ville Syrjälä
Intel
