Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0F8606A32F
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 21:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iW7LT1xs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3441010E359;
	Thu,  5 Nov 2026 21:19:08 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 723A010E359
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 21:19:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 71DD260147
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 21:19:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04ECE1F008A1;
 Thu,  5 Nov 2026 21:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793913541;
 bh=8SMf9LfvYHMM5vaMXSyRljdzp9L9j3fXSDiuPFI5SZs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iW7LT1xsKSC//kMTJeKdwkKHiQgGq3GNQ8q7PfDBsRhR1ntqkJxmDfXN63R/Oem6r
 ijwJH0D+xdn45iImrFEFsLw9Oq8XNy6uGBqPlwpdfpe63LT5r3EQ3rcuF5lz3RepeB
 sJqWxJd2jiMhg8CfxPSKEr5V+HISdMeYdQHURr5+QUimpMNFUdLUfPqrseyjVSS+sC
 /2TNb6AkxVB7cIe6IaQhy8fPj4XmECSKFES7rzlcFxi0FJYoSwkrUEqvcyqsZx17BN
 j2m2X/E5nvsqnkb/0vj7oC6cwJ/SM5/yPJ5qGOiuJa+HS+7/BMwHMMgqMuk7ljgmMC
 INM/ihRJkfqMg==
Message-ID: <sashiko-outbox-200215@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND 59/83] drm/tilcdc: Switch to
 drm_mode_config_create_initial_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261105-drm-no-more-config-reset-v1-59-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-59-1f58d1e33380@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 21:19:00 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/tilcdc: skipped tilcdc_crtc_hw_reset() in tilcdc_pdev_probe()
--

commit a7aa194e686d4c29674928aee2622cefc3bf4547
Author: Maxime Ripard <mripard@kernel.org>

drm/tilcdc: Switch to drm_mode_config_create_initial_state

This commit replaces drm_mode_config_reset() with
drm_mode_config_create_initial_state() in tilcdc_pdev_probe() to separate
initial KMS state creation at probe time from suspend/resume resets.

> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc=
/tilcdc_drv.c
> index 1d6c9a423a410..da718d9cb1d69 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> @@ -422,7 +422,9 @@ static int tilcdc_pdev_probe(struct platform_device *=
pdev)
>  		goto unregister_cpufreq_notif;
>  	}
> =20
> -	drm_mode_config_reset(ddev);
> +	ret =3D drm_mode_config_create_initial_state(ddev);
> +	if (ret)
> +		goto stop_poll;

[Severity: High]
Does replacing drm_mode_config_reset() with
drm_mode_config_create_initial_state() in tilcdc_pdev_probe() skip calling
tilcdc_crtc_hw_reset() at probe time?

In drivers/gpu/drm/tilcdc/tilcdc_crtc.c, tilcdc_crtc_hw_reset() is
registered as the drm_crtc_helper_funcs.hw_reset callback to turn off the
LCDC raster if the bootloader left it enabled, synchronizing the hardware
with the initial disabled software CRTC state:

drivers/gpu/drm/tilcdc/tilcdc_crtc.c:tilcdc_crtc_hw_reset() {
	/* Turn the raster off if it for some reason is on. */
	pm_runtime_get_sync(dev->dev);
	if (tilcdc_read(dev, LCDC_RASTER_CTRL_REG) & LCDC_RASTER_ENABLE) {
		/* Enable DMA Frame Done Interrupt */
		tilcdc_write(dev, LCDC_INT_ENABLE_SET_REG, LCDC_FRAME_DONE);
		tilcdc_clear_irqstatus(dev, 0xffffffff);

		tilcdc_crtc->frame_done =3D false;
		tilcdc_clear(dev, LCDC_RASTER_CTRL_REG, LCDC_RASTER_ENABLE);
		...
	}
	pm_runtime_put_sync(dev->dev);
}

This logic was added in commit 46a956ab3c5b ("drm/tilcdc: Turn raster off
in crtc reset, if it was on in the HW") and moved to the hw_reset hook in
commit 6e531fda1d6b ("drm/tilcdc: Move hardware reset to hw_reset hook").

Previously, tilcdc_pdev_probe() called drm_mode_config_reset() right after
tilcdc_irq_install(), which ran
drm_mode_config_crtc_reset_with_create_state() ->
helper_funcs->hw_reset(crtc).

However, drm_mode_config_create_initial_state() calls
drm_mode_config_crtc_create_state() directly without invoking
helper_funcs->hw_reset(crtc).

If the bootloader leaves LCDC_RASTER_ENABLE active at boot, won't the
hardware raster remain running while crtc->state->active and
tilcdc_crtc->enabled are initialized to false, causing the first modeset in
tilcdc_crtc_atomic_enable() -> tilcdc_crtc_enable() ->
tilcdc_crtc_set_mode() -> tilcdc_crtc_load_palette() to reprogram timings
and palette DMA while the raster is still active?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-drm-no-mor=
e-config-reset-v1-0-1f58d1e33380@kernel.org?part=3D59
