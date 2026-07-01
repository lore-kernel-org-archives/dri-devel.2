Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1731FC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 13:52:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6108110E351;
	Wed,  1 Jul 2026 13:52:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K9BopHwB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAD6C10E351
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 13:52:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A007241A9A;
 Wed,  1 Jul 2026 13:52:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B65B1F000E9;
 Wed,  1 Jul 2026 13:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782913948;
 bh=VDpaVJlS708zRfOZO5PAB+Hs1J4dA8avvbijsZKglYI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=K9BopHwBV4QcBM24HqDkbv9V68b+IscxN5klKIfPSihejhB+RkXHEyM2HscDhExFc
 NFDPyypQvojWGwKNAy6s/IcNn/WPe9fexRhQdY7ZICaNrv6iiTq6NWWeuAJqrcj87M
 NU0hZHnsj3gYn9Qzq7/GJEPdiS42zxhexOAyIv3EGPlcWhleOIp6zy0CpYoECSu3Du
 +dfL81zU2IWiBNuzOMrhb7Zj7KQItkdoJh19/H+wAh/mh2EHSwNTUTSo+1uzXX+85+
 BQyg67wqb2VqcV4fQAFThxFue2VB8qGucpnBoPvYFrEWw2MAZ/D0Mw328L/ENCZEos
 8FfKqm73+s2Xw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] backlight: aw99706: Validate all DT property values
 consistently
To: "Junjie Cao" <junjie.cao@linux.dev>
Cc: dri-devel@lists.freedesktop.org, lee@kernel.org, linux-leds@vger.kernel.org
In-Reply-To: <20260701133918.33487-2-junjie.cao@linux.dev>
References: <20260701133918.33487-1-junjie.cao@linux.dev>
 <20260701133918.33487-2-junjie.cao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 13:52:27 +0000
Message-Id: <20260701135228.0B65B1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] I2C read performed before enabling the chip via GPIO.
--

commit 9b2c49c6b957cfe305a408b8c9b3c4052b039334
Author: Junjie Cao <junjie.cao@linux.dev>

backlight: aw99706: Validate all DT property values consistently

The lookup helpers for dim-mode and ramp-ctl take a shortcut when
lookup_tbl is NULL: they accept any u32 value without range-checking
and return success unconditionally. Out-of-range values get silently
truncated by regmap_update_bits instead of triggering the dev_warn +
default-fallback path that the other properties use.

> diff --git a/drivers/video/backlight/aw99706.c b/drivers/video/backlight/=
aw99706.c
> index e130f164303a2..dfb4b38b5b4c7 100644
> --- a/drivers/video/backlight/aw99706.c
> +++ b/drivers/video/backlight/aw99706.c

[ ... ]

[Severity: High]
This is a pre-existing issue, but while reviewing this driver I noticed
a potential issue in aw99706_probe(). Does the driver attempt to read
the chip ID before enabling the device?

drivers/video/backlight/aw99706.c:aw99706_probe() {
    ...
	ret =3D aw99706_chip_id_read(aw);
	if (ret !=3D AW99706_ID)
		return dev_err_probe(dev, -ENODEV,
				     "Unknown chip id 0x%02x\n", ret);

	aw99706_dt_parse(aw, &props);

	aw->hwen_gpio =3D devm_gpiod_get(aw->dev, "enable", GPIOD_OUT_LOW);
    ...
}

If the bootloader leaves the chip disabled, would this I2C read fail or time
out because the enable GPIO is not fetched and asserted until later in the
probe sequence?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701133918.3348=
7-1-junjie.cao@linux.dev?part=3D2
