Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C72B9C5DF8C
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 12:58:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0430510E051;
	Sun, 23 Aug 2026 12:58:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J/b43y41";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF59D10E051
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 12:58:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A370841AD7;
 Sun, 23 Aug 2026 12:58:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E571F000E9;
 Sun, 23 Aug 2026 12:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787489880;
 bh=SUZQRXniSg4NqdAsVcSMtBYndzlOneeHYQFa+YCDFaA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=J/b43y41elGgPyzQMaE0gsOZNDqRrACgNBiDRi6rfU4giHL3W9Sc33Up/OGmxY31d
 eWfl5Mub+7ATT8W/eWrI19WIoSMcf/D6cf9P4GSzpqMYoBWCDBF/RzNXshfDt+3Jsa
 w63n7XLP5Pd1FotUJ5FYb8iq6S8cHqSQy6HGJ8PnpzYuSx5ow3HSDqhzVNUesegUMP
 KZ6Km9X+1WCAX4nKpdIWkysfiL8iUd8nJmWHQzhhVKr5ZLbdvgW/OXSfMkQJv77YbA
 +nd5JBXjme2AFbY0FZ97UCTG7991H8rUtEctb5yig64KEvVw/htkJeFe+8LtHJkBwp
 kiAUq8zB8UrHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] drm/rockchip: rk3066_hdmi: convert to
 devm_drm_bridge_alloc() API
To: "Johan Jonker" <jbx6244@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <dea8a038-577b-45da-bff3-703e9099b7e1@gmail.com>
References: <dea8a038-577b-45da-bff3-703e9099b7e1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 12:58:00 +0000
Message-Id: <20260823125800.67E571F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Devres allocations in component bind() cause permanent initializat=
ion failure (-EBUSY) on probe deferral.
- [High] Active devm-managed IRQ and I2C handlers access hardware with the =
clock disabled after unbind(), causing a system crash.
--

--- Patch [1]: [PATCH v1] drm/rockchip: rk3066_hdmi: convert to devm_drm_br=
idge_alloc() API ---
commit 2ee09d3b212b24956cbceb44c6bf494785f5586d
Author: Johan Jonker <jbx6244@gmail.com>

drm/rockchip: rk3066_hdmi: convert to devm_drm_bridge_alloc() API
   =20
The function devm_drm_bridge_alloc() is the new API for allocating DRM
bridges. This conversion was missed during the initial conversion of all
bridges to the new API.

> diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/roc=
kchip/rk3066_hdmi.c
> index f28d6a883e099..39c65ee07caac 100644
> --- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
> +++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c

[ ... ]

> @@ -747,9 +746,10 @@ static int rk3066_hdmi_bind(struct device *dev, stru=
ct device *master,
>  	int irq;
>  	int ret;
> =20
> -	hdmi =3D devm_kzalloc(dev, sizeof(*hdmi), GFP_KERNEL);
> -	if (!hdmi)
> -		return -ENOMEM;
> +	hdmi =3D devm_drm_bridge_alloc(dev, struct rk3066_hdmi, bridge,
> +				     &rk3066_hdmi_bridge_funcs);
> +	if (IS_ERR(hdmi))
> +		return PTR_ERR(hdmi);

[Severity: High]
This is a pre-existing issue, but does using devm_ allocations in the
component bind() function cause a permanent failure on probe deferral?

rk3066_hdmi_bind() allocates devres-managed resources using the component
device, including devm_platform_ioremap_resource() right below this hunk.
Devres actions are tied to the device's probe/remove lifecycle, not the
component bind/unbind lifecycle.

If bind() fails, for example when rk3066_hdmi_register() returns -EPROBE_DE=
FER
due to missing CRTCs, the devres resources are not freed.

When the master DRM device retries probing and calls bind() again,
devm_platform_ioremap_resource() will attempt to request the same physical
memory region via request_mem_region(). Because the first request was never
released by devres, this fails with -EBUSY, preventing the display from ever
initializing.

[Severity: High]
This is a pre-existing issue, but can the active devm-managed IRQ and I2C
handlers access hardware with the clock disabled after unbind(), causing a
system crash?

In rk3066_hdmi_bind(), the HDMI IRQ handler and I2C adapter are registered
using devm_request_threaded_irq() and devm_i2c_add_adapter() on the compone=
nt
device.=20

Because they are devres-managed on the component device's probe/remove
lifecycle, they are not removed when the master DRM device unbinds and calls
rk3066_hdmi_unbind().

In rk3066_hdmi_unbind(), the hardware bus clock is explicitly disabled:

    clk_disable_unprepare(hdmi->hclk);

If an I2C transfer is initiated from userspace (via /dev/i2c-*), or if a
shared IRQ fires after the master is unbound, the still-active handlers
(rk3066_hdmi_i2c_xfer or rk3066_hdmi_hardirq) will execute and access HDMI
hardware registers. Accessing hardware registers while the clock is disabled
causes a synchronous external abort (bus fault), resulting in a kernel pani=
c.

> =20
>  	hdmi->dev =3D dev;
>  	hdmi->drm_dev =3D drm;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/dea8a038-577b-45da-=
bff3-703e9099b7e1@gmail.com?part=3D1
