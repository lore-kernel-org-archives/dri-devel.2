Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C9DD3515E
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 08:53:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB8CE10EC53;
	Wed,  1 Apr 2026 08:53:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="FLIGidKm";
	dkim-atps=neutral
X-Greylist: delayed 382 seconds by postgrey-1.36 at gabe;
 Wed, 01 Apr 2026 08:53:01 UTC
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de
 [130.133.4.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EEC010EC53
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 08:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
 Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
 References; bh=mbS4sdBdy5EpZUWgeIqN0btTGaVpVymgwhUYntphOuU=; t=1775033581;
 x=1775638381; b=FLIGidKmCBXBjPCiSuQpUw+u6PVywkdTaLBhHhPQFbApQEKbdStkU89uPEAX2
 EX3JkeZNRqmuuTX17QSRSaIhbpUVENeDruvQ8w/F+Y+Tj292gQAn3i9TNyBYJdRi8smv8elKgsylt
 svQGfC8aH9AZi2vfWg1FVLuh1MS8EjFvIqfqUmzz55nNWOOS+Kc/hF89Wk1j6Aj8cuqt/+oD4bS7n
 g+sAdFqyq5ftyvHHE2iLViFWZIm35D51dp5deVaZXPLT416VvPgrp9XHGYNtRSOSVGf3RVcyiLe5n
 1Yn4gFLOxcwnjZmAWdVC8qC9ZNVgL0xWDX9fe/TnNkn5jAT5aA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
 by outpost.zedat.fu-berlin.de (Exim 4.99) with esmtps (TLS1.3)
 tls TLS_AES_256_GCM_SHA384
 (envelope-from <glaubitz@zedat.fu-berlin.de>)
 id 1w7rDc-000000024ZE-0O6N; Wed, 01 Apr 2026 10:46:32 +0200
Received: from tmo-086-60.customers.d1-online.com ([80.187.86.60]
 helo=[172.20.10.2]) by inpost2.zedat.fu-berlin.de (Exim 4.99)
 with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (envelope-from <glaubitz@physik.fu-berlin.de>)
 id 1w7rDb-00000003bOL-2glH; Wed, 01 Apr 2026 10:46:32 +0200
Message-ID: <b7c978f9728c1a1197e90a98bcec5e8e4dc7e7ec.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] arch/sh: Drop CONFIG_FIRMWARE_EDID from defconfig files
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Thomas Zimmermann <tzimmermann@suse.de>, ysato@users.sourceforge.jp, 
 dalias@libc.org, arnd@arndb.de
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org
Date: Wed, 01 Apr 2026 10:46:29 +0200
In-Reply-To: <20260401083242.214492-1-tzimmermann@suse.de>
References: <20260401083242.214492-1-tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 80.187.86.60
X-ZEDAT-Hint: PO
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi Thomas,

On Wed, 2026-04-01 at 10:32 +0200, Thomas Zimmermann wrote:
> CONFIG_FIRMWARE_EDID=3Dy depends on X86 or EFI_GENERIC_STUB. Neither is
> true here, so drop the lines from the defconfig files.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  arch/sh/configs/dreamcast_defconfig | 1 -
>  arch/sh/configs/hp6xx_defconfig     | 1 -
>  arch/sh/configs/se7343_defconfig    | 1 -
>  arch/sh/configs/se7780_defconfig    | 1 -
>  4 files changed, 4 deletions(-)
>=20
> diff --git a/arch/sh/configs/dreamcast_defconfig b/arch/sh/configs/dreamc=
ast_defconfig
> index dd58797e8298..b31bf17fe112 100644
> --- a/arch/sh/configs/dreamcast_defconfig
> +++ b/arch/sh/configs/dreamcast_defconfig
> @@ -50,7 +50,6 @@ CONFIG_HW_RANDOM=3Dy
>  CONFIG_WATCHDOG=3Dy
>  CONFIG_SH_WDT=3Dy
>  CONFIG_FB=3Dy
> -CONFIG_FIRMWARE_EDID=3Dy
>  CONFIG_FB_PVR2=3Dy
>  CONFIG_FRAMEBUFFER_CONSOLE=3Dy
>  CONFIG_FONTS=3Dy
> diff --git a/arch/sh/configs/hp6xx_defconfig b/arch/sh/configs/hp6xx_defc=
onfig
> index 04a9fcb4342a..b6116a203a27 100644
> --- a/arch/sh/configs/hp6xx_defconfig
> +++ b/arch/sh/configs/hp6xx_defconfig
> @@ -35,7 +35,6 @@ CONFIG_SERIAL_SH_SCI_CONSOLE=3Dy
>  CONFIG_LEGACY_PTY_COUNT=3D64
>  # CONFIG_HWMON is not set
>  CONFIG_FB=3Dy
> -CONFIG_FIRMWARE_EDID=3Dy
>  CONFIG_FB_HIT=3Dy
>  CONFIG_FB_SH_MOBILE_LCDC=3Dy
>  CONFIG_FRAMEBUFFER_CONSOLE=3Dy
> diff --git a/arch/sh/configs/se7343_defconfig b/arch/sh/configs/se7343_de=
fconfig
> index 2d4d1f974f14..b3ce8a502787 100644
> --- a/arch/sh/configs/se7343_defconfig
> +++ b/arch/sh/configs/se7343_defconfig
> @@ -57,7 +57,6 @@ CONFIG_I2C=3Dy
>  CONFIG_I2C_SH_MOBILE=3Dy
>  # CONFIG_HWMON is not set
>  CONFIG_FB=3Dy
> -CONFIG_FIRMWARE_EDID=3Dy
>  CONFIG_FB_SH_MOBILE_LCDC=3Dm
>  CONFIG_SOUND=3Dy
>  CONFIG_SND=3Dy
> diff --git a/arch/sh/configs/se7780_defconfig b/arch/sh/configs/se7780_de=
fconfig
> index 13fa6a59b8f1..9e96b000cb99 100644
> --- a/arch/sh/configs/se7780_defconfig
> +++ b/arch/sh/configs/se7780_defconfig
> @@ -60,7 +60,6 @@ CONFIG_SERIAL_SH_SCI_CONSOLE=3Dy
>  # CONFIG_HW_RANDOM is not set
>  CONFIG_THERMAL=3Dy
>  CONFIG_FB=3Dy
> -CONFIG_FIRMWARE_EDID=3Dy
>  CONFIG_FB_SH_MOBILE_LCDC=3Dm
>  CONFIG_FRAMEBUFFER_CONSOLE=3Dy
>  CONFIG_LOGO=3Dy

Thanks for catching this! I wonder where this configuration entry comes fro=
m though.

My SH7785LCR board does have a DVI output as well as a Silicon Motion SM-50=
1 video
chip though, so I think it should be able to perform EDID in general. Or is=
 the
protocol actually tied to the x86 architecture? What about monitors on a Po=
werPC
workstation, for example? Does EDID not work there at all?

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
