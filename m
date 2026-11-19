Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B21B606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Vt3Wan/v
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D28481124A8;
	Thu, 19 Nov 2026 14:33:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7AE111249B;
 Thu, 19 Nov 2026 14:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795098806; x=1826634806;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=kOhm33GcgTYW6Cfl9gwTuTaUtVMzJ1SBn8qWmlLVokI=;
 b=Vt3Wan/vzGBwKfx6zaTusCyfGxo4N50xveTG/shGzVQPzRfeHCgEw6JT
 /9vzc/07oGIvZLeHGcil1nKLwixkHkO9cLmk3IFB000EIvnEBvqgNgLdE
 OTic4menqP5qgjPfMGYXVsnXKEg3+WV72vXIayMjN/pqjdIOOuoC5sD0y
 A0cpnY7IpAjMKuadmgfZaEG0XZV+n9L+vc9OueBh6BTM6KXeQJkL+T1H4
 5FNaZuG7cLwhtoKS5eO98I9dt8EEAdPtaOvKT6KZuakybyIQlO74XGJJG
 yaXSKvAVmm5hgYt3oAe1tIdfmo3im4ud8Izq4pjXCrdPxZ99vdGk6RUfN w==;
X-CSE-ConnectionGUID: XO7HzKZ0R8iCoT+B0JT5SQ==
X-CSE-MsgGUID: TbFiKxG8T36lTy062KbGrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3975973"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3975973"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 06:33:25 -0800
X-CSE-ConnectionGUID: wtIXX9LKTzukTINbZ0E2VQ==
X-CSE-MsgGUID: lA7SShAxQOOv1AkBwqzamg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; d="scan'208";a="10578482"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.54])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 06:33:22 -0800
Date: Thu, 19 Nov 2026 16:33:19 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
 Harry.Wentland@amd.com, Sunpeng.Li@amd.com, tzimmermann@suse.de
Subject: Re: [PATCH v2 2/5] drm/vblank: Add
 drm_crtc_wait_one_vblank_interruptible()
Message-ID: <av8Ir1li1-eeoTcQ@intel.com>
References: <20261119082424.554841-1-Prike.Liang@amd.com>
 <20261119082424.554841-2-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261119082424.554841-2-Prike.Liang@amd.com>
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

On Thu, Nov 19, 2026 at 04:24:21PM +0800, Prike Liang wrote:
> drm_crtc_wait_one_vblank() waits uninterruptibly and only gives up after
> one second. That doesn't suit a wait that userspace asks for, such as
> FBIO_WAITFORVSYNC: if no vblank interrupt arrives, the task sleeps in D
> state for the whole second and can't be interrupted, not even by
> SIGKILL.
> 
> Add drm_crtc_wait_one_vblank_interruptible(), a DRM-internal variant of
> drm_crtc_wait_one_vblank() that a signal can interrupt. It returns
> -ERESTARTSYS in that case and otherwise behaves like
> drm_crtc_wait_one_vblank(), which includes ending the wait when vblank
> is turned off. Move the wait to __drm_crtc_wait_one_vblank(), which
> implements both functions.
> 
> drm_crtc_wait_one_vblank() doesn't change, and drivers keep using it.
> The new function has no user yet. The next patch uses it in
> drm_client_modeset_wait_for_vblank().
> 
> Version update:
> 1) https://lists.freedesktop.org/archives/dri-devel/2026-November/616727.html
> 
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Assisted-by: Copilot:claude-opus-5.5
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

> ---
>  drivers/gpu/drm/drm_internal.h |  1 +
>  drivers/gpu/drm/drm_vblank.c   | 64 ++++++++++++++++++++++++----------
>  2 files changed, 47 insertions(+), 18 deletions(-)
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
> index 54118eb1413c..5e247663978a 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -1297,22 +1297,12 @@ void drm_crtc_vblank_put(struct drm_crtc *crtc)
>  }
>  EXPORT_SYMBOL(drm_crtc_vblank_put);
>  
> -/**
> - * drm_crtc_wait_one_vblank - wait for one vblank
> - * @crtc: DRM crtc
> - *
> - * This waits for one vblank to pass on @crtc, using the irq driver interfaces.
> - * It is a failure to call this when the vblank irq for @crtc is disabled, e.g.
> - * due to lack of driver support or because the crtc is off. The wait also fails
> - * if drm_crtc_vblank_off() disables the vblank irq before a vblank passes.
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
> @@ -1323,14 +1313,22 @@ int drm_crtc_wait_one_vblank(struct drm_crtc *crtc)
>  
>  	last = drm_vblank_count(dev, pipe);
>  
> -	ret = wait_event_timeout(vblank->queue,
> -				 last != drm_vblank_count(dev, pipe) ||
> -				 !READ_ONCE(vblank->enabled),
> -				 msecs_to_jiffies(1000));
> +	if (interruptible)
> +		timeout = wait_event_interruptible_timeout(vblank->queue,
> +							   last != drm_vblank_count(dev, pipe) ||
> +							   !READ_ONCE(vblank->enabled),
> +							   timeout);
> +	else
> +		timeout = wait_event_timeout(vblank->queue,
> +					     last != drm_vblank_count(dev, pipe) ||
> +					     !READ_ONCE(vblank->enabled),
> +					     timeout);
>  
> -	drm_WARN(dev, ret == 0, "vblank wait timed out on crtc %i\n", pipe);
> +	drm_WARN(dev, timeout == 0, "vblank wait timed out on crtc %i\n", pipe);
>  
> -	if (!ret)
> +	if (timeout < 0)
> +		ret = timeout;
> +	else if (!timeout)
>  		ret = -ETIMEDOUT;
>  	else if (last == drm_vblank_count(dev, pipe))
>  		ret = -EINVAL; /* drm_crtc_vblank_off() ended the wait */
> @@ -1341,8 +1339,38 @@ int drm_crtc_wait_one_vblank(struct drm_crtc *crtc)
>  
>  	return ret;
>  }
> +
> +/**
> + * drm_crtc_wait_one_vblank - wait for one vblank
> + * @crtc: DRM crtc
> + *
> + * This waits for one vblank to pass on @crtc, using the irq driver interfaces.
> + * It is a failure to call this when the vblank irq for @crtc is disabled, e.g.
> + * due to lack of driver support or because the crtc is off. The wait also fails
> + * if drm_crtc_vblank_off() disables the vblank irq before a vblank passes.
> + *
> + * Returns: 0 on success, negative error on failures.
> + */
> +int drm_crtc_wait_one_vblank(struct drm_crtc *crtc)
> +{
> +	return __drm_crtc_wait_one_vblank(crtc, false);
> +}
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
