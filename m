Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BD8D3517D
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 13:24:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7307410EC88;
	Wed,  1 Apr 2026 13:24:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="VVyBzuIQ";
	dkim-atps=neutral
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de
 [130.133.4.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5693C10EC88
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 13:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
 Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
 References; bh=NzJUnPeIU9yROEt0tAey+LBgtzBXy8jsAIcZJhY4GiI=; t=1775049844;
 x=1775654644; b=VVyBzuIQs6OJ8mdb/Crmoac3Kslg6Ad+xQVqxkvLkuvrNdFOeTMr3qgGpzBoS
 qdh9Yjs0kxI3Pzdmn6xeShBLnvHXKXtOmzsnbZNCrE2Mt+Ou2OzHXNLEWLG+JehINGD6pB0O5ii82
 z1UPuRQU/tzBkAD4lHPVYX3eTa2vjaJBNgNxV0T/FnJN1LRFJH2KyBFaF8v95njW0qT7L71WLvZeY
 WBD3KSGruCpMvqbILJZhOQJdIAufmCqqLTwlubxp0Ni77bUTPpwSiIxrO7gTBL6TSPFYwYgv5ZV9x
 d3evUhG75YN3H9R86jUW6lTL+MxJBRi7M1l/eLbaMEKa0Cj3/A==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
 by outpost.zedat.fu-berlin.de (Exim 4.99) with esmtps (TLS1.3)
 tls TLS_AES_256_GCM_SHA384
 (envelope-from <glaubitz@zedat.fu-berlin.de>)
 id 1w7vY9-000000008mq-0ul0; Wed, 01 Apr 2026 15:24:01 +0200
Received: from dynamic-077-191-137-043.77.191.pool.telefonica.de
 ([77.191.137.43] helo=suse-laptop.fritz.box)
 by inpost2.zedat.fu-berlin.de (Exim 4.99) with esmtpsa (TLS1.3)
 tls TLS_AES_256_GCM_SHA384
 (envelope-from <glaubitz@physik.fu-berlin.de>)
 id 1w7vY9-000000005jL-00f2; Wed, 01 Apr 2026 15:24:01 +0200
Message-ID: <22ef0587b559e2578248a8d19b10cc04c04c4f7a.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] arch/sh: Drop CONFIG_FIRMWARE_EDID from defconfig files
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Thomas Zimmermann <tzimmermann@suse.de>, ysato@users.sourceforge.jp, 
 dalias@libc.org, arnd@arndb.de
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org
Date: Wed, 01 Apr 2026 15:24:00 +0200
In-Reply-To: <808dcd39-ed04-4288-9b21-55b47354de17@suse.de>
References: <20260401083242.214492-1-tzimmermann@suse.de>
 <b7c978f9728c1a1197e90a98bcec5e8e4dc7e7ec.camel@physik.fu-berlin.de>
 <808dcd39-ed04-4288-9b21-55b47354de17@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 77.191.137.43
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

On Wed, 2026-04-01 at 10:53 +0200, Thomas Zimmermann wrote:
> Hi
>=20
> Am 01.04.26 um 10:46 schrieb John Paul Adrian Glaubitz:
> > Hi Thomas,
> >=20
> > On Wed, 2026-04-01 at 10:32 +0200, Thomas Zimmermann wrote:
> > > CONFIG_FIRMWARE_EDID=3Dy depends on X86 or EFI_GENERIC_STUB. Neither =
is
> > > true here, so drop the lines from the defconfig files.
> > >=20
> > > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> > > ---
> > >   arch/sh/configs/dreamcast_defconfig | 1 -
> > >   arch/sh/configs/hp6xx_defconfig     | 1 -
> > >   arch/sh/configs/se7343_defconfig    | 1 -
> > >   arch/sh/configs/se7780_defconfig    | 1 -
> > >   4 files changed, 4 deletions(-)
> > >=20
> > > diff --git a/arch/sh/configs/dreamcast_defconfig b/arch/sh/configs/dr=
eamcast_defconfig
> > > index dd58797e8298..b31bf17fe112 100644
> > > --- a/arch/sh/configs/dreamcast_defconfig
> > > +++ b/arch/sh/configs/dreamcast_defconfig
> > > @@ -50,7 +50,6 @@ CONFIG_HW_RANDOM=3Dy
> > >   CONFIG_WATCHDOG=3Dy
> > >   CONFIG_SH_WDT=3Dy
> > >   CONFIG_FB=3Dy
> > > -CONFIG_FIRMWARE_EDID=3Dy
> > >   CONFIG_FB_PVR2=3Dy
> > >   CONFIG_FRAMEBUFFER_CONSOLE=3Dy
> > >   CONFIG_FONTS=3Dy
> > > diff --git a/arch/sh/configs/hp6xx_defconfig b/arch/sh/configs/hp6xx_=
defconfig
> > > index 04a9fcb4342a..b6116a203a27 100644
> > > --- a/arch/sh/configs/hp6xx_defconfig
> > > +++ b/arch/sh/configs/hp6xx_defconfig
> > > @@ -35,7 +35,6 @@ CONFIG_SERIAL_SH_SCI_CONSOLE=3Dy
> > >   CONFIG_LEGACY_PTY_COUNT=3D64
> > >   # CONFIG_HWMON is not set
> > >   CONFIG_FB=3Dy
> > > -CONFIG_FIRMWARE_EDID=3Dy
> > >   CONFIG_FB_HIT=3Dy
> > >   CONFIG_FB_SH_MOBILE_LCDC=3Dy
> > >   CONFIG_FRAMEBUFFER_CONSOLE=3Dy
> > > diff --git a/arch/sh/configs/se7343_defconfig b/arch/sh/configs/se734=
3_defconfig
> > > index 2d4d1f974f14..b3ce8a502787 100644
> > > --- a/arch/sh/configs/se7343_defconfig
> > > +++ b/arch/sh/configs/se7343_defconfig
> > > @@ -57,7 +57,6 @@ CONFIG_I2C=3Dy
> > >   CONFIG_I2C_SH_MOBILE=3Dy
> > >   # CONFIG_HWMON is not set
> > >   CONFIG_FB=3Dy
> > > -CONFIG_FIRMWARE_EDID=3Dy
> > >   CONFIG_FB_SH_MOBILE_LCDC=3Dm
> > >   CONFIG_SOUND=3Dy
> > >   CONFIG_SND=3Dy
> > > diff --git a/arch/sh/configs/se7780_defconfig b/arch/sh/configs/se778=
0_defconfig
> > > index 13fa6a59b8f1..9e96b000cb99 100644
> > > --- a/arch/sh/configs/se7780_defconfig
> > > +++ b/arch/sh/configs/se7780_defconfig
> > > @@ -60,7 +60,6 @@ CONFIG_SERIAL_SH_SCI_CONSOLE=3Dy
> > >   # CONFIG_HW_RANDOM is not set
> > >   CONFIG_THERMAL=3Dy
> > >   CONFIG_FB=3Dy
> > > -CONFIG_FIRMWARE_EDID=3Dy
> > >   CONFIG_FB_SH_MOBILE_LCDC=3Dm
> > >   CONFIG_FRAMEBUFFER_CONSOLE=3Dy
> > >   CONFIG_LOGO=3Dy
> > Thanks for catching this! I wonder where this configuration entry comes=
 from though.
> >=20
> > My SH7785LCR board does have a DVI output as well as a Silicon Motion S=
M-501 video
> > chip though, so I think it should be able to perform EDID in general. O=
r is the
> > protocol actually tied to the x86 architecture? What about monitors on =
a PowerPC
> > workstation, for example? Does EDID not work there at all?
>=20
> Yes, your system can fetch the EDID via the Linux driver. But=20
> FIRMWARE_EDID is a special feature where the EDID gets delivered by the=
=20
> boot loader. This has always only been possible on x86 or with EFI.

Ah, thanks. I wasn't aware of that feature. Let me add my RB then.

I'll try to merge some patches this week.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
