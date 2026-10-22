Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499BC606A31B
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ilKJeme/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAEF211265E;
	Thu, 22 Oct 2026 13:38:52 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED98C112624;
 Thu, 22 Oct 2026 13:38:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B58CE417F7;
 Thu, 22 Oct 2026 13:38:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535AE1F000C1;
 Thu, 22 Oct 2026 13:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792676325;
 bh=ULYZ/55QiRddvfDhSSFtUGP38N9/fKV9BspCQGFIXXY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ilKJeme/HkOCKSlSoyh0+0sFTsIhd0temS8j1xbMB9yw9gFqB4SKz27idnxkALOWj
 Y6W9a4l1Qz//YiB4jKEiK5Rb97nxmRu7G6DR/b0EA5C3TN/p9PjALEPAfnreVP0vyf
 DnzR3ubExHV8met34jnepcdCRVJCM1TuX2G1hgS0ShBd8JMEsHiEbEg/uH19f21+Eq
 QDiC8b4s+EPMsCIrq1tXzD1FfuwHefifCDPtg8ZAy3MSPAX5SloC3r9AQc/RlhaZsm
 erm2j/FwJtSQyWWKeGNLxazVt4hpSj0FVNufGG8u8R4S1mMzZB/LKwUIiN3OxlP4M5
 1+NFtnLXCc9sg==
Message-ID: <sashiko-outbox-181556@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/9] drm/bridge: pass extra events to the HPD callback
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-amlogic@lists.infradead.org, neil.armstrong@linaro.org
In-Reply-To: <20261022-hpd-irq-events-v6-4-337ea3ddaa62@oss.qualcomm.com>
References: <20261022-hpd-irq-events-v6-0-337ea3ddaa62@oss.qualcomm.com>
 <20261022-hpd-irq-events-v6-4-337ea3ddaa62@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 13:38:44 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] drm/bridge: misplaced hdmi5_bridge_hpd_notify() hunk breaks bisecta=
bility
--

commit c6cd0e6e9f3efd88f40aba30dc7463e072351c53
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/bridge: pass extra events to the HPD callback

This commit adds drm_bridge_hpd_notify_extra() and updates the HPD callback
signature registered via drm_bridge_hpd_enable() to pass extra sink events
such as DisplayPort IRQ_HPD to underlying drivers.

[ ... ]

> diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi5.c b/drivers/gpu/drm/omapdr=
m/dss/hdmi5.c
> index c542ba6ce7d32..a21f9355594cc 100644
> --- a/drivers/gpu/drm/omapdrm/dss/hdmi5.c
> +++ b/drivers/gpu/drm/omapdrm/dss/hdmi5.c
> @@ -427,7 +427,8 @@ static void hdmi5_bridge_disable(struct drm_bridge *b=
ridge,
> =20
>  static void hdmi5_bridge_hpd_notify(struct drm_bridge *bridge,
>  				    struct drm_connector *connector,
> -				    enum drm_connector_status status)
> +				    enum drm_connector_status status,
> +				    enum drm_connector_dp_event event)
>  {
>  	struct omap_hdmi *hdmi =3D drm_bridge_to_hdmi(bridge);
> =20

[Severity: Low]
In drivers/gpu/drm/omapdrm/dss/hdmi5.c, hdmi5_bridge_hpd_notify() is assign=
ed
to struct drm_bridge_funcs.hpd_notify rather than registered via
drm_bridge_hpd_enable():

static const struct drm_bridge_funcs hdmi5_bridge_funcs =3D {
	...
	.hpd_notify =3D hdmi5_bridge_hpd_notify,
	.edid_read =3D hdmi5_bridge_edid_read,
};

The hpd_notify callback signature in struct drm_bridge_funcs (in
include/drm/drm_bridge.h) and the other in-tree implementations (including
hdmi4_bridge_hpd_notify() in drivers/gpu/drm/omapdrm/dss/hdmi4.c) were
updated in parent commit 9cf55ff0f96b ("drm/bridge: pass down IRQ_HPD to the
drivers").

Because the hdmi5_bridge_hpd_notify() update landed in this patch instead,
building the kernel at commit 9cf55ff0f96b with CONFIG_DRM_OMAP and
CONFIG_OMAP5_DSS_HDMI enabled fails with an incompatible function pointer t=
ype
error when initializing hdmi5_bridge_funcs.hpd_notify.

Should this hunk be moved into commit 9cf55ff0f96b ("drm/bridge: pass down
IRQ_HPD to the drivers") to preserve bisectability?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-hpd-irq-ev=
ents-v6-0-337ea3ddaa62@oss.qualcomm.com?part=3D4
