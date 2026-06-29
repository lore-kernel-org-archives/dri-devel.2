Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA03C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:10:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8BD510E90E;
	Mon, 29 Jun 2026 14:10:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Et52j218";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 346DA10E904
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:10:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5F37660008;
 Mon, 29 Jun 2026 14:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45851F000E9;
 Mon, 29 Jun 2026 14:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782742213;
 bh=SKkUAgoS3h5nEkmbuI6vSXcSZvIEQ0cyvR2Cvxu5eG0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Et52j218Qe4P2/mxi7eXgxC8qQo2WgankqHGeGoZlamtXAV6h7YOSIVrf+EvXsLd3
 uHrtbuf9JDDX8MZkQoZz3HS3wVljurmzfdjilJ67R3+T64t8uCR5vKf1XIz+CpszbH
 WM7hN8MH9rmnqB4YBgUS8zu6pPrfx5fFjDeUA/cwqhcVFQdZarZJITe0a1HgvvKSPi
 YpuZ5xrcJnf6iTxzWAeS5zuxudxozQCrZ6gq9aeYXftVOtt6fAuvf9EVbS8vocHx10
 9ekCrl85VfmYMWtZGX+hpXr/GfKAwLGuG4HB2C5zJV4nW0mVzPnSQaeveYGDO/om0B
 jY4esFcGcaSzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] [RFC] gpiolib: introduce gpio_name() helper
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260629135917.1308621-1-arnd@kernel.org>
References: <20260629135917.1308621-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 14:10:12 +0000
Message-Id: <20260629141012.D45851F000E9@smtp.kernel.org>
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
- [High] Uncanceled timer in the probe error path leads to a Use-After-Free=
 when the timer fires.
- [High] Uncanceled delayed work in the probe error path and early IRQ requ=
est lead to Use-After-Free.
- [High] The return value of extcon_rtk_type_c_edev_register() is assigned =
but never checked, leading to silent failures.
--

commit fd9fdd473dd5d54a8f94bae5e74133accbec590a
Author: Arnd Bergmann <arnd@arndb.de>

gpiolib: introduce gpio_name() helper

Most remaining users of desc_to_gpio() only call it for printing debug
information.

Replace this with a new gpiod_name() helper that returns the
gpio_desc->name string after checking the gpio_desc pointer.

> diff --git a/drivers/extcon/extcon-rtk-type-c.c b/drivers/extcon/extcon-r=
tk-type-c.c
> index 82b60b927e41a..fb57e9d7ddb63 100644
> --- a/drivers/extcon/extcon-rtk-type-c.c
> +++ b/drivers/extcon/extcon-rtk-type-c.c
> @@ -1356,8 +1356,8 @@ static int extcon_rtk_type_c_probe(struct platform_=
device *pdev)
>  				(int)PTR_ERR(gpio));
>  		} else {
>  			type_c->rd_ctrl_gpio_desc =3D gpio;
> -			dev_dbg(dev, "%s get rd-ctrl-gpios (id=3D%d) OK\n",
> -				__func__, desc_to_gpio(gpio));
> +			dev_dbg(dev, "%s get rd-ctrl-gpios (id=3D%s) OK\n",
> +				__func__, gpiod_name(gpio));
>  		}
>  	}

[Severity: High]
This is a pre-existing issue, but I noticed a potential use-after-free if
extcon_rtk_type_c_init() fails.

In extcon_rtk_type_c_probe(), the code requests an IRQ before the delayed
work is initialized:

	ret =3D devm_request_irq(dev, type_c->irq, type_c_detect_irq, ...);
	...
	INIT_DELAYED_WORK(&type_c->delayed_work, host_device_switch);

	ret =3D extcon_rtk_type_c_init(type_c);
	if (ret) {
		dev_err(dev, "%s failed to init type_c\n", __func__);
		goto err;
	}

Could an early interrupt schedule the uninitialized work?

Also, if extcon_rtk_type_c_init() fails, the code jumps to the err label
and returns without canceling the delayed work. Since the structure is
freed by devres, will this cause a use-after-free when the work executes?

[Severity: High]
This is also a pre-existing issue, but further down in the same function,
the return value of extcon_rtk_type_c_edev_register() is assigned to ret
but is not checked:

	ret =3D extcon_rtk_type_c_edev_register(type_c);

	create_debug_files(type_c);

	return 0;

Could this mask a registration failure, since the function unconditionally
returns 0?

[ ... ]

> diff --git a/drivers/usb/gadget/udc/at91_udc.c b/drivers/usb/gadget/udc/a=
t91_udc.c
> index 5aa360ba4f039..0993136043870 100644
> --- a/drivers/usb/gadget/udc/at91_udc.c
> +++ b/drivers/usb/gadget/udc/at91_udc.c
> @@ -1896,8 +1896,8 @@ static int at91udc_probe(struct platform_device *pd=
ev)
>  					gpiod_to_irq(udc->board.vbus_pin),
>  					at91_vbus_irq, 0, driver_name, udc);
>  			if (retval) {
> -				DBG("request vbus irq %d failed\n",
> -				    desc_to_gpio(udc->board.vbus_pin));
> +				DBG("request vbus irq %s failed\n",
> +				    gpiod_name(udc->board.vbus_pin));
>  				goto err_unprepare_iclk;
>  			}
>  		}

[Severity: High]
This is a pre-existing issue, but there appears to be a missing timer clean=
up
in the probe error path.

In at91udc_probe(), when vbus_polled is true, a timer is armed:

		if (udc->board.vbus_polled) {
			INIT_WORK(&udc->vbus_timer_work, at91_vbus_timer_work);
			timer_setup(&udc->vbus_timer, at91_vbus_timer, 0);
			mod_timer(&udc->vbus_timer,
				  jiffies + VBUS_POLL_TIMEOUT);
		}

If usb_add_gadget_udc() fails later, the code jumps to err_unprepare_iclk
and returns without deleting the timer:

	retval =3D usb_add_gadget_udc(dev, &udc->gadget);
	if (retval)
		goto err_unprepare_iclk;
	...
err_unprepare_iclk:
	clk_unprepare(udc->iclk);
err_unprepare_fclk:
	clk_unprepare(udc->fclk);

	return retval;

If the probe fails, devres will free the udc structure. Does this mean the
timer can still fire and access the freed udc memory, causing a
use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629135917.1308=
621-1-arnd@kernel.org?part=3D1
