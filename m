Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EF5C79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:37:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CAA110F164;
	Wed,  9 Sep 2026 13:37:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hqMeOOKY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2057910F164
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 13:37:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E04B3437AB;
 Wed,  9 Sep 2026 13:37:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139231F00A3A;
 Wed,  9 Sep 2026 13:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788961029;
 bh=fzb49+LidpozewcCzPlMDyrUBRb2yKh9w4fGQVBsZLw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hqMeOOKYwmNoQZOYAmHI9GffEd82yvOCyWu0xD1DQPdMBpREPc23CGeh5N7HxeDK4
 4Wrd5YOqBtBVPvKbQTbuE2Gif0xM+dKMwON1yw+46Pz2LXEu5D8U3jQnUzxbX+Hsp0
 ld6fd6fzAtgi1yaBXxetQQkXlsb1GGjg8/GHq70Tlxp1VAUzrNZGhPRYsJ+vJO6wEB
 JHkxvZjrc5qcnMyEnT5sw4MhalN7huv7/w1CpaIsgDUkPTFmFU7Eo9Uc6ZRxM2i51j
 YmqRD3Y3D0KF9CWSrGUbNLASHpSQK+EILn68kEuH5scF3gTOeL13ohlNB5up1O0dEr
 YCTXpI7dg/o+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/14] mfd: remove unused adp5520 driver
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: mfd@lists.linux.dev, linux-hwmon@vger.kernel.org, media-ci@linuxtv.org,
 robh@kernel.org, conor+dt@kernel.org, linux-leds@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org,
 dmitry.torokhov@gmail.com, dri-devel@lists.freedesktop.org,
 linux-watchdog@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-input@vger.kernel.org, lee@kernel.org
In-Reply-To: <20260909132153.1596191-6-arnd@kernel.org>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-6-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 13:37:08 +0000
Message-Id: <20260909133709.139231F00A3A@smtp.kernel.org>
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
- [Low] Incomplete documentation cleanup: left over `_dim` attribute sysfs =
documentation for the removed ADP5520 driver.
--

commit bc7ed836cc23ed6cd96fb2b01eb1e87798e6abff
Author: Arnd Bergmann <arnd@arndb.de>

mfd: remove unused adp5520 driver

This driver requires the use of platform_data definitions rather than
devicetree, but that was last used on the blackfin architecture in
2018 and nothing could have used it upstream since.

> diff --git a/Documentation/ABI/testing/sysfs-class-backlight b/Documentat=
ion/ABI/testing/sysfs-class-backlight
> index c453646b06e2c..b73d66942fbbe 100644
> --- a/Documentation/ABI/testing/sysfs-class-backlight
> +++ b/Documentation/ABI/testing/sysfs-class-backlight
> @@ -97,17 +97,6 @@ Description:
> =20
>  		The <ambient light zone> is device-driver specific:
> =20
> -		For ADP5520 and ADP5501, <ambient light zone> can be:
> -
> -		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -		Ambient      sysfs entry
> -		light zone
> -		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -		daylight     /sys/class/backlight/<backlight>/daylight_max
> -		office       /sys/class/backlight/<backlight>/office_max
> -		dark         /sys/class/backlight/<backlight>/dark_max
> -		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
>  		For ADP8860, <ambient light zone> can be:
> =20
>  		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

[Severity: Low]
Should the corresponding block for the _dim attributes also be removed?

Further down in this file, under the documentation for the _dim attributes,
there is another block describing the sysfs nodes for the ADP5520 driver:

		For ADP5520 and ADP5501, <ambient light zone> can be:

		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
		Ambient      sysfs entry
		light zone
		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
		daylight     /sys/class/backlight/<backlight>/daylight_dim
		office       /sys/class/backlight/<backlight>/office_dim
		dark         /sys/class/backlight/<backlight>/dark_dim
		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Leaving this block behind orphans the documentation for hardware that is no
longer supported.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909132153.1596=
191-1-arnd@kernel.org?part=3D5
