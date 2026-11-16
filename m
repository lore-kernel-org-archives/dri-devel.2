Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B77A606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 18:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Bd3xTzev
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D75DF10EA8C;
	Mon, 16 Nov 2026 18:11:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 7D5D210EA8C
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 18:10:59 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 195891684
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:10:56 -0800 (PST)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 D57B83F632
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794852659; bh=ec/UT180PDbQA4d1GfHMuFK+SZ+6T2bqvgvbWxkRKfA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Bd3xTzevI4UFqzaQ0faA1Y5AHlfoXMdiNZbhzdzgONTL2Y7+qJSoWvfP0RkIJ89+X
 59QZdHP+j6XmcHutLLU4olsaWUTx731Nd0UzJWqIMeyJVBm0Ax8GYe5vG84XLIlUz0
 V0gLV6GGd8PfLFIR88hLesLsjhlHfjIMxg8dsHRc=
Date: Mon, 16 Nov 2026 18:10:52 +0000
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/64] drm/hdlcd: Fix drm_atomic_helper_shutdown() on
 the probe error path
Message-ID: <avtHLCDADPo05tTy@e142607>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
 <20261116-drm-no-more-config-reset-v2-3-0bb471f4d1e0@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261116-drm-no-more-config-reset-v2-3-0bb471f4d1e0@kernel.org>
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
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 11:30:19AM +0100, Maxime Ripard wrote:
> The hdlcd_probe() error paths for pm_runtime_set_active() and
> drm_vblank_init() fall through to the err_pm_active label, which calls
> drm_atomic_helper_shutdown().
> 
> However, both calls happen before drm_mode_config_reset(), so the CRTC
> state is still NULL at that point. drm_atomic_helper_shutdown() will
> then go through drm_atomic_helper_disable_all() and
> drm_atomic_get_crtc_state() to drm_atomic_helper_crtc_duplicate_state(),
> which trips its WARN_ON(!crtc->state) and returns an error.
> 
> Move drm_atomic_helper_shutdown() to the err_register label, the only
> error path where drm_mode_config_reset() has run and thus where
> shutting the device down makes sense. This also brings the error path
> closer to hdlcd_remove(), which calls drm_atomic_helper_shutdown()
> while runtime PM is still enabled.
> 
> The pm_runtime_set_active() error path now jumps directly to
> err_unload: runtime PM hasn't been enabled at that point, so calling
> pm_runtime_disable() there wasn't needed either.
> 
> It will also be needed when drm_mode_config_reset() gets replaced by
> drm_mode_config_create_initial_state(), whose state allocation can
> fail.
> 
> Fixes: d664b851eb2bc ("drm/arm/hdlcd: Reject atomic commits that disable only the plane")
> Reported-by: sashiko-bot@kernel.org
> Link: https://lore.kernel.org/r/sashiko-outbox-199498@kernel.org
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Something seems to have broken down in your setup as I've only been
Cc-ed on patch 04/64, discovered this one during a search.

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/arm/hdlcd_drv.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
> index 340b1bb38bf9..f2bf9a61979d 100644
> --- a/drivers/gpu/drm/arm/hdlcd_drv.c
> +++ b/drivers/gpu/drm/arm/hdlcd_drv.c
> @@ -297,11 +297,11 @@ static int hdlcd_probe(struct platform_device *pdev)
>  		goto err_unload;
>  	}
>  
>  	ret = pm_runtime_set_active(dev);
>  	if (ret)
> -		goto err_pm_active;
> +		goto err_unload;
>  
>  	pm_runtime_enable(dev);
>  
>  	ret = drm_vblank_init(drm, drm->mode_config.num_crtc);
>  	if (ret < 0) {
> @@ -333,14 +333,13 @@ static int hdlcd_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
>  err_register:
>  	drm_kms_helper_poll_fini(drm);
> +	drm_atomic_helper_shutdown(drm);
>  err_vblank:
>  	pm_runtime_disable(drm->dev);
> -err_pm_active:
> -	drm_atomic_helper_shutdown(drm);
>  err_unload:
>  	hdlcd_irq_uninstall(hdlcd);
>  	of_reserved_mem_device_release(drm->dev);
>  err_free:
>  	dev_set_drvdata(dev, NULL);
> 
> -- 
> 2.56.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
