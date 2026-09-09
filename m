Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D589C79FB7
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:40:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 582CF10F173;
	Wed,  9 Sep 2026 13:40:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kK4Zzt0k";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A12E310F172
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 13:39:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8A2C442B6B;
 Wed,  9 Sep 2026 13:39:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4DD51F00A3D;
 Wed,  9 Sep 2026 13:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788961197;
 bh=WA4y5vV3v0lUi1+6hd/3b8x4mAITSQ81uAkJYhdoYXk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kK4Zzt0kKlS3vN2zHQ8dhJw4lH7McJ00cIC+ipL9koVVCN/bhONTQ9VHYEId7n6aV
 +BetxU1jr2pmTqo9KaZQAYP9MCk5pzScSUnfq7tUoa1/YH3Pox8UGMZtSv8oo/2S07
 KKyQQ2oYGRgGRLjeVwR3rRTsj4yaqeoUofERsqHzVOBtXNMid9FC+iI+DodTsvpu/h
 +kLor+mUrSdMJI0qR6XqXfJRMp5ll0TVND5+7dZ1g+sYDk+6FhZdMJ/9UVizatGX+K
 5YvNhH1wrSACnUHH/Qj5z0FT6PncVAkkbMS28iCS4Jl6xFhQajRMwejA6/aYRdJGhe
 f0Jpdh8gbMKqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/14] mfd: remove unused rdc321x southbridge support
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 media-ci@linuxtv.org, mfd@lists.linux.dev, linux-leds@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org, linux-input@vger.kernel.org,
 "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, dmitry.torokhov@gmail.com,
 linux-watchdog@vger.kernel.org, lee@kernel.org, linux-rtc@vger.kernel.org,
 conor+dt@kernel.org
In-Reply-To: <20260909132153.1596191-3-arnd@kernel.org>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-3-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 13:39:56 +0000
Message-Id: <20260909133956.E4DD51F00A3D@smtp.kernel.org>
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
- [Low] Incomplete removal of RDC321x support leaves dead reboot fixups, PC=
I IDs, and a stale MAINTAINERS entry.
--

commit d66c645a0b11af3b988f3b3f1fe1a950247d9884
Author: Arnd Bergmann <arnd@arndb.de>

mfd: remove unused rdc321x southbridge support

This commit removes the rdc321x southbridge support (MFD, GPIO, and Watchdo=
g),
as the older i486 chips can no longer boot Linux.

> Remove this driver, as there is no way to run Linux any more on the
> older chips after i486 support has been removed.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

[Severity: Low]
Since the entire platform and driver support is being removed, should we
also clean up the remaining dead references to the RDC321x platform?

Specifically, the reboot fixup code in arch/x86/kernel/reboot_fixups_32.c
has a rdc321x_reset() function and an associated entry in fixups_table that
appear to be left behind now that the hardware is no longer supported.

Additionally, the PCI_DEVICE_ID_RDC_R6030 definition in include/linux/pci_i=
ds.h
is no longer used by any active driver.

Finally, there is a stale "RDC R-321X SoC" entry in MAINTAINERS that might
need to be removed to complete the cleanup.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909132153.1596=
191-1-arnd@kernel.org?part=3D2
