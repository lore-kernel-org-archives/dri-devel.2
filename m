Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D65C79FBB
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:39:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF72F10F171;
	Wed,  9 Sep 2026 13:39:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BE/vCTJ/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 723CD10F171
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 13:39:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 59C0A409C7;
 Wed,  9 Sep 2026 13:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9A01F00A3D;
 Wed,  9 Sep 2026 13:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788961170;
 bh=8Xmtb0gjRJEnI8n7CoVdt4HiBVODVmmu+Ac+R1zAeGY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BE/vCTJ/j6D/E44YVipxZ3Z1cCFSOu08+uJttVjNF0h102Qsx3FyQREBYztVtUrkF
 SUZNJ5S6RXYamB2+Fo6POTTv4WU4I6ofVBytwMqKI/LPPg+CaIgak3TOQD9ZM+kd/P
 iwrdoVzCOzQzTVu/oCncRomNVfO3XQiHI3pCZTWyMJEqnKVwItS4m0hmrQOceU3nh2
 GdppmWEZF2q+MF99akfiYGFh67l3OjAM4xVt2gP+N2viFsSDw1X60Gx5gHyUR4EQVx
 zEp64ZmtKGMY4cXyqdCmK0sJLRPHnEzFMdoEk31mY+37X8ec5G8URIBHWVfVGFm3AV
 S6r1jSzieeu9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/14] mfd: remove unused rc5t583 driver
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: mfd@lists.linux.dev, lee@kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, linux-input@vger.kernel.org,
 media-ci@linuxtv.org, conor+dt@kernel.org, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org, robh@kernel.org,
 linux-leds@vger.kernel.org, dri-devel@lists.freedesktop.org,
 dmitry.torokhov@gmail.com
In-Reply-To: <20260909132153.1596191-11-arnd@kernel.org>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-11-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 13:39:29 +0000
Message-Id: <20260909133929.AB9A01F00A3D@smtp.kernel.org>
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
- [Low] Incomplete feature removal: the patch deletes the core MFD_RC5T583 =
driver and header, but leaves behind the GPIO driver and its Kconfig/Makefi=
le entries.
--

commit 311a4001bd9ad092f34b02c5b27077bd1e8dfc62
Author: Arnd Bergmann <arnd@arndb.de>

mfd: remove unused rc5t583 driver
   =20
The commit removes the Ricoh RC5T583 MFD, regulator, and RTC drivers
along with their header file due to the lack of platform data and devicetree
support.

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 2cb2efafa8a48..fbcc45d2b0c40 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1291,20 +1291,6 @@ config MFD_RT5120
>  	  is targeted at providing the CPU voltage, memory, I/O and peripheral
>  	  power rails in home entertainment devices.
> =20
> -config MFD_RC5T583
> -	bool "Ricoh RC5T583 Power Management system device"
> -	depends on I2C=3Dy
> -	select MFD_CORE
> -	select REGMAP_I2C
> -	help
> -	  Select this option to get support for the RICOH583 Power
> -	  Management system device.

[Severity: Low]
Does this removal break Kconfig consistency and leave dead code in the tree?

The config GPIO_RC5T583 in drivers/gpio/Kconfig still depends on MFD_RC5T58=
3,
which violates Kconfig rules since the target dependency is now missing.

Additionally, drivers/gpio/gpio-rc5t583.c is left in the tree and still inc=
ludes
the deleted <linux/mfd/rc5t583.h> header, making it unbuildable, and its en=
try
is still present in drivers/gpio/Makefile.

Should the GPIO driver be removed in this patch as well?

> -	  This driver provides common support for accessing the device
> -	  through i2c interface. The device supports multiple sub-devices
> -	  like GPIO, interrupts, RTC, LDO and DCDC regulators, onkey.
> -	  Additional drivers must be enabled in order to use the
> -	  different functionality of the device.
> -
>  config MFD_RK8XX
>  	tristate
>  	select MFD_CORE

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909132153.1596=
191-1-arnd@kernel.org?part=3D10
