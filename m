Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1215C44508
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 16:06:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45C2910EB62;
	Tue, 14 Jul 2026 16:06:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nClTN4Kf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2FE510E6D2
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 16:06:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 57386601D9;
 Tue, 14 Jul 2026 16:06:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29161F00A3D;
 Tue, 14 Jul 2026 16:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784045160;
 bh=VCFs5WZINprs/GiCYSz4bcffEKQ0Mu3WyvN4pARMDGs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nClTN4KfP85Z7wHRZx8a5E0bSsCS1mhZd+QmLaFBwdCIxpjt+75XYeOE3GejcI3ZV
 u1ZWoAL5svA8aenqeRFB7gJP+2NJ1FmvVnmPSuvRjY7YT9GhhfT9ptmYqUM9NDOk5p
 HkG7W87dCv96nO8kxKOn/gyE2bpfgA+SfNq8TZdHrm7WGNSOnMfMRK1WoczlYhqCIw
 ogVije7H/dWMAiyH7cRg/x2pRdzxXB4hJ/gSIq4CfWnQuZjgPEj9DZOOzp/jn5DNVe
 4pYBniAIq1LRx4YIXLpu1FcW1qFdTYnkIBZv1beYS7q73LXPk6XUx9bFYn6m68wnRa
 +JwFAYgHHcjNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/8] Add Advantech EIO Backlight driver
To: "Ramiro Oliveira" <ramiro.oliveira@advantech.com>
Cc: mfd@lists.linux.dev, linux-hwmon@vger.kernel.org,
 linux-watchdog@vger.kernel.org, dri-devel@lists.freedesktop.org,
 lee@kernel.org
In-Reply-To: <20260714-upstream-v2-v2-5-76e5e41026db@advantech.com>
References: <20260714-upstream-v2-v2-0-76e5e41026db@advantech.com>
 <20260714-upstream-v2-v2-5-76e5e41026db@advantech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 16:05:59 +0000
Message-Id: <20260714160559.B29161F00A3D@smtp.kernel.org>
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
- [High] Partial overwrite of multi-byte integers via 1-byte pointer casts =
corrupts state logic on different architectures.
- [High] Global module parameters are improperly mutated during the device =
probe loop, causing cross-device state contamination.
- [High] The probe function arbitrarily fails if the last evaluated backlig=
ht is unavailable, tearing down successfully initialized devices.
- [High] The backlight enable/disable logic and state initialization are fu=
ndamentally inverted, causing the screen to turn on when blanked and turn o=
ff when activated.
- [Medium] A tautological bounds check unconditionally overwrites the hardw=
are's internal default for the enable-invert pin.
--

--- Patch [5]: [PATCH v2 5/8] Add Advantech EIO Backlight driver ---
commit 7087ac6577d7b4e152b12ed2ee29e0940be894fd
Author: Ramiro Oliveira <ramiro.oliveira@advantech.com>

Add Advantech EIO Backlight driver

This commit introduces a new backlight driver for the Advantech EIO Embedded
controller. It supports up to two backlight devices through PMC read and
write operations. Module parameters are also provided for setting PWM
frequency, polarity, and enable pin polarity.

> diff --git a/drivers/video/backlight/eio_bl.c b/drivers/video/backlight/e=
io_bl.c
> new file mode 100644
> index 0000000000000..c2826400de45b
> --- /dev/null
> +++ b/drivers/video/backlight/eio_bl.c

[ ... ]

> +static int pmc_read(struct device *mfd, u8 ctrl, u8 dev_id, void *data)
> +{
> +	struct pmc_op op =3D {
> +		.cmd       =3D PMC_BL_READ,
> +		.control   =3D ctrl,
> +		.device_id =3D dev_id,
> +		.payload   =3D (u8 *)data,
> +		.size      =3D (ctrl =3D=3D BL_CTRL_FREQ) ? 4 : 1,
> +	};
> +
> +	return eio_core_pmc_operation(mfd, &op);
> +}

[Severity: High]
Does this cast of the data pointer to a single byte payload cause issues
when reading into 32-bit integer variables? Since variables like bri_invert
and bl_power_invert are initialized to -1 (0xFFFFFFFF), writing only a sing=
le
byte to them via this cast will leave the upper bytes intact, potentially
resulting in corrupted values like -256 on little-endian systems.

> +static int bl_update_status(struct backlight_device *bl)
> +{
> +	struct eio_bl_dev *eio_bl =3D bl_get_data(bl);
> +	u8 duty =3D clamp_val(backlight_get_brightness(bl), 0, THERMAL_MAX);
> +	u8 sw =3D backlight_is_blank(bl);
> +	int ret;
> +
> +	/* Setup PWM duty */
> +	ret =3D pmc_write(eio_bl->mfd, BL_CTRL_DUTY, eio_bl->id, &duty);
> +	if (ret)
> +		return ret;
> +
> +	/* Setup backlight enable pin */
> +	return pmc_write(eio_bl->mfd, BL_CTRL_ENABLE, eio_bl->id, &sw);
> +}

[Severity: High]
Is the logic here backwards for enabling the backlight? The function
backlight_is_blank() returns true (1) when the display should be blanked,
but passing this directly to BL_CTRL_ENABLE would turn the screen on
(since BL_ENABLE_ON is 0x01).

[ ... ]

> +static int bl_init(struct device *dev, int id,
> +		   struct backlight_properties *props)
> +{
> +	int ret;
> +	u8 enabled =3D 0;
> +	u8 status =3D 0;

[ ... ]

> +	/* Invert PWM */
> +	if (bri_invert > USE_DEFAULT) {
> +		ret =3D pmc_write(dev, BL_CTRL_INVERT, id, &bri_invert);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret =3D pmc_read(dev, BL_CTRL_INVERT, id, &bri_invert);

[Severity: High]
Could reading the hardware state directly into the global module parameter
bri_invert cause problems for systems with multiple backlight devices?
When bl_probe() loops over multiple devices, the hardware state from the
first device permanently overwrites the global parameter, which would then
contaminate the configuration for the second device.

[ ... ]

> +	if (bl_power_invert >=3D USE_DEFAULT) {
> +		ret =3D pmc_write(dev, BL_CTRL_ENABLE_INVERT, id, &bl_power_invert);
> +		if (ret)
> +			return ret;
> +	}

[Severity: Medium]
Since bl_power_invert is initialized to USE_DEFAULT, does this >=3D conditi=
on
always evaluate to true (-1 >=3D -1)? This seems to cause an unconditional
pmc_write() that could overwrite the hardware's internal default state for
the enable-invert pin.

> +	ret =3D pmc_read(dev, BL_CTRL_ENABLE_INVERT, id, &bl_power_invert);
> +	if (ret)
> +		return ret;
> +
> +	/* Read power state */
> +	ret =3D pmc_read(dev, BL_CTRL_ENABLE, id, &enabled);
> +	if (ret)
> +		return ret;
> +
> +	props->power =3D enabled ? BACKLIGHT_POWER_OFF : BACKLIGHT_POWER_ON;

[Severity: High]
Does this initialization map the power state inversely? If enabled is true,
assigning BACKLIGHT_POWER_OFF seems to indicate the backlight is off when
the hardware is actually enabled.

[ ... ]

> +static int bl_probe(struct platform_device *pdev)
> +{
> +	u8 id;
> +	int ret;
> +	struct device *dev =3D &pdev->dev;
> +	struct eio_dev *eio_dev =3D dev_get_drvdata(dev->parent);

[ ... ]

> +	for (id =3D 0; id < BL_MAX; id++) {
> +		char name[32];
> +		struct backlight_properties props;
> +		struct eio_bl_dev *eio_bl;
> +		struct backlight_device *bl;
> +
> +		memset(&props, 0, sizeof(props));
> +		props.type           =3D BACKLIGHT_RAW;
> +		props.max_brightness =3D THERMAL_MAX;
> +		props.power          =3D BACKLIGHT_POWER_OFF;
> +		props.brightness     =3D props.max_brightness;
> +		props.scale	     =3D BACKLIGHT_SCALE_NON_LINEAR;
> +
> +		eio_bl =3D devm_kzalloc(dev, sizeof(*eio_bl), GFP_KERNEL);
> +		if (!eio_bl)
> +			return -ENOMEM;
> +
> +		eio_bl->mfd =3D dev->parent;
> +		eio_bl->id  =3D id;
> +
> +		ret =3D bl_init(eio_bl->mfd, id, &props);
> +		if (ret) {
> +			dev_info(dev, "%d No Backlight %u enabled!\n", ret, id);
> +			continue;
> +		}
> +
> +		snprintf(name, sizeof(name), "%s%u", pdev->name, id);
> +
> +		bl =3D devm_backlight_device_register(dev, name, dev, eio_bl,
> +						    &bl_ops, &props);
> +
> +		if (IS_ERR(bl)) {
> +			ret =3D PTR_ERR(bl);
> +			if (ret =3D=3D -EPROBE_DEFER)
> +				return ret;
> +
> +			dev_err(dev, "register %s failed: %d\n", name, ret);
> +			continue;
> +		}
> +	}
> +	return ret;
> +}

[Severity: High]
If the first device initializes successfully but a subsequent iteration
fails bl_init() (such as when a port is unpopulated), ret is updated and
the loop continues. Does this result in bl_probe() returning an error code
at the end, causing the successfully initialized first device to be torn
down by devres?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-upstream-v=
2-v2-0-76e5e41026db@advantech.com?part=3D5
