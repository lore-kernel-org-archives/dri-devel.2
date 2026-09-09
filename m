Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74AE2C79FB7
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:43:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A87CC10F177;
	Wed,  9 Sep 2026 13:43:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O0r7S8RU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B54010F174
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 13:43:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6BFFC6020A;
 Wed,  9 Sep 2026 13:43:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED151F00A3A;
 Wed,  9 Sep 2026 13:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788961436;
 bh=RdwnXzBL7WyMLLjYxNFInZCiDTIkVZjGk6NUVcwdr5I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=O0r7S8RUBf3AvCE6uMfgQ79R48DFP6URtXbvVhBzoboogAcWCuNfDijEk9TrxGtGu
 C6Xkk8kuXoDHVrr0qtku4f1SJsFZOVgtKIJ0mbJa4Ot2Ps1tJ8xlE/V5UvFE3N4+3q
 AoQT77+P3Loy24fTFgexcVLF6f0OY23EQzo5Dgo9Uqhmg3TqD8z68nF8as1ohTJs3b
 SLaLCu86dujBm/lIoHZ4sUR5QH40FkUyqs2ajiGkzZKkrpbUePCKcyksYYGHaZM072
 jJqVZJMyeOr71hQxFBeTY6W0RKzAUxFWUY/zWKJwOM1fMIHeYHD5Pt9p92e+la2IX6
 ZqvxuH1BNb9yA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/14] mfd: remove unused iPaq micro driver
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: media-ci@linuxtv.org, lee@kernel.org, robh@kernel.org,
 dmitry.torokhov@gmail.com, linux-rtc@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-input@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-watchdog@vger.kernel.org,
 mfd@lists.linux.dev, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260909132153.1596191-15-arnd@kernel.org>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-15-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 13:43:54 +0000
Message-Id: <20260909134355.5ED151F00A3A@smtp.kernel.org>
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
- [High] The patch removes the MFD_IPAQ_MICRO core driver, but leaves behin=
d references to its non-existent Kconfig symbol in select statements, as we=
ll as orphaned child drivers and header files.
- [Low] The commit message does not follow the mandatory prefix and capital=
ization rules for the MFD subsystem.
--

commit 083382aa696919c18a4b69206eaec876c285e518
Author: Arnd Bergmann <arnd@arndb.de>

mfd: remove unused iPaq micro driver

The iPaq support has been removed from the kernel, this driver is
no longer used anywhere.

> mfd: remove unused iPaq micro driver

[Severity: Low]
Is the commit message subject missing the standard MFD prefix format?
It appears the format should be "mfd: <Driver>: <Capitalized description>"
rather than "mfd: remove unused iPaq micro driver".

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 02e52398fcd28..6189bd7cc1098 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -780,16 +780,6 @@ config MFD_INTEL_PMC_BXT
>  	  Register and P-unit access. In addition this creates devices
>  	  for iTCO watchdog and telemetry that are part of the PMC.
> =20
> -config MFD_IPAQ_MICRO
> -	bool "Atmel Micro ASIC (iPAQ h3100/h3600/h3700) Support"

[Severity: High]
Are there still orphaned references to this config symbol in other parts of
the tree?

For example, arch/arm/mach-sa1100/Kconfig still selects this symbol for
SA1100_H3600:

    select MFD_IPAQ_MICRO

This causes unmet dependency warnings during the build.

Additionally, child drivers like KEYBOARD_IPAQ_MICRO in
drivers/input/keyboard/Kconfig still depend on it:

    depends on MFD_IPAQ_MICRO

which turns them into unselectable dead code.

Should the child driver source files and headers be removed as well?
In drivers/leds/leds-ipaq-micro.c, micro_leds_brightness_set() attempts to
call a function from the MFD core that has just been removed:

    return ipaq_micro_tx_msg_sync(micro, &msg);

The header include/linux/mfd/ipaq-micro.h also remains, declaring APIs like
ipaq_micro_tx_msg() that no longer have an implementation.

> -	depends on SA1100_H3600
> -	select MFD_CORE
> -	help
> -	  Select this to get support for the Microcontroller found in
> -	  the Compaq iPAQ handheld computers. This is an Atmel
> -	  AT90LS8535 microcontroller flashed with a special iPAQ
> -	  firmware using the custom protocol implemented in this driver.
> -

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909132153.1596=
191-1-arnd@kernel.org?part=3D14
