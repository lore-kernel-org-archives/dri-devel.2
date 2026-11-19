Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A06606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MzlTQwVD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A7BD1124C4;
	Thu, 19 Nov 2026 14:40:18 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD4BC1124C5;
 Thu, 19 Nov 2026 14:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795099212; x=1826635212;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=/yTbx4M89DY7qZV4gtUeaZ6iggWcmFbtE07suT1xHZ0=;
 b=MzlTQwVDI5Di12Prh3Dn3duj0yNaLCD+sb0lDpYUgoPcnHppqyb1UbVh
 HURMnZxtQA/UU5T6keBVFFGXj41NfFNweKgjeDpZTMU9u6sLegDGN9Raw
 YIYzyuO8iMGPH/Pla/eWeR3l7dyz0FDzH9nRwUGgRGOFgGMSTqYEK5p25
 vBzOP1SZs5hNTwqC7pU7sIVAy515AS1YpDhRX/inuu/OC6UJIyr6eq+sR
 QUiZRoOFTc8n4Yj54aPYog305lCSW05ozGXReP58TM5zPLAtMlWYCE4Qt
 ha1J7Lf5QwtMk1Lu90mNF6un6PbM7aPzNae1Fa9K+ZJkw7huFL+ON0olN w==;
X-CSE-ConnectionGUID: DaaJauKAQXKxHKONtqageQ==
X-CSE-MsgGUID: JQ18She5SdS1fR4k4Q0EFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3849278"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3849278"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 06:40:11 -0800
X-CSE-ConnectionGUID: 6bFkeaCyQfu5UhGog788Yw==
X-CSE-MsgGUID: wmC7edA+R5aDhOU81ppiYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; d="scan'208";a="10479396"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.54])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 06:40:08 -0800
Date: Thu, 19 Nov 2026 16:40:05 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
 Harry.Wentland@amd.com, Sunpeng.Li@amd.com, tzimmermann@suse.de
Subject: Re: [PATCH v2 3/5] drm/client: Make the FBIO_WAITFORVSYNC vblank
 wait interruptible
Message-ID: <av8KRUbu966lGfi_@intel.com>
References: <20261119082424.554841-1-Prike.Liang@amd.com>
 <20261119082424.554841-3-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261119082424.554841-3-Prike.Liang@amd.com>
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

On Thu, Nov 19, 2026 at 04:24:22PM +0800, Prike Liang wrote:
> FBIO_WAITFORVSYNC calls drm_client_modeset_wait_for_vblank(), which
> waits with drm_crtc_wait_one_vblank(). That wait is uninterruptible and
> only gives up after one second. If no vblank interrupt arrives, for
> example while the driver resets the display hardware, the caller sleeps
> in D state for the whole second and can't be interrupted, not even by
> SIGKILL.
> 
> DRM_IOCTL_WAIT_VBLANK waits interruptibly, and so do fbdev drivers that
> implement FBIO_WAITFORVSYNC themselves, such as atyfb and matroxfb.

So we have precedent. Good.

> 
> Use drm_crtc_wait_one_vblank_interruptible() in
> drm_client_modeset_wait_for_vblank(). Return -ERESTARTSYS when a signal
> interrupts the wait, so that the ioctl returns to userspace or is
> restarted. Timeouts and disabled CRTCs are still not reported.
> 
> The fbdev damage worker also calls drm_client_modeset_wait_for_vblank(),
> but it runs in a kernel thread, which doesn't receive signals, so its
> wait doesn't change.

The damage workers recent unilateral use of vblank waits is bugging me.
Enabling vblanks has hardware side effects on i915/xe that we probably
don't want there. Need to take a look at demidlayering that at some
point...

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
>  drivers/gpu/drm/drm_client_modeset.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
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
>  
> -- 
> 2.34.1

-- 
Ville Syrjälä
Intel
