Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F5DC55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 04:23:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C781810E0D6;
	Tue,  4 Aug 2026 04:23:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="g/qcxecs";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4935510E0D6
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 04:23:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B72BE43669;
 Tue,  4 Aug 2026 04:23:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632FD1F000E9;
 Tue,  4 Aug 2026 04:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785817397;
 bh=dVT3F4lcuJIPGuX6JukqtRJLQ59x2zLR/GrzLyBgLNk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=g/qcxecsG4Dzl9xsxJPmntHyYvus8Ze3Ui/owDaDQZTxjHDIoXbNNNH3QGOYo+Iit
 fal5o2wFZdoO4W4F3JiNpA1xBws9VQS1D/7HzWoMJBIqqGf+tL+2+zmErH1cR1X3Dg
 lxmSgPLlaP1WQfzLxhbWyMVK3uYDgjte47qEEd84h5OVe2Zr5fbGqKpWpuzXl2bhWG
 GMkysqlveGGZiBRhwO05vfw+JwjkYhTIoT7RWhsxrd5pDmr69oDEQXC/6K5tu6isvH
 poOIIa6KmA/XRZfavlFrRAdGgGLANRBSxkeleby/jONG6zICcFgarxtNjA5/ceZ43P
 z6IBYDs1UzThQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] backlight: aw99706: Honor the core blank state
 in update_status()
To: "Junjie Cao" <junjie.cao@linux.dev>
Cc: lee@kernel.org, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org
In-Reply-To: <20260803141310.1379194-4-junjie.cao@linux.dev>
References: <20260803141310.1379194-1-junjie.cao@linux.dev>
 <20260803141310.1379194-4-junjie.cao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 04:23:16 +0000
Message-Id: <20260804042317.632FD1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] I2C chip ID read is performed before the hardware enable GPIO is r=
equested and asserted.
- [High] Hardware is manually disabled in `remove()` while the backlight de=
vice remains registered via `devm_`, leading to a use-after-disable race.
- [Medium] Missing delay after asserting the enable GPIO before issuing I2C=
 commands.
- [Medium] Incomplete suspend/resume logic leaves hardware enable GPIO asse=
rted.
--

--- Patch [3]: [PATCH v2 3/3] backlight: aw99706: Honor the core blank stat=
e in update_status() ---
commit 0ee82864b515a444eccb8c16ea1fd1e52d9895f0
Author: Junjie Cao <junjie.cao@linux.dev>
Date:   Mon Aug 3 14:13:10 2026 +0000

    backlight: aw99706: Honor the core blank state in update_status()
   =20
    update_status() passes props.brightness straight to the hardware and
    ignores the power/blank state tracked by the core. Writing 4 to the
    bl_power sysfs attribute or blanking the framebuffer therefore leaves
    the backlight lit.
   =20
    Use backlight_get_brightness(), which returns 0 while the device is
    blanked.
   =20
    Fixes: 147b38a5ad06 ("backlight: aw99706: Add support for Awinic AW9970=
6 backlight")
    Signed-off-by: Junjie Cao <junjie.cao@linux.dev>

> diff --git a/drivers/video/backlight/aw99706.c b/drivers/video/backlight/=
aw99706.c
> index dfb4b38b5b4c7..d035ff5af52c6 100644
> --- a/drivers/video/backlight/aw99706.c
> +++ b/drivers/video/backlight/aw99706.c
> @@ -340,7 +340,7 @@ static int aw99706_bl_update_status(struct backlight_=
device *bl)
>  {
>  	struct aw99706_device *aw =3D bl_get_data(bl);
> =20
> -	return aw99706_update_brightness(aw, bl->props.brightness);
> +	return aw99706_update_brightness(aw, backlight_get_brightness(bl));
>  }

While reviewing this patch, I noticed a few pre-existing issues in the driv=
er:

drivers/video/backlight/aw99706.c:aw99706_probe() {
    ...
	ret =3D aw99706_chip_id_read(aw);
	if (ret !=3D AW99706_ID)
		return dev_err_probe(dev, -ENODEV,
				     "Unknown chip id 0x%02x\n", ret);

	aw99706_dt_parse(aw, &props);

	aw->hwen_gpio =3D devm_gpiod_get(aw->dev, "enable", GPIOD_OUT_LOW);
	if (IS_ERR(aw->hwen_gpio))
		return dev_err_probe(dev, PTR_ERR(aw->hwen_gpio),
				     "Failed to get enable gpio\n");
    ...
}

[Severity: High]
This is a pre-existing issue, but doesn't aw99706_chip_id_read() perform an
I2C read before the hardware enable GPIO is requested and asserted?

If the hardware is disabled by default or left in reset by the bootloader,
won't this I2C read fail and make the driver completely non-functional?


drivers/video/backlight/aw99706.c:aw99706_remove() {
	struct aw99706_device *aw =3D i2c_get_clientdata(client);

	aw99706_update_brightness(aw, 0);

	msleep(50);

	gpiod_set_value_cansleep(aw->hwen_gpio, 0);
}

[Severity: High]
This is a pre-existing issue, but does disabling the hardware here create a
use-after-disable race?

The backlight device is registered with devm_backlight_device_register(), so
devres will unregister it after aw99706_remove() returns.

If a userspace process accesses the sysfs backlight attributes in this wind=
ow,
could aw99706_bl_update_status() issue I2C writes to a powered-down chip?


drivers/video/backlight/aw99706.c:aw99706_hw_init() {
	int ret, i;

	gpiod_set_value_cansleep(aw->hwen_gpio, 1);

	for (i =3D 0; i < ARRAY_SIZE(aw->init_tbl); i++) {
		ret =3D aw99706_i2c_update_bits(aw, aw->init_tbl[i].reg,
    ...
}

[Severity: Medium]
This is a pre-existing issue, but does this sequence need a stabilization
delay between asserting hwen_gpio and issuing I2C commands?

Could the initialization commands be dropped or NACKed if the controller
requires a few milliseconds to wake up before accepting I2C traffic?


drivers/video/backlight/aw99706.c:aw99706_suspend() {
	struct aw99706_device *aw =3D dev_get_drvdata(dev);

	return aw99706_update_brightness(aw, 0);
}

static int aw99706_resume(struct device *dev)
{
	struct aw99706_device *aw =3D dev_get_drvdata(dev);

	return aw99706_hw_init(aw);
}

[Severity: Medium]
This is a pre-existing issue, but do these suspend and resume operations
handle the hardware enable GPIO correctly?

aw99706_suspend() zeros out the brightness but leaves hwen_gpio asserted,
and aw99706_resume() blindly re-initializes all hardware registers without
the power ever being removed.

Should aw99706_suspend() pull hwen_gpio low to actually save power, or are
these operations redundant given BL_CORE_SUSPENDRESUME already handles sett=
ing
brightness to 0?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803141310.1379=
194-1-junjie.cao@linux.dev?part=3D3
