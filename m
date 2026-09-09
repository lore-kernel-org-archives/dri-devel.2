Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC57C79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:41:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FC0310F115;
	Wed,  9 Sep 2026 13:41:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M/mxKVZi";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D75C10F115
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 13:41:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EAEF243394;
 Wed,  9 Sep 2026 13:41:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157A01F00A3A;
 Wed,  9 Sep 2026 13:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788961263;
 bh=wxMXjNBdXbhhVdeekOL7ly4h76Cr8A1CF6EPfA72hcE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=M/mxKVZiP6/lVyh2S0uVt5RwObq0pHb2AISuZ9ZhkQDt5uk+a7izGlK34Gbr9mdzM
 rfOfnPojA2Am84NNqUghl5XiM7B4w5BHUDTEGkjUz8wsV2e0AwNtADXa6FsZ7dKtRs
 B4VFLVFv4pX98WYQDE+zoiFd+zDlHUtwvzB0GqdJB64v90VbKM31NBn/ZNPSEVh3Ce
 7Ahvh6E2Re3e3UFIaBPVPVLYB0de8NsA1tb7ULqpYHelbw7WVKutu7H7f+H3rsHMKp
 wJMFJq+UiG186ONqmlDHzyp93h2g3CXXLZz9C7z6NSHYFwULyP0CW1kdaQ7lFpbzRl
 66N3LgVdIyyoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/14] mfd: remove unused wm8350 driver
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-leds@vger.kernel.org, linux-input@vger.kernel.org, lee@kernel.org,
 conor+dt@kernel.org, linux-watchdog@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, robh@kernel.org,
 mfd@lists.linux.dev, dmitry.torokhov@gmail.com, linux-hwmon@vger.kernel.org,
 linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, media-ci@linuxtv.org
In-Reply-To: <20260909132153.1596191-12-arnd@kernel.org>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-12-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 13:41:02 +0000
Message-Id: <20260909134103.157A01F00A3A@smtp.kernel.org>
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
- [Low] Stale documentation references to the removed wm8350 driver.
--

commit 180d02f3fe78e14ad7acf9b29e2590c4c4ee3a29
Author: Arnd Bergmann <arnd@arndb.de>

mfd: remove unused wm8350 driver

This commit removes the wm8350 driver entirely, as it relied on platform
data probing for development boards that have been dropped from the kernel.
It removes the core driver along with its hwmon, gpio, led, power,
regulator, rtc, watchdog, and sound codec components.

> mfd: remove unused wm8350 driver
>=20
> This driver was used on the i.MX31 ADS reference board from Freescale
> and the smdk6410 reference board from Samsung. Both used platform_data
> based driver probing and are now gone from the kernel.
>=20
> Since probing with devicetree has never been supported by wm8350,
> it is clear that nothing can use the driver on an upstream kernel,
> and it is unlikely that anyone is still interested in a devicetree
> conversion, so remove it.

[Severity: Low]
Since the wm8350 driver is being completely removed here, should we also
update the documentation files that still reference it as a working example=
?=20

Currently, there are a few places left behind that point developers to the
removed driver code. For instance, in Documentation/scheduler/completion.rst
referencing wait_for_completion_interruptible_timeout:

    why (e.g. see drivers/mfd/wm8350-core.c wm8350_read_auxadc())::

And its Chinese translation in
Documentation/translations/zh_CN/scheduler/completion.rst:

    =EF=BC=88=E4=BE=8B=E5=A6=82=EF=BC=8C=E8=A7=81drivers/mfd/wm8350-core.c =
wm8350_read_auxadc()::

Additionally, Documentation/sound/soc/jack.rst points to the removed codec:

    CODEC integrated jack detection can be see in the WM8350 driver.

Would it make sense to update these documents to point to a different,
active driver as an example to avoid confusing developers who might try
to look up the removed files?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909132153.1596=
191-1-arnd@kernel.org?part=3D11
