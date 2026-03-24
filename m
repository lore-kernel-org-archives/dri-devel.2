Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BEEDFEC10C
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 20:20:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D01910E17B;
	Tue, 24 Mar 2026 20:20:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IliEOg+C";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39E5510E06D;
 Tue, 24 Mar 2026 20:20:27 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id DA60342B38;
 Tue, 24 Mar 2026 20:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300E5C19424;
 Tue, 24 Mar 2026 20:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774383626;
 bh=jqs8FgFqkKhigzwvQapiQPQa1IQGevSk8rRRBaNo7OQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=IliEOg+C3Ye1hGyVE6JZfnppSZQx39HO5wE1lQqZlRTk8g71yy86QqLa3MNhQy63J
 W4kSNQj9ek9PSH/xRqIF2dAIY+n2aZa7ieqDeEr2wWJeiDBBeXD91vYZsBnUSvPox4
 6EALOFF3A9hnLly8/KG+YfoyQfCRrSDlvhOSJkA8bsKnLIBt5T3lhehSmjSMJblnt7
 2pvam5KtIqGAh+tBLlI77KIT/cwSxlNR3HVXaMNm7ekNbYlEb8R4xHB2qKtvIUaJXB
 3vCa7zCwg6PV7zCTpNrem/wKYl40TF1sqPPJDtjgTYoF05IYMGngulZGV/Hld3oq/4
 5vrD2UW4cucyw==
Message-ID: <5d601bdc-48b4-43dc-a49b-014c956b963c@kernel.org>
Date: Tue, 24 Mar 2026 15:20:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] drm/vblank: Add drm_crtc_vblank_is_off() helper
To: sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, simona@ffwll.ch, airlied@gmail.com,
 jani.nikula@linux.intel.com, ville.syrjala@linux.intel.com
References: <20260323202755.315929-1-sunpeng.li@amd.com>
 <20260323202755.315929-2-sunpeng.li@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260323202755.315929-2-sunpeng.li@amd.com>
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



On 3/23/26 15:27, sunpeng.li@amd.com wrote:
> From: Leo Li <sunpeng.li@amd.com>
> 
> Add and use an drm internal helper to check if vblanks have been turned
> off (via drm_crtc_vblank_off()) for a CRTC, rather than relying on the
> return value of drm_crtc_vblank_get().
> 
> This is in preparation of introducing deferred vblank enable/disable, as
> vblank_get() will not return the expected error code when the driver
> defers vblank enable.
> 
> No functional change is intended.
> 
I have two trivial nits below, you can include my tag with next version 
or just fix them when committing if everything else turns out reviewed OK.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Signed-off-by: Leo Li <sunpeng.li@amd.com>
> ---
>   drivers/gpu/drm/drm_atomic_helper.c | 11 +++++------
>   drivers/gpu/drm/drm_internal.h      |  1 +
>   drivers/gpu/drm/drm_vblank.c        | 17 +++++++++++++++++
>   3 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 26953ed6b53e8..102937e3ff35b 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -48,6 +48,7 @@
>   
>   #include "drm_crtc_helper_internal.h"
>   #include "drm_crtc_internal.h"
> +#include "drm_internal.h"
>   
>   /**
>    * DOC: overview
> @@ -1259,7 +1260,7 @@ drm_atomic_helper_commit_crtc_disable(struct drm_device *dev, struct drm_atomic_
>   
>   	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
>   		const struct drm_crtc_helper_funcs *funcs;
> -		int ret;
> +		bool vblank_off;
>   
>   		/* Shut down everything that needs a full modeset. */
>   		if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
> @@ -1287,19 +1288,17 @@ drm_atomic_helper_commit_crtc_disable(struct drm_device *dev, struct drm_atomic_
>   		if (!drm_dev_has_vblank(dev))
>   			continue;
>   
> -		ret = drm_crtc_vblank_get(crtc);
> +		vblank_off = drm_crtc_vblank_is_off(crtc);
>   		/*
>   		 * Self-refresh is not a true "disable"; ensure vblank remains
>   		 * enabled.
>   		 */
>   		if (new_crtc_state->self_refresh_active)
> -			WARN_ONCE(ret != 0,
> +			WARN_ONCE(vblank_off,
>   				  "driver disabled vblank in self-refresh\n");
>   		else
> -			WARN_ONCE(ret != -EINVAL,
> +			WARN_ONCE(!vblank_off,
>   				  "driver forgot to call drm_crtc_vblank_off()\n");
> -		if (ret == 0)
> -			drm_crtc_vblank_put(crtc);
>   	}
>   }
>   EXPORT_SYMBOL(drm_atomic_helper_commit_crtc_disable);
> diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
> index f893b1e3a596e..7d10515fe2ed5 100644
> --- a/drivers/gpu/drm/drm_internal.h
> +++ b/drivers/gpu/drm/drm_internal.h
> @@ -131,6 +131,7 @@ static inline void drm_vblank_destroy_worker(struct drm_vblank_crtc *vblank)
>   int drm_vblank_worker_init(struct drm_vblank_crtc *vblank);
>   void drm_vblank_cancel_pending_works(struct drm_vblank_crtc *vblank);
>   void drm_handle_vblank_works(struct drm_vblank_crtc *vblank);
> +bool drm_crtc_vblank_is_off(struct drm_crtc *crtc);
>   
>   /* IOCTLS */
>   int drm_wait_vblank_ioctl(struct drm_device *dev, void *data,
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index f78bf37f1e0a7..983c131b23694 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -2318,3 +2318,20 @@ void drm_crtc_vblank_get_vblank_timeout(struct drm_crtc *crtc, ktime_t *vblank_t
>   	*vblank_time = ktime_sub(*vblank_time, vtimer->interval);
>   }
>   EXPORT_SYMBOL(drm_crtc_vblank_get_vblank_timeout);
> +
> +/**
> + * drm_crtc_vblank_is_off - check if vblank is off on a CRTC
> + * @crtc: CRTC in question
> + *
> + * Return true if vblanks is currently turned off via drm_crtc_vblank_off().
> + * Return False otherwise.

nit1: you should be consistent with case of true/False
nit2: vblank not vblanks

> + */
> +bool drm_crtc_vblank_is_off(struct drm_crtc *crtc)
> +{
> +	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
> +
> +	/* Spinlock adds the necessary barriers */
> +	guard(spinlock_irqsave)(&crtc->dev->vbl_lock);
> +	return vblank->inmodeset && !vblank->enabled;
> +}
> +EXPORT_SYMBOL(drm_crtc_vblank_is_off);

