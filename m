Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF41C55171
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 23:41:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A7BF10E26D;
	Fri, 31 Jul 2026 23:41:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aFGSZicr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE27010E26D
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 23:41:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AB2FE600B0;
 Fri, 31 Jul 2026 23:41:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE751F00AC4;
 Fri, 31 Jul 2026 23:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785541306;
 bh=9Kz2Jdd4EUfbP7yiPBIp3LG0+L2DP1L8Au1EyeOylRE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aFGSZicrgrQzeoTn+IG7WhZjGh/f10nNAmkGHQ2Zqk2zdvJ4g0X+sro7aHES69jcG
 dUM/1WmuY1pS/VzeqNClEDRomffeRHqeNvZFbyUPtDgLJ5vWeYIVfAwhLN41cGLPb5
 GKmM5fTv6CsONmzoVMzp2l+7x9PjY5W6vZwyKMl3gskZpVyBgT5uAeHMoJojL0KiKM
 eljMdItV13dc/oitMwr1UgHqJaXaiHNCAzWbDOiJBztCwg9CjZ0UyHEi/XcakqredI
 4RI2iDX6dAi4HaKVZnVcgGfmRiZTXaZVY1KoslvpWMk1TzF6/pYqmb9NkSXPW9Siw3
 DQgxBmgKOgD8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 54/69] drm/rockchip: rk3066_hdmi: Advertise HDMI 1.4
 capabilities
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260731-dw-hdmi-qp-scramb-v10-54-294364b2cf15@collabora.com>
References: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
 <20260731-dw-hdmi-qp-scramb-v10-54-294364b2cf15@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 23:41:45 +0000
Message-Id: <20260731234146.3DE751F00AC4@smtp.kernel.org>
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
- [High] Using devm_ functions inside a component bind callback causes reso=
urce leaks and permanent re-bind failures.
--

--- Patch [54]: [PATCH v10 54/69] drm/rockchip: rk3066_hdmi: Advertise HDMI=
 1.4 capabilities ---
commit ec81435b2b3f978e3738f994975d9efc7aae982d
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
drm/rockchip: rk3066_hdmi: Advertise HDMI 1.4 capabilities

This patch configures the RK3066 HDMI TX bridge to advertise HDMI 1.4
capabilities. This enables the DRM core to properly filter out modes
that exceed the 340 MHz TMDS limit.

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
This is a pre-existing issue, but I noticed a potential problem in how
resources are managed in this file during component initialization.

Does the use of devm_ functions inside the component bind callback
rk3066_hdmi_bind() cause resource leaks and permanent re-bind failures?

If rk3066_hdmi_bind() or a subsequent component's bind() returns an error
(such as -EPROBE_DEFER from devm_clk_get() or rk3066_hdmi_register()), the
DRM master driver's probe will fail. However, the resources allocated via
devm_kzalloc() and devm_platform_ioremap_resource() in rk3066_hdmi_bind()
are tied to the subcomponent's platform device, which isn't unbound during
this failure.

This means the resources are not freed. On the next probe attempt,
rk3066_hdmi_bind() will execute again and devm_platform_ioremap_resource()
will fail with -EBUSY because the memory region is already exclusively held
by the previous un-freed allocation. This appears to permanently break the
display driver until a system reboot or manual unbind.

Should these allocations be moved to the platform probe callback instead,
or explicitly managed so they can be properly freed in rk3066_hdmi_unbind()?

> =20
>  	hdmi->bridge.ddc =3D rk3066_hdmi_i2c_adapter(hdmi);
>  	if (IS_ERR(hdmi->bridge.ddc))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-dw-hdmi-qp=
-scramb-v10-0-294364b2cf15@collabora.com?part=3D54
