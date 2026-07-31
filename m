Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958C3C5516F
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 23:10:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8EF810E23F;
	Fri, 31 Jul 2026 23:10:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TMPeKzxY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B34A10E23F
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 23:10:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6E166600B0;
 Fri, 31 Jul 2026 23:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48D91F00AC4;
 Fri, 31 Jul 2026 23:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785539430;
 bh=oCfdB9hYafhgoEcwQoI2YHadEIE09pnI1XVWbUmBxGk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TMPeKzxYzaEoZn3J+AVCfdCRcwpCQwlB2PugXIgs0tj1zgfPTGNtelqiMxJLcalVe
 +quTXXzh2aYrAOpLKdb+NCyGeuJ/idNZLH80o2fTPd8CJMj2qkSHjeSQT4SDfZuDDI
 dYqBrlIDumsBh9eTb9i3s3FlpZuSEhSoE3qmb9Z7VLwmKD6bKOxOUYCR6rOkrUaHnT
 uq/MLXdo7asr8U6jpIGVBD6PVwV+wv+AFttVrhbWBnixN3QeTWFXBIMlqa3+nReJVp
 yJ/18ARo6k6AuyVqds2mDWWkMw7/5/XJ3ajpU3aDN0i2bN2eGdRBW7ARTqwseOBLh9
 4D4IuHSGamFZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 49/69] drm/bridge: inno-hdmi: Advertise HDMI 1.2
 capabilities
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260731-dw-hdmi-qp-scramb-v10-49-294364b2cf15@collabora.com>
References: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
 <20260731-dw-hdmi-qp-scramb-v10-49-294364b2cf15@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 23:10:29 +0000
Message-Id: <20260731231029.D48D91F00AC4@smtp.kernel.org>
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
- [High] The I2C adapter is registered and exposed before `hdmi->i2c` is as=
signed, creating a race window where an I2C transfer can trigger a NULL poi=
nter dereference.
- [High] The threaded IRQ is requested before the DRM bridge is fully initi=
alized and attached, causing a NULL pointer dereference if an early interru=
pt fires.
--

--- Patch [49]: [PATCH v10 49/69] drm/bridge: inno-hdmi: Advertise HDMI 1.2=
 capabilities ---
commit edc5142ea37d19616540dca30f30fcf265c228eb
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/bridge: inno-hdmi: Advertise HDMI 1.2 capabilities

Bridges using DRM_BRIDGE_OP_HDMI are now expected to also provide a
supported HDMI version.  This is not yet enforced, but will become
mandatory once the migration to the new caps-based HDMI connector
initialization API is completed.

Since inno_hdmi_phy_config.pixelclock does not exceed 165 MHz for any of
the chip variants handled by the driver, advertise HDMI 1.2 as the
supported version.

> diff --git a/drivers/gpu/drm/bridge/inno-hdmi.c b/drivers/gpu/drm/bridge/=
inno-hdmi.c
> index dd35f5a875d3d..ea3447d4f285b 100644
> --- a/drivers/gpu/drm/bridge/inno-hdmi.c
> +++ b/drivers/gpu/drm/bridge/inno-hdmi.c
> @@ -1119,6 +1119,7 @@ struct inno_hdmi *inno_hdmi_bind(struct device *dev,
>  	hdmi->bridge.type =3D DRM_MODE_CONNECTOR_HDMIA;
>  	hdmi->bridge.vendor =3D "Inno";
>  	hdmi->bridge.product =3D "Inno HDMI";

[Severity: High]
This is a pre-existing issue, but is it possible for an early interrupt to
cause a NULL pointer dereference here?

Earlier in inno_hdmi_bind(), devm_request_threaded_irq() is called, which
can enable the IRQ and trigger inno_hdmi_irq() before the bridge is fully
initialized. If that happens, inno_hdmi_irq() calls:
drm_helper_hpd_irq_event(hdmi->bridge.dev).

However, hdmi->bridge.dev is not initialized until drm_bridge_attach() is
called later in the inno_hdmi_bind() sequence. Will this lead to
drm_helper_hpd_irq_event() dereferencing a NULL pointer?

> +	hdmi->bridge.supported_hdmi_ver =3D HDMI_VERSION_1_2;
> =20
>  	hdmi->bridge.ddc =3D inno_hdmi_i2c_adapter(hdmi);

[Severity: High]
This isn't a bug introduced by this patch, but does registering the I2C
adapter before assigning the internal data structure pointer create a race
condition?

Inside inno_hdmi_i2c_adapter(), devm_i2c_add_adapter(hdmi->dev, adap) is
called before hdmi->i2c =3D i2c is set.

If a concurrent I2C transfer is initiated (for example, from userspace via
i2c-dev) immediately after registration, the transfer callback
inno_hdmi_i2c_xfer() will execute.

When inno_hdmi_i2c_xfer() runs, it does:

struct inno_hdmi_i2c *i2c =3D hdmi->i2c;
mutex_lock(&i2c->lock);

Could this dereference the uninitialized hdmi->i2c pointer, causing a crash?

>  	if (IS_ERR(hdmi->bridge.ddc))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-dw-hdmi-qp=
-scramb-v10-0-294364b2cf15@collabora.com?part=3D49
