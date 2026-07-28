Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6983EC53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 08:32:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB61D10E535;
	Tue, 28 Jul 2026 08:32:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n0QXlJvN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD71010E535
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 08:32:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2774A600FC;
 Tue, 28 Jul 2026 08:32:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65141F000E9;
 Tue, 28 Jul 2026 08:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785227536;
 bh=3/0sfXalVE5etO6V4X3dxJSTBW8jqDrdkNqewM9CZ6E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=n0QXlJvNvM/Tx8WiB8ZPIS5UleIo4dVnZzrKDmFmdVgz16HwSn3Di8HAhMeZ53AWY
 1TyLSb68BS/K5h8t2zmmnrorKznkb/q35iwiozHat9gkwgiRMML7lKKSCvawB6IhX+
 xUFTSgqn/yWia/GjOFdhrJtF/aekVg8Pehds6JTVppJv9VC06AIY4+nt/4QzS56bte
 246SOD21PB+8MNjFZsroW0XP9GE1+TG3YFzNMjoIldUiX++lekCzyFrGOCTnw74N4D
 vuZZPS+nxgWD9tTvwmbdlSYX+tsqc9rlBoeyKkbhVQDQaNx4Bbg79ndaTiFZlBLBD5
 xUXMIz4VEfgLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 2/4] firmware: Move firmware attributes class helper
To: "Sean Rhodes" <sean@starlabs.systems>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <f1f028a5cb40595032120ca9dd43360594c83bf4.1785226809.git.sean@starlabs.systems>
References: <cover.1785226809.git.sean@starlabs.systems>
 <f1f028a5cb40595032120ca9dd43360594c83bf4.1785226809.git.sean@starlabs.systems>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 08:32:16 +0000
Message-Id: <20260728083216.A65141F000E9@smtp.kernel.org>
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
- [High] The asus-armoury driver incorrectly uses device_destroy() with MKD=
EV(0,0), which can destroy other drivers' firmware attribute devices.
--

--- Patch [2]: [PATCH v10 2/4] firmware: Move firmware attributes class hel=
per ---
commit 054683b4de0166df7f1b8f201cf00b84efd05b62
Author: Sean Rhodes <sean@starlabs.systems>

firmware: Move firmware attributes class helper

Move the firmware attributes class helper from drivers/platform/x86 to
drivers/firmware and expose its class declaration through a public Linux
header. The helper is not x86-specific, allowing coreboot firmware drivers
to use the standard ABI without living under platform/x86.

[ ... ]

> diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/a=
sus-armoury.c
> index f3d8c5a857621..e6af93608ec50 100644
> --- a/drivers/platform/x86/asus-armoury.c
> +++ b/drivers/platform/x86/asus-armoury.c
> @@ -20,7 +20,7 @@
>  #include <linux/dmi.h>
>  #include <linux/err.h>
>  #include <linux/errno.h>
> -#include "firmware_attributes_class.h"
> +#include <linux/firmware_attributes.h>

[Severity: High]
This is a pre-existing issue, but I noticed a potential problem with how
this class is used in this driver.

In asus_fw_attr_add() (on the error path) and asus_fw_exit(), the driver ca=
lls:

    device_destroy(&firmware_attributes_class, MKDEV(0, 0));

device_destroy() uses class_find_device_by_devt() to find the first device
matching the devt (which is MKDEV(0,0)).

Multiple drivers in this class (like dell-wmi-sysman or think-lmi) create
devices with devt=3D0.

Will this indiscriminately destroy another driver's device instead of the
one belonging to asus-armoury?

If another firmware attributes driver is active, could this leave the victim
driver with a dangling device pointer, leading to a crash when it unloads a=
nd
calls device_unregister(), while leaking the actual asus-armoury device?

>  #include <linux/fs.h>
>  #include <linux/kernel.h>
>  #include <linux/kmod.h>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1785226809.gi=
t.sean@starlabs.systems?part=3D2
