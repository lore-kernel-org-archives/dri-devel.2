Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E3CC44503
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 22:13:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44BFD10F30C;
	Wed,  8 Jul 2026 22:13:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QYRiQVVR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CDB010F30C
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 22:13:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C19E3601D9;
 Wed,  8 Jul 2026 22:13:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 266FB1F000E9;
 Wed,  8 Jul 2026 22:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783548782;
 bh=P/gg+CaCjmsXVBsMQxP0pFI2Lsw/Kd3DlGYTL4UIgv4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QYRiQVVRDyUfvVIOgc3053mNa3V4PN/KNZvNZrkeU+mDEmlv49d6SWMeOkhrLwYet
 s+pVLMHnBhdXAQFrQc/+0kSRX1Qo9cN/LkdHloJFFVKvjWfTeLPQ+hLIT2hIaCCkUU
 Hl3Wp2ti7zEm9LmPC70EW3o+h6ltFMwJlhV+Kd19bvMsxnIKynN5pf3W/IiNzifjby
 5muTouUnDjsHFjLGZj5XMIAN+QaetXSzARHDwE4L1ZtLedbIdCn9GcKaH2QLKaf5UV
 nGzOhiGxrRs7Z6T353n5TJc1OXsRA/N5Mh/Am5iWpcDXNxdmqSGIsBIC03UHuE0wCk
 4p06ESpYIHFqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/14] drm/rockchip: dw_hdmi_qp: Support 10-bit
 YUV422 output format
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20260709-dw-hdmi-qp-yuv-v3-12-a4a982a9f2e7@collabora.com>
References: <20260709-dw-hdmi-qp-yuv-v3-0-a4a982a9f2e7@collabora.com>
 <20260709-dw-hdmi-qp-yuv-v3-12-a4a982a9f2e7@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 22:13:01 +0000
Message-Id: <20260708221302.266FB1F000E9@smtp.kernel.org>
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
- [High] The `atomic_check` callback unconditionally mutates global driver =
state and configures hardware PHY, breaking DRM atomic design principles an=
d corrupting state during `TEST_ONLY` commits.
--

--- Patch [12]: [PATCH v3 12/14] drm/rockchip: dw_hdmi_qp: Support 10-bit Y=
UV422 output format ---
commit 4acf186e6f48344c73efb358bbf5b17c6a065aa5
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/rockchip: dw_hdmi_qp: Support 10-bit YUV422 output format

This commit adds support for 10-bit YUV422 output via the
MEDIA_BUS_FMT_UYVY10_1X20 format. It also forces 8 bpc for the HDMI PHY
configuration when YUV 4:2:2 is in use to keep the PHY PLL output aligned
with the TMDS character rate.

> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu=
/drm/rockchip/dw_hdmi_qp-rockchip.c
> --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
[ ... ]
> @@ -226,7 +227,14 @@ dw_hdmi_qp_rockchip_encoder_atomic_check(struct drm_=
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

[Severity: High]
This is a pre-existing issue, but does dw_hdmi_qp_rockchip_encoder_atomic_c=
heck
mutate active hardware state and global driver state during TEST_ONLY commi=
ts?

Because atomic_check callbacks are executed when userspace issues a
DRM_MODE_ATOMIC_TEST_ONLY ioctl to probe display configurations, calling
phy_configure() here could actively alter the PHY hardware under an active
display.

Additionally, modifying hdmi->tmds_char_rate mutates global driver state
even if the test commit is subsequently discarded by the kernel, potentially
corrupting the active configuration. Should these side effects be deferred =
to
an atomic_enable or atomic_update callback instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-dw-hdmi-qp=
-yuv-v3-0-a4a982a9f2e7@collabora.com?part=3D12
