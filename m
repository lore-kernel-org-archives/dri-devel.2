Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7339AC5516F
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 23:47:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7081C10E1D4;
	Fri, 31 Jul 2026 23:47:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="inzbZr/Q";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF38E10E1D4
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 23:47:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3D11F600BC;
 Fri, 31 Jul 2026 23:47:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3FDA1F00AC4;
 Fri, 31 Jul 2026 23:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785541626;
 bh=oNXig1kPcHU+NdNkz+KRPha6XX0+j94Lo8nRLAzz8Tw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=inzbZr/Qz5yFqFfxqQliBiXXe1FAFkAaxxGrk9OJuo9shXiugGhRkfAYAkBo5+SK4
 kSppqqYiBiR2Wgv5Wew2OEQDp5DGOE9dm4Gwdjh8GkNdQH2ewGjNwSZ0GwwYSkU+W/
 62jqCHm7lbORs0tTRZseOe8GmvquaZMX8mgUHxZslJzoISTEuqNZmlGQwJkPaIwVZx
 KVNXs3mGoHT+N1Auuy+tAKtqN+YlzRe8dU/GyooY+GHE/Uf8d9uGv6v9hgjpTmUzEd
 VFKNv66AVP+1T+zIPNuffT2vz+AGFlsrKSmbG9yr4lbVWzPh8RnruGe/g0IL216HYL
 13pva47yxWkZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 55/69] drm/sun4i: hdmi: Convert to
 drmm_connector_hdmi_init()
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260731-dw-hdmi-qp-scramb-v10-55-294364b2cf15@collabora.com>
References: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
 <20260731-dw-hdmi-qp-scramb-v10-55-294364b2cf15@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 23:47:05 +0000
Message-Id: <20260731234705.B3FDA1F00AC4@smtp.kernel.org>
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
- [Low] A comment originally describing the vendor and product strings was =
left behind after the strings were moved to a struct, making it confusing.
--

--- Patch [55]: [PATCH v10 55/69] drm/sun4i: hdmi: Convert to drmm_connecto=
r_hdmi_init() ---
commit b114fe117b3fdd374cdabeb7a675643189411792
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
drm/sun4i: hdmi: Convert to drmm_connector_hdmi_init()

This patch switches the sun4i HDMI driver to use the new
drmm_connector_hdmi_init() signature. The vendor, product, format
capabilities, and max bpc are moved into the drm_connector_hdmi_funcs
structure.

> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun=
4i/sun4i_hdmi_enc.c
> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c

[ ... ]

> @@ -653,19 +654,16 @@ static int sun4i_hdmi_bind(struct device *dev, stru=
ct device *master,
> =20
>  	drm_connector_helper_add(&hdmi->connector,
>  				 &sun4i_hdmi_connector_helper_funcs);
> -	ret =3D drmm_connector_hdmi_ini2(drm, &hdmi->connector,
> +	ret =3D drmm_connector_hdmi_init(drm, &hdmi->connector,
>  				       /*
>  					* NOTE: Those are likely to be
>  					* wrong, but I couldn't find the
>  					* actual ones in the BSP.
>  					*/
> -				       "AW", "HDMI",
>  				       &sun4i_hdmi_connector_funcs,

[Severity: Low]
This isn't a bug, but should this comment be moved along with the "AW" and
"HDMI" strings to sun4i_hdmi_hdmi_connector_funcs? Leaving it here makes it
appear as if it refers to the sun4i_hdmi_connector_funcs argument.

>  				       &sun4i_hdmi_hdmi_connector_funcs,
>  				       DRM_MODE_CONNECTOR_HDMIA,
> -				       hdmi->ddc_i2c,
> -				       BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
> -				       8);
> +				       hdmi->ddc_i2c);
>  	if (ret) {
>  		dev_err(dev,
>  			"Couldn't initialise the HDMI connector\n");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-dw-hdmi-qp=
-scramb-v10-0-294364b2cf15@collabora.com?part=3D55
