Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2587ACDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:51:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D11E10E2E9;
	Tue, 23 Jun 2026 20:51:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PgHGa1mW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D94AA10E2E9
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:51:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B091B406C8;
 Tue, 23 Jun 2026 20:51:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF271F000E9;
 Tue, 23 Jun 2026 20:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782247876;
 bh=ayLBPgvBZ3FBSH7Pyg9Se35v0qo5SoF/f3h+0edTIOc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PgHGa1mWVDgmJeRoTarYse9R6uCsdNs2BYML/311fxFc7KuMSo7DEIm89416wLOf9
 hWA8POFRNSACPm/nUrv1yTvQrrcsy1eAsugPXaaGtDuV2GXgiinEx22vvbZUJxhlJz
 kY6Gv/fvpAzoLpH4iP8/cjs+lQRAOK2wsD/+oKBZGBr/lPbzHGN613PcS172IQu3AD
 bGSNKK3kbtGFGpCEgBaNCryLBWsjffybQzACWefaoUYiyBb+uQqsrBNZOj8/kzBvPb
 q6YUe6ji01pFLIoklfpEGKTFqY9bE/rtFeWJxIAehteh9LFf647nOXS5EsAHHIQRUo
 aQcaXzoilI4jw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/9] drm/rockchip: dw_hdmi_qp: Support 10-bit YUV422
 output format
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260617-dw-hdmi-qp-yuv-v1-7-a665cfd06d7d@collabora.com>
References: <20260617-dw-hdmi-qp-yuv-v1-0-a665cfd06d7d@collabora.com>
 <20260617-dw-hdmi-qp-yuv-v1-7-a665cfd06d7d@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 20:51:15 +0000
Message-Id: <20260623205116.4FF271F000E9@smtp.kernel.org>
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
- [High] Mutating hardware state and global device tracking variables insid=
e an atomic_check callback.
--

commit ee5f0003f61d5c3a78b5bc65346f39307471c74c
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/rockchip: dw_hdmi_qp: Support 10-bit YUV422 output format

This commit adds support for the 10-bit YUV 4:2:2 output format
(MEDIA_BUS_FMT_UYVY10_1X20) to the Rockchip DW HDMI QP encoder. It also
forces 8 bpc when YUV 4:2:2 is in use to ensure the PHY PLL output remains
aligned with the TMDS character rate.

> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu=
/drm/rockchip/dw_hdmi_qp-rockchip.c
> --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c

[ ... ]

> @@ -227,7 +228,14 @@ dw_hdmi_qp_rockchip_encoder_atomic_check(struct drm_=
encoder *encoder,
>  	}
> =20
>  	phy_cfg.hdmi.tmds_char_rate =3D conn_state->hdmi.tmds_char_rate;
> -	phy_cfg.hdmi.bpc =3D conn_state->hdmi.output_bpc;
> +	/*
> +	 * YUV422 always transmits two 12-bit components per clock cycle,
> +	 * regardless of the color depth, which from a rate perspective is
> +	 * equivalent to three 8-bit RGB components.  Force 8 bpc here to
> +	 * keep the PHY PLL output aligned with the TMDS character rate.
> +	 */
> +	phy_cfg.hdmi.bpc =3D (s->output_mode =3D=3D ROCKCHIP_OUT_MODE_YUV422 ?
> +				8 : conn_state->hdmi.output_bpc);
> =20
>  	ret =3D phy_configure(hdmi->phy, &phy_cfg);
>  	if (!ret) {
>  		hdmi->tmds_char_rate =3D conn_state->hdmi.tmds_char_rate;
>  		s->output_type =3D DRM_MODE_CONNECTOR_HDMIA;
>  		s->output_bpc =3D conn_state->hdmi.output_bpc;
>  		s->bus_format =3D ingest_fmt;
>  	} else {

[Severity: High]
This is a pre-existing issue, but does
dw_hdmi_qp_rockchip_encoder_atomic_check() mutate hardware state and global
tracking variables during an atomic check?

In the DRM atomic framework, the atomic_check phase is expected to be
side-effect free. However, this code calls phy_configure(), which writes
directly to the PHY hardware registers, and then modifies the global
hdmi->tmds_char_rate variable.

Could this corrupt the active display configuration if userspace performs a
DRM_MODE_ATOMIC_TEST_ONLY commit or if an atomic commit fails a later
validation stage?

Furthermore, if the device is runtime-suspended, could accessing unclocked
hardware registers here trigger a synchronous abort and hang the system?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-dw-hdmi-qp=
-yuv-v1-0-a665cfd06d7d@collabora.com?part=3D7
