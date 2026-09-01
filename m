Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E2D5C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 20:24:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2888D10E259;
	Tue,  1 Sep 2026 20:24:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NMGmQdqS";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3434A10E259
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 20:24:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F2DB041644;
 Tue,  1 Sep 2026 20:24:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC431F000E9;
 Tue,  1 Sep 2026 20:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788294296;
 bh=sY1MV/aJmbhll6IpE85AlLpiMCq+eVtABRrN6TXDVdg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NMGmQdqSEy+Xffvi13OpuTuSjxjilvuKpz7khUKGsLkA++cu+Rq2B2j2g30yEwDc0
 X8NspWUiO+be8KepwQaKx/SfRm1ThA6KKZ2HLaoi6ZKFsqpMgAfBYAWuF4StmU5cqd
 g3IUa/5EMid7rKhxVqLi8FUKNqLEK1EMKX1OPNqrslsjg+we25Qb2Jzin/aOuUieTL
 BuTDX/+Oa6Mre7aCMaJJv94sWP+Y7C4aaIoPbR5MCjBKSQUUVUMKieOpaS5Ws0jxQr
 WPDZjBJqM5oxpYDbzS3ED2sf6IXxb4mQ3/AtlzPphQoAj4PjZgGxCStcXlUB/uaN7T
 5yB2dV3wSfAEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 56/74] drm/rockchip: rk3066_hdmi: Advertise HDMI 1.4
 capabilities
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-56-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
 <20260901-dw-hdmi-qp-scramb-v11-56-bc12954a0688@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 20:24:56 +0000
Message-Id: <20260901202456.9FC431F000E9@smtp.kernel.org>
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
- [High] Sleeping function usleep_range() called from atomic context in bri=
dge callbacks.
--

commit e5405bf223ae48e74dcd786c773802d19ff07667
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/rockchip: rk3066_hdmi: Advertise HDMI 1.4 capabilities

This commit advertises HDMI 1.4 capabilities for the RK3066 HDMI TX bridge.
This ensures that display modes exceeding the 340 MHz TMDS limit are
properly rejected by the core DRM API.

> diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/roc=
kchip/rk3066_hdmi.c
> index f28d6a883e099..f748700b0ba6c 100644
> --- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
> +++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
[ ... ]
> @@ -712,6 +713,7 @@ rk3066_hdmi_register(struct drm_device *drm, struct r=
k3066_hdmi *hdmi)
>  	hdmi->bridge.type =3D DRM_MODE_CONNECTOR_HDMIA;
>  	hdmi->bridge.vendor =3D "Rockchip";
>  	hdmi->bridge.product =3D "RK3066 HDMI";
> +	hdmi->bridge.supported_hdmi_ver =3D HDMI_VERSION_1_4;

[Severity: High]
This isn't a bug introduced by this patch, but there is a pre-existing issue
with this bridge driver's atomic callbacks. The DRM subsystem defines atomic
enable and disable callbacks as atomic context paths where sleeping is
strictly forbidden.

However, the bridge callbacks in drivers/gpu/drm/rockchip/rk3066_hdmi.c
appear to call sleeping functions:

rk3066_hdmi_bridge_atomic_disable() directly calls:
    usleep_range(500, 510);

Additionally, the atomic enable path calls rk3066_hdmi_set_power_mode(),
which does:
    usleep_range(90, 100);

Could these sleeping delays cause kernel warnings or potential deadlocks
during atomic commits? Would it be safer to replace these usleep_range()
calls with non-sleeping delay functions like udelay() since they execute
in an atomic context?

> =20
>  	hdmi->bridge.ddc =3D rk3066_hdmi_i2c_adapter(hdmi);
>  	if (IS_ERR(hdmi->bridge.ddc))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-dw-hdmi-qp=
-scramb-v11-0-bc12954a0688@collabora.com?part=3D56
