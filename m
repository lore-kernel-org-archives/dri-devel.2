Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB553CC6B1A
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 18:21:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F207610E990;
	Tue, 13 Oct 2026 18:21:20 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAC2B10E990
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 18:21:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 40A7B601FF;
 Tue, 13 Oct 2026 18:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83AC61F000FF;
 Tue, 13 Oct 2026 18:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791915674;
 bh=F5ZDCkRw8VVdeYAs2vWti8KDb0kjYXkm9J+gbJ7w07k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NzVj3J5njiwF9GXU/dmWYgrIVduAORQA/s6MYbtSFyZsTi8lMLdhvjCVFQvsOqKRc
 R0JA4b0R/+Hgp6R9I2/iyfS6XJcGpX0PkX6luBkl/X6FSV32aZmTb4VwyNCOKLExj4
 XfMDAD9qUeAL8SkOVKCLEqCbPslqtgL2xpvTZB6VXROoDSGhkuKtrrnP7LO7de2oYm
 4IwQP2hrhjhgteAKvjyUqoqo0Pe/cTf/LvBX0pqVWPe0nEqgu3e5tpl7Ljzp83v1GX
 VeQ2akA6dAp4J/AHU4tnFdZOmJslnaPHETEUlCzMb2IG8qS2VXJRkbvJ2GjFersDAK
 NDx8ohyEU2rrA==
Message-ID: <sashiko-outbox-170318@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] mfd: aat2870: Convert to use OF bindings
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org,
 lee@kernel.org
In-Reply-To: <20261013180933.487013-4-clamor95@gmail.com>
References: <20261013180933.487013-1-clamor95@gmail.com>
 <20261013180933.487013-4-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 18:21:13 +0000
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
- [Medium] video: missing default value for optional led-max-microamp prope=
rty
- [Medium] mfd: aat2870: WARNING triggered by gpiod_set_value on sleepable =
GPIOs
- [Low] video: incompatible pointer type in device_property_read_u32
- [Low] regulator: missing const on aat2870_regulators array
--

commit 44f47c7fe6dfacca37d21c28bab7fce4a68f379a
Author: Svyatoslav Ryhel <clamor95@gmail.com>

mfd: aat2870: Convert to use OF bindings

This commit converts the AAT2870 driver to use OF bindings by replacing
mfd_add_devices() with of_platform_populate() and adding separate compatible
strings for its backlight and regulator sub-devices. It also updates the
GPIO enable logic to use gpiod helpers and modifies the child drivers to pa=
rse
properties directly from the Device Tree, allowing the removal of platform =
data.

> diff --git a/drivers/mfd/aat2870-core.c b/drivers/mfd/aat2870-core.c
> index 0d56cd6fbc6a5..909c14ee60323 100644
> --- a/drivers/mfd/aat2870-core.c
> +++ b/drivers/mfd/aat2870-core.c
[ ... ]
> @@ -348,60 +309,29 @@ static int aat2870_i2c_probe(struct i2c_client *cli=
ent)
> =20
>  	aat2870->reg_cache =3D aat2870_regs;
> =20
> -	if (pdata->en_pin < 0)
> -		aat2870->en_pin =3D -1;
> -	else
> -		aat2870->en_pin =3D pdata->en_pin;
> +	aat2870->en_pin =3D devm_gpiod_get_optional(&client->dev, "enable",
> +						  GPIOD_OUT_HIGH);
> +	if (IS_ERR(aat2870->en_pin))
> +		return dev_err_probe(&client->dev, PTR_ERR(aat2870->en_pin),
> +				     "Failed to get EN GPIO\n");
> =20
> -	aat2870->init =3D pdata->init;
> -	aat2870->uninit =3D pdata->uninit;
>  	aat2870->read =3D aat2870_read;
>  	aat2870->write =3D aat2870_write;
>  	aat2870->update =3D aat2870_update;
> =20
>  	mutex_init(&aat2870->io_lock);
> =20
> -	if (aat2870->init)
> -		aat2870->init(aat2870);
> -
> -	if (aat2870->en_pin >=3D 0) {
> -		ret =3D devm_gpio_request_one(&client->dev, aat2870->en_pin,
> -					GPIOF_OUT_INIT_HIGH, "aat2870-en");
> -		if (ret < 0) {
> -			dev_err(&client->dev,
> -				"Failed to request GPIO %d\n", aat2870->en_pin);
> -			return ret;
> -		}
> -	}
> -
> -	aat2870_enable(aat2870);
> -
> -	for (i =3D 0; i < pdata->num_subdevs; i++) {
> -		for (j =3D 0; j < ARRAY_SIZE(aat2870_devs); j++) {
> -			if ((pdata->subdevs[i].id =3D=3D aat2870_devs[j].id) &&
> -					!strcmp(pdata->subdevs[i].name,
> -						aat2870_devs[j].name)) {
> -				aat2870_devs[j].platform_data =3D
> -					pdata->subdevs[i].platform_data;
> -				break;
> -			}
> -		}
> -	}
> +	gpiod_set_value(aat2870->en_pin, 1);

[Severity: Medium]
Should this use gpiod_set_value_cansleep() instead?

Since this device is an I2C MFD, the enable GPIO could be attached to an
I2C or SPI expander, which means toggling it might sleep. Using the
non-cansleep gpiod_set_value() here, as well as in the probe error path and
suspend/resume callbacks, could trigger a WARN_ON() in gpiolib if the
underlying controller requires sleeping.

> =20
> -	ret =3D mfd_add_devices(aat2870->dev, 0, aat2870_devs,
> -			      ARRAY_SIZE(aat2870_devs), NULL, 0, NULL);
> -	if (ret !=3D 0) {
> -		dev_err(aat2870->dev, "Failed to add subdev: %d\n", ret);
> -		goto out_disable;
> +	ret =3D devm_of_platform_populate(&client->dev);
> +	if (ret) {
> +		gpiod_set_value(aat2870->en_pin, 0);

[Severity: Medium]
Similar to the above, would gpiod_set_value_cansleep() be safer here on the
error path to avoid a potential gpiolib WARN_ON()?

> +		return dev_err_probe(&client->dev, ret, "Failed to populate cells\n");
>  	}
> =20
>  	aat2870_init_debugfs(aat2870);
> =20
>  	return 0;
> -
> -out_disable:
> -	aat2870_disable(aat2870);
> -	return ret;
>  }
> =20
>  static int aat2870_i2c_suspend(struct device *dev)
> @@ -409,7 +339,7 @@ static int aat2870_i2c_suspend(struct device *dev)
>  	struct i2c_client *client =3D to_i2c_client(dev);
>  	struct aat2870_data *aat2870 =3D i2c_get_clientdata(client);
> =20
> -	aat2870_disable(aat2870);
> +	gpiod_set_value(aat2870->en_pin, 0);

[Severity: Medium]
Should we use gpiod_set_value_cansleep() here in the suspend handler?

> =20
>  	return 0;
>  }
> @@ -421,7 +351,7 @@ static int aat2870_i2c_resume(struct device *dev)
>  	struct aat2870_register *reg =3D NULL;
>  	int i;
> =20
> -	aat2870_enable(aat2870);
> +	gpiod_set_value(aat2870->en_pin, 1);

[Severity: Medium]
Should we use gpiod_set_value_cansleep() here in the resume handler?

> =20
>  	/* restore registers */
>  	for (i =3D 0; i < AAT2870_REG_NUM; i++) {
> diff --git a/drivers/regulator/aat2870-regulator.c b/drivers/regulator/aa=
t2870-regulator.c
> index 970d86f2bbb81..9b8eb8df220a7 100644
> --- a/drivers/regulator/aat2870-regulator.c
> +++ b/drivers/regulator/aat2870-regulator.c
[ ... ]
> @@ -101,84 +102,60 @@ static const unsigned int aat2870_ldo_voltages[] =
=3D {
>  	3000000, 3100000, 3200000, 3300000,
>  };
> =20
> -#define AAT2870_LDO(ids)				\
> -	{						\
> -		.desc =3D {				\
> -			.name =3D #ids,			\
> -			.id =3D AAT2870_ID_##ids,		\
> -			.n_voltages =3D ARRAY_SIZE(aat2870_ldo_voltages),	\
> -			.volt_table =3D aat2870_ldo_voltages, \
> -			.ops =3D &aat2870_ldo_ops,	\
> -			.type =3D REGULATOR_VOLTAGE,	\
> -			.owner =3D THIS_MODULE,		\
> -		},					\
> -	}
> +#define AAT2870_LDO(ids, match, vsel, vmask) {		\
> +	.name =3D #ids,					\
> +	.of_match =3D (match),				\
> +	.id =3D AAT2870_ID_##ids,				\
> +	.n_voltages =3D ARRAY_SIZE(aat2870_ldo_voltages),	\
> +	.volt_table =3D aat2870_ldo_voltages,		\
> +	.ops =3D &aat2870_ldo_ops,			\
> +	.type =3D REGULATOR_VOLTAGE,			\
> +	.owner =3D THIS_MODULE,				\
> +	.vsel_reg =3D (vsel),				\
> +	.vsel_mask =3D (vmask),				\
> +	.enable_reg =3D AAT2870_LDO_EN,			\
> +	.enable_mask =3D BIT(AAT2870_ID_##ids),		\
> +}
> =20
> -static struct aat2870_regulator aat2870_regulators[] =3D {
> -	AAT2870_LDO(LDOA),
> -	AAT2870_LDO(LDOB),
> -	AAT2870_LDO(LDOC),
> -	AAT2870_LDO(LDOD),
> +static struct regulator_desc aat2870_regulators[] =3D {

[Severity: Low]
Could we add the const qualifier to this array?

Since the descriptions are static and never modified at runtime, and
devm_regulator_register() expects a const struct regulator_desc *, adding
const would allow this array to be placed in read-only .rodata memory
instead of mutable .data.

> +	AAT2870_LDO(LDOA, "ldo-a", AAT2870_LDO_AB, AAT2870_LDO_AB_A_MASK),
> +	AAT2870_LDO(LDOB, "ldo-b", AAT2870_LDO_AB, AAT2870_LDO_AB_B_MASK),
> +	AAT2870_LDO(LDOC, "ldo-c", AAT2870_LDO_CD, AAT2870_LDO_CD_C_MASK),
> +	AAT2870_LDO(LDOD, "ldo-d", AAT2870_LDO_CD, AAT2870_LDO_CD_D_MASK),
>  };
> =20
> diff --git a/drivers/video/backlight/aat2870_bl.c b/drivers/video/backlig=
ht/aat2870_bl.c
> index eb686e315921d..705a8d32d224f 100644
> --- a/drivers/video/backlight/aat2870_bl.c
> +++ b/drivers/video/backlight/aat2870_bl.c
[ ... ]
> @@ -129,21 +124,20 @@ static int aat2870_bl_probe(struct platform_device =
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

[Severity: Low]
Does this cause an incompatible pointer type warning?

aat2870_bl->max_current is defined as a signed int, but
device_property_read_u32() expects a u32 pointer. This could break
builds that treat -Wincompatible-pointer-types as an error.

[Severity: Medium]
What happens if the optional "led-max-microamp" property is missing from
the device tree?

If the property is missing, device_property_read_u32() leaves max_current
at 0 (its initial value from devm_kzalloc). When passed into clamp(0, 450,
27900), it gets forced to 450, and dividing by 900 evaluates to 0.

This sets bd->props.max_brightness to 1 (0 + 1), silently degrading the
backlight limits to an almost invisible state, whereas the previous behavior
correctly defaulted to 27.9mA (32 steps). Should max_current be initialized
to a default value before reading the property?

> +	aat2870_bl->max_current =3D clamp(aat2870_bl->max_current, AAT2870_CURR=
ENT_MIN,
> +					AAT2870_CURRENT_MAX);
> +	aat2870_bl->max_current /=3D AAT2870_CURRENT_STEP;
> =20
>  	/*
>  	 * The maximum number of brightness steps is determined by the max curr=
ent.
> -	 * The aat2870_current enum maps directly to the allowed brightness ste=
ps.
> +	 * The aat2870_bl->max_current value maps to the allowed brightness ste=
ps
> +	 * with +1 offset since max_current 0 is still 450uA.
>  	 */
> -	bd->props.max_brightness =3D pdata->max_current;
> +	bd->props.max_brightness =3D aat2870_bl->max_current + 1;
> =20
>  	aat2870_bl->brightness =3D 0;
>  	bd->props.power =3D BACKLIGHT_POWER_ON;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013180933.4870=
13-1-clamor95@gmail.com?part=3D3
