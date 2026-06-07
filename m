Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD76CD8C8C
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 12:49:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66CB910EA2D;
	Sun,  7 Jun 2026 12:49:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lphiXPCC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B37710EA2D
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 12:49:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7D7126001D;
 Sun,  7 Jun 2026 12:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1041F00893;
 Sun,  7 Jun 2026 12:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780836540;
 bh=K31V9uZb5MGXlIvs5crb4nnqW8zKvBjWlyPSWZZi1bQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lphiXPCCewsg+XM9g/4392nsJE+HgOEfqL0B0NHzm+bBwIKn/IGO6nDOnTqDEq4ZS
 SCea9D4xnkUs39/aXFQEAdH4QNT0xlw8iQ1Zk3Xo7c8RLlF+Un36wG04rUBTAEthUx
 Z7krBpF90NsDcmC5MEIsEIp5Py2PUnFsDNgQJVs0PHCp896PGQlkkB2BwqX7hSYH7e
 p0jEwvKxaL8bDobxRA4S7i3ceFxjQbGOb4qIkGmrQ2Ah3Q2d4OcyhPpbp4Iy3DYv7b
 qdw5/AtRhV9+kRdQv8JGZ+kSAyegS1lnDpR/BTEZpjd3I/68bHyQJsVhMV3BuSZp3R
 eCA2ubM3fFvow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/rockchip: dsi: Open-code drm_simple_encoder_init()
To: "Diogo Silva" <diogompaissilva@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260607123739.393974-2-diogompaissilva@gmail.com>
References: <20260607123739.393974-2-diogompaissilva@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 12:48:59 +0000
Message-Id: <20260607124900.0C1041F00893@smtp.kernel.org>
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
- [High] The return value of `drm_encoder_init()` is ignored, which can lea=
d to a NULL pointer dereference on subsequent error cleanup paths.
--

commit 386dea7155c8b56dde923c52be1155ed455ebd09
Author: Diogo Silva <diogompaissilva@gmail.com>

drm/rockchip: dsi: Open-code drm_simple_encoder_init()

This patch removes the dependency on the deprecated simple KMS helper from
rockchip DRM drivers by inlining drm_simple_encoder_init into the drivers.

[ ... ]

> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/dr=
m/rockchip/dw_hdmi-rockchip.c
> --- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c

[ ... ]

> @@ -604,7 +607,8 @@ static int dw_hdmi_rockchip_bind(struct device *dev, =
struct device *master,
>  	}
> =20
>  	drm_encoder_helper_add(encoder, &dw_hdmi_rockchip_encoder_helper_funcs);
> -	drm_simple_encoder_init(drm, encoder, DRM_MODE_ENCODER_TMDS);
> +	drm_encoder_init(drm, encoder, &dw_hdmi_rockchip_encoder_funcs,
> +			 DRM_MODE_ENCODER_TMDS, NULL);

[Severity: High]
This isn't a bug introduced by this patch, but does the return value of
drm_encoder_init() need to be checked here?

If drm_encoder_init() fails, encoder->dev remains NULL. If the subsequent
dw_hdmi_bind() call fails, the error path jumps to err_bind and calls
drm_encoder_cleanup(encoder). This explicitly dereferences encoder->dev
inside drm_mode_object_unregister(), which would cause a NULL pointer
dereference.

[ ... ]

> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu=
/drm/rockchip/dw_hdmi_qp-rockchip.c
> --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c

[ ... ]

> @@ -586,7 +589,8 @@ static int dw_hdmi_qp_rockchip_bind(struct device *de=
v, struct device *master,
>  		return ret;
> =20
>  	drm_encoder_helper_add(encoder, &dw_hdmi_qp_rockchip_encoder_helper_fun=
cs);
> -	drm_simple_encoder_init(drm, encoder, DRM_MODE_ENCODER_TMDS);
> +	drm_encoder_init(drm, encoder, &dw_hdmi_qp_rockchip_encoder_funcs,
> +			 DRM_MODE_ENCODER_TMDS, NULL);

[Severity: High]
This is a pre-existing issue, but should this code check the return value of
drm_encoder_init() for errors?

Similar to the previous file, if this initialization fails and leaves
encoder->dev as NULL, a subsequent failure in dw_hdmi_qp_bind() triggers
an error path that explicitly calls drm_encoder_cleanup(encoder), leading
to a NULL pointer dereference.

[ ... ]

> diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/roc=
kchip/rk3066_hdmi.c
> --- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
> +++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c

[ ... ]

> @@ -696,7 +699,8 @@ rk3066_hdmi_register(struct drm_device *drm, struct r=
k3066_hdmi *hdmi)
>  		return -EPROBE_DEFER;
> =20
>  	drm_encoder_helper_add(encoder, &rk3066_hdmi_encoder_helper_funcs);
> -	drm_simple_encoder_init(drm, encoder, DRM_MODE_ENCODER_TMDS);
> +	drm_encoder_init(drm, encoder, &rk3066_hdmi_encoder_funcs,
> +			 DRM_MODE_ENCODER_TMDS, NULL);

[Severity: High]
This is a pre-existing issue, but what happens if drm_encoder_init() fails
here?

If it fails and a subsequent initialization step fails, the error cleanup w=
ill
call the encoder's destroy function, causing a NULL pointer dereference sin=
ce
encoder->dev would be NULL.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607123739.3939=
74-2-diogompaissilva@gmail.com?part=3D1
