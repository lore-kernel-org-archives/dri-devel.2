Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FA8606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aiAVOWKU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4001110FDD2;
	Wed, 18 Nov 2026 15:29:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAD2410FDD4;
 Wed, 18 Nov 2026 15:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795015789; x=1826551789;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=6Ohqi1RBdYZ0jXh1hA/p6C6U6t+xwRU+Av9bp9OlQl4=;
 b=aiAVOWKUMrvLTZU0VxfvW2Kjqa39kgeD/nyvgnutJ1lUJbskCcsQEE9+
 AbisAEfWpJIX959jgOdtEs7l6/PcnKDs+Tp5qhAsrycbO2J8gQAAqjM1j
 SjlK3hIMk5AyqtgVxid5x8/uhKr1Wk+Ocm+SGqjmd4hvomFekqduci9kl
 0+VYmvNffkLBCjV51c/Lviiu/90M+rVlp1dW/+0PdsQ+7sh7zO5Z5TQ+4
 DDYY458MEa2PC7Xwtr5CWPedVMmD7Kuq2/gtKNBwBEZ6PQmjrp5sPR5qz
 /+uJa1zno7cHFbcFMmQI37Vowv8a4swArBHn1flQXF8Qjqwndhgj3H4DI w==;
X-CSE-ConnectionGUID: x2hW8kIIScC0XISNr4mmaQ==
X-CSE-MsgGUID: 1L925QwpQteMLKT3DuePCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3871554"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3871554"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 07:29:48 -0800
X-CSE-ConnectionGUID: xi19Z2p/RnaelOriLfnHUg==
X-CSE-MsgGUID: HVFBmBlqSA29VA0lr5yEiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10106960"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.16])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 07:29:46 -0800
Date: Wed, 18 Nov 2026 17:29:42 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
 Harry.Wentland@amd.com, Sunpeng.Li@amd.com, tzimmermann@suse.de
Subject: Re: [PATCH RESEND 2/5] drm/vblank: Stop drm_crtc_wait_one_vblank()
 when vblank is turned off
Message-ID: <av3EZjSWFetO7U3e@intel.com>
References: <20261111085534.514957-1-Prike.Liang@amd.com>
 <20261111085534.514957-2-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261111085534.514957-2-Prike.Liang@amd.com>
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

On Wed, Nov 11, 2026 at 04:55:31PM +0800, Prike Liang wrote:
> drm_crtc_vblank_off() turns off the vblank interrupt even while someone
> holds a vblank reference and waits for a vblank. It then wakes up the
> vblank wait queue. DRM_IOCTL_WAIT_VBLANK stops waiting at this point,
> because its wait condition also checks whether vblank is still enabled.
> 
> drm_crtc_wait_one_vblank() and drm_crtc_wait_one_vblank_interruptible()
> only check whether the vblank count has changed. Once vblank is off, the
> count doesn't change, so the woken waiter sleeps again until the wait
> times out after one second and warns "vblank wait timed out". This
> happens, for example, when the fbdev damage worker or FBIO_WAITFORVSYNC
> waits for a vblank while the driver turns the CRTC off for suspend or a
> GPU reset.
> 
> Make __drm_crtc_wait_one_vblank(), which implements both functions, also
> stop waiting when vblank is turned off, and return -EINVAL if no vblank
> passed, the same error that drm_vblank_get() returns when vblank is off.
> The wait condition is checked before going to sleep, so this also covers
> vblank being turned off between drm_vblank_get() and the wait. Waits
> that see a vblank, time out or are interrupted behave as before.
> 
> Fixes: e8450f51a4b3 ("drm/irq: Implement a generic vblank_wait function")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Assisted-by: Copilot:claude-opus-5.5
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/drm_vblank.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index c3c9afc08ed2..5e247663978a 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -1315,21 +1315,29 @@ static int __drm_crtc_wait_one_vblank(struct drm_crtc *crtc, bool interruptible)
>  
>  	if (interruptible)
>  		timeout = wait_event_interruptible_timeout(vblank->queue,
> -							   last != drm_vblank_count(dev, pipe),
> +							   last != drm_vblank_count(dev, pipe) ||
> +							   !READ_ONCE(vblank->enabled),
>  							   timeout);
>  	else
>  		timeout = wait_event_timeout(vblank->queue,
> -					     last != drm_vblank_count(dev, pipe),
> +					     last != drm_vblank_count(dev, pipe) ||
> +					     !READ_ONCE(vblank->enabled),
>  					     timeout);
>  
>  	drm_WARN(dev, timeout == 0, "vblank wait timed out on crtc %i\n", pipe);
>  
> -	drm_vblank_put(dev, pipe);
> -
>  	if (timeout < 0)
> -		return timeout;
> +		ret = timeout;
> +	else if (!timeout)
> +		ret = -ETIMEDOUT;
> +	else if (last == drm_vblank_count(dev, pipe))
> +		ret = -EINVAL; /* drm_crtc_vblank_off() ended the wait */

The error matches the one you get from drm_vblank_get() if calling this
when the vblank has been already turned off prior to the wait. Not sure
if we might want a different error value? Perhaps not. The ioctl does
return with success for a terminated wait, but I suppose having the
internal one return with an error will let the caller know that vblanks
are no longer available, so seems like a OK choice to me.

What is different between the two drm_vblank_get() failing vs.
terminating early due to _off() is that drm_vblank_get() failing will
WARN, terminating the vblank early does not. I take it that is the
behaviour you are after here. I think that difference is worth pointing
in the commit message, so we know it's intentional.

I think you should probably reorder the series and move this to be the
first patch so that it could even be backported without having to bring
the interruptible variant along for the ride.

> +	else
> +		ret = 0;
>  
> -	return timeout ? 0 : -ETIMEDOUT;
> +	drm_vblank_put(dev, pipe);
> +
> +	return ret;
>  }
>  
>  /**
> @@ -1338,7 +1346,8 @@ static int __drm_crtc_wait_one_vblank(struct drm_crtc *crtc, bool interruptible)
>   *
>   * This waits for one vblank to pass on @crtc, using the irq driver interfaces.
>   * It is a failure to call this when the vblank irq for @crtc is disabled, e.g.
> - * due to lack of driver support or because the crtc is off.
> + * due to lack of driver support or because the crtc is off. The wait also fails
> + * if drm_crtc_vblank_off() disables the vblank irq before a vblank passes.
>   *
>   * Returns: 0 on success, negative error on failures.
>   */
> -- 
> 2.34.1

-- 
Ville Syrjälä
Intel
