Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E2ECD98ED
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 08:16:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8964F10EEA4;
	Wed, 17 Jun 2026 08:16:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B9KwxgCq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6864E10EEA4
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 08:16:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 243F5434CB;
 Wed, 17 Jun 2026 08:16:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D981F00A3D;
 Wed, 17 Jun 2026 08:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781684205;
 bh=9d9IY2AjX42Rn3jsTp1PZWQRQY7g0SFSrugxwXeqMs8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=B9KwxgCqONOQsGY6pmnBp41mdV1zFR6vtBaPplfxvy3dg9UG78pZK3yZgvTAPFwHE
 tR2muEbCA/EZcsJfGsXiaFtSx+5ZHLVt5Xz13PMjCCI3di9ItY4tfojuuRuBWDRuWf
 Dw3jUSCy4sb+cQKhxyoYFjhpWHihJMEKp27JV659BVaKZOtllHpOJD5WEtH6TaikR8
 VtP5Bp/77MnqBzTzGXNymhz6ocWNGeDNI4cBk2h7FVPzPvZAQyjmfqpoNU72up6F+z
 +HcrmYkGwYxg3xAKC33V6UzZj8KU8vNypOdLOnRmz2GqptlV7Uej4BscAWhxtOjmMC
 bMlOuqrlzW6Ig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/14] mfd: lm3533: Convert to use OF bindings
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260617080031.99156-9-clamor95@gmail.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260617080031.99156-9-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 08:16:44 +0000
Message-Id: <20260617081644.51D981F00A3D@smtp.kernel.org>
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
- [Medium] The `default-brightness` property is read from the Device Tree a=
s a `u32` without being clamped to `LM3533_BL_MAX_BRIGHTNESS` (255).
--

commit ea75baf449ff637e79d3393f0fdd68b3fcf947de
Author: Svyatoslav Ryhel <clamor95@gmail.com>

mfd: lm3533: Convert to use OF bindings

This commit removes platform data support and transitions the driver to use
Device Tree bindings for its configuration.

> diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backligh=
t/lm3533_bl.c
> index 9ef171d3aaeab..2c24647fc17a4 100644
> --- a/drivers/video/backlight/lm3533_bl.c
> +++ b/drivers/video/backlight/lm3533_bl.c

[ ... ]

> @@ -292,13 +291,21 @@ static int lm3533_bl_probe(struct platform_device *=
pdev)
>  	bl->cb.id =3D lm3533_bl_get_ctrlbank_id(bl);
>  	bl->cb.dev =3D NULL;			/* until registered */
> =20
> +	name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s-%d",
> +			      pdev->name, pdev->id);
> +	if (!name)
> +		return -ENOMEM;
> +
> +	device_property_read_u32(&pdev->dev, "default-brightness",
> +				 &default_brightness);
> +
>  	memset(&props, 0, sizeof(props));
>  	props.type =3D BACKLIGHT_RAW;
>  	props.max_brightness =3D LM3533_BL_MAX_BRIGHTNESS;
> -	props.brightness =3D pdata->default_brightness;
> +	props.brightness =3D default_brightness;

[Severity: Medium]
Should default_brightness be clamped to LM3533_BL_MAX_BRIGHTNESS before bei=
ng
assigned to props.brightness?

The transition to Device Tree bindings introduces reading default-brightness
as a u32. In the previous platform data implementation, default_brightness
was a u8, which inherently restricted it to a 0-255 range.

If a Device Tree provides a value greater than 255, it will be implicitly
truncated to an 8-bit unsigned integer when passed to the hardware writing
functions (for instance, 256 would wrap around to 0). This would cause the
backlight to turn off instead of setting it to the expected maximum brightn=
ess.

Does it make sense to clamp default_brightness similar to how led-max-micro=
amp
is clamped later in this function?

> -	bd =3D devm_backlight_device_register(&pdev->dev, pdata->name,
> -					pdev->dev.parent, bl, &lm3533_bl_ops,
> -					&props);
> +
> +	bd =3D devm_backlight_device_register(&pdev->dev, name, &pdev->dev,
> +					    bl, &lm3533_bl_ops, &props);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617080031.9915=
6-1-clamor95@gmail.com?part=3D8
