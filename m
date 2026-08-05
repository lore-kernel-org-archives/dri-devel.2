Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E024C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 21:20:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B7AA10E23A;
	Wed,  5 Aug 2026 21:20:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BuxCt/UW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AD1C10E23A
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 21:20:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AFD5043AF5
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 21:20:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658711F000E9;
 Wed,  5 Aug 2026 21:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785964833;
 bh=ijmkFFCnXEo8WbbU+5ogO0jROvvloRxYt0Rn3c+8by4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BuxCt/UWd1bMxk+7ynHeIFvQFlk2PIwwRG5MZNBmDsornZqA5FRsnvhkPL76pIB16
 jZg2ZvAWa+uF/wQkRRbq91LQKUTGotVStxmxrBKEm1kgcSXpqtCKi89flSEUeQqk0v
 7he/KCYe544FTAcrCZFrxQTg+XgReb1AyuNlkLHtgIS3+wJ8irvniSQw6pJYXQLoCQ
 Bvcranzs6stbGRjCgSo5xYGukeIH9w7vz/H0KP3pIELyq3gH2f1Bvx4IA2uDABnMPe
 wLLFpudColcirF77YmKQhWjlWfg7bHPL67uMsKzOx54SYbXYQ/V1WtqUD3k4Fp0LaV
 vxf4iBKz3wc5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] sticon/parisc: Detect default STI graphics card for
 console output
To: "Helge Deller" <deller@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260805210641.21740-1-deller@kernel.org>
References: <20260805210641.21740-1-deller@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 21:20:32 +0000
Message-Id: <20260805212033.658711F000E9@smtp.kernel.org>
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
- [Critical] Buffer overflow when formatting hardware path into default_sti=
_path.
- [High] Invalid downcast of PCI devices to PA-RISC devices causes type con=
fusion and corrupted hardware paths.
--

--- Patch [1]: [PATCH] sticon/parisc: Detect default STI graphics card for =
console output ---
commit 8dd6681b0fa075edc554f38ec871c9f29bd33be0
Author: Helge Deller <deller@gmx.de>

sticon/parisc: Detect default STI graphics card for console output

This commit adds logic to detect the default graphic card used for firmware
messages. It extracts the hardware path from stable storage or page zero and
stores it as the default STI path for later comparison.

> diff --git a/drivers/video/sticore.c b/drivers/video/sticore.c
> --- a/drivers/video/sticore.c
> +++ b/drivers/video/sticore.c
> @@ -1148,6 +1148,25 @@ static void sti_init_roms(void)
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
> +		if (dev)
> +			print_pa_hwpath(to_parisc_device(dev),
> +					default_sti_path);

[Severity: Critical]
Does this code overflow default_sti_path[]?

Looking at the definition of default_sti_path in drivers/video/sticore.c,
it is a fixed-size 21-byte array:

static char default_sti_path[21] __read_mostly;

The print_pa_hwpath() function formats a hardware path using unbounded
sprintf calls for up to 6 bus converter components and 1 module component
(e.g., 255/255/...). This can produce a string up to 28 bytes long, which
would write past the end of the 21-byte default_sti_path array and corrupt
adjacent variables in the __read_mostly section.

[Severity: High]
Can this unconditional cast cause type confusion for PCI devices?

If hwpath_to_device() resolves to a PCI device, it returns the generic
struct device embedded within a struct pci_dev. By unconditionally casting
this to a struct parisc_device using to_parisc_device(), we end up with an
invalid pointer.

Due to structural layout differences between pci_dev and parisc_device,
accessing dev->hw_path through this incorrectly cast pointer will read
random bytes from the PCI device memory space instead of the correct path,
causing the console default graphics card matching logic to fail silently
for PCI devices.

> +		pr_debug("default graphic card: %s\n", default_sti_path);
> +	}
> +
>  	/* Register drivers for native & PCI cards */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805210641.2174=
0-1-deller@kernel.org?part=3D1
