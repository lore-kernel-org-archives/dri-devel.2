Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28386606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 14:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Jf8Y2S8s
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8DC41124A6;
	Thu, 19 Nov 2026 14:31:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C30C11249B;
 Thu, 19 Nov 2026 14:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795098687; x=1826634687;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=jtH2dDgvMP7GZwr08nwBsN3TLt+RM7WhA6myra5Ryw4=;
 b=Jf8Y2S8svyIlmzu667XlssskRVQCB+5Z/Rasze2nMKHCUziWX5TaGcqi
 8betBKU4oK9o7VEh1mSDJmxL7+1PYTWQfPOqy/Lmf10Yf8Ctfb9V1pooG
 oX2EEOsx7LIPxqzaTJrJ8QHs5alRpmm/V5kkyge8TALW+rumAJac/gL8A
 iRD9OySbKpGbb5n8p38CK2VjLiBi1HSdZPo1lZlbttzLQT1to6xTMI7Xf
 DU/hFi21uxuF1dRljKzJmKbDzdbdVeizSWKo0E63b/srA4ILDH3DQuvtZ
 tqnUX/e3iqjZRa1NoMPWPFz799Tv7DpRqPnrC1XtoC13yGqIVZkQ1FPEx g==;
X-CSE-ConnectionGUID: O5gyyR7YSByac20bgDgzQw==
X-CSE-MsgGUID: dC2PBN0WQhC2UOpTz10H1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3794418"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3794418"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 06:31:27 -0800
X-CSE-ConnectionGUID: wbCNqAYJQaGWnRXdmNmVJg==
X-CSE-MsgGUID: TJL9ti19Tym8RPaqk0SSgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; d="scan'208";a="10699786"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.54])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 06:31:24 -0800
Date: Thu, 19 Nov 2026 16:31:20 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
 Harry.Wentland@amd.com, Sunpeng.Li@amd.com, tzimmermann@suse.de
Subject: Re: [PATCH v2 1/5] drm/vblank: Stop drm_crtc_wait_one_vblank() when
 vblank is turned off
Message-ID: <av8IOJf8blSIt8mf@intel.com>
References: <20261119082424.554841-1-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261119082424.554841-1-Prike.Liang@amd.com>
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

On Thu, Nov 19, 2026 at 04:24:20PM +0800, Prike Liang wrote:
> drm_crtc_vblank_off() turns off the vblank interrupt even while someone
> holds a vblank reference and waits for a vblank. It then wakes up the
> vblank wait queue. DRM_IOCTL_WAIT_VBLANK stops waiting at this point,
> because its wait condition also checks whether vblank is still enabled.
> 
> drm_crtc_wait_one_vblank() only checks whether the vblank count has
> changed. Once vblank is off, the count doesn't change, so the woken
> waiter sleeps again until the wait times out after one second and warns
> "vblank wait timed out". This happens, for example, when the fbdev
> damage worker or FBIO_WAITFORVSYNC waits for a vblank while the driver
> turns the CRTC off for suspend or a GPU reset.
> 
> Make drm_crtc_wait_one_vblank() also stop waiting when vblank is turned
> off, and return -EINVAL if no vblank passed, the same error that
> drm_vblank_get() returns when vblank is off. The wait condition is
> checked before going to sleep, so this also covers vblank being turned
> off between drm_vblank_get() and the wait. Waits that see a vblank or
> time out behave as before.
> 
> The two cases differ in that drm_crtc_wait_one_vblank() warns "vblank
> not available" if drm_vblank_get() fails, but doesn't warn if
> drm_crtc_vblank_off() ends the wait. That is intentional: it's a
> failure to call the function while vblank is off, but a waiter, such as
> the fbdev damage worker, can't keep the CRTC from being turned off
> meanwhile. The error only tells the caller that no more vblanks are
> coming.
> 
> version update:
> 1) https://lists.freedesktop.org/archives/dri-devel/2026-November/616745.html
> 
> Fixes: e8450f51a4b3 ("drm/irq: Implement a generic vblank_wait function")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Assisted-by: Copilot:claude-opus-5.5
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/drm_vblank.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index f90fb2d13e42..54118eb1413c 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -1303,7 +1303,8 @@ EXPORT_SYMBOL(drm_crtc_vblank_put);
>   *
>   * This waits for one vblank to pass on @crtc, using the irq driver interfaces.
>   * It is a failure to call this when the vblank irq for @crtc is disabled, e.g.
> - * due to lack of driver support or because the crtc is off.
> + * due to lack of driver support or because the crtc is off. The wait also fails
> + * if drm_crtc_vblank_off() disables the vblank irq before a vblank passes.

The "The wait also fails ..." wording feels a bit vague to me.
Maybe something like "The wait terminates early with an error
if drm_crtc_vblank_off() ..." ?

If you do decide to change the wording remember to carry it
through to the other patches when rebasing them.

Apart from that, this looks pretty good to me
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

>   *
>   * Returns: 0 on success, negative error on failures.
>   */
> @@ -1323,14 +1324,22 @@ int drm_crtc_wait_one_vblank(struct drm_crtc *crtc)
>  	last = drm_vblank_count(dev, pipe);
>  
>  	ret = wait_event_timeout(vblank->queue,
> -				 last != drm_vblank_count(dev, pipe),
> +				 last != drm_vblank_count(dev, pipe) ||
> +				 !READ_ONCE(vblank->enabled),
>  				 msecs_to_jiffies(1000));
>  
>  	drm_WARN(dev, ret == 0, "vblank wait timed out on crtc %i\n", pipe);
>  
> +	if (!ret)
> +		ret = -ETIMEDOUT;
> +	else if (last == drm_vblank_count(dev, pipe))
> +		ret = -EINVAL; /* drm_crtc_vblank_off() ended the wait */
> +	else
> +		ret = 0;
> +
>  	drm_vblank_put(dev, pipe);
>  
> -	return ret ? 0 : -ETIMEDOUT;
> +	return ret;
>  }
>  EXPORT_SYMBOL(drm_crtc_wait_one_vblank);
>  
> -- 
> 2.34.1

-- 
Ville Syrjälä
Intel
