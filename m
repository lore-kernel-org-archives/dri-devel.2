Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E58606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jglmAG3j
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C63C710E7F6;
	Wed, 18 Nov 2026 15:14:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 409C910E7EC;
 Wed, 18 Nov 2026 15:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795014850; x=1826550850;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=1iW6nN7YOnkW3F0Xhc6/Dv1Kz4h+ANti5XBxydiznDM=;
 b=jglmAG3jM0eURuEWMzkMD1oqWbDZvRx5Yvce/cwqvXAKqIwOpuEe8V4L
 Hh9L1EOZWU8BW2uuSsvGOwVZUJsuYNkGMNqS4IBS3u7/cdov9wKHcbvr+
 YNADSJPXXvtw6iHwcBv1fQz0Hj3BhilztvpT82bMRAc+VnRfYe1PO0cTp
 u7qSVyJgweOFTyA8myQYovQfz4n42iJPCCgjtLJXi6Eym4IXdjRLFR1lX
 KP+YkskTeyPsky+bo6QbdCrI9JYfUMiJBbrpw9AcTgWvFP9c/xuXihjvd
 qy5nkggQC26iHghaVn6S+ac3qlNTjbkL5teXBiSpfo6WbpZ3sYWpPqehG Q==;
X-CSE-ConnectionGUID: XrGwgV/AQEa/ecW9b/HjMQ==
X-CSE-MsgGUID: ffn+T4m5QD6ZbDjOx+Qm1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3714692"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3714692"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 07:13:34 -0800
X-CSE-ConnectionGUID: prrTxY8DQbixivXi/AfIEg==
X-CSE-MsgGUID: wQlzZOB8Q3iipYzP+Zdogw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10567526"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.16])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 07:13:31 -0800
Date: Wed, 18 Nov 2026 17:13:28 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
 Harry.Wentland@amd.com, Sunpeng.Li@amd.com, tzimmermann@suse.de
Subject: Re: [PATCH RESEND 1/5] drm/client: Make the FBIO_WAITFORVSYNC vblank
 wait interruptible
Message-ID: <av3AmHw484cJZjd9@intel.com>
References: <20261111085534.514957-1-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261111085534.514957-1-Prike.Liang@amd.com>
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

On Wed, Nov 11, 2026 at 04:55:30PM +0800, Prike Liang wrote:
> FBIO_WAITFORVSYNC calls drm_client_modeset_wait_for_vblank(), which
> waits with drm_crtc_wait_one_vblank(). That wait is uninterruptible and
> only gives up after one second. If no vblank interrupt arrives, for
> example while the driver resets the display hardware, the caller sleeps
> in D state for the whole second and can't be interrupted, not even by
> SIGKILL.
> 
> DRM_IOCTL_WAIT_VBLANK waits interruptibly, and so do fbdev drivers that
> implement FBIO_WAITFORVSYNC themselves, such as atyfb and matroxfb.
> 
> Add drm_crtc_wait_one_vblank_interruptible(), a DRM-internal variant of
> drm_crtc_wait_one_vblank() that a signal can interrupt, and use it in
> drm_client_modeset_wait_for_vblank(). Return -ERESTARTSYS when a signal
> interrupts the wait, so that the ioctl returns to userspace or is
> restarted. Timeouts and disabled CRTCs are still not reported.
> 
> The fbdev damage worker also calls drm_client_modeset_wait_for_vblank(),
> but it runs in a kernel thread, which doesn't receive signals, so its
> wait doesn't change. Drivers keep using drm_crtc_wait_one_vblank().
> 
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Assisted-by: Copilot:claude-opus-5.5
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/drm_client_modeset.c | 10 +++--
>  drivers/gpu/drm/drm_internal.h       |  1 +
>  drivers/gpu/drm/drm_vblank.c         | 60 ++++++++++++++++++++--------
>  3 files changed, 51 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
> index 0080a8e9556a..b475b8dbdb17 100644
> --- a/drivers/gpu/drm/drm_client_modeset.c
> +++ b/drivers/gpu/drm/drm_client_modeset.c
> @@ -1301,10 +1301,11 @@ EXPORT_SYMBOL(drm_client_modeset_dpms);
>   *
>   * Block the caller until the given CRTC has seen a VBLANK. Do nothing
>   * if the CRTC is disabled. If there's another DRM master present, fail
> - * with -EBUSY.
> + * with -EBUSY. A signal interrupts the wait.
>   *
>   * Returns:
> - * 0 on success, or negative error code otherwise.
> + * 0 on success, -ERESTARTSYS if a signal interrupted the wait, or
> + * negative error code otherwise.
>   */
>  int drm_client_modeset_wait_for_vblank(struct drm_client_dev *client, unsigned int crtc_index)
>  {
> @@ -1328,13 +1329,14 @@ int drm_client_modeset_wait_for_vblank(struct drm_client_dev *client, unsigned i
>  	 */
>  	ret = drm_crtc_vblank_get(crtc);
>  	if (!ret) {
> -		drm_crtc_wait_one_vblank(crtc);
> +		ret = drm_crtc_wait_one_vblank_interruptible(crtc);
>  		drm_crtc_vblank_put(crtc);
>  	}
>  
>  	drm_master_internal_release(dev);
>  
> -	return 0;
> +	/* Only report interruption by a signal, not timeouts. */
> +	return ret == -ERESTARTSYS ? ret : 0;
>  }
>  EXPORT_SYMBOL(drm_client_modeset_wait_for_vblank);

You should probably split this patch into two:
1. add drm_crtc_wait_one_vblank_interruptible()
2. use it in drm_client_modeset_wait_for_vblank()

>  
> diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
> index f893b1e3a596..2be21c20eb78 100644
> --- a/drivers/gpu/drm/drm_internal.h
> +++ b/drivers/gpu/drm/drm_internal.h
> @@ -115,6 +115,7 @@ void drm_vblank_disable_and_save(struct drm_device *dev, unsigned int pipe);
>  int drm_vblank_get(struct drm_device *dev, unsigned int pipe);
>  void drm_vblank_put(struct drm_device *dev, unsigned int pipe);
>  u64 drm_vblank_count(struct drm_device *dev, unsigned int pipe);
> +int drm_crtc_wait_one_vblank_interruptible(struct drm_crtc *crtc);
>  
>  /* drm_vblank_work.c */
>  static inline void drm_vblank_flush_worker(struct drm_vblank_crtc *vblank)
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index f90fb2d13e42..c3c9afc08ed2 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -1297,21 +1297,12 @@ void drm_crtc_vblank_put(struct drm_crtc *crtc)
>  }
>  EXPORT_SYMBOL(drm_crtc_vblank_put);
>  
> -/**
> - * drm_crtc_wait_one_vblank - wait for one vblank
> - * @crtc: DRM crtc
> - *
> - * This waits for one vblank to pass on @crtc, using the irq driver interfaces.
> - * It is a failure to call this when the vblank irq for @crtc is disabled, e.g.
> - * due to lack of driver support or because the crtc is off.
> - *
> - * Returns: 0 on success, negative error on failures.
> - */
> -int drm_crtc_wait_one_vblank(struct drm_crtc *crtc)
> +static int __drm_crtc_wait_one_vblank(struct drm_crtc *crtc, bool interruptible)
>  {
>  	struct drm_device *dev = crtc->dev;
>  	int pipe = drm_crtc_index(crtc);
>  	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
> +	long timeout = msecs_to_jiffies(1000);
>  	int ret;
>  	u64 last;
>  
> @@ -1322,18 +1313,55 @@ int drm_crtc_wait_one_vblank(struct drm_crtc *crtc)
>  
>  	last = drm_vblank_count(dev, pipe);
>  
> -	ret = wait_event_timeout(vblank->queue,
> -				 last != drm_vblank_count(dev, pipe),
> -				 msecs_to_jiffies(1000));
> +	if (interruptible)
> +		timeout = wait_event_interruptible_timeout(vblank->queue,
> +							   last != drm_vblank_count(dev, pipe),
> +							   timeout);
> +	else
> +		timeout = wait_event_timeout(vblank->queue,
> +					     last != drm_vblank_count(dev, pipe),
> +					     timeout);
>  
> -	drm_WARN(dev, ret == 0, "vblank wait timed out on crtc %i\n", pipe);
> +	drm_WARN(dev, timeout == 0, "vblank wait timed out on crtc %i\n", pipe);
>  
>  	drm_vblank_put(dev, pipe);
>  
> -	return ret ? 0 : -ETIMEDOUT;
> +	if (timeout < 0)
> +		return timeout;
> +
> +	return timeout ? 0 : -ETIMEDOUT;
> +}
> +
> +/**
> + * drm_crtc_wait_one_vblank - wait for one vblank
> + * @crtc: DRM crtc
> + *
> + * This waits for one vblank to pass on @crtc, using the irq driver interfaces.
> + * It is a failure to call this when the vblank irq for @crtc is disabled, e.g.
> + * due to lack of driver support or because the crtc is off.
> + *
> + * Returns: 0 on success, negative error on failures.
> + */
> +int drm_crtc_wait_one_vblank(struct drm_crtc *crtc)
> +{
> +	return __drm_crtc_wait_one_vblank(crtc, false);
>  }
>  EXPORT_SYMBOL(drm_crtc_wait_one_vblank);
>  
> +/**
> + * drm_crtc_wait_one_vblank_interruptible - wait for one vblank, interruptibly
> + * @crtc: DRM crtc
> + *
> + * Like drm_crtc_wait_one_vblank(), but a signal interrupts the wait.
> + *
> + * Returns: 0 on success, -ERESTARTSYS if a signal interrupted the wait,
> + * negative error on other failures.
> + */
> +int drm_crtc_wait_one_vblank_interruptible(struct drm_crtc *crtc)
> +{
> +	return __drm_crtc_wait_one_vblank(crtc, true);
> +}
> +
>  /**
>   * drm_crtc_vblank_off - disable vblank events on a CRTC
>   * @crtc: CRTC in question
> -- 
> 2.34.1

-- 
Ville Syrjälä
Intel
