Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B72C56208
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 15:29:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B87A110F222;
	Thu,  6 Aug 2026 15:29:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W+S4Btjz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38FC310F226
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 15:29:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AB56E60AB0
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 15:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021291F000E9;
 Thu,  6 Aug 2026 15:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786030158;
 bh=VPFcSmpjoCTCMJF5TzDzVM4VVkO7ULhORhxE0HRYXOY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=W+S4Btjz9ZXz14rIEEmUpVoNgmI+qCst6/7X6QuPJM5az0vQpnsI2KuI1mmC/wqnF
 J7CuWcV+a1XIPPovJc7p98jCr8akv4lbT2U5H8Oi8bnVwclLFp3RIGu8cMUndLIlp7
 t8m3m5bHDT3jk4KNsRpmgIZIUNKK6EhoT1irdv3n4Dxp3SBfNCR09jwploAtbR7SzO
 JNtTmAr/8D2DznB9bCkqQDK9cZJkcK6ixy/us8rsfgZzD0738JqRhO9U9qjhSvjJJ0
 4QcyzTRFP7qX+LbCNa7Ls3zN+/jxT2jDrA6uNZrpJqpJ4rIwz5yFsyHfVwW3Z5e4fP
 fyEYAg6hn/x4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] sticon/parisc: Detect default STI graphics card for
 console output
To: "Helge Deller" <deller@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260806150414.7870-2-deller@kernel.org>
References: <20260806150414.7870-2-deller@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 15:29:17 +0000
Message-Id: <20260806152918.021291F000E9@smtp.kernel.org>
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

New issues:
- [Medium] The function `hwpath_to_device` returns an unrefcounted pointer =
to a `struct device`, leading to a potential Use-After-Free if the device i=
s concurrently removed.

Pre-existing issues:
- [High] Unbounded sprintf formatting in `print_pa_hwpath` and `print_pci_h=
wpath` can overflow the statically sized 24-byte `pa_path` buffer inside `s=
truct sti_struct`.
--

--- Patch [1]: [PATCH v2] sticon/parisc: Detect default STI graphics card f=
or console output ---
commit 29c9337b8cdefb96f4918bde459cea7d9955e767
Author: Helge Deller <deller@gmx.de>

sticon/parisc: Detect default STI graphics card for console output

This commit detects the graphics card used for firmware messages and sets
it as the default for sticon and fbcon. It extracts the hardware path
from stable storage or PAGE0 and compares it to identify the default device.
The default_sti_path string length is increased to 32 characters to prevent
buffer overflows during hardware path formatting.

>     Increase max string size for default_sti_path to 32 chars as the
>     print_pa_hwpath() function formats a hardware path using unbounded sp=
rintf
>     calls for up to 6 bus converter components and 1 module component (e.=
g.,
>     255/255/...), which can produce a string up to 28 bytes long.

[Severity: High]
This is a pre-existing issue, but since the commit message correctly identi=
fies
that print_pa_hwpath() and print_pci_hwpath() can produce a string up to
28 bytes long, does this also overflow the pa_path buffer inside
struct sti_struct?

include/video/sticore.h:
    struct sti_struct {
        ...
        char pa_path[24];
        ...
    }

Since sticore_pa_init() and sticore_pci_init() pass sti->pa_path directly to
these functions, could this overflow the 24-byte pa_path array and corrupt
adjacent heap memory during device enumeration?

> diff --git a/drivers/video/sticore.c b/drivers/video/sticore.c
> index 0d37e4b10447e..1d4477f204504 100644
> --- a/drivers/video/sticore.c
> +++ b/drivers/video/sticore.c

[ ... ]

> @@ -1148,6 +1148,26 @@ static void sti_init_roms(void)
>  	pr_info("STI GSC/PCI core graphics driver "
>  			STI_DRIVERVERSION "\n");
> =20
> +	/*
> +	 * Find default console by hardware path which is either stored in
> +	 * console entry in stable storage or alternatively from console path
> +	 * in PAGE0 used by BCH and PDC.
> +	 */
> +	if (!default_sti_path[0]) {
> +		struct pdc_module_path conspath;
> +		struct device *dev =3D NULL;
> +
> +		if (pdc_stable_read(0x60, &conspath, sizeof(conspath)) =3D=3D PDC_OK)
> +			dev =3D hwpath_to_device(&conspath.path);
> +		if (!dev)
> +			dev =3D hwpath_to_device(&PAGE0->mem_cons.dp.path);
> +		if (dev && dev_is_pci(dev))

[Severity: Medium]
Does hwpath_to_device() return an unrefcounted device pointer?

Looking at hwpath_to_device() in arch/parisc/kernel/drivers.c, it seems to
use device_for_each_child() to find the device but returns the pointer with=
out
elevating its reference count.

If the console hardware is concurrently hot-unplugged after hwpath_to_devic=
e()
returns, could this lead to a use-after-free when calling dev_is_pci(dev) or
to_pci_dev(dev) on the freed device pointer?

> +			print_pci_hwpath(to_pci_dev(dev), default_sti_path);
> +		else if (dev && !dev_is_pci(dev))
> +			print_pa_hwpath(to_parisc_device(dev), default_sti_path);
> +		pr_debug("default graphic card: %s\n", default_sti_path);
> +	}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806150414.7870=
-2-deller@kernel.org?part=3D1
