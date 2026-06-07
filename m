Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33608CD8C8C
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 10:59:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1608010E9E2;
	Sun,  7 Jun 2026 10:59:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="gmiN5pvj";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A898310E9E1
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 10:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=97NZlk873g/D280FN02tm4Cwk27MbU4WZEUElaU0aQM=; b=gmiN5pvjvSslkFeya7EuNki80z
 Qv3sH3Vh16k9AXWcagQLxnhxoDd7f3QtMAvEyrA6paLlnLN0/6ayEGeuifHytKkoxXhFdw8XiKrDh
 T9130QoSZa0s2glYzMT2/e/bgrOd9PynunSBzAW7XIvhvyzXa90BSEyzko4omuBcHEY22T2pbb5IV
 G+lE+ZaEXoUOse9OZTRVJTQQmEM2+I2ffXf/HWOUcUwug/lbNm695Cl8qRJGbFvyjLAfcuKxB7glf
 DmiY11iAM9YRkxRV2u0XE88uTgbvharrnzIXPXNRWtq7u/f8GX50f1b0wYPZJxR4PwH4FSYRSGuuV
 2aALXJDA==;
From: Heiko Stuebner <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Diogo Silva <diogompaissilva@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Diogo Silva <diogompaissilva@gmail.com>
Subject: Re: [PATCH] drm/rockchip: dsi: Open-code drm_simple_encoder_init()
Date: Sun, 07 Jun 2026 12:59:00 +0200
Message-ID: <5277524.h16uAIiOU7@phil>
In-Reply-To: <20260604123224.192543-2-diogompaissilva@gmail.com>
References: <20260604123224.192543-2-diogompaissilva@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Hi Diego,

Am Donnerstag, 4. Juni 2026, 14:32:25 Mitteleurop=C3=A4ische Sommerzeit sch=
rieb Diogo Silva:
> Remove the dependency on drm_simple_kms_helper by open-coding the
> drm_simple_encoder_init call.

this description is missing a rationale.

Looking at the drm git history, I guess here you could add a second
paragraph, with something like:

=2D---------- 8< -----------
The helpers have been deprecated for years as they only add an an
intermediate layer between atomic modesetting and the DRM driver.
=2D---------- 8< -----------

Shamelessly stolen from the Todo item ;-)


> Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
> ---
>  drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 9 +++++++--

Any reason for only changing the DSI driver?

Looking at [0] a number of the Rockchip drivers use the same pattern:
=2D drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
=2D drivers/gpu/drm/rockchip/cdn-dp-core.c
=2D drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
=2D drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c
=2D drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
=2D drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
=2D drivers/gpu/drm/rockchip/rk3066_hdmi.c
=2D drivers/gpu/drm/rockchip/rockchip_lvds.c
=2D drivers/gpu/drm/rockchip/rockchip_rgb.c

You can just do all Rockchip ones - even in one patch I think :-) .


Thanks
Heiko

[0] https://elixir.bootlin.com/linux/v7.1-rc6/A/ident/drm_simple_encoder_in=
it


>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gp=
u/drm/rockchip/dw-mipi-dsi-rockchip.c
> index 3547d91b25d3..a09b382d208e 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> @@ -25,7 +25,6 @@
>  #include <drm/drm_mipi_dsi.h>
>  #include <drm/drm_of.h>
>  #include <drm/drm_print.h>
> -#include <drm/drm_simple_kms_helper.h>
> =20
>  #include "rockchip_drm_drv.h"
> =20
> @@ -825,6 +824,10 @@ static void dw_mipi_dsi_encoder_enable(struct drm_en=
coder *encoder)
>  	clk_disable_unprepare(dsi->grf_clk);
>  }
> =20
> +static const struct drm_encoder_funcs dw_mipi_dsi_encoder_funcs =3D {
> +	.destroy =3D drm_encoder_cleanup,
> +};
> +
>  static const struct drm_encoder_helper_funcs
>  dw_mipi_dsi_encoder_helper_funcs =3D {
>  	.atomic_check =3D dw_mipi_dsi_encoder_atomic_check,
> @@ -840,7 +843,9 @@ static int rockchip_dsi_drm_create_encoder(struct dw_=
mipi_dsi_rockchip *dsi,
>  	encoder->possible_crtcs =3D drm_of_find_possible_crtcs(drm_dev,
>  							     dsi->dev->of_node);
> =20
> -	ret =3D drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_DSI);
> +	ret =3D drm_encoder_init(drm_dev, encoder,
> +				&dw_mipi_dsi_encoder_funcs,
> +				DRM_MODE_ENCODER_DSI, NULL);
>  	if (ret) {
>  		DRM_ERROR("Failed to initialize encoder with drm\n");
>  		return ret;
>=20




