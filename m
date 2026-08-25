Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A075CC61DB4
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 10:22:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02E3410E9C9;
	Tue, 25 Aug 2026 10:22:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gSQBWlAc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EC4D10E9C9
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 10:22:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 797DB601DE;
 Tue, 25 Aug 2026 10:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA6E1F000E9;
 Tue, 25 Aug 2026 10:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787653375;
 bh=FHldwiAotDRWrej6zv3JjN/g2r9UFHIeS6i13C/l1q0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gSQBWlAcBWNcQy9j98QjvEuB5+v5f7VTkEyoVwtN1Nd/QIS2ZHYG/9ai2YCl5s/IQ
 nSUc9fC1LZQJNoQ5u2YffQ9QDTuRpMKBa3MQ00Ul1GE+bdAbB15FZszA5ENPdJ7RPI
 OUK9KUa9oYxB50hNO+VlBtI8th7QPgBRApjtRv61o3urLxV/Atj05lAqLrFAll+9YZ
 4WOhNSX4pDZ8T8C1Vt9Q5IagvkbeYGaSTtXZjNktaCrBSbqeCW1T5tX7XAvMPYiKV3
 kIQC7XK+H8GsjF6pP8Ev39Ht/I2wpsz9Ef9Qdz0yE4Uu+RGPHPhSAT4YJ8LrcKTfK0
 m216wDkZ1F8MA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/12] drm/bridge: ti-dlpc3433: don't depend on
 DRM_PANEL
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260825-drm-bridge-drm_panel-cleanup-v2-3-c6c88ba7ffd2@bootlin.com>
References: <20260825-drm-bridge-drm_panel-cleanup-v2-0-c6c88ba7ffd2@bootlin.com>
 <20260825-drm-bridge-drm_panel-cleanup-v2-3-c6c88ba7ffd2@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 10:22:54 +0000
Message-Id: <20260825102255.0EA6E1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The DSI device registered with `mipi_dsi_device_register_full()` i=
s never unregistered, causing a memory and device node leak that prevents d=
river reload.
--

--- Patch [3]: [PATCH v2 03/12] drm/bridge: ti-dlpc3433: don't depend on DR=
M_PANEL ---
commit 1c4393105a1871917fd54292e2edbfa8634d5ce0
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/bridge: ti-dlpc3433: don't depend on DRM_PANEL

This driver does not use the drm_panel APIs at all, so no need to select
DRM_PANEL.

> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kcon=
fig
> index 958b4f687d4dd..043596801a65b 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -428,7 +428,7 @@ config DRM_TOSHIBA_TC358775
> =20
>  config DRM_TI_DLPC3433
>  	tristate "TI DLPC3433 Display controller"
> -	depends on DRM && DRM_PANEL
> +	depends on DRM

[Severity: High]
This is a pre-existing issue, but I noticed a device node leak in the
driver itself.

In dlpc_host_attach(), the DSI device is registered manually:

drivers/gpu/drm/bridge/ti-dlpc3433.c:dlpc_host_attach()
    ...
    dlpc->dsi =3D mipi_dsi_device_register_full(host, &info);
    ...

However, the remove callback fails to unregister it:

drivers/gpu/drm/bridge/ti-dlpc3433.c:dlpc3433_remove()
static void dlpc3433_remove(struct i2c_client *client)
{
	struct dlpc *dlpc =3D i2c_get_clientdata(client);

	drm_bridge_remove(&dlpc->bridge);
	of_node_put(dlpc->host_node);
}

Should there be a call to mipi_dsi_device_unregister(dlpc->dsi) here to
prevent leaking the device node unconditionally upon unbind? Alternatively,
could this be migrated to devm_mipi_dsi_device_register_full() so it is
managed by devres?

>  	depends on OF
>  	select DRM_MIPI_DSI
>  	help

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825-drm-bridge=
-drm_panel-cleanup-v2-0-c6c88ba7ffd2@bootlin.com?part=3D3
