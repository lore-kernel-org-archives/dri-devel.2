Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E88C79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:39:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F017910F172;
	Wed,  9 Sep 2026 13:39:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RStrXrZT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF50A10F172
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 13:39:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9831440B07;
 Wed,  9 Sep 2026 13:39:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5FC1F00A3A;
 Wed,  9 Sep 2026 13:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788961196;
 bh=3sx/8+b19P+3KuWUHTPZEvdaV3mA3HPGKEAeTZLTHcI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RStrXrZTIman062uHENY0up1qxLRqVdxLVc7Hgdi8R2nD9LEbyI3MHwB/9ZMq3BcU
 za0ZlyaaYbuoce+GuN20I901SiNhfVoKKbn4wYLEfmED4SbVYhSVtZp9KntKdn3RfC
 Px1MA/6QyDZwyUTnKCtcpR28hoyfhEDaKesLtzKmgacqjOIGHTIhicUPIfSqq5F+NQ
 DIF9Th85HvMNr/pGNIkrj+3eZaG5RmcGjmGvoQU4nnMV7H1Zl00FLPwojCAMXGUdQ5
 RwqIkxtt623oDC9N12qsnVhoQb2qxy8XVC7gayUq9D5HLSLTIA9laHndBnb9SyV/L4
 /e2ZcpYzsOeqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/14] mfd: remove unused lp8788 driver
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-watchdog@vger.kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, linux-leds@vger.kernel.org,
 robh@kernel.org, mfd@lists.linux.dev, media-ci@linuxtv.org,
 conor+dt@kernel.org, linux-hwmon@vger.kernel.org, dmitry.torokhov@gmail.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-input@vger.kernel.org, lee@kernel.org
In-Reply-To: <20260909132153.1596191-8-arnd@kernel.org>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-8-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 13:39:55 +0000
Message-Id: <20260909133955.BD5FC1F00A3A@smtp.kernel.org>
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
- [Low] Incomplete cleanup: orphaned Makefile entry for `rtc-lp8788.o`.
--

commit b9b327cd8a968733772283e939af3a5d5a3cf637
Author: Arnd Bergmann <arnd@arndb.de>

mfd: remove unused lp8788 driver

This commit removes the unused lp8788 driver and its sub-device drivers
across multiple subsystems. The driver lacks devicetree support and has
apparently never been used upstream.

> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index ad5c9b8ceb242..0ce7c1a8f4517 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
[ ... ]
> @@ -317,12 +317,6 @@ config RTC_DRV_HYM8563
>  	  This driver can also be built as a module. If so, the module
>  	  will be called rtc-hym8563.
> =20
> -config RTC_DRV_LP8788
> -	tristate "TI LP8788 RTC driver"
> -	depends on MFD_LP8788
> -	help
> -	  Say Y to enable support for the LP8788 RTC/ALARM driver.
> -

[Severity: Low]
This patch removes the CONFIG_RTC_DRV_LP8788 symbol here, and also deletes
the drivers/rtc/rtc-lp8788.c source file. Should the corresponding build=20
rule in drivers/rtc/Makefile also be removed?

Currently, drivers/rtc/Makefile still contains this entry:
obj-$(CONFIG_RTC_DRV_LP8788) +=3D rtc-lp8788.o

Since the Kconfig symbol is no longer defined, it evaluates to an empty
string, leaving a dead configuration line in the build system.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909132153.1596=
191-1-arnd@kernel.org?part=3D7
