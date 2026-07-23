Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F5F6C44532
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 01:52:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B608510EF56;
	Thu, 23 Jul 2026 01:52:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B4MImNFO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40B0710EF56
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 01:52:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 29C7A41311;
 Thu, 23 Jul 2026 01:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3911F000E9;
 Thu, 23 Jul 2026 01:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784771541;
 bh=6FWO1yh2ahSgwSdyb0AymlvjvW4KFjGkextkVbB4ZUo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=B4MImNFOrHp/7/q+n8H6HV3ZhcRPUyJT+A6pK3d45GWAVqsOPM0kgZ4qhA0U+WNT3
 vcfWQi5KiRP9AfSX49zJLb11nwVUB5HiaqNXYzlt/osEFQeC7ZUjlOLrkxctgn06Yo
 q+pyj7WWtyXJmAuUdJ5DjuN+OoFP86vTUVmErGg2H7lvBLO0MU4M3gX442//ktFjXu
 CNRlZVA4Z+QCHq87W2pxIsgeKb1xV0E5YpBLP/X7+K4A3HK0kb2TTPiLOgE2hRXogZ
 iTWAZZxz+T3lbFkPGEe4NazYLdlUjAynHEH3KxbbQnfw46QaZLcFr7MuEvNDdqCMlb
 okt1Lr1bNPJNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 20/61] drm/bridge: dw-hdmi-qp: Provide
 .{enable,disable}_hpd() PHY ops
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260723-dw-hdmi-qp-scramb-v9-20-4fb12ea22ac9@collabora.com>
References: <20260723-dw-hdmi-qp-scramb-v9-0-4fb12ea22ac9@collabora.com>
 <20260723-dw-hdmi-qp-scramb-v9-20-4fb12ea22ac9@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 01:52:20 +0000
Message-Id: <20260723015220.CC3911F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The patch fails to achieve its stated goal of preventing prematu=
re HPD interrupt delivery because the underlying PHY driver was not updated=
 and HPD remains statically armed.
- [Medium] The bridge implements `.hpd_enable` but never calls `drm_bridge_=
hpd_notify()`, bypassing the DRM core's hot-plug notification callback.
--

--- Patch [20]: [PATCH v9 20/61] drm/bridge: dw-hdmi-qp: Provide .{enable,d=
isable}_hpd() PHY ops ---
commit 1e237fa22e4f4ffd6fd8e88a7191823f910b5d7a
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/bridge: dw-hdmi-qp: Provide .{enable,disable}_hpd() PHY ops

This commit implements the .hpd_enable() and .hpd_disable() bridge callbacks
for the dw-hdmi-qp driver and extends dw_hdmi_qp_phy_ops with corresponding
hooks. The goal is to allow the DRM core to control when HPD interrupts are
armed to prevent premature delivery.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/d=
rm/bridge/synopsys/dw-hdmi-qp.c
> index 7475b6b71836b..a0613f0d2ebcf 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> @@ -1189,6 +1189,22 @@ static int dw_hdmi_qp_cec_transmit(struct drm_brid=
ge *bridge, u8 attempts,
>  #define dw_hdmi_qp_cec_transmit NULL
>  #endif /* CONFIG_DRM_DW_HDMI_QP_CEC */
> =20
> +static void dw_hdmi_qp_bridge_hpd_enable(struct drm_bridge *bridge)
> +{
> +	struct dw_hdmi_qp *hdmi =3D bridge->driver_private;
> +
> +	if (hdmi->phy.ops->enable_hpd)
> +		hdmi->phy.ops->enable_hpd(hdmi, hdmi->phy.data);
> +}

[Severity: Medium]
The commit message states this change enables the DRM core to control when =
HPD
interrupts are armed to prevent premature interrupt delivery.

Does this actually prevent premature delivery? Looking at dw_hdmi_qp_init_h=
w(),
it still unconditionally calls the setup_hpd hook, which statically unmasks
the HPD interrupt before the DRM core assumes control.

Additionally, if the underlying PHY driver hasn't been updated to implement
these new enable_hpd/disable_hpd hooks, won't these callbacks just be silent
no-ops, leaving HPD statically armed?

[Severity: Medium]
By implementing .hpd_enable, the driver opts into the dynamic HPD
notification API.

This API contract expects the driver to call drm_bridge_hpd_notify() when an
HPD event occurs, so the DRM core can execute its registered callback. Since
dw-hdmi-qp.c neither calls drm_bridge_hpd_notify() nor provides a way for t=
he
platform wrapper to trigger it, won't the DRM core's hot-plug notification
callback remain unexecuted?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-dw-hdmi-qp=
-scramb-v9-0-4fb12ea22ac9@collabora.com?part=3D20
