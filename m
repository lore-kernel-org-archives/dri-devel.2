Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DBECC6B0F
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 23:13:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4B4A10E989;
	Tue, 13 Oct 2026 23:12:54 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A48A310E989
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 23:12:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5CC4B42D61;
 Tue, 13 Oct 2026 23:12:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E585B1F000FF;
 Tue, 13 Oct 2026 23:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791933168;
 bh=MwwSZ9tU4MCrJ5+lp72ySnRVD9y8LVCfzIVRG0+uc6o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lrv0dJO6c/RTVWqVzCns6Gu7KkB4w1TPgQCmxZ0RaFVYxPu4MXKofTjma+5TcZAvB
 QK7Sc3DpFr1MogqvsYpf2ObwoZtbvHUmfbDqXnJjcMNsz9zK6+Ryb6NXlg5A9X5ngl
 oqIvivXCD9zWT8oudMmTln44+/UzfZIe9K89KFAlAxLavPwt+ufn4/64buzWmOB4Jg
 POdwXbzQIwwdCMafMhLK9mwuXSnItivWqwd+W3bUgn/2iquYnGhxhe/AhsmtyQOj4l
 TubAsxciNuJ7y3WBiu8+3keI2EOj6lEjXTtE9nzYNR618CVizleu7/c/XsnSEKy1rf
 Rc5UxFFyyLm7w==
Message-ID: <sashiko-outbox-170630@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 13/15] drm/rockchip: dw_hdmi_qp: Support 10-bit
 YUV422 output format
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261014-dw-hdmi-qp-yuv-v5-13-6fab0fe43a9b@collabora.com>
References: <20261014-dw-hdmi-qp-yuv-v5-0-6fab0fe43a9b@collabora.com>
 <20261014-dw-hdmi-qp-yuv-v5-13-6fab0fe43a9b@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 23:12:47 +0000
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
- [High] drm/rockchip: dw_hdmi_qp: state leak in atomic_check corrupts PHY =
bpc configuration
--

commit 197f61f0c784edd007d1f4b375c9dad379eab849
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/rockchip: dw_hdmi_qp: Support 10-bit YUV422 output format

This patch adds support for 10-bit YUV 4:2:2 output to the Rockchip DW HDMI=
 QP
encoder by using the MEDIA_BUS_FMT_UYVY10_1X20 format. It also forces 8 bpc
when YUV 4:2:2 is used to keep the PHY PLL output aligned with the TMDS
character rate.

> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu=
/drm/rockchip/dw_hdmi_qp-rockchip.c
> index db1933d75ced5..380dd9ca6870d 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
[ ... ]
> @@ -229,7 +230,14 @@ dw_hdmi_qp_rockchip_encoder_atomic_check(struct drm_=
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

[Severity: High]
Does calling phy_configure() in this atomic check function leak test-only
state to the PHY driver?

Because dw_hdmi_qp_rockchip_encoder_atomic_check() executes during
DRM_MODE_ATOMIC_TEST_ONLY commits, calling phy_configure() here updates the
PHY driver's cached state (like hdmi_cfg.bpc) with test configurations. It
also mutates the global encoder state when it sets hdmi->tmds_char_rate on
success.

If a TEST_ONLY commit changes output_bpc while tmds_char_rate remains
unchanged, the new bpc is cached by the PHY.

A subsequent full modeset on the active state could then hit the early
return earlier in this function:

	if (hdmi->tmds_char_rate =3D=3D conn_state->hdmi.tmds_char_rate &&
	    s->output_bpc =3D=3D conn_state->hdmi.output_bpc &&
	    s->bus_format =3D=3D ingest_fmt)
		return 0;

This would bypass phy_configure() and allow phy_power_on() to apply the
leaked TEST_ONLY bpc state, potentially desynchronizing the PHY PLLs and
corrupting display output.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014-dw-hdmi-qp=
-yuv-v5-0-6fab0fe43a9b@collabora.com?part=3D13
