Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C38CA5FCE
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 09:01:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E93B10E321;
	Thu,  1 Oct 2026 09:01:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="eFAAfenp";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C870310E321
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 09:01:12 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 421BE1A109C;
 Thu,  1 Oct 2026 09:01:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 134E260341;
 Thu,  1 Oct 2026 09:01:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A2529103297EB; 
 Thu,  1 Oct 2026 11:00:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790845263; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=rHHej9yH4XOkeqe7HQOUFBElNtKlXqD/p/0et4Eq7R4=;
 b=eFAAfenpgJOe2xIhdUHmHAesTdEsRZoiGi+WTbKNKG7qX7brGr4vDD4GyzKQdu0RqwZqzZ
 zaKmMh1y8IDr6xG6DzSDzKw3BSSZ4xYxfkW1qr9fzEVtu7hrleahNhk3/q8qYdWBq/7zdr
 8ViJ1SBMZAYskH04L4dB5FOS8P5fqKiyenKj+35uoUiGMvZxzOLygCkd9r11UakuzAqgeJ
 HOSEmxBuMGnXf7PBafa82grUcAw34ucnCtiXwNrfbNPzt1k+giAt+pleGicJLx9+4r3Jzv
 RLYb6FbNCHK64az4xJVPMO3MsGh8EAuecr7otze70SgsrarbcMa5Bex6sqNleQ==
Message-ID: <78bd3e3e0fcd20f012c3b01f7f595376f7a6173d.camel@bootlin.com>
Subject: Re: [PATCH v2 7/7] drm: renesas: shmobile: stop using deprecated
 devm_drm_of_get_bridge()
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Frank Li	 <Frank.Li@nxp.com>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Icenowy Zheng	
 <zhengxingda@iscas.ac.cn>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart	 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Dave
 Stevenson <dave.stevenson@raspberrypi.com>,  =?ISO-8859-1?Q?Ma=EDra?= Canal
 <mcanal@igalia.com>, Raspberry Pi Kernel Maintenance	
 <kernel-list@raspberrypi.com>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Arnd Bergmann <arnd@kernel.org>, Doug Anderson <dianders@chromium.org>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni	 <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, 	imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, 	linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
Date: Thu, 01 Oct 2026 11:00:53 +0200
In-Reply-To: <20260929-drm-fix-of_get_bridge-build-regression-v2-7-6da431d8f180@bootlin.com>
References: <20260929-drm-fix-of_get_bridge-build-regression-v2-0-6da431d8f180@bootlin.com>
 <20260929-drm-fix-of_get_bridge-build-regression-v2-7-6da431d8f180@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi Luca,

Le mardi 29 septembre 2026 =C3=A0 15:39 +0200, Luca Ceresoli a =C3=A9crit=
=C2=A0:
> devm_drm_of_get_bridge() is deprecated, switch to
> of_drm_get_bridge_by_endpoint(). As of_drm_get_bridge_by_endpoint() retur=
ns
> a refcounted bridge, ensure it is put.
>=20
> drm_panel.h becomes unused, drop the include.
>=20
> Acked-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Reviewed-by: Paul Cercueil <paul.cercueil@bootlin.com>

Cheers,
-Paul

> ---
> =C2=A0drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c | 5 ++---
> =C2=A01 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> index 328a36215e39..51bae2008cc6 100644
> --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> @@ -28,7 +28,6 @@
> =C2=A0#include <drm/drm_gem_dma_helper.h>
> =C2=A0#include <drm/drm_modeset_helper.h>
> =C2=A0#include <drm/drm_modeset_helper_vtables.h>
> -#include <drm/drm_panel.h>
> =C2=A0#include <drm/drm_probe_helper.h>
> =C2=A0#include <drm/drm_vblank.h>
> =C2=A0
> @@ -447,7 +446,6 @@ static const struct drm_encoder_funcs shmob_encoder_f=
uncs
> =3D {
> =C2=A0int shmob_drm_encoder_create(struct shmob_drm_device *sdev)
> =C2=A0{
> =C2=A0	struct drm_encoder *encoder =3D &sdev->encoder;
> -	struct drm_bridge *bridge;
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	encoder->possible_crtcs =3D 1;
> @@ -463,7 +461,8 @@ int shmob_drm_encoder_create(struct shmob_drm_device
> *sdev)
> =C2=A0	}
> =C2=A0
> =C2=A0	/* Create a panel bridge */
> -	bridge =3D devm_drm_of_get_bridge(sdev->dev, sdev->dev->of_node, 0, 0);
> +	struct drm_bridge *bridge __free(drm_bridge_put) =3D
> +		of_drm_get_bridge_by_endpoint(sdev->dev->of_node, 0, 0);
> =C2=A0	if (IS_ERR(bridge))
> =C2=A0		return PTR_ERR(bridge);
> =C2=A0
