Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB73CD6E79
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 21:28:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22F6710F9CB;
	Mon,  8 Jun 2026 21:28:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hqE3jz6w";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC29810F9CB
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 21:28:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B469243B9D;
 Mon,  8 Jun 2026 21:28:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B141F00893;
 Mon,  8 Jun 2026 21:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780954093;
 bh=0X30NoJrdl9rQt+N8+pJovio2+3ljRkDN0Q3UkAwJqQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hqE3jz6wmSyr88TWdmLGB+qfLz0wLDQPZBj5u8DjZo5dgXA4LBuqgPBB8JfdFMG4s
 L7Or+vgZPOIbOZmKdnJ0nIMe30UJsHlru9WEpZ4YNNcy7sc1RZfpTr3qVAyzbAdK3c
 Da8RhlBVuP7p6TTqGEZOj2gUTrq2s4A6bzaoax4CQGGSU3j+MdJ+lvdJm1yJ9AYcfJ
 LOaf0qK3cgz9l2UgVmK14GPC13rbgoVt//8mMVlsuHRXbFbWEW/JUf7btS5wwq6kJH
 4+3rly7fpC8+ac/c19K9/c6Q7ToV22ukjduhRLygM6AH0tokkkIslnvyPVnudZz+vM
 8ecOYfe8XZaKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] drm/kmb: Fix device reference leaks in probe
To: "Yuho Choi" <dbgh9129@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260608211341.123939-1-dbgh9129@gmail.com>
References: <20260608211341.123939-1-dbgh9129@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 21:28:13 +0000
Message-Id: <20260608212813.78B141F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [Low] Undeclared identifier `dev` in `kmb_dsi_init()` breaks the build.

Pre-existing issues:
- [High] Devres-managed resources are bound to the wrong device, causing me=
mory leaks on probe deferrals.
- [High] The MIPI DSI host remains registered indefinitely if the DRM probe=
 defers, leading to a Use-After-Free upon module unload.
- [High] Calling `drm_crtc_cleanup()` on an uninitialized CRTC causes a NUL=
L pointer dereference and kernel panic.
- [High] Ignored return value from `kmb_dsi_encoder_init()` leads to incomp=
lete DRM initialization and crashes.
- [High] Ignored return value from `kmb_initialize_clocks()` leads to hardw=
are operations without enabled clocks.
--

commit fe279368e5a0418668dc2dae4e274724b0887c0b
Author: Yuho Choi <dbgh9129@gmail.com>

drm/kmb: Fix device reference leaks in probe

kmb_probe() takes a reference to its own platform device only to keep a
local dev pointer, and passes an extra reference to the DSI platform
device into kmb_dsi_host_bridge_init(). Neither reference is released.

> diff --git a/drivers/gpu/drm/kmb/kmb_drv.c b/drivers/gpu/drm/kmb/kmb_drv.c
> index 7c2eb1152fc2f..f8ef618e3a810 100644
> --- a/drivers/gpu/drm/kmb/kmb_drv.c
> +++ b/drivers/gpu/drm/kmb/kmb_drv.c
[ ... ]
> @@ -515,20 +515,24 @@ static int kmb_probe(struct platform_device *pdev)
> =20
>  	of_node_put(dsi_in);
>  	of_node_put(dsi_node);
> -	ret =3D kmb_dsi_host_bridge_init(get_device(&dsi_pdev->dev));
> +	ret =3D kmb_dsi_host_bridge_init(&dsi_pdev->dev);
> =20
> -	if (ret =3D=3D -EPROBE_DEFER) {
> -		return -EPROBE_DEFER;
> -	} else if (ret) {
> -		DRM_ERROR("probe failed to initialize DSI host bridge\n");
> -		return ret;
> +	if (ret) {
> +		if (ret !=3D -EPROBE_DEFER) {
> +			DRM_ERROR("probe failed to initialize DSI host bridge\n");
> +			kmb_dsi_host_unregister(NULL);
> +		}
> +		goto err_put_dsi_pdev;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but if kmb_probe() returns
-EPROBE_DEFER, it explicitly skips calling kmb_dsi_host_unregister(NULL).

If the module is subsequently unloaded while still in this deferred state,
could this cause a use-after-free since the globally allocated dsi_host
would remain registered in the MIPI DSI core's internal list pointing to
unloaded memory?

[ ... ]
> diff --git a/drivers/gpu/drm/kmb/kmb_dsi.c b/drivers/gpu/drm/kmb/kmb_dsi.c
> index 59d0e856392fc..a7df845088842 100644
> --- a/drivers/gpu/drm/kmb/kmb_dsi.c
> +++ b/drivers/gpu/drm/kmb/kmb_dsi.c
[ ... ]
> @@ -1410,7 +1430,6 @@ int kmb_dsi_mode_set(struct kmb_dsi *kmb_dsi, struc=
t drm_display_mode *mode,
>  struct kmb_dsi *kmb_dsi_init(struct platform_device *pdev)
>  {
>  	struct kmb_dsi *kmb_dsi;
> -	struct device *dev =3D get_device(&pdev->dev);
> =20
>  	kmb_dsi =3D devm_kzalloc(dev, sizeof(*kmb_dsi), GFP_KERNEL);

[Severity: Low]
Does the removal of the dev variable declaration cause a build failure?

It looks like dev is still being used here in devm_kzalloc() without
being declared in kmb_dsi_init().

[Severity: High]
This is a pre-existing issue, but is the memory allocation tied to the
wrong platform device?

The devm_kzalloc() call resolves dev to dsi_pdev->dev, which is the device
returned by of_find_device_by_node(), rather than the device actively
being probed.

Since dsi_pdev isn't cleaned up when kmb_probe() returns -EPROBE_DEFER,
won't this leak a new kmb_dsi structure into dsi_pdev's devres list on
every probe deferral?

[Severity: High]
This is a pre-existing issue, but does the error path in kmb_probe()
cause a NULL pointer dereference?

If kmb_setup_mode_config() fails before kmb->crtc is initialized,
the error path unconditionally jumps here:

drivers/gpu/drm/kmb/kmb_drv.c:kmb_probe() {
    ...
 err_free:
    drm_crtc_cleanup(&kmb->crtc);
    ...
}

Since devm_drm_dev_alloc() zeroes the memory, kmb->crtc.dev is NULL.
Calling drm_crtc_cleanup() on this uninitialized CRTC would dereference
this NULL pointer.

[Severity: High]
This is a pre-existing issue, but are we ignoring the return value
from kmb_dsi_encoder_init() here?

drivers/gpu/drm/kmb/kmb_drv.c:kmb_setup_mode_config() {
    ...
    ret =3D kmb_dsi_encoder_init(drm, kmb->kmb_dsi);
    /* Set the CRTC's port so that the encoder component can find it */
    kmb->crtc.port =3D of_graph_get_port_by_id(drm->dev->of_node, 0);
    ret =3D drm_vblank_init(drm, drm->mode_config.num_crtc);
    ...
}

The result in ret is immediately overwritten by drm_vblank_init().
If encoder initialization fails, the driver proceeds to register the DRM
device with an incomplete display pipeline, which could lead to crashes
during subsequent modeset operations.

[Severity: High]
This is a pre-existing issue, but is it safe to ignore the error code
returned from kmb_initialize_clocks()?

drivers/gpu/drm/kmb/kmb_drv.c:kmb_hw_init() {
    ...
    /* Enable display clocks */
    kmb_initialize_clocks(kmb, &pdev->dev);

    /* Allocate LCD interrupt resources */
    irq_lcd =3D platform_get_irq(pdev, 0);
    ...
}

If clock initialization fails, the driver silently continues execution
and attempts to access hardware MMIO registers. Accessing unclocked
MMIO registers usually triggers a synchronous external abort and hangs
the system.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608211341.1239=
39-1-dbgh9129@gmail.com?part=3D1
