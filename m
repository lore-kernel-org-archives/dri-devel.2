Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E738AC88E40
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 07:55:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C246110E853;
	Sun, 13 Sep 2026 07:55:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hvvtM+Lh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08D1410E853
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 07:55:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C5EF241AB6;
 Sun, 13 Sep 2026 07:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BE01F000FF;
 Sun, 13 Sep 2026 07:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789286126;
 bh=EBefiISfrw4p2vHc+Y7EofVc16Mls+ldmvCbJv3e19U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hvvtM+LheQpSbSKqgCYiyA/8rn40tZvgwAe06F5Kjvkz84T56FbI1YYQGudZNfpOs
 V2pK/w3Jm6jH2eGfggSFW7xLdKVnwfuUJnXYBVhzrseBZotRWppd7jjXGpKAuBh8RE
 8PNIDNmmVl2AghWUxp+x0gZKNMgVHv7LhZo6VZCQKDqL0iDCYQCODpUrdYJykKvvXv
 ohvtSx3P3ZvwPx7fx/TnFyDr5Z2ug0pypZ7KO9P+ngGIBg1thj6zoRAiqGiANNWRcl
 a2cqDw65kacfBE6ooAz1GugkmzrY+Qe4E6hPKlxTspiQ3EFD3aHf+RWvlpjIMxPPCr
 qbn3+Puq/cG/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/kmb: fix potential use-after-free on probe failure
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260913074120.1483518-1-lgs201920130244@gmail.com>
References: <20260913074120.1483518-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 07:55:26 +0000
Message-Id: <20260913075526.85BE01F000FF@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Double cleanup of DRM mode config resources on probe failure.
- [High] Dereferencing ERR_PTR when kmb_dsi_init() fails.
--

commit 2823b7cb00bc3152bdd5fb74968092a522fc9d34
Author: Guangshuo Li <lgs201920130244@gmail.com>

drm/kmb: fix potential use-after-free on probe failure

kmb_irq_install() registers the LCD interrupt handler with the DRM
device as its dev_id. If drm_dev_register() subsequently fails, the
probe error path tears down polling but does not uninstall the IRQ.

> diff --git a/drivers/gpu/drm/kmb/kmb_drv.c b/drivers/gpu/drm/kmb/kmb_drv.c
> index 7c2eb1152fc2f..d8e2fc28ee9ec 100644
> --- a/drivers/gpu/drm/kmb/kmb_drv.c
> +++ b/drivers/gpu/drm/kmb/kmb_drv.c
> @@ -569,6 +569,7 @@ static int kmb_probe(struct platform_device *pdev)
> =20
>   err_register:
>  	drm_kms_helper_poll_fini(&kmb->drm);
> +	kmb_irq_uninstall(&kmb->drm);
>   err_irq:
>  	pm_runtime_disable(kmb->drm.dev);
>   err_free:

[Severity: High]
This isn't a bug introduced by this patch, but is a pre-existing issue.
Does the explicit cleanup of the DRM mode config here cause a double free?

kmb_setup_mode_config() initializes the mode configuration using the managed
API drmm_mode_config_init(). If the probe fails subsequently (e.g., in
kmb_irq_install() or drm_dev_register()), the error path jumps to err_free
and executes:

drivers/gpu/drm/kmb/kmb_drv.c:kmb_probe() {
    ...
 err_free:
	drm_crtc_cleanup(&kmb->crtc);
	drm_mode_config_cleanup(&kmb->drm);
    ...
}

Since drmm_mode_config_init() already registers a devres action to call
drm_mode_config_cleanup() when the device goes away, won't this manual
cleanup call cause double frees of idr structures like crtc_idr and tile_id=
r,
potentially leading to memory corruption or a kernel panic?

[Severity: High]
This is also a pre-existing issue, but can this code path dereference an
ERR_PTR and cause a crash?

If kmb_dsi_init() fails (for example, if devm_kzalloc returns -ENOMEM), it
returns an ERR_PTR which is stored in kmb->kmb_dsi. kmb_probe() captures
this pointer, evaluates IS_ERR(), and jumps to err_free1:

drivers/gpu/drm/kmb/kmb_drv.c:kmb_probe() {
    ...
	kmb->kmb_dsi =3D kmb_dsi_init(dsi_pdev);
	if (IS_ERR(kmb->kmb_dsi)) {
		drm_err(&kmb->drm, "failed to initialize DSI\n");
		ret =3D PTR_ERR(kmb->kmb_dsi);
		goto err_free1;
	}
    ...
 err_free1:
	dev_set_drvdata(dev, NULL);
	kmb_dsi_host_unregister(kmb->kmb_dsi);
    ...
}

kmb_dsi_host_unregister() then passes this error pointer directly to
kmb_dsi_clk_disable():

drivers/gpu/drm/kmb/kmb_dsi.c:kmb_dsi_clk_disable() {
    ...
	clk_disable_unprepare(kmb_dsi->clk_mipi);
    ...
}

Will this unconditionally dereference the invalid ERR_PTR without checking?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913074120.1483=
518-1-lgs201920130244@gmail.com?part=3D1
