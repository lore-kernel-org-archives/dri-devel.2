Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B826BC5DF70
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 17:18:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9846A10E437;
	Mon, 17 Aug 2026 17:18:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OnEzj/40";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D80BF10E437
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 17:18:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 773A34086C;
 Mon, 17 Aug 2026 17:18:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0241F000E9;
 Mon, 17 Aug 2026 17:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786987089;
 bh=hRm2ZuPRE4rami4zWoUZyjYkK7rJIN1lymSrdbntFNE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OnEzj/40vUJ/qMswWRLU2vDG9sazF4SAETpLb5mBLWIr79kzZvwdbX4xfruvWRA8z
 EN1leLmH7ae7E27Zgyk726aI22dsV7bljUrySph5ZnpzwRcQzQ5f4cgy0imft7h5eT
 7/vQM9wBqp/ha7pvtFS42OJISl4zBkLD/Uc3n30pl9eIfzJoirEdCBNLMkWwPg4C7P
 j0meYOzZHP3YKIaI+rTWYHbfpGchax0aFbn7/kJ5vooXOIMfM7V2Xaw6Tu3galtobh
 oEi7QysCgOFNBcV+ydiQGhOFLCyYCKoC8nwJje5eiMW+yMYKA5fhUOTbWcn7zkbU8z
 XQRU7/V3jM0pQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] backlight: led_bl: Add
 devm_led_backlight_register() helper
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: lee@kernel.org, linux-leds@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260817170817.1933046-2-alexander.sverdlin@siemens.com>
References: <20260817170817.1933046-1-alexander.sverdlin@siemens.com>
 <20260817170817.1933046-2-alexander.sverdlin@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 17:18:08 +0000
Message-Id: <20260817171809.1F0241F000E9@smtp.kernel.org>
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

New issues:
- [High] The devres registration order for the backlight device and the LED=
 disable action is reversed, creating a TOCTOU race condition on device rem=
oval that allows the hardware to be improperly turned back on.
- [Medium] Hardcoding `dev_name(dev)` as the backlight device name prevents=
 a single device from registering multiple LED-backed backlights.

Pre-existing issues:
- [High] Dereferencing a potentially NULL `supplier` pointer inside `dev_na=
me()` during an error path causes a kernel panic.
--

--- Patch [1]: [PATCH 1/2] backlight: led_bl: Add devm_led_backlight_regist=
er() helper ---
commit 9866a4a9924f34ae7a659947d01fcc9dc9744ec2
Author: Alexander Sverdlin <alexander.sverdlin@siemens.com>

backlight: led_bl: Add devm_led_backlight_register() helper

This commit factors out the backlight registration into a led_bl_register()
helper and adds devm_led_backlight_register(). This allows self-contained
LED providers to expose a backlight interface. It also switches to
devres-managed functions to handle teardown, removing the explicit .remove
callback.

> diff --git a/drivers/video/backlight/led_bl.c b/drivers/video/backlight/l=
ed_bl.c
> index f7ab9b3607313..f87a48f74186a 100644
> --- a/drivers/video/backlight/led_bl.c
> +++ b/drivers/video/backlight/led_bl.c

[ ... ]

> @@ -203,24 +200,28 @@ static int led_bl_probe(struct platform_device *pde=
v)
>  	props.brightness =3D priv->default_brightness;
>  	props.power =3D (priv->default_brightness > 0) ? BACKLIGHT_POWER_OFF :
>  		      BACKLIGHT_POWER_ON;
> -	priv->bl_dev =3D backlight_device_register(dev_name(&pdev->dev),
> -			&pdev->dev, priv, &led_bl_ops, &props);
> -	if (IS_ERR(priv->bl_dev)) {
> -		dev_err(&pdev->dev, "Failed to register backlight\n");
> -		return PTR_ERR(priv->bl_dev);
> -	}
> +	priv->bl_dev =3D devm_backlight_device_register(dev, dev_name(dev), dev,
> +						      priv, &led_bl_ops, &props);

[Severity: Medium]
Since dev_name(dev) is used for the backlight device name, will this prevent
a single device from registering multiple LED-backed backlights?

If a single controller driver calls devm_led_backlight_register() more than
once for different LEDs, it seems the second call will fail due to a sysfs
naming collision (-EEXIST) because the name is hardcoded to the parent
device's name.

> +	if (IS_ERR(priv->bl_dev))
> +		return dev_err_probe(dev, PTR_ERR(priv->bl_dev),
> +				     "Failed to register backlight\n");
> =20
>  	for (i =3D 0; i < priv->nb_leds; i++) {
> +		struct device *supplier =3D priv->leds[i]->dev->parent;
>  		struct device_link *link;
> =20
> -		link =3D device_link_add(&pdev->dev, priv->leds[i]->dev->parent,
> -				       DL_FLAG_AUTOREMOVE_CONSUMER);
> -		if (!link) {
> -			dev_err(&pdev->dev, "Failed to add devlink (consumer %s, supplier %s)=
\n",
> -				dev_name(&pdev->dev), dev_name(priv->leds[i]->dev->parent));
> -			backlight_device_unregister(priv->bl_dev);
> -			return -EINVAL;
> -		}
> +		/*
> +		 * BL and the LED are the same device if instantiated via
> +		 * devm_led_backlight_register()
> +		 */
> +		if (supplier =3D=3D dev)
> +			continue;
> +
> +		link =3D device_link_add(dev, supplier, DL_FLAG_AUTOREMOVE_CONSUMER);
> +		if (!link)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Failed to add devlink (consumer %s, supplier %s)\n",
> +					     dev_name(dev), dev_name(supplier));

[Severity: High]
This is a pre-existing issue, but could this dev_name(supplier) call trigge=
r a
NULL pointer dereference?

If an LED classdev without a parent device (where parent =3D NULL) is passed
to devm_led_backlight_register(), supplier becomes NULL.

Since device_link_add() unconditionally returns NULL when the supplier is
NULL, the error path will execute and dev_name(supplier) will panic by
dereferencing NULL.

>  	}
> =20
>  	for (i =3D 0; i < priv->nb_leds; i++) {
> @@ -229,26 +230,68 @@ static int led_bl_probe(struct platform_device *pde=
v)
>  		mutex_unlock(&priv->leds[i]->led_access);
>  	}
> =20
> +	ret =3D devm_add_action_or_reset(dev, led_bl_disable, priv);
> +	if (ret)
> +		return ret;

[Severity: High]
Does registering the led_bl_disable action here create a race condition
during device removal?

Because devres actions execute in LIFO order (reverse of registration),
led_bl_disable() will run before the backlight device is unregistered.

This means led_bl_disable() turns off the LED, but the backlight sysfs nodes
are still active. Could userspace write to the backlight's sysfs brightness
attribute during this window, turning the LED back on just before the driver
is removed, thus leaving the hardware powered on?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817170817.1933=
046-1-alexander.sverdlin@siemens.com?part=3D1
