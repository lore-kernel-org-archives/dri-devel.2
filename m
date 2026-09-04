Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65DCEC61DD6
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:42:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8194B10E55F;
	Fri,  4 Sep 2026 13:42:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZX01FCF+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CB3310E55F
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 13:42:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7BB1940243;
 Fri,  4 Sep 2026 13:42:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DAD1F00A3D;
 Fri,  4 Sep 2026 13:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788529372;
 bh=wzU4YjPnSETRdodZme4TDyvK+QC9EtY4n+yRYCubHZg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZX01FCF+BY26ep95y1j0Ggg5eTyVHVdVJNvbhbJ6wkGZ22mcxeEQKocLLLDnWI8uM
 Z9B0QGZDOrgeJmcl9JjMvUc3f9cUOAOkbUfaBUd3eFCWMSXk/yCdFKvl5M2fOiJOFq
 6mMYqbNj9mYsO1aIvyr8h2Pyd3CjZsGujPjk2Za6NsKsnyXsJRZSHUz/m27Wa8gRfs
 rGpDdru+IlzblBtoLG9glzq4Na7zs1FqQpoIiFpwOqP4rDOGeJckwpqoos2Lsdv+l5
 Bv4ljVAf9cqJVmJGYMIo7l6Rq4Q02+rkP2PznBwboOk03RIM1pMRgJLWe3pOsgP4Nx
 jjCLs4liQ04kA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/19] drm/bridge: inno-hdmi: Split probe out of bind
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: lee@kernel.org, linux-phy@lists.infradead.org, robh@kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, vkoul@kernel.org,
 neil.armstrong@linaro.org, olteanv@gmail.com, mfd@lists.linux.dev,
 conor+dt@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260904-jh7110-clean-send-v3-7-484f9ae72715@samsung.com>
References: <20260904-jh7110-clean-send-v3-0-484f9ae72715@samsung.com>
 <CGME20260904132721eucas1p2e5f5bb9d907e641c4488908403b9d52f@eucas1p2.samsung.com>
 <20260904-jh7110-clean-send-v3-7-484f9ae72715@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 13:42:50 +0000
Message-Id: <20260904134251.61DAD1F00A3D@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Using `devm_` APIs during the component bind phase causes permanen=
t resource leaks and breaks EPROBE_DEFER.
- [High] The hotplug interrupt handler `inno_hdmi_irq` can fire before the =
bridge is attached, leading to a NULL pointer dereference.
- [High] The I2C adapter is exposed before its private data is initialized,=
 leading to a NULL pointer dereference on concurrent access.
--

commit 72f1334365740cfcdf0865d9dfd6562b9c3b40a8
Author: Michal Wilczynski <m.wilczynski@samsung.com>
Subject: drm/bridge: inno-hdmi: Split probe out of bind

This commit splits the hardware setup of the inno-hdmi driver into a new
inno_hdmi_probe() function. This separates the bridge registration from its
attachment in inno_hdmi_bind(), allowing decoupled MFD/glue drivers to mana=
ge
them independently.

> diff --git a/drivers/gpu/drm/bridge/inno-hdmi.c b/drivers/gpu/drm/bridge/=
inno-hdmi.c
> index dd35f5a875d3d..aab474740f7f5 100644
> --- a/drivers/gpu/drm/bridge/inno-hdmi.c
> +++ b/drivers/gpu/drm/bridge/inno-hdmi.c
> @@ -1061,11 +1061,24 @@ static struct i2c_adapter *inno_hdmi_i2c_adapter(=
struct inno_hdmi *hdmi)
>  	return adap;
>  }

[Severity: High]
This is a pre-existing issue, but the I2C adapter is exposed before its pri=
vate
data is initialized, which can lead to a NULL pointer dereference on concur=
rent
access.

Just above this line, devm_i2c_add_adapter() makes the bus visible to the s=
ystem
before hdmi->i2c is assigned:

    ret =3D devm_i2c_add_adapter(hdmi->dev, adap);
    if (ret) {
        ...
    }

    hdmi->i2c =3D i2c;

If a concurrent I2C transfer is initiated (e.g. via udev running i2cdetect),
inno_hdmi_i2c_xfer() can be invoked. It will read the uninitialized hdmi->i=
2c
and attempt to lock its mutex:

drivers/gpu/drm/bridge/inno-hdmi.c:inno_hdmi_i2c_xfer() {
    struct inno_hdmi_i2c *i2c =3D hdmi->i2c;
    ...
    mutex_lock(&i2c->lock);
    ...
}

Could hdmi->i2c be assigned before calling devm_i2c_add_adapter() to prevent
this race?

> -struct inno_hdmi *inno_hdmi_bind(struct device *dev,
> -				 struct drm_encoder *encoder,
> -				 const struct inno_hdmi_plat_data *plat_data)
> +/**
> + * inno_hdmi_probe - Internal helper to perform common setup
> + * @pdev: platform device
> + * @plat_data: SoC-specific platform data
> + *
> + * This function handles all the common hardware setup: allocating the m=
ain
> + * struct, mapping registers, getting clocks, initializing the hardware,
> + * setting up the IRQ, and initializing the DDC adapter and bridge struc=
t.
> + * It returns a pointer to the inno_hdmi struct on success, or an ERR_PTR
> + * on failure.
> + *
> + * This function is used by modern, decoupled MFD/glue drivers. It regis=
ters
> + * the bridge but does not attach it.
> + */
> +struct inno_hdmi *inno_hdmi_probe(struct platform_device *pdev,
> +				  const struct inno_hdmi_plat_data *plat_data)
>  {

[Severity: High]
This isn't a bug introduced by this patch, but using devm_ APIs in the
component bind phase (now moved to inno_hdmi_probe()) causes permanent
resource leaks and breaks EPROBE_DEFER.

Because inno_hdmi_bind() is called from inno_hdmi_rockchip_bind() (a
component bind callback), the platform device is not removed when a compone=
nt
unbinds. If another component in the DRM pipeline defers, the devm_ resourc=
es
are not freed.

Subsequent bind attempts will fail with -EBUSY when re-requesting the IRQ or
I/O regions:

drivers/gpu/drm/bridge/inno-hdmi.c:inno_hdmi_probe() {
    ...
    ret =3D devm_request_threaded_irq(dev, irq, inno_hdmi_hardirq,
                                    inno_hdmi_irq, IRQF_SHARED,
                                    dev_name(dev), hdmi);
    ...
}

Should this driver be converted to request resources during the actual probe
phase rather than bind?

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

[Severity: High]
This is a pre-existing issue, but this refactoring significantly widens the=
 race
window for a NULL pointer dereference. The hotplug interrupt handler can fi=
re
before the bridge is attached.

inno_hdmi_probe() unmasks the HPD interrupt and registers the IRQ handler w=
ith
devm_request_threaded_irq(). If a monitor is physically connected, the
interrupt can fire immediately.

The IRQ handler then attempts to dereference hdmi->bridge.dev:

drivers/gpu/drm/bridge/inno-hdmi.c:inno_hdmi_irq() {
    ...
    drm_helper_hpd_irq_event(hdmi->bridge.dev);
    ...
}

However, hdmi->bridge.dev is only assigned when drm_bridge_attach() is call=
ed.
Since this patch decouples probe from attach for modern MFD/glue drivers, t=
he
attach phase happens much later, leaving a dangerous race window.

Should the IRQ registration be moved to after the bridge is attached, or sh=
ould
the IRQ handler check if the bridge is attached before proceeding?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-jh7110-cle=
an-send-v3-0-484f9ae72715@samsung.com?part=3D7
