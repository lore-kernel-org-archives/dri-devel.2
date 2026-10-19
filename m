Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDD5CCF2D6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 10:21:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AA2310E987;
	Mon, 19 Oct 2026 10:21:20 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72D7010E987
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 10:21:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8EA83601FB;
 Mon, 19 Oct 2026 10:21:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01181F000C4;
 Mon, 19 Oct 2026 10:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792405273;
 bh=8UJg2BKoLo6QJa+/0Y5EWFsrBfSroDSG6h0pgdbGvF0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Zv/d5KIdTE7tXKMbD5QvZnf8/OYyCVzQp6gJl0IZ52Ek2oFEF+ho6SCiprgSEUUjh
 8EMHLWObz+p+ui9FX6IUqh3i9WTIWDKVxKQkclg1ThzlHnTllEpyVgOK+CQGvAzG1Y
 UIh5VFaXiVaiuG5PnMzr7zJyDWo22Eg/MxMS+pzSu7Z5tyMl6LDSH7/vFh/Puaf/uv
 Oa6NMLXJZ2/3MIsQqdHCcOOVESUhs5fuoZ7UQyrBjX50L1nlx+hv1NcP5fk+9xVUrh
 TMa7s+z2hznOHxdrzPbfVyI5V+DnQe7+QmOqQs1gcji6SOlysiYE4kNhYQIrH/TQEl
 I9uUnHm1xYU+w==
Message-ID: <sashiko-outbox-176974@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/4] mfd: aat2870: Convert to use OF bindings
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org,
 lee@kernel.org
In-Reply-To: <20261019100930.110954-4-clamor95@gmail.com>
References: <20261019100930.110954-1-clamor95@gmail.com>
 <20261019100930.110954-4-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 10:21:12 +0000
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
- [Low] mfd: aat2870: missing linux/gpio/consumer.h include breaks !CONFIG_=
GPIOLIB build
--

commit 7efa32d759fbc7ee0e1963e704db3b5316d972db
Author: Svyatoslav Ryhel <clamor95@gmail.com>

mfd: aat2870: Convert to use OF bindings

This commit converts the AAT2870 core, regulator, and backlight drivers from
platform data to Device Tree bindings and modern GPIO consumer helpers.

> diff --git a/drivers/mfd/aat2870-core.c b/drivers/mfd/aat2870-core.c
> index 0d56cd6fbc6a5..fe43ef675f257 100644
> --- a/drivers/mfd/aat2870-core.c
> +++ b/drivers/mfd/aat2870-core.c
> @@ -16,8 +16,15 @@
>  #include <linux/gpio/legacy.h>
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/aat2870.h>
> +#include <linux/of_platform.h>
>  #include <linux/regulator/machine.h>

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
> +	gpiod_set_value_cansleep(aat2870->en_pin, 1);

[Severity: Low]
Should drivers/mfd/aat2870-core.c replace #include <linux/gpio/legacy.h>
with #include <linux/gpio/consumer.h>?

In drivers/mfd/aat2870-core.c, aat2870_i2c_probe(), aat2870_i2c_suspend(),
and aat2870_i2c_resume() now use devm_gpiod_get_optional(), GPIOD_OUT_HIGH,
and gpiod_set_value_cansleep(), which are declared in
<linux/gpio/consumer.h>.

However, <linux/gpio/legacy.h> only pulls in <linux/gpio/consumer.h> when
CONFIG_GPIOLIB is enabled:

include/linux/gpio/legacy.h:
    #ifdef CONFIG_GPIOLIB

    #include <linux/gpio/consumer.h>

Because MFD_AAT2870_CORE in drivers/mfd/Kconfig has:

    depends on GPIOLIB || COMPILE_TEST

building with CONFIG_MFD_AAT2870_CORE=3Dy, CONFIG_COMPILE_TEST=3Dy, and
CONFIG_GPIOLIB=3Dn will fail to compile due to missing declarations for
GPIOD_OUT_HIGH, devm_gpiod_get_optional(), and gpiod_set_value_cansleep().

[ ... ]

>
> base-commit: 8c3ce6554a5b995599b84388347b301553e9efd5
> --

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019100930.1109=
54-1-clamor95@gmail.com?part=3D3
