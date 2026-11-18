Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3908F606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 04:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Y6IEx5ou
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65F1210E4F8;
	Wed, 18 Nov 2026 04:38:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FA4D10E271;
 Wed, 18 Nov 2026 04:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794976710; x=1826512710;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=lEGmLiFPnr7cPZZSIE7NpgVKa/gGgyiJ8eU6d3Z1uXE=;
 b=Y6IEx5ouniEAethKLLn1hjofRtC3kjX16ofdYLiRxQqSetpvODUgRePO
 dZNmXU6FoTMiKqZiaTI/TP/xE9Iq517rHMt9yfJnYzhoeycrr5t2D2Tj7
 7G3NX8z4OmFjkm2cKtgDzmmxO5KC2oYCTAYk+4G1kOPbKvQHO9EvkVLJv
 5Zai1INW3rje5EXNbtkd7+olJrqunBJwJQjcwd5ufd+8RTHObl15W51Ki
 9fonjA+FFMBLNCtYF1k6KMsIF7S8bJm/O7yrB/Ub5PqKdFkKdXVAcuV0h
 VGPEWOdkwAYhv1ftvSZ3WPK7kCJZ6DSCcqUn4nO9ItejyKJlBXylAVC9z w==;
X-CSE-ConnectionGUID: Y+iqbKhJRt2+uQWJCwQiQQ==
X-CSE-MsgGUID: fV2jROzZSsuHKTtXTCmO1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3812805"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3812805"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 20:38:30 -0800
X-CSE-ConnectionGUID: oiHqSbkXR5uTXEKfPj2y5g==
X-CSE-MsgGUID: De7/jgGqQ8yWL3TmwBeqvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9893993"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.117])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 20:38:28 -0800
Date: Wed, 18 Nov 2026 06:38:24 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Hanson Wang <hanson.wang@ugreen.com>
Cc: intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
 rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
 tursulin@ursulin.net, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/i915/bw: sync global BW after non-atomic plane disable
Message-ID: <av0rwG6o5gzMXGDB@intel.com>
References: <20261118033312.902366-1-hanson.wang@ugreen.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261118033312.902366-1-hanson.wang@ugreen.com>
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

On Wed, Nov 18, 2026 at 11:33:12AM +0800, Hanson Wang wrote:
> Hardware readout copies the firmware plane configuration into the
> global bandwidth state. skl_dbuf_sanitize() may then disable those
> planes through intel_plane_disable_noatomic(), which clears the
> CRTC-local active_planes, data_rate and DDB entries but does not
> update the global state.
> 
> A later atomic modeset sees both the old and new per-CRTC bandwidth
> as zero and skips the global update. The sanitized pipe therefore
> keeps contributing a phantom data rate and an active plane to the
> QGV check.
> 
> Do not force !hw.active to zero. A logically enabled but inactive CRTC
> must retain its bandwidth reservation so that reactivating it cannot
> fail due to insufficient bandwidth. After the non-atomic disable,
> recompute the global intel_bw_state and the separate dbuf bandwidth
> state from the updated CRTC-local plane and DDB state.
> 
> Reproduced on two N5105 systems from different board vendors running
> 6.18.15. After DBUF sanitization, pipe B retained 196000 kB/s and one
> plane in the global BW state despite its local plane state being
> cleared and the pipe subsequently being disabled.
> 
> With the corresponding fix backported to 6.18.15 on one system, the
> same sanitization path updated the global accounting to 0 kB/s and
> zero planes. Subsequent QGV checks no longer included the stale
> bandwidth.

I think what we might want to do is add a new
intel_display_update_hw_state() wrapper that calls all the
intel_foo_update_hw_state() functions. Then we just call that
after any disable_noatomic() stuff is done. Not sure if a single
call would be sufficient once we've sanitized everything, or if
we'd need to do a few extra calls during the sanitization
sequence.

And if we're missing any intel_foo_update_hw_state()
implementations then we should just add them.

> 
> Link: https://lore.kernel.org/intel-gfx/20261016014704.3876294-1-hanson.wang@ugreen.com
> 
> Signed-off-by: Hanson Wang <hanson.wang@ugreen.com>
> ---
> Testing:
> - The corresponding 6.18.15 backport was tested on one N5105 system.
> - This mainline version has not been runtime-tested.
> - The original high-bandwidth application failure was not replayed.
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_bw.c b/drivers/gpu/drm/i915/display/intel_bw.c
> index 99fd84a5ac13..84fe1f68e312 100644
> --- a/drivers/gpu/drm/i915/display/intel_bw.c
> +++ b/drivers/gpu/drm/i915/display/intel_bw.c
> @@ -1444,6 +1444,20 @@ static void intel_bw_crtc_update(struct intel_bw_state *bw_state,
>  		    bw_state->num_active_planes[crtc->pipe]);
>  }
>  
> +void intel_bw_crtc_update_noatomic(struct intel_crtc *crtc)
> +{
> +	struct intel_display *display = to_intel_display(crtc);
> +	struct intel_bw_state *bw_state =
> +		to_intel_bw_state(display->bw.obj.state);
> +	const struct intel_crtc_state *crtc_state =
> +		to_intel_crtc_state(crtc->base.state);
> +
> +	if (DISPLAY_VER(display) < 11)
> +		return;
> +
> +	intel_bw_crtc_update(bw_state, crtc_state);
> +}
> +
>  void intel_bw_update_hw_state(struct intel_display *display)
>  {
>  	struct intel_bw_state *bw_state =
> @@ -1456,12 +1470,9 @@ void intel_bw_update_hw_state(struct intel_display *display)
>  	bw_state->pipe_sagv_reject = 0;
>  
>  	for_each_intel_crtc(display, crtc) {
> -		const struct intel_crtc_state *crtc_state =
> -			to_intel_crtc_state(crtc->base.state);
>  		enum pipe pipe = crtc->pipe;
>  
> -		if (DISPLAY_VER(display) >= 11)
> -			intel_bw_crtc_update(bw_state, crtc_state);
> +		intel_bw_crtc_update_noatomic(crtc);
>  
>  		/* initially SAGV has been forced off */
>  		bw_state->pipe_sagv_reject |= BIT(pipe);
> diff --git a/drivers/gpu/drm/i915/display/intel_bw.h b/drivers/gpu/drm/i915/display/intel_bw.h
> index 99b447388245..41ace27608dc 100644
> --- a/drivers/gpu/drm/i915/display/intel_bw.h
> +++ b/drivers/gpu/drm/i915/display/intel_bw.h
> @@ -30,6 +30,7 @@ void intel_bw_init_hw(struct intel_display *display);
>  int intel_bw_init(struct intel_display *display);
>  int intel_bw_atomic_check(struct intel_atomic_state *state);
>  void intel_bw_update_hw_state(struct intel_display *display);
> +void intel_bw_crtc_update_noatomic(struct intel_crtc *crtc);
>  void intel_bw_crtc_disable_noatomic(struct intel_crtc *crtc);
>  
>  bool intel_bw_pmdemand_needs_update(struct intel_atomic_state *state);
> diff --git a/drivers/gpu/drm/i915/display/intel_dbuf_bw.c b/drivers/gpu/drm/i915/display/intel_dbuf_bw.c
> index 6cf674c586dc..453ceaa52e26 100644
> --- a/drivers/gpu/drm/i915/display/intel_dbuf_bw.c
> +++ b/drivers/gpu/drm/i915/display/intel_dbuf_bw.c
> @@ -226,21 +226,29 @@ int intel_dbuf_bw_calc_min_cdclk(struct intel_atomic_state *state,
>  	return 0;
>  }
>  
> -void intel_dbuf_bw_update_hw_state(struct intel_display *display)
> +void intel_dbuf_bw_crtc_update_noatomic(struct intel_crtc *crtc)
>  {
> +	struct intel_display *display = to_intel_display(crtc);
>  	struct intel_dbuf_bw_state *dbuf_bw_state =
>  		to_intel_dbuf_bw_state(display->dbuf_bw.obj.state);
> -	struct intel_crtc *crtc;
> +	const struct intel_crtc_state *crtc_state =
> +		to_intel_crtc_state(crtc->base.state);
>  
>  	if (DISPLAY_VER(display) < 9)
>  		return;
>  
> -	for_each_intel_crtc(display, crtc) {
> -		const struct intel_crtc_state *crtc_state =
> -			to_intel_crtc_state(crtc->base.state);
> +	skl_crtc_calc_dbuf_bw(&dbuf_bw_state->dbuf_bw[crtc->pipe], crtc_state);
> +}
>  
> -		skl_crtc_calc_dbuf_bw(&dbuf_bw_state->dbuf_bw[crtc->pipe], crtc_state);
> -	}
> +void intel_dbuf_bw_update_hw_state(struct intel_display *display)
> +{
> +	struct intel_crtc *crtc;
> +
> +	if (DISPLAY_VER(display) < 9)
> +		return;
> +
> +	for_each_intel_crtc(display, crtc)
> +		intel_dbuf_bw_crtc_update_noatomic(crtc);
>  }
>  
>  void intel_dbuf_bw_crtc_disable_noatomic(struct intel_crtc *crtc)
> diff --git a/drivers/gpu/drm/i915/display/intel_dbuf_bw.h b/drivers/gpu/drm/i915/display/intel_dbuf_bw.h
> index 61875b9d5969..434f3c605995 100644
> --- a/drivers/gpu/drm/i915/display/intel_dbuf_bw.h
> +++ b/drivers/gpu/drm/i915/display/intel_dbuf_bw.h
> @@ -32,6 +32,7 @@ int intel_dbuf_bw_calc_min_cdclk(struct intel_atomic_state *state,
>  int intel_dbuf_bw_min_cdclk(struct intel_display *display,
>  			    const struct intel_dbuf_bw_state *dbuf_bw_state);
>  void intel_dbuf_bw_update_hw_state(struct intel_display *display);
> +void intel_dbuf_bw_crtc_update_noatomic(struct intel_crtc *crtc);
>  void intel_dbuf_bw_crtc_disable_noatomic(struct intel_crtc *crtc);
>  
>  #endif /* __INTEL_DBUF_BW_H__ */
> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
> index b897678a93c0..b81d8f288810 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> @@ -67,6 +67,7 @@
>  #include "intel_cursor.h"
>  #include "intel_cursor_regs.h"
>  #include "intel_cx0_phy.h"
> +#include "intel_dbuf_bw.h"
>  #include "intel_ddi.h"
>  #include "intel_de.h"
>  #include "intel_dip.h"
> @@ -679,6 +680,14 @@ void intel_plane_disable_noatomic(struct intel_crtc *crtc,
>  
>  	skl_wm_plane_disable_noatomic(crtc, plane);
>  
> +	/*
> +	 * Keep the global bandwidth states in sync with the updated
> +	 * CRTC-local plane and DDB state. Otherwise a later atomic check
> +	 * may skip the update when its old and new inputs are identical.
> +	 */
> +	intel_bw_crtc_update_noatomic(crtc);
> +	intel_dbuf_bw_crtc_update_noatomic(crtc);
> +
>  	if ((crtc_state->active_planes & ~BIT(PLANE_CURSOR)) == 0 &&
>  	    hsw_ips_disable(crtc_state)) {
>  		crtc_state->ips_enabled = false;
> -- 
> 2.34.1

-- 
Ville Syrjälä
Intel
