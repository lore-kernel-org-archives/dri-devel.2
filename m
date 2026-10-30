Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4105D606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 16:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fNqSrot5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68DE510E257;
	Fri, 30 Oct 2026 16:06:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C405510E257
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 16:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793376392; x=1824912392;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=2crQ5KYneZHm8LkgEjHqKfNRkrHORc64BZmm5OkwcKw=;
 b=fNqSrot5zxEYeME0rzRXIE7uFcIFwggH2G/RmxlhDfMMBrwvUqPdRZ66
 2tNVceL++6G9291wKY4IeupNIbobyYHFFCw/zWeMtSwKCQPfJ3Ls31tsI
 MLhNBuvVAWXSiu4t63pUtfb2r8b+/7lZIvyMs8APFeNqC2pESaxAvRJf/
 Q4kOx8sEbOGmi05tFPn1vuPDwP7JnI4g7CCEq1XjPJSOAo4O/hwO36vz3
 aw5bZcruvq0KpLcnfV1c8Bcg8U9FTJGsf5BLCEs2++IEwm8FNGmmfzYPL
 5YmXAR9ZByN5g/vEWK96fZI0FNKa4AY68QLShpwF4b47NCgcIMrC1Eqdo g==;
X-CSE-ConnectionGUID: KpmzgD5vR3Stss9sXunYKg==
X-CSE-MsgGUID: XGbqWl2CQda5bPOciRxR2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2148248"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2148248"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 09:06:31 -0700
X-CSE-ConnectionGUID: 6mN3PrxjTqCGU8Ws7YTM0Q==
X-CSE-MsgGUID: y1KqBAtQT/SquMXICG1vzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5482015"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.58])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 09:06:27 -0700
Date: Fri, 30 Oct 2026 18:06:23 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: me@romanilin.is, louis.chauvet@bootlin.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch, javierm@redhat.com,
 dmitry.osipenko@collabora.com, regressions@leemhuis.info,
 peter.m.arnesen@gmail.com, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v4] drm/vblank: Don't arm vblank timer with invalid frame
 duration
Message-ID: <auTAf4ul_xzhk44v@intel.com>
References: <20260914110004.211027-1-tzimmermann@suse.de>
 <auIMt8XmmaVykZTC@intel.com>
 <2c2f33cf-da6f-4e31-84bb-768778d7b063@suse.de>
 <auSIZNhP4DTj8Nb2@intel.com>
 <be8e41da-5ef1-4c37-a044-171ab1f32c6d@suse.de>
 <auSgII_W-FJJz44W@intel.com>
 <f406b2f6-cad9-411f-941a-7e4f26af3947@suse.de>
 <c874d311-f7b1-4a24-ab75-b502ba1c5e58@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c874d311-f7b1-4a24-ab75-b502ba1c5e58@suse.de>
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

On Fri, Oct 30, 2026 at 04:33:24PM +0100, Thomas Zimmermann wrote:
> 
> 
> Am 30.10.26 um 15:25 schrieb Thomas Zimmermann:
> [...]
> > How about we add a dedicated mode_fixup helper for vblank validation? 
> > It would run after new CRTC's mode_fixup callback. [1] There we could 
> > try to adapt the CRTC's adjusted_mode.  Since we know the bug exactly, 
> > we can try to detect it, fix it, and document it.
> >
> 
> The attached patch implements this idea. It does work in the sense that 
> it doesn't immediately break my testing setup.
> 
> Thorsten (or anyone else) could you please test if this patch also 
> resolve the bug with SPICE?
> 
> 
> 
> >>
> >
> 
> -- 
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
> GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)
> 

> From 2a76d04bfc3630c1d6bb79b3d64ecbcadf860090 Mon Sep 17 00:00:00 2001
> From: Roman Ilin <me@romanilin.is>
> Date: Thu, 2 Jul 2026 21:10:27 +0300
> Subject: [PATCH] drm/vblank: Don't arm vblank timer with invalid frame
>  duration
> 
> When a CRTC's display mode carries a too small pixel clock,
> drm_calc_timestamping_constants() computes a frame duration that
> exceeds INT_MAX. drm_vblank_crtc.framedur_ns becomes negative.
> drm_crtc_vblank_start_timer() then arms the vblank hrtimer with this
> interval, after which vblank events are no longer delivered. Pending
> page flips never complete and the display appears frozen.
> 
> This could be triggered on virtio-gpu guests that have dynamic resolution
> enabled: when the SPICE agent or the X server resizes the output, it
> submits a mode whose pixel clock is off by a factor of 1000, e.g.:
> 
>     clock = 406 kHz, htotal = 3152, vtotal = 2148
> 
>     framedur_ns = 3152 * 2148 * 1000000 / 406 = 16675852216 ns (~16.7 s)
> 
> 16675852216 does not fit into an int and wraps to roughly -504000000.
> ns_to_ktime() then yields a negative interval and the timer stops working.
> 
> Found by bisection, which pointed at commit a036f5fceedb ("drm/virtgpu:
> Use vblank timer"). That commit merely made virtio-gpu use the vblank
> timer and thereby exposed the pre-existing problem in the timer setup
> added by commit 74afeb812850 ("drm/vblank: Add vblank timer").
> 
> To fix this, introduce drm_crtc_vblank_mode_fixup() to detect and adjust
> the bogus pixel clock. The helper runs unconditionally at the beginning
> of the mode-fixup code. Drivers still have the opportunity to detect bogus
> adjustments in later mode-fixup steps.
> 
> v5:
> - fix up the broken pixel clock beforehand (Ville)
> v4:
> - avoid log spamming with drm_warn_once()
> 
> Fixes: 74afeb812850 ("drm/vblank: Add vblank timer")
> Signed-off-by: Roman Ilin <me@romanilin.is>
> 
> mode_fixup
> 
> Revert "drm/vblank: Don't arm vblank timer with invalid frame duration"
> 
> This reverts commit f3ca78682a4f9607444a3dafbe12ab6acdb1fa2f.
> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 11 +++++
>  drivers/gpu/drm/drm_vblank.c        | 68 +++++++++++++++++++++++++++++
>  include/drm/drm_vblank.h            |  2 +
>  3 files changed, 81 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 9d006f98413a..6a0f04a72292 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -432,6 +432,17 @@ mode_fixup(struct drm_atomic_commit *state)
>  			continue;
>  
>  		drm_mode_copy(&new_crtc_state->adjusted_mode, &new_crtc_state->mode);
> +
> +		if (!new_crtc_state->enable)
> +			continue;
> +
> +		ret = drm_crtc_vblank_mode_fixup(crtc, &new_crtc_state->mode,
> +						 &new_crtc_state->adjusted_mode);

We don't want this hack applied to all drivers. It's a problem
for a single driver, so that one driver should handle it.

> +		if (!ret) {
> +			drm_dbg_atomic(crtc->dev, "[CRTC:%d:%s] vblank fixup failed\n",
> +				       crtc->base.id, crtc->name);
> +			return -EINVAL;
> +		}
>  	}
>  
>  	for_each_new_connector_in_state(state, connector, new_conn_state, i) {
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index f90fb2d13e42..6e826c3b6c42 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -620,6 +620,74 @@ wait_queue_head_t *drm_crtc_vblank_waitqueue(struct drm_crtc *crtc)
>  }
>  EXPORT_SYMBOL(drm_crtc_vblank_waitqueue);
>  
> +static int drm_vblank_validate_dotclock(u16 crtc_htotal, u16 crtc_vtotal, u32 flags, int dotclock)
> +{
> +	unsigned int frame_size;
> +	u64 linedur_ns, framedur_ns;
> +
> +	if (dotclock <= 0)
> +		return -EINVAL;
> +
> +	frame_size = (unsigned int)crtc_htotal * (unsigned int)crtc_vtotal;
> +
> +	/*
> +	 * Convert scanline length in pixels and video dot clock to line duration
> +	 * and frame duration in nanoseconds.
> +	 */
> +	linedur_ns  = div_u64((u64)crtc_htotal * 1000000, dotclock);
> +	framedur_ns = div_u64((u64)frame_size * 1000000, dotclock);
> +
> +	/*
> +	 * Fields of interlaced scanout modes are only half a frame duration.
> +	 */
> +	if (flags & DRM_MODE_FLAG_INTERLACE)
> +		framedur_ns /= 2;
> +
> +	if (linedur_ns > INT_MAX || framedur_ns > INT_MAX)
> +		return -ERANGE; /* dot clock too low */
> +
> +	return 0;
> +}
> +
> +bool drm_crtc_vblank_mode_fixup(struct drm_crtc *crtc, const struct drm_display_mode *mode,
> +				struct drm_display_mode *adjusted_mode)
> +{
> +	struct drm_device *dev = crtc->dev;
> +	unsigned int pipe = drm_crtc_index(crtc);
> +	int dotclock = adjusted_mode->crtc_clock;
> +	int ret;
> +
> +	if (!drm_dev_has_vblank(dev))
> +		return true;
> +
> +	if (drm_WARN_ON(dev, pipe >= dev->num_crtcs))
> +		return false;
> +
> +	ret = drm_vblank_validate_dotclock(adjusted_mode->crtc_htotal,
> +					   adjusted_mode->crtc_vtotal,
> +					   adjusted_mode->flags, dotclock);
> +	if (ret == -ERANGE) {
> +		int dotclock_1000;
> +
> +		/*
> +		 * SPICE' vd_agent has a bug where it specifies the dot clock in kHz
> +		 * instead of Hz. Setting up a vblank interrupt or timer for such a
> +		 * mode overflows the calculation in drm_calc_timestamping_constants().
> +		 * An errno code of ERANGE specifically points to this problem. Try
> +		 * converting the dot clock to Hz and validate again.
> +		 */
> +		if (check_mul_overflow(dotclock, 1000, &dotclock_1000)) {
> +			ret = drm_vblank_validate_dotclock(adjusted_mode->crtc_htotal,
> +							   adjusted_mode->crtc_vtotal,
> +							   adjusted_mode->flags, dotclock_1000);
> +			if (!ret)
> +				adjusted_mode->crtc_clock = dotclock_1000;
> +		}
> +	}
> +
> +	return !ret;
> +}
> +EXPORT_SYMBOL(drm_crtc_vblank_mode_fixup);
>  
>  /**
>   * drm_calc_timestamping_constants - calculate vblank timestamp constants
> diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
> index 2fcef9c0f5b1..a3628c477f59 100644
> --- a/include/drm/drm_vblank.h
> +++ b/include/drm/drm_vblank.h
> @@ -311,6 +311,8 @@ void drm_crtc_vblank_on(struct drm_crtc *crtc);
>  u64 drm_crtc_accurate_vblank_count(struct drm_crtc *crtc);
>  void drm_crtc_vblank_restore(struct drm_crtc *crtc);
>  
> +bool drm_crtc_vblank_mode_fixup(struct drm_crtc *crtc, const struct drm_display_mode *mode,
> +				struct drm_display_mode *adjusted_mode);
>  void drm_calc_timestamping_constants(struct drm_crtc *crtc,
>  				     const struct drm_display_mode *mode);
>  wait_queue_head_t *drm_crtc_vblank_waitqueue(struct drm_crtc *crtc);
> -- 
> 2.56.0
> 


-- 
Ville Syrjälä
Intel
