Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A462C61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:01:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 972E710F3B9;
	Fri, 28 Aug 2026 14:01:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OB4qG1sp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C17310F3B9
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:01:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 29DF041153;
 Fri, 28 Aug 2026 14:01:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C641F000E9;
 Fri, 28 Aug 2026 14:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787925678;
 bh=9ekEJRd5FMjnbwKp4zU4Nj6ot2XimkwzMO04o1f9lNI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OB4qG1spJDL2GiHu0RseVakg4F52NZzuZ58eOik2Qse6ngpg+q9k0XVtXSLBLaFGB
 LIJjkW8sqG75c0PzNqzV6cZB7SMchalusi2EJXt0dCu+oh0lzwmT3HPl3/bG57wenN
 dx1jgKELEYB8ixjZCEukoKLehcVMq6TE8mG+mbNxDAGSTEIXdO3tOPUFYZzCvIiOq8
 SmayeT6ieN8WKW5ZxedUizdQCcSz0Lvg8UbZkQ5woMNn2iZenLqYPP1tPQDjhA02+T
 MV52n0lSuhTiCk8ZdXZ7AJA+Y0WnzK9Te0GPIUqztdq9HOlF+PYYICC4qUV2pzgD2Y
 Z0egWlwxKxTlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/15] drm/bridge: inno-hdmi: Split probe out of bind
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: conor+dt@kernel.org, vkoul@kernel.org, olteanv@gmail.com,
 devicetree@vger.kernel.org, robh@kernel.org, linux-phy@lists.infradead.org,
 mfd@lists.linux.dev, lee@kernel.org, dri-devel@lists.freedesktop.org,
 neil.armstrong@linaro.org, linux-clk@vger.kernel.org
In-Reply-To: <20260828-jh7110-clean-send-v2-4-331680c8b9d1@samsung.com>
References: <20260828-jh7110-clean-send-v2-0-331680c8b9d1@samsung.com>
 <CGME20260828134821eucas1p2a29505e5487f9e773a36b5dde7257df1@eucas1p2.samsung.com>
 <20260828-jh7110-clean-send-v2-4-331680c8b9d1@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 14:01:16 +0000
Message-Id: <20260828140117.64C641F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Missing `inno_hdmi_remove` implementation leads to hardware interr=
upt storms and violates API contract.

Pre-existing issues:
- [Critical] HPD IRQ is requested and enabled before bridge attach, leading=
 to NULL pointer dereference in the interrupt handler.
- [High] Resource leak of devm_-managed allocations during component bind r=
etries.
- [High] TOCTOU race exposing the I2C adapter to userspace before internal =
initialization completes.
- [High] Use-after-free in the interrupt handler during device teardown due=
 to incorrect devres registration order.
--

commit 355630a3f7bbfe2d55d6902048b35afc6cb4d58d
Author: Michal Wilczynski <m.wilczynski@samsung.com>

drm/bridge: inno-hdmi: Split probe out of bind
   =20
inno_hdmi_bind() both sets up the bridge and attaches it to a DRM
encoder. A platform whose HDMI controller is a child of a larger device
needs the first half without the second, since it registers as its own
platform driver and lets the DRM core bind the bridge later.
   =20
Move the setup into a new exported inno_hdmi_probe(), with a matching
inno_hdmi_remove(), and reduce inno_hdmi_bind() to a wrapper around it.
   =20
No functional change intended.

> Move the setup into a new exported inno_hdmi_probe(), with a matching
> inno_hdmi_remove(), and reduce inno_hdmi_bind() to a wrapper around it.

[Severity: High]
The commit message mentions adding a matching inno_hdmi_remove() function,
but it does not appear to be implemented in this patch.

Without an exported remove function to safely tear down the hardware and
unmask interrupts, could this lead to hardware interrupt storms if the
platform module is removed or the driver is unbound?

> diff --git a/drivers/gpu/drm/bridge/inno-hdmi.c b/drivers/gpu/drm/bridge/=
inno-hdmi.c
> index 9a62bf59a4033..12fd208d5e852 100644
> --- a/drivers/gpu/drm/bridge/inno-hdmi.c
> +++ b/drivers/gpu/drm/bridge/inno-hdmi.c
[ ... ]
> +struct inno_hdmi *inno_hdmi_probe(struct platform_device *pdev,
> +				  const struct inno_hdmi_plat_data *plat_data)
>  {
> -	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct device *dev =3D &pdev->dev;

[Severity: High]
This isn't a bug introduced by this patch, but there appears to be a
time-of-check to time-of-use (TOCTOU) race condition during I2C adapter
registration within this setup path.

In inno_hdmi_i2c_adapter(), devm_i2c_add_adapter() publishes the adapter
to userspace before assigning hdmi->i2c =3D i2c. If a userspace tool
initiates an I2C transaction concurrently during this small window,
inno_hdmi_i2c_xfer() will attempt to lock i2c->lock using the still-NULL
hdmi->i2c pointer.

Can this lead to a NULL pointer dereference?

[Severity: Critical]
This is a pre-existing issue, but requesting the IRQ before the bridge
is attached seems to cause a crash on decoupled platforms.

During the hardware setup in this path, devm_request_threaded_irq()
requests the hotplug interrupt. If a monitor is already connected, the
interrupt can fire immediately. The handler, inno_hdmi_irq(), unconditional=
ly
calls drm_helper_hpd_irq_event(hdmi->bridge.dev). However, hdmi->bridge.dev
remains NULL until drm_bridge_attach() is called later.

Since this patch explicitly supports decoupled drivers that register
the bridge without immediately attaching it, does this guarantee a boot-time
NULL pointer dereference if a display is connected?

[Severity: High]
This is a pre-existing issue, but there appears to be a devres registration
order issue that leads to a use-after-free.

The IRQ is requested via devm_request_threaded_irq() before the I2C
adapter memory is allocated with devm_kzalloc(). During device teardown,
devres cleans up resources in reverse order, meaning the I2C memory is freed
while the IRQ remains active.

If a hardware interrupt fires during this teardown window,
inno_hdmi_hardirq() will check the dangling pointer and call
inno_hdmi_i2c_irq(), which accesses the already freed memory.

Should the IRQ be requested after all resources it depends on are allocated?

[ ... ]
> +struct inno_hdmi *inno_hdmi_bind(struct device *dev,
> +				 struct drm_encoder *encoder,
> +				 const struct inno_hdmi_plat_data *plat_data)
> +{
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct inno_hdmi *hdmi;
> +	int ret;
> +
> +	hdmi =3D inno_hdmi_probe(pdev, plat_data);
> +	if (IS_ERR(hdmi))
> +		return hdmi;
> +
> +	ret =3D drm_bridge_attach(encoder, &hdmi->bridge, NULL,
> +				DRM_BRIDGE_ATTACH_NO_CONNECTOR);
> +	if (ret)
> +		return ERR_PTR(ret);

[Severity: High]
This isn't a bug introduced by this patch, but if drm_bridge_attach() fails
(for example, due to probe deferral of another bridge), this returns an
error directly without explicitly destroying the devm_ resources allocated
during inno_hdmi_probe().

Since devm_ allocations are tied to the component device's lifetime rather
than the component bind cycle, won't this leak memory and accumulate
duplicate IRQ registrations on each component bind retry?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-jh7110-cle=
an-send-v2-0-331680c8b9d1@samsung.com?part=3D4
