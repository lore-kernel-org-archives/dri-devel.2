Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B055CD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 12:16:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D119110E3C8;
	Mon, 15 Jun 2026 12:16:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k4rexQuW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EED2D10E3C8
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 12:16:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CD58243EE2;
 Mon, 15 Jun 2026 12:16:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25F41F000E9;
 Mon, 15 Jun 2026 12:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781525811;
 bh=9iqVy+5+rJXm592HelTq9mDfS/LD1A876hdQuh6hkaY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=k4rexQuWEzHcDIa3/xN5n7hsNV4UKB6i2J2slVzKJrwsynxinZ3KZc0+RfalDv/wu
 LqNKZZdUTQKFQU6lbfke4k4jTnyUcrYxrJjTkr1KXweivpS8ZYa5ujLx3ZZrO+kUzQ
 8VDuswC2T1prEAL1U7Oz/K2FP/vFv+11tHAos6uypeGfPh4nOZn8U/W/+k167ElAyJ
 6oGZcKcLaAPUJ68vJSxorJz/ub3aC4NNi5xlNmqRhINqftfBmEnKgsSTeep5qikC+h
 bH0A4opuPmA9qr8zJTdnczwCM+xjLiV25gwY0dB2+nHOYCu9FBeghsq/riklvLRbIX
 Hk6h3qgy+NX8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] backlight: lp8864: Convert from LED to backlight
 class driver
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org
In-Reply-To: <20260615120353.3409035-4-alexander.sverdlin@siemens.com>
References: <20260615120353.3409035-4-alexander.sverdlin@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 12:16:50 +0000
Message-Id: <20260615121650.F25F41F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Hardcoded backlight device name prevents probing multiple device i=
nstances.
- [High] Unclamped device tree brightness properties bypass limits and caus=
e hardware wraparound.
- [High] The LED class interface completely ignores DT backlight limits, al=
lowing userspace to overdrive the display.
- [Medium] Concurrent sysfs writes from the backlight and LED subsystems ca=
use a data race on `priv->led_status_mask`.
--

commit 3a876b5316e78acf44b2217cdc076c3285471e8a
Author: Alexander Sverdlin <alexander.sverdlin@gmail.com>

backlight: lp8864: Convert from LED to backlight class driver
   =20
Move the TI LP8864/LP8866 driver from drivers/leds/ to drivers/video/backli=
ght/
and convert it to register a backlight class device. The driver preserves
backward-compatible LED class device registration if the "led" child node is
present.

> diff --git a/drivers/video/backlight/lp8864_bl.c b/drivers/video/backligh=
t/lp8864_bl.c
> index d05211b970c94..67b28f7daedd2 100644
> --- a/drivers/leds/leds-lp8864.c
> +++ b/drivers/video/backlight/lp8864_bl.c

[ ... ]

> @@ -157,28 +162,59 @@ static int lp8864_fault_check(struct lp8864 *priv)
>  	return ret;
>  }
> =20
> -static int lp8864_brightness_set(struct led_classdev *led_cdev,
> -				 enum led_brightness brt_val)
> +static int lp8864_brightness_set(struct lp8864 *priv, unsigned int brigh=
tness)
>  {
> -	struct lp8864 *priv =3D container_of(led_cdev, struct lp8864, led_dev);
> -	/* Scale 0..LED_FULL into 16-bit HW brightness */
> -	unsigned int val =3D brt_val * 0xffff / LED_FULL;
>  	int ret;
> =20
>  	ret =3D lp8864_fault_check(priv);

[Severity: Medium]
Since the driver registers both a backlight device and an LED class
device, can concurrent sysfs writes to both interfaces cause a data race?

The LED and Backlight subsystems use independent locks (led_access mutex
and update_lock mutex). Parallel writes will result in concurrent calls to
lp8864_brightness_set(), which calls lp8864_fault_check().

Inside lp8864_fault_check(), the driver performs an unprotected
read-modify-write on priv->led_status_mask. Could this concurrent access
cause fault status updates to be lost?

>  	if (ret)
>  		return ret;

[ ... ]

> +static int lp8864_led_brightness_set(struct led_classdev *led_cdev,
> +				     enum led_brightness brt_val)
> +{
> +	struct lp8864 *priv =3D dev_get_drvdata(led_cdev->dev->parent);
> +
> +	/* Scale 0..LED_FULL into 16-bit HW brightness */
> +	return lp8864_brightness_set(priv, brt_val * 0xffff / LED_FULL);
> +}

[Severity: High]
Does the LED class interface ignore the device tree backlight limits?

The backlight device respects props.max_brightness, but the parallel LED
interface scales the requested brightness using a hardcoded LED_FULL divisor
(brt_val * 0xffff / LED_FULL).

If a custom max-brightness is specified in the device tree, writing to
the LED sysfs interface could bypass this limit and write arbitrary high
values to the hardware. Could this overdrive and potentially damage the
display?

[ ... ]

> @@ -258,11 +290,46 @@ static int lp8864_probe(struct i2c_client *client)
>  	if (ret)
>  		return ret;
> =20
> +	/* Register backlight class device */
> +	memset(&props, 0, sizeof(props));
> +	props.type =3D BACKLIGHT_RAW;
> +	props.max_brightness =3D LP8864_MAX_BRIGHTNESS;
> +	props.brightness =3D LP8864_MAX_BRIGHTNESS;
> +	props.scale =3D BACKLIGHT_SCALE_LINEAR;
> +
> +	if (!device_property_read_u32(&client->dev, "max-brightness", &val))
> +		props.max_brightness =3D val;
> +
> +	if (!device_property_read_u32(&client->dev, "default-brightness", &val))
> +		props.brightness =3D val;

[Severity: High]
Could reading max-brightness without default-brightness bypass the
protective limits during boot?

If max-brightness is provided in the device tree but default-brightness
is not, props.brightness retains its initial 0xFFFF value. When
backlight_update_status() is called shortly after, it will write this
unconstrained 0xFFFF to the hardware.

Additionally, since device_property_read_u32() is used without upper bound
checks, would values greater than 65535 in the device tree wrap around
when passed to the 16-bit regmap_write() in lp8864_brightness_set()?

> +
> +	bl =3D devm_backlight_device_register(&client->dev, "lp8864-backlight",
> +					    &client->dev, priv,
> +					    &lp8864_backlight_ops, &props);

[Severity: High]
Will using a fixed string for the backlight device name prevent probing
multiple instances?

The commit message mentions a use case on a hot-pluggable segment of an
I2C bus. If there are multiple LP8864 instances on the same system, the
second instance will fail to probe because the sysfs core mandates unique
names for devices in the same class.

Should this use a dynamically unique name, such as dev_name(&client->dev),
to avoid device_add() returning -EEXIST?

> +	if (IS_ERR(bl))
> +		return dev_err_probe(&client->dev, PTR_ERR(bl),
> +				     "Failed to register backlight device\n");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615120353.3409=
035-1-alexander.sverdlin@siemens.com?part=3D3
