Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB761CD3439
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 18:47:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0671610E1EE;
	Wed,  6 May 2026 18:47:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZxXcdMC/";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B90F10E1EE;
 Wed,  6 May 2026 18:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778093237; x=1809629237;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=3xpbKJPzqoU1Z63eak0Nx7FiPMzzURfEUudld2qqJTU=;
 b=ZxXcdMC/fatLn/BOtuZE5v7iCPX/572DkxaDDSPtG+Jzjas9GOVppDU2
 BAR59Q7IgDGBBWi8H0bfaM6aXo+OAgQGZQ0mVlrfxngkAQsovugEDDMBx
 578Z4PNLw88LzBI5df7m3JzCxZIIQDBXQpC7LQaiFRGB0KhLKdkJVfSIR
 i4c+grI9+NG9Xm7b8fttRjzvCLyUHDQxgLu40yj8ZWqmXwUK2t5FAlOXC
 9zLoIOZH7M5iRO1eETTZCA+5L3JpEGBlbbZOlmR4BA2I+XvO/9bCjt5Mk
 en5ykbxoOF4/TjJ7Zhcj9oLVU5/GJlpebGY6rDZBSr3t0iF9sVP4wnerV A==;
X-CSE-ConnectionGUID: HjhATKS+RC2ZdR2cBHTOVQ==
X-CSE-MsgGUID: UxZudTMBR2y8r4JjiHU0pA==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="66566774"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; d="scan'208";a="66566774"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 11:47:16 -0700
X-CSE-ConnectionGUID: h5WmaH2FTjeC1v/DIqpSdg==
X-CSE-MsgGUID: wyaab4rqQyeoF1LpeBAujA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; d="scan'208";a="236137464"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.47])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 11:47:09 -0700
Date: Wed, 6 May 2026 21:47:05 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Hamza Mahfooz <someguy@effective-light.com>
Cc: dri-devel@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Hung <alex.hung@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Ivan Lipski <ivan.lipski@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 Tom Chung <chiahsuan.chung@amd.com>, Roman Li <Roman.Li@amd.com>,
 Takashi Iwai <tiwai@suse.de>, Colin Ian King <colin.i.king@gmail.com>,
 Charlene Liu <charlene.liu@amd.com>, Kees Cook <kees@kernel.org>,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] drm/atomic: attempt full modeset on page flip
 timeout
Message-ID: <afuMqXoBt2oIFRm9@intel.com>
References: <20260505182105.420525-1-someguy@effective-light.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260505182105.420525-1-someguy@effective-light.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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

On Tue, May 05, 2026 at 02:20:57PM -0400, Hamza Mahfooz wrote:
> We should try to recover from page flip timeouts. Forcing
> a full modeset should be generic across all atomic KMS drivers,
> so try that first.
> 
> Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 49 +++++++++++++++++++++++++++--
>  1 file changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index a768398a1884..7ee9d52f63c5 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -1926,6 +1926,43 @@ drm_atomic_helper_wait_for_vblanks(struct drm_device *dev,
>  }
>  EXPORT_SYMBOL(drm_atomic_helper_wait_for_vblanks);
>  
> +static int force_full_modeset(struct drm_crtc *crtc)
> +{
> +	struct drm_modeset_acquire_ctx ctx;
> +	struct drm_crtc_state *crtc_state;
> +	struct drm_atomic_state *state;
> +	int ret;
> +	int err;
> +
> +	if (drm_atomic_crtc_needs_modeset(crtc->state))
> +		return -EBUSY;
> +
> +	DRM_MODESET_LOCK_ALL_BEGIN(crtc->dev, ctx, 0, err);
> +	state = drm_atomic_state_alloc(crtc->dev);
> +	if (!state)
> +		return -ENOMEM;
> +
> +	state->acquire_ctx = &ctx;
> +
> +	crtc_state = drm_atomic_get_crtc_state(state, crtc);
> +	if (IS_ERR(crtc_state)) {
> +		ret = PTR_ERR(crtc_state);
> +		goto out;
> +	}
> +
> +	crtc_state->mode_changed = true;
> +
> +	drm_info(crtc->dev,
> +		 "[CRTC:%d:%s] Attempting force full modeset...\n",
> +		 crtc->base.id, crtc->name);
> +
> +	ret = drm_atomic_commit(state);
> +out:
> +	drm_atomic_state_put(state);
> +	DRM_MODESET_LOCK_ALL_END(crtc->dev, ctx, err);
> +	return ret;
> +}
> +
>  /**
>   * drm_atomic_helper_wait_for_flip_done - wait for all page flips to be done
>   * @dev: DRM device
> @@ -1949,17 +1986,23 @@ void drm_atomic_helper_wait_for_flip_done(struct drm_device *dev,
>  
>  	for (i = 0; i < dev->mode_config.num_crtc; i++) {
>  		struct drm_crtc_commit *commit = state->crtcs[i].commit;
> -		int ret;
>  
>  		crtc = state->crtcs[i].ptr;
>  
>  		if (!crtc || !commit)
>  			continue;
>  
> -		ret = wait_for_completion_timeout(&commit->flip_done, 10 * HZ);
> -		if (ret == 0)
> +		if (!wait_for_completion_timeout(&commit->flip_done, 10 * HZ)) {
> +			int ret;
>  			drm_err(dev, "[CRTC:%d:%s] flip_done timed out\n",
>  				crtc->base.id, crtc->name);
> +
> +			ret = force_full_modeset(crtc);

This looks like some kind of ugly hack to paper over a driver bug.
I really don't want this for i915/xe because all it'll end up doing
is make it harder to debug any real issues.

> +			if (ret)
> +				drm_err(dev,
> +					"[CRTC:%d:%s] force full modeset failed! ret=%d\n",
> +					crtc->base.id, crtc->name, ret);
> +		}
>  	}
>  
>  	if (state->fake_commit)
> -- 
> 2.54.0

-- 
Ville Syrjälä
Intel
