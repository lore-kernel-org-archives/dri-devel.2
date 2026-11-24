Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BEB606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hkKA6FFo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39B5410E86C;
	Tue, 24 Nov 2026 13:29:49 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EE2710E86C;
 Tue, 24 Nov 2026 13:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795526984; x=1827062984;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=c2gprbatkDkjYlfhP4QoOH0ysl7PoIXsOMTosccR5XQ=;
 b=hkKA6FFoadOWWuDi1i3z/UuEQfL7LMM/avr6SJRTJGsxxBKj8OE9sSji
 kTlC5rfig6h1weDHx0vieVuai2fHy5OvNeNuRJsiOQzfurrYM4KkECytF
 p+i+MkwH94h0HGYnBs1Ww+fTABmA17P2D/ENS84/DJgTZqoVQVtp9RT8L
 s49i/Zp8vWp8WjBtMmO5pviWrzvFnDIW6w6lW7XhEno9BfNyG/ODOW2IY
 rJWH5WUzry3qW3McMPXFtKvOhqdwAAQlYubvFTSPWq5Z9RFHblpc/ajia
 IoueBf8nzjkvl0ONa+6rwQfRbkn+E70RvMgG8xbvq/W4yaXT5B3NREy6p Q==;
X-CSE-ConnectionGUID: flXxI2hnR0ayCisIpkQ69w==
X-CSE-MsgGUID: aVyCarDmSRWuE1ExNcntBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4259395"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4259395"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 05:29:28 -0800
X-CSE-ConnectionGUID: Jyf2vyQwTiOC0hCS5q451A==
X-CSE-MsgGUID: YsZaICDlS2qE/IiSA82shg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; d="scan'208";a="11576104"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.100])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 05:29:18 -0800
Date: Tue, 24 Nov 2026 15:29:15 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 6/6] drm/i915: Carry the current state over created states
Message-ID: <awWRK6MkcmPNAdUy@intel.com>
References: <20261124-drm-i915-conversion-state-readout-v1-0-b7132f72644d@kernel.org>
 <20261124-drm-i915-conversion-state-readout-v1-6-b7132f72644d@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261124-drm-i915-conversion-state-readout-v1-6-b7132f72644d@kernel.org>
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 11:59:56AM +0100, Maxime Ripard wrote:
> The states of an atomic commit usually come from
> intel_crtc_duplicate_state(), which carries the whole current state
> over. The upcoming DRM_MODE_ATOMIC_RESET flag of the atomic ioctl
> builds its commits out of states created through atomic_create_state()
> instead: those come pristine, with only the uapi properties userspace
> applied on top of the defaults.
> 
> A CRTC that stays enabled across such a commit, because userspace
> re-applies the same configuration, takes the nomodeset path of
> intel_atomic_check(): that path only updates the color management
> part of the hw state and relies on everything else having been carried
> over by the duplicate. Without the carry-over, the pipe mode, the
> transcoder, the DPLL, the scaler bookkeeping and all the other derived
> state would be zeroed on a CRTC the hardware keeps driving, and the
> scaler staging would fail to find a free scaler for the planes still
> using one.

I think you'll just want to force a full state recomputation for
a commit that resets everything.

> 
> Carry the current state over the created ones like a duplicate would,
> keeping the uapi state userspace just configured. A created state is
> told apart from a duplicated one through its invalid transcoder: the
> state of an active CRTC always holds a valid one, a duplicate carries
> it over, and a created state comes reset.
> 
> The planes get the same treatment for their scaler assignment: the
> scaler staging frees the scaler of a plane through the new state, and
> assigns it one when it still needs scaling, both of which need the
> assignment the current state holds. Carry the scaler id over when the
> current state has one and the new state doesn't.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/i915/display/intel_display.c | 114 +++++++++++++++++++++++++++
>  1 file changed, 114 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
> index 1172e48daf23..d645203104a7 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> @@ -6517,10 +6517,120 @@ static int intel_atomic_check_config_and_link(struct intel_atomic_state *state)
>  			break;
>  	}
>  
>  	return ret;
>  }
> +/*
> + * intel_atomic_carry_over_state - carry the current state over created states
> + * @state: atomic state
> + *
> + * The states of a commit usually come from intel_crtc_duplicate_state(),
> + * which carries the whole current state over. The upcoming
> + * DRM_MODE_ATOMIC_RESET flag of the atomic ioctl builds its commits out
> + * of states created through atomic_create_state() instead: those come
> + * pristine, with only the uapi properties userspace applied on top of
> + * the defaults.
> + *
> + * A CRTC that stays enabled across such a commit, because userspace
> + * re-applies the same configuration, takes the nomodeset path of
> + * intel_atomic_check(): that path only updates the color management
> + * part of the hw state and relies on everything else having been
> + * carried over by the duplicate. Take the current state over like a
> + * duplicate would, keeping the uapi state userspace just configured:
> + * without it, the pipe mode, the transcoder, the DPLL, the scaler
> + * bookkeeping and all the other derived state would be zeroed on a
> + * CRTC the hardware keeps driving.
> + *
> + * A created state is told apart from a duplicated one through its
> + * invalid transcoder: the state of an active CRTC always holds a valid
> + * one, a duplicate carries it over, and a created state comes reset.
> + *
> + * The planes need the same for their scaler assignment: the scaler
> + * staging frees the scaler of a plane through the new state, and
> + * assigns it one when it still needs scaling, both of which need the
> + * assignment the current state holds. A created plane state comes with
> + * none, and with the scaler still marked in use in the carried CRTC
> + * state, it could neither be freed nor replaced.
> + */
> +static int intel_atomic_carry_over_state(struct intel_atomic_state *state)
> +{
> +	struct intel_crtc_state *old_crtc_state, *new_crtc_state;
> +	struct intel_plane_state *old_plane_state, *new_plane_state;
> +	struct intel_crtc *crtc;
> +	struct intel_plane *plane;
> +	int i;
> +
> +	for_each_oldnew_intel_crtc_in_state(state, crtc, old_crtc_state,
> +					    new_crtc_state) {
> +		struct intel_crtc_state *carried_state;
> +
> +		if (new_crtc_state->cpu_transcoder != INVALID_TRANSCODER ||
> +		    !old_crtc_state->hw.active)
> +			continue;
> +
> +		carried_state = kmemdup(old_crtc_state, sizeof(*carried_state),
> +					GFP_KERNEL);
> +		if (!carried_state)
> +			return -ENOMEM;
> +
> +		/* Keep the uapi state userspace just configured. */
> +		carried_state->uapi = new_crtc_state->uapi;
> +
> +		intel_crtc_free_hw_state(new_crtc_state);
> +		if (new_crtc_state->dp_tunnel_ref.tunnel)
> +			drm_dp_tunnel_ref_put(&new_crtc_state->dp_tunnel_ref);
> +
> +		memcpy(new_crtc_state, carried_state, sizeof(*new_crtc_state));
> +		kfree(carried_state);
> +
> +		/* Take the references a duplicated state would carry. */
> +		if (new_crtc_state->hw.degamma_lut)
> +			drm_property_blob_get(new_crtc_state->hw.degamma_lut);
> +		if (new_crtc_state->hw.ctm)
> +			drm_property_blob_get(new_crtc_state->hw.ctm);
> +		if (new_crtc_state->hw.gamma_lut)
> +			drm_property_blob_get(new_crtc_state->hw.gamma_lut);
> +
> +		if (new_crtc_state->pre_csc_lut)
> +			drm_property_blob_get(new_crtc_state->pre_csc_lut);
> +		if (new_crtc_state->post_csc_lut)
> +			drm_property_blob_get(new_crtc_state->post_csc_lut);
> +
> +		if (new_crtc_state->dp_tunnel_ref.tunnel)
> +			drm_dp_tunnel_ref_get(new_crtc_state->dp_tunnel_ref.tunnel,
> +					      &new_crtc_state->dp_tunnel_ref);
> +
> +		/* Clear the transient flags, like a duplicate would. */
> +		new_crtc_state->update_pipe = false;
> +		new_crtc_state->update_m_n = false;
> +		new_crtc_state->update_lrr = false;
> +		new_crtc_state->disable_cxsr = false;
> +		new_crtc_state->update_wm_pre = false;
> +		new_crtc_state->update_wm_post = false;
> +		new_crtc_state->fifo_changed = false;
> +		new_crtc_state->preload_luts = false;
> +		new_crtc_state->wm.need_postvbl_update = false;
> +		new_crtc_state->do_async_flip = false;
> +		new_crtc_state->fb_bits = 0;
> +		new_crtc_state->update_planes = 0;
> +		new_crtc_state->dsb_color = NULL;
> +		new_crtc_state->dsb_commit = NULL;
> +		new_crtc_state->use_dsb = false;
> +		new_crtc_state->use_flipq = false;
> +	}
> +
> +	for_each_oldnew_intel_plane_in_state(state, plane, old_plane_state,
> +					      new_plane_state, i) {
> +		if (new_plane_state->scaler_id < 0 &&
> +		    old_plane_state->scaler_id >= 0)
> +			new_plane_state->scaler_id =
> +				old_plane_state->scaler_id;
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * intel_atomic_check - validate state object
>   * @dev: drm device
>   * @_state: state to validate
>   */
> @@ -6534,10 +6644,14 @@ int intel_atomic_check(struct drm_device *dev,
>  	int ret;
>  
>  	if (!intel_display_driver_check_access(display))
>  		return -ENODEV;
>  
> +	ret = intel_atomic_carry_over_state(state);
> +	if (ret)
> +		goto fail;
> +
>  	for_each_oldnew_intel_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state) {
>  		/*
>  		 * crtc's state no longer considered to be inherited
>  		 * after the first userspace/client initiated commit.
>  		 */
> 
> -- 
> 2.56.1

-- 
Ville Syrjälä
Intel
