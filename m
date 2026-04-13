Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E45EBFD0A
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 07:29:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1796C10E332;
	Mon, 13 Apr 2026 07:29:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="ZTNR5Vd3";
	dkim-atps=neutral
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de
 [130.133.4.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B952210E332
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 07:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
 Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
 References; bh=HG8xZOikE5wswKuWNX0ZhN/h9I3xfWt6DYNlMj8kLjI=; t=1776065377;
 x=1776670177; b=ZTNR5Vd3v95nigu42eLXaUss12ZHMLWeebIYJR0GqfYxwNYqb3sJTjIE25Ejd
 r/iU7HAf2g2IoOeJ5iD+57/ta7wGeys0flE2EsF0sBCIwaxZndN/+89W1DAKhI2OmJgVLc6Mqd5KA
 ah98Ckbl0rhLvar7nvInoIopWL2X9g6RiBvpP1/v3Mmhefw8WpALvbeD1torTsIVuw1tn0xTz58ky
 hBcXr2a+7nVUNwupMel0QVb0kUy/ERQcNYfl2MXVVvhq9FCF6DiCxHcyF9T3Ve9H9sbUjXMU5avHX
 DXL03nD+Zq3d+YsN7jckbaRTXZ/BTkZfyb2jx9qhUiCNdgd9WQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
 by outpost.zedat.fu-berlin.de (Exim 4.99) with esmtps (TLS1.3)
 tls TLS_AES_256_GCM_SHA384
 (envelope-from <glaubitz@zedat.fu-berlin.de>)
 id 1wCBji-00000003irS-1fdb; Mon, 13 Apr 2026 09:29:34 +0200
Received: from dynamic-093-128-043-080.93.128.pool.telefonica.de
 ([93.128.43.80] helo=[192.168.178.50])
 by inpost2.zedat.fu-berlin.de (Exim 4.99) with esmtpsa (TLS1.3)
 tls TLS_AES_256_GCM_SHA384
 (envelope-from <glaubitz@physik.fu-berlin.de>)
 id 1wCBji-00000001ADe-0kCJ; Mon, 13 Apr 2026 09:29:34 +0200
Message-ID: <d3af51074e76f051b72d59c1bc45ebe4eff3cb4e.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] arch: sh: Include <linux/io.h> in dac.h
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Thomas Zimmermann <tzimmermann@suse.de>, ysato@users.sourceforge.jp, 
 dalias@libc.org, lee@kernel.org, danielt@kernel.org, simona.vetter@ffwll.ch
Cc: linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org, kernel test
 robot <lkp@intel.com>, Jingoo Han <jingoohan1@gmail.com>
Date: Mon, 13 Apr 2026 09:29:33 +0200
In-Reply-To: <5ce643a9-59ec-480a-985e-764bf23e2485@suse.de>
References: <20251028170913.16711-1-tzimmermann@suse.de>
 <e2c0c4686908f38858716a1dcf67df7de488fd33.camel@physik.fu-berlin.de>
 <5ce643a9-59ec-480a-985e-764bf23e2485@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 93.128.43.80
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

On Mon, 2026-04-13 at 08:59 +0200, Thomas Zimmermann wrote:
> Hi
>=20
> Am 12.04.26 um 09:35 schrieb John Paul Adrian Glaubitz:
> > Hi Thomas,
> >=20
> > On Tue, 2025-10-28 at 18:07 +0100, Thomas Zimmermann wrote:
> > > Include <linux/io.h> to avoid depending on <linux/backlight.h> for
> > > including it. Declares __raw_readb() and __raw_writeb().
> > >=20
> > > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202510282206.wI0HrqcK-l=
kp@intel.com/
> > > Fixes: 243ce64b2b37 ("backlight: Do not include <linux/fb.h> in heade=
r file")
> > > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > > Cc: Daniel Thompson (RISCstar) <danielt@kernel.org>
> > > Cc: Simona Vetter <simona.vetter@ffwll.ch>
> > > Cc: Lee Jones <lee@kernel.org>
> > > Cc: Daniel Thompson <danielt@kernel.org>
> > > Cc: Jingoo Han <jingoohan1@gmail.com>
> > > Cc: dri-devel@lists.freedesktop.org
> > > ---
> > > This is fallout from a recent cleanup of the backlight header file. I=
 don't
> > > have the option of building or testing this change, though.
> > > ---
> > >   arch/sh/include/cpu-sh3/cpu/dac.h | 2 ++
> > >   1 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/arch/sh/include/cpu-sh3/cpu/dac.h b/arch/sh/include/cpu-=
sh3/cpu/dac.h
> > > index fd02331608a8..323ec8570bcd 100644
> > > --- a/arch/sh/include/cpu-sh3/cpu/dac.h
> > > +++ b/arch/sh/include/cpu-sh3/cpu/dac.h
> > > @@ -2,6 +2,8 @@
> > >   #ifndef __ASM_CPU_SH3_DAC_H
> > >   #define __ASM_CPU_SH3_DAC_H
> > >  =20
> > > +#include <linux/io.h>
> > > +
> > >   /*
> > >    * Copyright (C) 2003  Andriy Skulysh
> > >    */
> > I'm just looking at this patch again and was wondering where <linux/bac=
klight.h> is
> > actually being pulled in on SH3. I assume this is somewhere on the driv=
er side, no?
>=20
> Oh well, it's been ages...
>=20
> I've been cleaning up the plenty of places that include <linux/fb.h> and=
=20
> <linux/backlight.h> unnecessarily. Besides the Fixes tag, presumably=20
> commit df1445598758 ("backlight: hp680_bl: Do not include <linux/fb.h>")=
=20
> is involved as well. The hp680_bl backlight driver got <linux/io.h> via=
=20
> <linux/fb.h> via <linux/backlight.h> before including <cpu/dac.h>. With=
=20
> fb.h gone from backlight.h gone,=C2=A0 dac.h should best include its=20
> dependencies. Hence the patch here.

Perfect, thanks for the quick explanation! I will pick up the patch then.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
