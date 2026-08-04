Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73381C55182
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 03:15:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA4C010E567;
	Tue,  4 Aug 2026 03:15:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k8TbuyY2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5391D10E822
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 03:15:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 20F29436A0;
 Tue,  4 Aug 2026 03:15:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CD41F00A3A;
 Tue,  4 Aug 2026 03:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785813334;
 bh=Pf4NxLroK6RaL2a1Y2//tPATGRTgTegVkXZ3orDWCjg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=k8TbuyY2Qgu/VH7JA1fLdXrFoUTRFmx+5DYsjADkoohcDY8s4OgG+Y3kkBBHzOviP
 LSST/wVm7gDz85fayedKNFH1xvVtvtMIO9FhHaR8Vcg4szWvagmCexElCz+Phv+abj
 Rlzql6FCwuI/hTHa9LOGEvczwl1xGMof2eFYAaB8O9SNMqR/tfL3QTMYKvcv2PEOey
 NptMxUeigHUWNhkcBAUYjKJXDc+RyWr2eviE0Fyf/7O2iuDW9ajuepCiZBqC6BZWmH
 p8P6r6fWwO3CudbIOv5RvOQ8M3wyc9b9b2f55xjnxFh5GMQ5D4zia/0nXw7ecciO6f
 Wwy9+f+vcWqig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] backlight: aw99706: Honor the core blank state
 in update_status()
To: "Junjie Cao" <junjie.cao@intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, lee@kernel.org
In-Reply-To: <20260804030255.1934470-4-junjie.cao@intel.com>
References: <20260804030255.1934470-1-junjie.cao@intel.com>
 <20260804030255.1934470-4-junjie.cao@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 03:15:33 +0000
Message-Id: <20260804031533.B5CD41F00A3A@smtp.kernel.org>
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
- [High] I2C read is performed before the hardware is powered up or enabled.
- [High] The initial backlight state parsed from device tree is never appli=
ed to the hardware during probe.
--

--- Patch [3]: [PATCH v3 3/3] backlight: aw99706: Honor the core blank stat=
e in update_status() ---
commit 4fd7fd023a2e220d60fcbcb9c519d9b49b430467
Author: Junjie Cao <junjie.cao@linux.dev>

backlight: aw99706: Honor the core blank state in update_status()

update_status() passes props.brightness straight to the hardware and
ignores the power/blank state tracked by the core. Writing 4 to the
bl_power sysfs attribute or blanking the framebuffer therefore leaves
the backlight lit.

> diff --git a/drivers/video/backlight/aw99706.c b/drivers/video/backlight/=
aw99706.c
> index 6ec49b6cb14c6..c4a66b59ecf13 100644
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
> =20
>  static const struct backlight_ops aw99706_bl_ops =3D {

[Severity: High]
This is a pre-existing issue, but I noticed an I2C read is performed before
the hardware is powered up or enabled.

In drivers/video/backlight/aw99706.c:aw99706_probe():

	ret =3D aw99706_chip_id_read(aw);
	if (ret !=3D AW99706_ID)
		return dev_err_probe(dev, -ENODEV,
				     "Unknown chip id 0x%02x\n", ret);

	aw99706_dt_parse(aw, &props);

	aw->hwen_gpio =3D devm_gpiod_get(aw->dev, "enable", GPIOD_OUT_LOW);

	ret =3D aw99706_hw_init(aw);

Will the driver probe fail with -ENODEV here if the hardware is disabled by
default, since the hardware enable GPIO (aw->hwen_gpio) is not requested and
asserted until later via devm_gpiod_get() and aw99706_hw_init()?


[Severity: High]
This is also a pre-existing issue, but the initial backlight state parsed f=
rom
device tree is never applied to the hardware during probe.

In drivers/video/backlight/aw99706.c:aw99706_probe():

	bl_dev =3D devm_backlight_device_register(dev, "aw99706-backlight", dev,
						aw, &aw99706_bl_ops, &props);
	if (IS_ERR(bl_dev))
		return dev_err_probe(dev, PTR_ERR(bl_dev),
				     "Failed to register backlight!\n");

	aw->bl_dev =3D bl_dev;

	return 0;

Does the backlight remain off during the entire boot process until userspace
writes to the sysfs brightness attribute?

The probe function completes without calling backlight_update_status() to
synchronize the parsed device tree brightness properties to the hardware, a=
nd
the backlight core does not automatically sync the initial software state
upon registration.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804030255.1934=
470-1-junjie.cao@intel.com?part=3D3
