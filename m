Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E63B4C79F85
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:12:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1150A10FAFF;
	Fri,  4 Sep 2026 12:12:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="eYS+/eog";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5F9B10FAFE;
 Fri,  4 Sep 2026 12:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788523931; x=1820059931;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=5GxNU/TgSCVz28OGCaasO2Pr4ZyUnJk0hLLNjCHf9Xc=;
 b=eYS+/eogoR0eaL40yeChXmcTWwaHfxehbv1MS1WbOHC+d8m1fgH0VC9H
 9ODApBub03o/ODTEYnvpQ1OhVjCMfn2l7khiGAFtvcCqnTg0OZeuqI3w7
 0GITChMdpwpYnCygkjVQpDJXN8yz+oe735WQ65C2o3pF5NDezgFfjJJQQ
 0YePCEzjockvFJ8Z4n5QDY8m015KBztQoV8wMMU80FhVfuorhWAr6n2To
 GvF8W17Qly3hRDii6yEE1H41oit+jICjoNXyd80w72wwVEoqxOFcc1keH
 fx+uGL2ZGcra4H9RZ4EvVwDuA6uOfIwxl7EjdBzrFw2p8oM2GFYtWYBvE w==;
X-CSE-ConnectionGUID: e12b3cA1SPK6eS3mgEdt6w==
X-CSE-MsgGUID: sjs4t0uEQnmoCGbzx4r0Hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="92722149"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; d="scan'208";a="92722149"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 05:12:11 -0700
X-CSE-ConnectionGUID: wSvr6RlXQce7GjpNnsMxeQ==
X-CSE-MsgGUID: 4b1YNG61R7mHu8UTh438EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; d="scan'208";a="270010741"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.29])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 05:12:08 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Hemanth Selam <hemanth.selam@gmail.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/2] drm/i915: fix typos in comments
In-Reply-To: <20260904120225.15868-2-hemanth.selam@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260904120225.15868-1-hemanth.selam@gmail.com>
 <20260904120225.15868-2-hemanth.selam@gmail.com>
Date: Fri, 04 Sep 2026 15:12:05 +0300
Message-ID: <744758b82712dba9acff294a7b0a520667919c4b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Fri, 04 Sep 2026, Hemanth Selam <hemanth.selam@gmail.com> wrote:
> Fix typos in comments, reported by scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Only touches comments, no code
> changes.
>
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/gpu/drm/i915/display/icl_dsi.c      | 2 +-
>  drivers/gpu/drm/i915/display/intel_hdcp.c   | 2 +-
>  drivers/gpu/drm/i915/display/intel_hdmi.c   | 4 ++--
>  drivers/gpu/drm/i915/display/intel_vdsc.c   | 2 +-
>  drivers/gpu/drm/i915/display/intel_vrr.c    | 2 +-
>  drivers/gpu/drm/i915/display/skl_scaler.c   | 2 +-
>  drivers/gpu/drm/i915/display/vlv_dsi.c      | 2 +-
>  drivers/gpu/drm/i915/gem/i915_gem_context.c | 2 +-
>  drivers/gpu/drm/i915/gt/intel_migrate.c     | 2 +-
>  9 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/icl_dsi.c b/drivers/gpu/drm/i915/display/icl_dsi.c
> index ea0cdb7822f3..d2b1a0b68260 100644
> --- a/drivers/gpu/drm/i915/display/icl_dsi.c
> +++ b/drivers/gpu/drm/i915/display/icl_dsi.c
> @@ -958,7 +958,7 @@ gen11_dsi_set_transcoder_timings(struct intel_encoder *encoder,
>  	/* TRANS_HSYNC register to be programmed only for video mode */
>  	if (is_vid_mode(intel_dsi)) {
>  		if (intel_dsi->video_mode == NON_BURST_SYNC_PULSE) {
> -			/* BSPEC: hsync size should be atleast 16 pixels */
> +			/* BSPEC: hsync size should be at least 16 pixels */
>  			if (hsync_size < 16)
>  				drm_err(display->drm,
>  					"hsync size < 16 pixels\n");
> diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c b/drivers/gpu/drm/i915/display/intel_hdcp.c
> index e56df337dc6d..0003dd7b106b 100644
> --- a/drivers/gpu/drm/i915/display/intel_hdcp.c
> +++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
> @@ -787,7 +787,7 @@ int intel_hdcp_auth_downstream(struct intel_connector *connector)
>  
>  	/*
>  	 * When V prime mismatches, DP Spec mandates re-read of
> -	 * V prime atleast twice.
> +	 * V prime at least twice.
>  	 */
>  	for (i = 0; i < tries; i++) {
>  		ret = intel_hdcp_validate_v_prime(connector, shim,
> diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
> index 8a019d3574df..59af06443476 100644
> --- a/drivers/gpu/drm/i915/display/intel_hdmi.c
> +++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
> @@ -3234,7 +3234,7 @@ intel_hdmi_dsc_get_num_slices(const struct intel_crtc_state *crtc_state,
>  #define HDMI_DSC_PEAK_PIXEL_RATE		2720000
>  /*
>   * Rates at which the source and sink are required to process pixels in each
> - * slice, can be two levels: either atleast 340000KHz or atleast 40000KHz.
> + * slice, can be two levels: either at least 340000KHz or at least 40000KHz.
>   */
>  #define HDMI_DSC_MAX_ENC_THROUGHPUT_0		340000
>  #define HDMI_DSC_MAX_ENC_THROUGHPUT_1		400000
> @@ -3267,7 +3267,7 @@ intel_hdmi_dsc_get_num_slices(const struct intel_crtc_state *crtc_state,
>  
>  	/*
>  	 * As per spec, the rate at which the source and the sink process
> -	 * the pixels per slice are at two levels: atleast 340Mhz or 400Mhz.
> +	 * the pixels per slice are at two levels: at least 340Mhz or 400Mhz.
>  	 * This depends upon the pixel clock rate and output formats
>  	 * (kslice adjust).
>  	 * If pixel clock * kslice adjust >= 2720MHz slices can be processed
> diff --git a/drivers/gpu/drm/i915/display/intel_vdsc.c b/drivers/gpu/drm/i915/display/intel_vdsc.c
> index 8f06c3a4d56d..e61808dc2ce6 100644
> --- a/drivers/gpu/drm/i915/display/intel_vdsc.c
> +++ b/drivers/gpu/drm/i915/display/intel_vdsc.c
> @@ -378,7 +378,7 @@ int intel_dsc_compute_params(struct intel_crtc_state *pipe_config)
>  
>  	/*
>  	 * From XE_LPD onwards we supports compression bpps in steps of 1
> -	 * upto uncompressed bpp-1, hence add calculations for all the rc
> +	 * up to uncompressed bpp-1, hence add calculations for all the rc
>  	 * parameters
>  	 *
>  	 * We don't want to calculate all rc parameters when the panel
> diff --git a/drivers/gpu/drm/i915/display/intel_vrr.c b/drivers/gpu/drm/i915/display/intel_vrr.c
> index 51e4f3309b8b..4e1e849ab150 100644
> --- a/drivers/gpu/drm/i915/display/intel_vrr.c
> +++ b/drivers/gpu/drm/i915/display/intel_vrr.c
> @@ -46,7 +46,7 @@ bool intel_vrr_is_capable(struct intel_connector *connector)
>  	/*
>  	 * DP Sink is capable of VRR video timings if
>  	 * Ignore MSA bit is set in DPCD.
> -	 * EDID monitor range also should be atleast 10 for reasonable
> +	 * EDID monitor range also should be at least 10 for reasonable
>  	 * Adaptive Sync or Variable Refresh Rate end user experience.
>  	 */
>  	switch (connector->base.connector_type) {
> diff --git a/drivers/gpu/drm/i915/display/skl_scaler.c b/drivers/gpu/drm/i915/display/skl_scaler.c
> index 7994b983d509..066fb0587aa3 100644
> --- a/drivers/gpu/drm/i915/display/skl_scaler.c
> +++ b/drivers/gpu/drm/i915/display/skl_scaler.c
> @@ -194,7 +194,7 @@ skl_update_scaler(struct intel_crtc_state *crtc_state, bool force_detach,
>  
>  	/*
>  	 * if plane is being disabled or scaler is no more required or force detach
> -	 *  - free scaler binded to this plane/crtc
> +	 *  - free scaler bound to this plane/crtc
>  	 *  - in order to do this, update crtc->scaler_usage
>  	 *
>  	 * Here scaler state in crtc_state is set free so that
> diff --git a/drivers/gpu/drm/i915/display/vlv_dsi.c b/drivers/gpu/drm/i915/display/vlv_dsi.c
> index 8829f365592e..693084164713 100644
> --- a/drivers/gpu/drm/i915/display/vlv_dsi.c
> +++ b/drivers/gpu/drm/i915/display/vlv_dsi.c
> @@ -1028,7 +1028,7 @@ static void bxt_dsi_get_pipe_config(struct intel_encoder *encoder,
>  	adjusted_mode_sw = &crtc->config->hw.adjusted_mode;
>  
>  	/*
> -	 * Atleast one port is active as encoder->get_config called only if
> +	 * At least one port is active as encoder->get_config called only if
>  	 * encoder->get_hw_state() returns true.
>  	 */
>  	for_each_dsi_port(port, intel_dsi->ports) {
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
> index c58ffa5a8fa6..ee9d2991f162 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
> @@ -1378,7 +1378,7 @@ static struct intel_engine_cs *active_engine(struct intel_context *ce)
>  	list_for_each_entry_reverse(rq, &ce->timeline->requests, link) {
>  		bool found;
>  
> -		/* timeline is already completed upto this point? */
> +		/* timeline is already completed up to this point? */
>  		if (!i915_request_get_rcu(rq))
>  			break;
>  
> diff --git a/drivers/gpu/drm/i915/gt/intel_migrate.c b/drivers/gpu/drm/i915/gt/intel_migrate.c
> index aff5aca591e6..86927e0c76e2 100644
> --- a/drivers/gpu/drm/i915/gt/intel_migrate.c
> +++ b/drivers/gpu/drm/i915/gt/intel_migrate.c
> @@ -643,7 +643,7 @@ calculate_chunk_sz(struct drm_i915_private *i915, bool src_is_lmem,
>  {
>  	if (ccs_bytes_to_cpy && !src_is_lmem)
>  		/*
> -		 * When CHUNK_SZ is passed all the pages upto CHUNK_SZ
> +		 * When CHUNK_SZ is passed all the pages up to CHUNK_SZ
>  		 * will be taken for the blt. in Flat-ccs supported
>  		 * platform Smem obj will have more pages than required
>  		 * for main memory hence limit it to the required size

-- 
Jani Nikula, Intel
