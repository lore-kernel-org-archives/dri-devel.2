Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D9EC44532
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 13:28:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E949510EA1A;
	Tue, 21 Jul 2026 13:28:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ei8pZ4Rx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D868F10E34C
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:28:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 844954015D;
 Tue, 21 Jul 2026 13:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482F01F00A3A;
 Tue, 21 Jul 2026 13:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784640497;
 bh=xUaBeccQ3VGP4oO1hO6ta2pwWtYhqJ0xF2q8v9dZohQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ei8pZ4RxrKLRCF0eZv757MQGhEYi8xiTBwQrB5A9811kwn0vvx4ivISsDyrRJb3dw
 FONeH2AE9G7jAf+w4FiI0rUF18NrNUOBNWB7mCud0KGTpP1ugXzzenRSLo3StDe3jh
 SpwPfWB6WiZniKoMK2Lut6s+jYjzi4UjlhUZ76LtO6JLYcAw23J2o7bFgAs+9UNRlX
 LV1tpgzz1f+WAyhaRthXpHx0dpvU3tF0WIE045ZwbqsJQj3MmL4D1YjFJGPLpDuFg2
 zn6TaWLIZdTQKsV1uj3gAvIeN4vqw8LyfMK6SqF+OvLQ2Pn+IT5Pv0LDbb0wtoqbzA
 k63BaTF09sULw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] doc: ABI: sysfs-class-backlight: update outdated HAL
 userspace reference
To: "Shivank Sharma" <shivanksharma2376543@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260721132253.256422-1-shivanksharma2376543@gmail.com>
References: <20260721132253.256422-1-shivanksharma2376543@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 13:28:16 +0000
Message-Id: <20260721132817.482F01F00A3A@smtp.kernel.org>
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
- [Low] The patch incompletely updates the 'Users: HAL' references, missing=
 the occurrence under 'actual_brightness'.
--

--- Patch [1]: [PATCH] doc: ABI: sysfs-class-backlight: update outdated HAL=
 userspace reference ---
commit 394037cb75e2eb0f44c91b48f3a8658b6c642c06
Author: Shivank Sharma <shivanksharma2376543@gmail.com>

doc: ABI: sysfs-class-backlight: update outdated HAL userspace reference

This commit replaces the deprecated HAL userspace references in the
sysfs-class-backlight ABI documentation with modern userspace references.

> diff --git a/Documentation/ABI/stable/sysfs-class-backlight b/Documentati=
on/ABI/stable/sysfs-class-backlight
> index 40b8c46b95b28..2f60dd3f40a5c 100644
> --- a/Documentation/ABI/stable/sysfs-class-backlight
> +++ b/Documentation/ABI/stable/sysfs-class-backlight
[ ... ]
> @@ -19,7 +19,7 @@ Description:
>  		are between 0 and max_brightness. This file will also
>  		show the brightness level stored in the driver, which
>  		may not be the actual brightness (see actual_brightness).
> -Users:		HAL
> +Users:		systemd-logind, udev, general userspace.
> =20
>  What:		/sys/class/backlight/<backlight>/actual_brightness
>  Date:		March 2006

[Severity: Low]
Did this patch miss updating the Users field for actual_brightness?

In Documentation/ABI/stable/sysfs-class-backlight, actual_brightness also
has HAL listed as the user, but it appears to have been left out of this
update:

What:           /sys/class/backlight/<backlight>/actual_brightness
Date:           March 2006
KernelVersion:  2.6.17
Contact:        Richard Purdie <rpurdie@rpsys.net>
Description:
                Show the actual brightness by querying the hardware. Due
...
Users:          HAL

> @@ -40,7 +40,7 @@ KernelVersion:	2.6.12
>  Contact:	Richard Purdie <rpurdie@rpsys.net>
>  Description:
>  		Maximum brightness for <backlight>.
> -Users:		HAL
> +Users:		systemd-logind, udev, general userspace.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721132253.2564=
22-1-shivanksharma2376543@gmail.com?part=3D1
