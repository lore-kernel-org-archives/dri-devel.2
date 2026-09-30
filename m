Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2F6CA5FBB
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:28:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54FF110E115;
	Wed, 30 Sep 2026 07:28:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WK8HCKIT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C1F410E115
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 07:28:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BB4E1600D4;
 Wed, 30 Sep 2026 07:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87201F000FF;
 Wed, 30 Sep 2026 07:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790753297;
 bh=ZXVY8tIAhS9qjxPb0Ele3g9MhKSgr/Y0y/yYr2pvjGc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WK8HCKITwBTX2ZDIl8xO14tpspQ6fnSgZzhQrDP5y7ucAEV9QvVfTOgpK4y7HYJ67
 a6tB9DFbQJCpYvtcDZwXL6OVF1vrJCAkDjQ5HAHXVTlIP0EqRZf5PPWpdaj1EZrBWp
 VxpIO/Nu6dI4CmqZZTZYVnLV/j7bpT/iYfGuNl8CzQ30DHcg+wXnbwNLzjDcVWWBpg
 k0eN7Jfhc6Dj6vrPsK69B9RhLI3G6rp2MemySZ/Ls1Kj0jshYVM09jpEfLV5G4L4Sn
 bf0566hOVntYbLmzMpoaBvJWV0Jf5b3Fl6U3DeLCyKEJNnu70WB8LlJ77HwteV7Og8
 SP6Gx6tmjXQNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/3] mfd: aat2870: Convert to use OF bindings
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: lee@kernel.org, devicetree@vger.kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 linux-leds@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260930071513.54697-3-clamor95@gmail.com>
References: <20260930071513.54697-1-clamor95@gmail.com>
 <20260930071513.54697-3-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 07:28:16 +0000
Message-Id: <20260930072816.C87201F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] regulator: Missing DT Configuration for aat2870
- [High] regulator: Global state corruption causing UAF via of_regulator_ma=
tch
- [High] backlight: Logic error scales max_current to zero due to unit mism=
atch
- [High] backlight: Missing default initialization causes max_current trunc=
ation to zero
- [High] mfd: Resource Leak and UAF due to unmanaged of_platform_populate
- [High] backlight: Divide by zero in aat2870_brightness()
- [Low] backlight: Type mismatch passing int pointer to u32 reader
--

commit fb76177a0777d443ea10abf629ceb4bbf320d8b9
Author: Svyatoslav Ryhel <clamor95@gmail.com>

mfd: aat2870: Convert to use OF bindings

This commit converts the AAT2870 driver to use OF bindings, replacing the
MFD registration API with of_platform_populate(). It updates the backlight
and regulator child drivers to parse device tree properties directly and
removes the legacy platform data initialization.

> diff --git a/drivers/mfd/aat2870-core.c b/drivers/mfd/aat2870-core.c
> --- a/drivers/mfd/aat2870-core.c
> +++ b/drivers/mfd/aat2870-core.c
[ ... ]
> @@ -348,60 +309,29 @@ static int aat2870_i2c_probe(struct i2c_client *cli=
ent)
[ ... ]
> -	ret =3D mfd_add_devices(aat2870->dev, 0, aat2870_devs,
> -			      ARRAY_SIZE(aat2870_devs), NULL, 0, NULL);
> -	if (ret !=3D 0) {
> -		dev_err(aat2870->dev, "Failed to add subdev: %d\n", ret);
> -		goto out_disable;
> +	gpiod_set_value(aat2870->en_pin, 1);
> =20
> -	}
> +	ret =3D of_platform_populate(client->dev.of_node, NULL, NULL, &client->=
dev);
> +	if (ret) {

[Severity: High]
Are we missing an of_platform_depopulate() call here?

Since of_platform_populate() creates unmanaged child devices, if the parent
I2C driver unbinds, the child devices will remain active. If a child device
is accessed after the parent is removed, wouldn't it result in a
use-after-free when dereferencing the freed parent driver data? Using
devm_of_platform_populate() might resolve this leak.

> +		gpiod_set_value(aat2870->en_pin, 0);
> +		return dev_err_probe(&client->dev, ret, "Failed to populate cells\n");
>  	}
> =20
>  	aat2870_init_debugfs(aat2870);
[ ... ]
> diff --git a/drivers/regulator/aat2870-regulator.c b/drivers/regulator/aa=
t2870-regulator.c
> --- a/drivers/regulator/aat2870-regulator.c
> +++ b/drivers/regulator/aat2870-regulator.c
[ ... ]
> @@ -121,6 +130,13 @@ static struct aat2870_regulator aat2870_regulators[]=
 =3D {
>  	AAT2870_LDO(LDOD),
>  };
> =20
> +static struct of_regulator_match aat2870_regulator_matches[] =3D {
> +	{ .name =3D "ldo-a" },
> +	{ .name =3D "ldo-b" },
> +	{ .name =3D "ldo-c" },
> +	{ .name =3D "ldo-d" },
> +};

[Severity: High]
Does of_regulator_match() mutate this static array?

of_regulator_match() typically writes device-specific of_node and init_data
pointers into the matched array. If multiple AAT2870 devices are probed,
wouldn't the second probe overwrite the pointers from the first, leading to
data corruption and a potential use-after-free during devres cleanup?

> +
>  static struct aat2870_regulator *aat2870_get_regulator(int id)
>  {
[ ... ]
> @@ -152,33 +167,50 @@ static int aat2870_regulator_probe(struct platform_=
device *pdev)
[ ... ]
> +	for (int idx =3D 0; idx < ARRAY_SIZE(aat2870_regulator_matches); idx++)=
 {
> +		if (!aat2870_regulator_matches[idx].of_node)
> +			continue;
> =20
> -		return PTR_ERR(rdev);
> +		ri =3D aat2870_get_regulator(idx);
> +		if (!ri)
> +			return dev_err_probe(&pdev->dev, -EINVAL,
> +					     "Invalid device ID, %d\n", idx);
> +
> +		ri->aat2870 =3D dev_get_drvdata(pdev->dev.parent);
> +
> +		config.dev =3D &pdev->dev;
> +		config.driver_data =3D ri;
> +
> +		rdev =3D devm_regulator_register(&pdev->dev, &ri->desc, &config);

[Severity: High]
Is there a missing assignment for the Device Tree configuration?

of_regulator_match() parses the DT constraints into the match array, but
config.init_data and config.of_node don't seem to be populated from
aat2870_regulator_matches[idx] before calling devm_regulator_register().
Without these, do the regulators get registered without their DT constraint=
s?

> +		if (IS_ERR(rdev))
> +			return dev_err_probe(&pdev->dev, PTR_ERR(rdev),
> +					     "Failed to register regulator %s\n",
> +					     ri->desc.name);
>  	}
[ ... ]
> diff --git a/drivers/video/backlight/aat2870_bl.c b/drivers/video/backlig=
ht/aat2870_bl.c
> --- a/drivers/video/backlight/aat2870_bl.c
> +++ b/drivers/video/backlight/aat2870_bl.c
[ ... ]
> @@ -140,20 +135,16 @@ static int aat2870_bl_probe(struct platform_device =
*pdev)
> =20
>  	aat2870_bl->bd =3D bd;
> =20
> -	if (pdata->channels > 0)
> -		aat2870_bl->channels =3D pdata->channels;
> -	else
> -		aat2870_bl->channels =3D AAT2870_BL_CH_ALL;
> +	aat2870_bl->channels =3D AAT2870_BL_CH_ALL;
> +	device_property_read_u8(&pdev->dev, "skyworks,channels", &aat2870_bl->c=
hannels);
> =20
> -	if (pdata->max_current > 0)
> -		aat2870_bl->max_current =3D pdata->max_current;
> -	else
> -		aat2870_bl->max_current =3D AAT2870_CURRENT_27_9;
> +	device_property_read_u32(&pdev->dev, "led-max-microamp", &aat2870_bl->m=
ax_current);
> +	aat2870_bl->max_current =3D clamp(aat2870_bl->max_current, AAT2870_CURR=
ENT_MIN,
> +					AAT2870_CURRENT_MAX);
> +	aat2870_bl->max_current /=3D AAT2870_CURRENT_STEP;

[Severity: High]
Can this sequence cause the max current to evaluate to 0?

If the led-max-microamp property is missing, aat2870_bl->max_current starts=
 at
0 (due to devm_kzalloc) before entering the clamp logic.

Also, the clamp and divide logic seems to mix units. If the DT provides a
microamp value like 27900, it gets clamped up to AAT2870_CURRENT_MIN
(450,000) and then integer-divided by AAT2870_CURRENT_STEP (900,000). This
results in 0, which would lock the brightness at 0 when calculating
aat2870_brightness(). Does this need scaling adjustments?

> =20
> -	if (pdata->max_brightness > 0)
> -		bd->props.max_brightness =3D pdata->max_brightness;
> -	else
> -		bd->props.max_brightness =3D 255;
> +	bd->props.max_brightness =3D 255;
> +	device_property_read_u32(&pdev->dev, "max-brightness", &bd->props.max_b=
rightness);

[Severity: Low]
Is it safe to pass a pointer to a signed int here? bd->props.max_brightness
is an int, but device_property_read_u32() expects a u32 pointer. This might
cause signedness mismatch issues.

[Severity: High]
Could this lead to a division by zero in aat2870_brightness()?

If the device tree configures max-brightness =3D <0>, this property reader =
will
directly overwrite the default 255 with 0. Later, aat2870_brightness()
executes val /=3D bd->props.max_brightness, which would cause a kernel pani=
c.

> =20
>  	aat2870_bl->brightness =3D 0;
>  	bd->props.power =3D BACKLIGHT_POWER_ON;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930071513.5469=
7-1-clamor95@gmail.com?part=3D2
