Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B01BCDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 21:03:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B16FF10ECBF;
	Tue, 23 Jun 2026 21:03:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RC0PfHzF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA2B810ECBF
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 21:03:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0169460008;
 Tue, 23 Jun 2026 21:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B5E1F000E9;
 Tue, 23 Jun 2026 21:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782248616;
 bh=g6z07HIddUQIv5yP8llaSZlv6I3Zv/zIjhZiWeI08cc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RC0PfHzFHycY1SQJLc4J7uGToLzs4rIAA9rtbc7mUhFZZrDcdyIAn6fhF1P63ov6J
 R9oceZQtPskfLvX/MLANn8NoqfX6MeUeQyOIlR6q4exXijK9pIUHSE04dkszx8JN0K
 I9yE5ecggCJPRS4ZcE4VCDTUwVf+sF47x5HxZUq/8yYGVAnLrBzLlOZH1FTF8hzPsP
 qfo8b79aMNdqKCVk+rVKbxZwaNHrMPBM63g7d5JOm0mRKYhMTTdhASD7wjNUUWQEZv
 VxMYk5Is13VJ9U3cVSjDdSFCEirps6n/zJfwtZokj7VsA0tTGMWsR8k0aTPwKjQyMU
 ocIS24YtxXyYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/9] drm/rockchip: dw_hdmi_qp: Enable YUV420 output format
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260617-dw-hdmi-qp-yuv-v1-8-a665cfd06d7d@collabora.com>
References: <20260617-dw-hdmi-qp-yuv-v1-0-a665cfd06d7d@collabora.com>
 <20260617-dw-hdmi-qp-yuv-v1-8-a665cfd06d7d@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 21:03:35 +0000
Message-Id: <20260623210336.68B5E1F000E9@smtp.kernel.org>
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
- [High] Hardware State Mutation in Atomic Check
--

commit 88f697e7fc21ab15ca1c009f0f830ab90e6ec4e7
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/rockchip: dw_hdmi_qp: Enable YUV420 output format

Both RK3576 and RK3588 SoCs are capable of driving the YUV420 output
color format, and the required bus-format handling and VOP2 support are
already in place. Advertise it via the platform supported formats so
the HDMI core can select it.

> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu=
/drm/rockchip/dw_hdmi_qp-rockchip.c
> index 3a1c027aa90bb..e29522afc6f05 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> @@ -612,7 +612,8 @@ static int dw_hdmi_qp_rockchip_bind(struct device *de=
v, struct device *master,
> =20
>  	plat_data.supported_formats =3D BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444) |
>  				      BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444) |
> -				      BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422);
> +				      BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422) |
> +				      BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420);

[Severity: High]
This is a pre-existing issue, but I noticed that adding new formats might
exercise the atomic check path more frequently.=20

Looking at dw_hdmi_qp_rockchip_encoder_atomic_check() in this same file,
it appears to mutate hardware state during the atomic validation phase:

drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c:dw_hdmi_qp_rockchip_encoder_=
atomic_check() {
	...
	ret =3D phy_configure(hdmi->phy, &phy_cfg);
	if (!ret) {
		hdmi->tmds_char_rate =3D conn_state->hdmi.tmds_char_rate;
		s->output_type =3D DRM_MODE_CONNECTOR_HDMIA;
		s->output_bpc =3D conn_state->hdmi.output_bpc;
		s->bus_format =3D ingest_fmt;
	} else {
	...
}

And in the PHY driver, phy_configure() mutates global state:

drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c:rk_hdptx_phy_configure() {
	...
	ret =3D rk_hdptx_phy_verify_hdmi_config(hdptx, &opts->hdmi, &hdptx->hdmi_c=
fg);
	if (ret) {
		dev_err(hdptx->dev, "invalid hdmi params for phy configure\n");
	} else {
		hdptx->restrict_rate_change =3D true;
	...
}

Does this sequence cause problems when a userspace application (like a disp=
lay
compositor) submits a test-only commit using the DRM_MODE_ATOMIC_TEST_ONLY=
=20
flag?

Since the atomic check runs for test-only commits, won't this corrupt the
active driver state and potentially break subsequent real commits if they s=
kip
necessary hardware configurations due to the cached state already matching?

> =20
>  	encoder =3D &hdmi->encoder.encoder;
>  	encoder->possible_crtcs =3D drm_of_find_possible_crtcs(drm, dev->of_nod=
e);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-dw-hdmi-qp=
-yuv-v1-0-a665cfd06d7d@collabora.com?part=3D8
