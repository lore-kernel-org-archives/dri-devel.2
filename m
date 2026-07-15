Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C0E6C44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 19:36:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 315B210E218;
	Wed, 15 Jul 2026 19:36:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="HBeCfxPr";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23DE610E218
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 19:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=EkAmAXWFdRaV2FEnkFzbQfqrpancqGX/NTP3iRaWbqk=; b=HBeCfxPrMerzTTa1P1DjEdUQs0
 1J1B5NjvdxSdyZy57mYE3pbiGFIzwtcYqFyxc3BPUR/JO1ZFiyUeUUajoAqaKpCSwvImiWpjiyzUn
 keOhAkk1rUm4l5zrSKhBbolCn6Jutkv6GX93ct2DmnH7WZlgbBrfgsDrBM53XB2nC6lDYCvlOXjFI
 jzgrK/oN5gCR4ytiQxQgElEVKJIDE6fzemVetvlwCAjZuS0K9aY0QR6FgiOuIOSxwOnmmhl5eDhth
 DCo4QmILQZAsAqlhkga1GS3r+lN7uq3d9uGkMjO9CYzTudQ00ltb2qxudglNoJ8WXYQTFwaAK38cp
 huSUHPPQ==;
From: Heiko Stuebner <heiko@sntech.de>
To: linux-kernel@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 3/3] drm/rockchip: remove unneeded 'fast_io' parameter in
 regmap_config
Date: Wed, 15 Jul 2026 21:36:00 +0200
Message-ID: <9698684.rMLUfLXkoz@phil>
In-Reply-To: <20260705163536.1850-8-wsa+renesas@sang-engineering.com>
References: <20260705163536.1850-5-wsa+renesas@sang-engineering.com>
 <20260705163536.1850-8-wsa+renesas@sang-engineering.com>
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

Am Sonntag, 5. Juli 2026, 18:35:38 Mitteleurop=C3=A4ische Sommerzeit schrie=
b Wolfram Sang:
> When using MMIO with regmap, fast_io is implied. No need to set it
> again.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> No dependencies, can be applied directly to the subsystem tree. Buildbot =
is
> happy, too.
>=20
>  drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c b/drivers/g=
pu/drm/rockchip/dw-mipi-dsi2-rockchip.c
> index d2e76d36d724..aa8642e5b621 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c
> @@ -368,7 +368,6 @@ static const struct regmap_config dw_mipi_dsi2_rockch=
ip_regmap_config =3D {
>  	.reg_bits =3D 32,
>  	.val_bits =3D 32,
>  	.reg_stride =3D 4,
> -	.fast_io =3D true,
>  };

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


