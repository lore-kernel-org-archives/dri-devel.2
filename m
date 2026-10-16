Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5B5CCA46C
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 16:39:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C94C210E362;
	Fri, 16 Oct 2026 16:39:44 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E90710E362
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 16:39:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2322260008;
 Fri, 16 Oct 2026 16:39:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7491E1F000C4;
 Fri, 16 Oct 2026 16:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792168777;
 bh=mu5Or24tAvvN5+fThhSll8YuACjLcuqS/05wCRz8M40=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TZp0Nc475kkzdpWZEJMAFQF5eNY6VLidiNVrAvZ2AdGDQnN1o9EsEVUpReJC434KS
 Vt1Slo0dCvBLK427Qp7K87COm9qoHZ71DL0dyCqTjiyZmkKFVZse/+Kv6K9XRKlvoR
 hfLRBnJL6g8i8xlfYas9mugeksUFFQAErBYSHUkVXlHXhvBkop4LcLEOLljI/puIWc
 tidV4lxlb0nVkket5HQcjg/bvWul697W1KUhM1oDl3mECn5Ibv3j4ZnQ6PyeJJzvth
 foXfyGapn/e+4HyUCoyanmN99aCPjm2TUqHmFfU1elxYjhhIYXRuuNvhZYYdRYAbWG
 fgKaTtKA9aRBg==
Message-ID: <sashiko-outbox-174655@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] backlight: Add Awinic AW99703 backlight driver
To: "Luka Panio" <lukapanio@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 lee@kernel.org
In-Reply-To: <20261016162912.64581-3-lukapanio@gmail.com>
References: <20261016162912.64581-1-lukapanio@gmail.com>
 <20261016162912.64581-3-lukapanio@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 16:39:36 +0000
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
- [High] build: Incompatible pointer type passed to device_property_read_u3=
2()
- [Medium] gpio: Hardware left powered on upon early probe failure
- [Low] backlight: TOCTOU race in aw99703_shutdown() missing update_lock
--

commit b010e2c6526192785d6b65bcadf761f3928c7acd
Author: Luka Panio <lukapanio@gmail.com>

backlight: Add Awinic AW99703 backlight driver

Add a driver for the Awinic AW99703 3-string WLED backlight controller.

> diff --git a/drivers/video/backlight/aw99703.c b/drivers/video/backlight/=
aw99703.c
> new file mode 100644
> index 0000000000000..b0a46753d1765
> --- /dev/null
> +++ b/drivers/video/backlight/aw99703.c
[ ... ]
> +static void aw99703_dt_parse(struct aw99703_device *aw,
> +			     struct backlight_properties *props)
> +{
[ ... ]
> +	props->max_brightness =3D AW99703_MAX_BRT_LVL;
> +	device_property_read_u32(aw->dev, "max-brightness",
> +				 &props->max_brightness);

[Severity: High]
Does this code trigger a -Wincompatible-pointer-types build failure?

device_property_read_u32() expects a u32 * as its third argument, but
&props->max_brightness is a pointer to int. In recent kernel builds, this
warning is promoted to a fatal error.

> +	if (props->max_brightness > AW99703_MAX_BRT_LVL)
> +		props->max_brightness =3D AW99703_MAX_BRT_LVL;
> +
> +	props->brightness =3D props->max_brightness >> 1;
> +	device_property_read_u32(aw->dev, "default-brightness",
> +				 &props->brightness);

[Severity: High]
Similarly, &props->brightness is also a pointer to int.

[ ... ]
> +static void aw99703_power_off(void *data)
> +{
> +	struct aw99703_device *aw =3D data;
> +
> +	aw99703_update_brightness(aw, 0);
> +	gpiod_set_value_cansleep(aw->hwen_gpio, 0);
> +}
> +
> +static int aw99703_probe(struct i2c_client *client)
> +{
[ ... ]
> +	if (aw->hwen_gpio) {
> +		ret =3D gpiod_direction_output(aw->hwen_gpio, 1);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "failed to drive enable gpio\n");
> +		fsleep(AW99703_HWEN_ON_DELAY_US);
> +	}
> +
> +	ret =3D aw99703_chip_id_read(aw);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "chip id check failed\n");

[Severity: Medium]
If the chip ID read fails, does this return without de-asserting the GPIO?

The probe function sets the hwen_gpio output to 1 to power on the chip,
but if aw99703_chip_id_read() or aw99703_hw_init() fail, it returns an
error code immediately. Since the devm_add_action_or_reset() for
aw99703_power_off is registered later in the function, the cleanup
action won't execute on early probe failure, leaving the hardware
permanently enabled.

> +
> +	props.type =3D BACKLIGHT_RAW;
> +	aw99703_dt_parse(aw, &props);
> +	aw99703_read_boot_brightness(aw, &props);
> +
> +	ret =3D aw99703_hw_init(aw);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to initialize chip\n");
> +
> +	ret =3D devm_add_action_or_reset(dev, aw99703_power_off, aw);
[ ... ]
> +static void aw99703_shutdown(struct i2c_client *client)
> +{
> +	aw99703_power_off(i2c_get_clientdata(client));
> +}

[Severity: Low]
Is there a data race between this shutdown callback and concurrent sysfs
writes to the brightness attribute?

aw99703_shutdown() invokes aw99703_power_off(), which modifies the
aw->bl_enable flag and writes to I2C registers via aw99703_update_brightnes=
s()
without acquiring the backlight bd->update_lock mutex. Since userspace tasks
are not frozen during system shutdown, a concurrent sysfs operation could
attempt to communicate with the chip while its registers are being written
or after the power pin is de-asserted.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016162912.6458=
1-1-lukapanio@gmail.com?part=3D2
