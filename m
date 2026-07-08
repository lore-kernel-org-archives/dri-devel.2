Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67419C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 22:15:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D57A410F30E;
	Wed,  8 Jul 2026 22:15:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lJ5N/A7d";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2066F10F30E
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 22:15:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6A3346001A;
 Wed,  8 Jul 2026 22:15:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39551F000E9;
 Wed,  8 Jul 2026 22:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783548943;
 bh=7DTJJU6TlX9Bg2RWnPOawNG7pfIEmDlVMYVPRfNZoVg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lJ5N/A7d1GPYbKaAlGkZ+p5EzTNQN1W/0ZsotGYkRcNqJznxV9b868O51u5N/zsYM
 Yr2oe4qhmUIcQ0L4y4LtxVDcx3Ri6/4qpn2W7xGISzJHoqx9rbjdQT22pYsxfVa708
 tOdEB5x2Ja6J6QF5RAufbMDpb5FPsIONKGg/xxXr/GbQkVA8yN5en4KjO5tNrDs7eP
 Og6oZ0KFkcOTXIB28HsYiJQng2V+L8BZAZsVlvk4RC4QTXL8IdWPdNQHOsXPyQl++4
 IECXZ4lUMl1P/A5YTttJd581x2api0T2xTE8c6ApMpGcjE674C5j9JPMKxnlz5lobF
 O8J3c6JkbrIIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/14] drm/rockchip: dw_hdmi_qp: Enable YUV420 output
 format
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260709-dw-hdmi-qp-yuv-v3-13-a4a982a9f2e7@collabora.com>
References: <20260709-dw-hdmi-qp-yuv-v3-0-a4a982a9f2e7@collabora.com>
 <20260709-dw-hdmi-qp-yuv-v3-13-a4a982a9f2e7@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 22:15:41 +0000
Message-Id: <20260708221542.C39551F000E9@smtp.kernel.org>
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
- [High] Modifying hardware or global driver state within atomic_check call=
back.
--

--- Patch [13]: [PATCH v3 13/14] drm/rockchip: dw_hdmi_qp: Enable YUV420 ou=
tput format ---
commit 886f3880152ce2fc09e568484e921ca99dad89d4
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/rockchip: dw_hdmi_qp: Enable YUV420 output format

Both RK3576 and RK3588 SoCs are capable of driving the YUV420 output
color format, and the required bus-format handling and VOP2 support are
already in place.  Advertise it via the platform supported formats so
the HDMI core can select it.

YUV420 halves the TMDS bandwidth compared to RGB/YUV444, which enables
high-resolution modes such as 4K@60Hz on links that cannot otherwise
carry the full-bandwidth signal.

> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu=
/drm/rockchip/dw_hdmi_qp-rockchip.c
> index 78473f9a0fce3..1af29066a0a31 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but I noticed something concerni=
ng
in dw_hdmi_qp_rockchip_encoder_atomic_check() in this same file:

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

Does this code accidentally configure the hardware PHY and modify global
driver state (hdmi->tmds_char_rate) during the atomic_check phase?

When userspace performs an atomic modeset with the DRM_MODE_ATOMIC_TEST_ONLY
flag, dw_hdmi_qp_rockchip_encoder_atomic_check() is invoked to validate the
state. Modifying hardware or global state here breaks the guarantee that
atomic test-only commits are free of side effects. This could cause the
hardware state to desynchronize from the DRM core's expectations.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-dw-hdmi-qp=
-yuv-v3-0-a4a982a9f2e7@collabora.com?part=3D13
