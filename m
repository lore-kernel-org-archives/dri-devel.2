Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2BD1CCA490
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 12:41:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9F8810E61C;
	Sun, 18 Oct 2026 12:41:21 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A47D10E61C
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 12:41:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2E518418BB;
 Sun, 18 Oct 2026 12:41:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F951F000C4;
 Sun, 18 Oct 2026 12:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792327275;
 bh=iSE8FXR1Ov3rw1Z+52l0n+l3k96etzVpur842aaKKyg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=arhPkPwP0KKa44S1ARkO9KVfdKOeVtFM5QyX+iqFKmhimifFc6TtO2G67F8kkoru7
 KiYSxhlK81eX+ImoqI99Vzqr3iuV76sRqa1iI5zkTvXJiSAoRMNxmUULD5Xz5DvliK
 sx+YdvYcrEv79vzZOkUaLryRGv9IlIryirfvv97YQ7mqWkWyGwF2uE4ywCJNq4a1Nh
 K3i9dmUDa59yo63zytmVeYykdL5BGWnkJDh0AJktgUPr8U/dfrsbaxJKuaZokWGNAM
 09LRNj1eOOQL4qB6ZgbTiobZRodwIfZXQsRUztwlWdstXOc87RTQVrMlUrkrB3C2Q5
 kQqxb4O2gAoLA==
Message-ID: <sashiko-outbox-176122@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/6] drm/rockchip: dw_hdmi_qp: Advertise BT.709 and
 BT.2020 colorimetries
To: =?utf-8?b?SmFuIENsYXXDn2Vu?= <jan.claussen10@web.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261018123037.19560-7-jan.claussen10@web.de>
References: <20261018123037.19560-1-jan.claussen10@web.de>
 <20261018123037.19560-7-jan.claussen10@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 12:41:14 +0000
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
- [Medium] drm/rockchip: missing s->color_space update in dw_hdmi_qp atomic=
_check()
--

commit 43d044058730a347faa3ac82bf806a1a71fe7cd1
Author: Jan Clau=C3=9Fen <jan.claussen10@web.de>

drm/rockchip: dw_hdmi_qp: Advertise BT.709 and BT.2020 colorimetries

This commit populates plat_data.supported_colorspaces in
dw_hdmi_qp_rockchip_bind() to advertise BT.709 YCC, BT.2020 RGB, and
BT.2020 YCC colorimetries on the Rockchip DW HDMI QP connector.

> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu=
/drm/rockchip/dw_hdmi_qp-rockchip.c
> index 9c4cf68d79d50..dbb87dfd000c2 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> @@ -605,6 +605,10 @@ static int dw_hdmi_qp_rockchip_bind(struct device *d=
ev, struct device *master,
>  				      BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444) |
>  				      BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422);
> =20
> +	plat_data.supported_colorspaces =3D BIT(DRM_MODE_COLORIMETRY_BT709_YCC)=
 |
> +				      BIT(DRM_MODE_COLORIMETRY_BT2020_RGB) |
> +				      BIT(DRM_MODE_COLORIMETRY_BT2020_YCC);
> +

[Severity: Medium]
When userspace selects DRM_MODE_COLORIMETRY_BT2020_YCC or
DRM_MODE_COLORIMETRY_BT2020_RGB while the HDMI output format is YCbCr
(DRM_OUTPUT_COLOR_FORMAT_YCBCR444 or DRM_OUTPUT_COLOR_FORMAT_YCBCR422),
should dw_hdmi_qp_rockchip_encoder_atomic_check() also update s->color_space
from conn_state->colorspace?

On RK3588 and RK3576, RGB-to-YCbCr conversion is performed by VOP2 when the
bridge requests a YUV bus format (such as MEDIA_BUS_FMT_YUV8_1X24,
MEDIA_BUS_FMT_YUV10_1X30, or MEDIA_BUS_FMT_UYVY8_1X16). Both
vop2_setup_csc_mode() and vop2_bgcolor_setup() in
drivers/gpu/drm/rockchip/rockchip_drm_vop2.c rely on vcstate->color_space to
choose between CSC_BT2020L (for V4L2_COLORSPACE_BT2020) and CSC_BT709L:

drivers/gpu/drm/rockchip/rockchip_drm_vop2.c:vop2_setup_csc_mode() {
	int output_csc =3D vcstate->color_space;
	...
	} else if (!is_input_yuv && is_output_yuv) {
		y2r_en =3D false;
		r2y_en =3D true;
		csc_mode =3D vop2_convert_csc_mode(output_csc);
	}
}

drivers/gpu/drm/rockchip/rockchip_drm_vop2.c:vop2_bgcolor_setup() {
	if (new_vcstate->yuv_overlay) {
		vop2_rgb16_to_yuv16(new_vcstate->color_space,
				    DRM_ARGB64_GETR(bgcolor),
				    DRM_ARGB64_GETG(bgcolor),
				    DRM_ARGB64_GETB(bgcolor),
				    &y, &cb, &cr);
}

Currently, dw_hdmi_qp_rockchip_encoder_atomic_check() never sets
s->color_space, and its early return check only compares tmds_char_rate,
output_bpc, and bus_format:

drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c:dw_hdmi_qp_rockchip_encoder_=
atomic_check() {
	if (hdmi->tmds_char_rate =3D=3D conn_state->hdmi.tmds_char_rate &&
	    s->output_bpc =3D=3D conn_state->hdmi.output_bpc &&
	    s->bus_format =3D=3D ingest_fmt)
		return 0;
	...
	if (!ret) {
		hdmi->tmds_char_rate =3D conn_state->hdmi.tmds_char_rate;
		s->output_type =3D DRM_MODE_CONNECTOR_HDMIA;
		s->output_bpc =3D conn_state->hdmi.output_bpc;
		s->bus_format =3D ingest_fmt;
	}
}

Without updating s->color_space, won't VOP2 leave vcstate->color_space at 0
(V4L2_COLORSPACE_DEFAULT) and convert RGB planes and the background color to
YCbCr using the Rec. 709 matrix (CSC_BT709L) while the HDMI AVI InfoFrame
signals BT.2020 colorimetry to the sink?

>  	encoder =3D &hdmi->encoder.encoder;
>  	encoder->possible_crtcs =3D drm_of_find_possible_crtcs(drm, dev->of_nod=
e);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018123037.1956=
0-1-jan.claussen10@web.de?part=3D6
