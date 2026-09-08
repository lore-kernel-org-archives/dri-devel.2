Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37989C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:55:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7840A10E0C0;
	Tue,  8 Sep 2026 15:55:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Kao9mFOk";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DFC810E0C0
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 15:55:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 14BCC60230
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 15:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB8B1F00A3A;
 Tue,  8 Sep 2026 15:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788882946;
 bh=vH5T0YzgrnlgIgz7qtn6BIyvyPiswJhYOI0mr5Da2KY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Kao9mFOkCCfX2dLv3blyy5UmJ/DDb240RHC9VNU9iQR/OxwkZtM4jhDD9cE3Eh4JT
 TFoKF9X02z1dc95fW+67mv1YDzUyXJlr2O3fd1VcaubNfGvms5Ue2P3bDKTkiasVIw
 nKxW5+Tr8OGSWeQxU8fGafHlqhDIz4Nilj9N+FUgBbgVH61iWqN28Xsf6sBY0D8D/8
 oJmDBbiBZ5LRg2umMSLXzwW3xM4FVo1GotO3BUrtES2MIJ4qFdy7uh9V7iZUyFlJN0
 AXnlnyynKGAWnxugh7hoKn0hq97ZyfomWAIgRTNRPIB/ryJKVvOciEz+HDnPZj8WHP
 uqJ9ZEb2QHQ3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/13] ARM: remove footbridge
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: dri-devel@lists.freedesktop.org, Frank.Li@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev, robh@kernel.org
In-Reply-To: <20260908152808.3928630-3-arnd@kernel.org>
References: <20260908152808.3928630-1-arnd@kernel.org>
 <20260908152808.3928630-3-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 15:55:45 +0000
Message-Id: <20260908155546.5DB8B1F00A3A@smtp.kernel.org>
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
- [Medium] Dangling Kconfig dependencies and orphaned drivers reference rem=
oved Footbridge/NetWinder symbols.
- [Medium] Dead code blocks conditionally compiled for deleted architecture=
s remain in core ARM files.
--

commit 5927fe5f70523467f7f940a2a1678e08472c6f67
Author: Arnd Bergmann <arnd@arndb.de>

ARM: remove footbridge

This commit removes the deprecated Footbridge platform, including the
StrongARM EBSA285 and NetWinder machines. It deletes the associated
architecture-specific Kconfig entries, makefiles, and source files.

> diff --git a/arch/arm/kernel/atags_parse.c b/arch/arm/kernel/atags_parse.c
> index 4ec591bde3dfa..9865ec7f90d98 100644
> --- a/arch/arm/kernel/atags_parse.c
> +++ b/arch/arm/kernel/atags_parse.c
> @@ -69,24 +69,6 @@ static int __init parse_tag_mem32(const struct tag *ta=
g)
> =20
>  __tagtable(ATAG_MEM, parse_tag_mem32);
> =20
> -#if defined(CONFIG_ARCH_FOOTBRIDGE) && defined(CONFIG_VGA_CONSOLE)
> -static int __init parse_tag_videotext(const struct tag *tag)
> -{
[ ... ]
> -__tagtable(ATAG_VIDEOTEXT, parse_tag_videotext);
> -#endif
> -

[Severity: Medium]
Since this patch removes the footbridge architecture, should similar
arch-specific dead code be removed from arch/arm/kernel/atags_compat.c as
well?

For example, build_tag_list() in that file still retains conditional blocks
for the removed configurations:

#ifdef CONFIG_ARCH_NETWINDER
    if (params->u1.s.nr_pages !=3D 0x02000 &&
...
#ifdef CONFIG_FOOTBRIDGE
    if (params->u1.s.mem_fclk_21285) {
...
#ifdef CONFIG_ARCH_EBSA285
    if (machine_is_ebsa285()) {

> diff --git a/arch/arm/mach-footbridge/Kconfig b/arch/arm/mach-footbridge/=
Kconfig
> deleted file mode 100644
> index 96a74d447028d..0000000000000
> --- a/arch/arm/mach-footbridge/Kconfig
> +++ /dev/null
> @@ -1,57 +0,0 @@
[ ... ]
> -config ARCH_NETWINDER
> -	bool "NetWinder"
[ ... ]
> -config FOOTBRIDGE
> -	def_bool y

[Severity: Medium]
By removing the FOOTBRIDGE and ARCH_NETWINDER configs here, what happens to
the drivers in other subsystems that still depend on them?=20

For example, drivers/watchdog/Kconfig still contains dependencies like:
    config 21285_WATCHDOG
        depends on FOOTBRIDGE

And drivers/char/Kconfig has symbols like DS1620, NWBUTTON, and NWFLASH
that depend on ARCH_NETWINDER. Will these be left permanently unbuildable
since their configurations are orphaned?

Additionally, 977_WATCHDOG depends on:
    (FOOTBRIDGE && ARCH_NETWINDER) || (ARM && COMPILE_TEST)

If someone builds with COMPILE_TEST, won't this driver try to build but
fail due to missing headers?

> diff --git a/arch/arm/include/asm/hardware/dec21285.h b/arch/arm/include/=
asm/hardware/dec21285.h
> deleted file mode 100644
> index 894f2a635cbbd..0000000000000
> --- a/arch/arm/include/asm/hardware/dec21285.h
> +++ /dev/null

[Severity: Medium]
Will the removal of this header cause fatal build errors for the orphaned
drivers mentioned above?

For example, if compilation is attempted (such as with COMPILE_TEST),
nwflash_init() in drivers/char/nwflash.c and serial21285_init() in=20
drivers/tty/serial/21285.c both still include <asm/hardware/dec21285.h>.

Does this patch need to remove those orphaned drivers as well to prevent
build breakages?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908152808.3928=
630-1-arnd@kernel.org?part=3D2
