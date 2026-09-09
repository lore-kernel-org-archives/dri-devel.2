Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C36C79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:39:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3168710F170;
	Wed,  9 Sep 2026 13:39:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="egJbhgfY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C8AD10F170
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 13:39:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 704B96020A;
 Wed,  9 Sep 2026 13:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6428D1F00A3A;
 Wed,  9 Sep 2026 13:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788961144;
 bh=SpOPfr2ReQiqwGUnnCKY8XMzRuE7it2CJR17DCuQCKc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=egJbhgfYu9Xcsn0rWtO8Y1mvsiMo3zEUzJocdGJ9irQKae8Ea7PNLpE65RQWhPMrY
 KQ38HSUN2ykXprj/XiupLTY+dmBNf+KB/AA4oqQTcmYLXBLQYXRwOKEKfl2YgO2yDB
 5uArAmpI1Gqp2i0e+ay9cw9DpGu4XQynD2YApu2/JzOkzwsfmPsO9P5ih/CWeM8zIf
 2fmKy8Vu5psZQWVlGbxQUP+Gjr3Y3C2+dRrUoO5etH1kb5kS3i2Kij3+1SP3WOcIC0
 2lqveHCwWm6PDvd0zp+Jx7mcw0X6z9YFiM6cSC1/0iqYOhagq1+G9AkqDTq9mzZMMB
 jB8C7XdOixhbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/14] mfd: remove unused da903x driver
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: mfd@lists.linux.dev, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com,
 linux-hwmon@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, robh@kernel.org,
 linux-leds@vger.kernel.org, linux-watchdog@vger.kernel.org,
 media-ci@linuxtv.org, lee@kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260909132153.1596191-7-arnd@kernel.org>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-7-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 13:39:02 +0000
Message-Id: <20260909133903.6428D1F00A3A@smtp.kernel.org>
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
- [Low] Incomplete driver removal leaves behind orphaned header, MAINTAINER=
S entry, and stale defconfig options.
--

commit 5d7f5a2366c42ef6c4fd37de982c54aaa25f59e1
Author: Arnd Bergmann <arnd@arndb.de>

mfd: remove unused da903x driver

This driver was used on a handful of ARM/PXA boards until those
got removed a few years ago. Without devicetree support, there is
no way to use them upstream.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index ce681f5e08967..43355bffc6100 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7575,7 +7575,6 @@ F:	drivers/input/misc/da72??.[ch]
>  F:	drivers/input/misc/da90??_onkey.c
>  F:	drivers/input/touchscreen/da9052_tsi.c
>  F:	drivers/leds/leds-da90??.c
> -F:	drivers/mfd/da903x.c
>  F:	drivers/mfd/da90??-*.c

[Severity: Low]
Does this incomplete removal leave behind the orphaned header file
include/linux/mfd/da903x.h? It appears the header is no longer used but
was not deleted in this commit.

Additionally, should the MAINTAINERS entry for include/linux/mfd/da903x.h
(at line 7590) be removed along with it?

Finally, are there stale defconfig options (CONFIG_PMIC_DA903X=3Dy) left in
arch/arm/configs/pxa_defconfig (at line 322) and
arch/arm/configs/pxa3xx_defconfig (at line 57) that should be cleaned
up as well, to avoid minor kernel configuration warnings when running
make defconfig?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909132153.1596=
191-1-arnd@kernel.org?part=3D6
