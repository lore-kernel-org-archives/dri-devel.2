Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14D4F3ED6D
	for <dri-devel@archiver.kernel.org>; Sun, 12 Apr 2026 07:36:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90CD810E07D;
	Sun, 12 Apr 2026 07:36:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="krpq44Xu";
	dkim-atps=neutral
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de
 [130.133.4.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46F8510E07D
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 07:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
 Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
 References; bh=rCaJARKuSHV6Wf+a3VuN+78c7JCL984SGCykXFzZQcs=; t=1775979364;
 x=1776584164; b=krpq44Xufu3hthxutcKWXp/+1F03bPkNzLFOdDmLL7c0XUgMELbYDT8W0z5vb
 NhiPZqOxtkkYPxVLtS86qTB4m+evEItVseaQ6FBsQ28pLdhTY8/5+53Ju40mWvkgyU5ViYWbf8GLZ
 TSXmMjIy03M5BbP7KfopSutmcL6wsaIHnkwtcPf74qgHzZnaqBrDfuZI4H5btxZLAltV6BVOx86NG
 YjYuNvuo/74WrjFRdYRV+8yZ8bMYNLn7nrkyhlDuQAyDQAWNkeMW+83v3r8O7HceU4MDeV6LNengw
 WcPny8qaDDhqDWmwN1x4K5+kGH6/dj3YfDHEG6eN1KwT4ZibCw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
 by outpost.zedat.fu-berlin.de (Exim 4.99) with esmtps (TLS1.3)
 tls TLS_AES_256_GCM_SHA384
 (envelope-from <glaubitz@zedat.fu-berlin.de>)
 id 1wBpMM-00000002RpE-3s0w; Sun, 12 Apr 2026 09:35:58 +0200
Received: from dynamic-077-183-202-106.77.183.pool.telefonica.de
 ([77.183.202.106] helo=[192.168.178.50])
 by inpost2.zedat.fu-berlin.de (Exim 4.99) with esmtpsa (TLS1.3)
 tls TLS_AES_256_GCM_SHA384
 (envelope-from <glaubitz@physik.fu-berlin.de>)
 id 1wBpMM-00000001dYV-2v5W; Sun, 12 Apr 2026 09:35:58 +0200
Message-ID: <e2c0c4686908f38858716a1dcf67df7de488fd33.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] arch: sh: Include <linux/io.h> in dac.h
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Thomas Zimmermann <tzimmermann@suse.de>, ysato@users.sourceforge.jp, 
 dalias@libc.org, lee@kernel.org, danielt@kernel.org, simona.vetter@ffwll.ch
Cc: linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org, kernel test
 robot <lkp@intel.com>, Jingoo Han <jingoohan1@gmail.com>
Date: Sun, 12 Apr 2026 09:35:57 +0200
In-Reply-To: <20251028170913.16711-1-tzimmermann@suse.de>
References: <20251028170913.16711-1-tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 77.183.202.106
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

On Tue, 2025-10-28 at 18:07 +0100, Thomas Zimmermann wrote:
> Include <linux/io.h> to avoid depending on <linux/backlight.h> for
> including it. Declares __raw_readb() and __raw_writeb().
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202510282206.wI0HrqcK-lkp@i=
ntel.com/
> Fixes: 243ce64b2b37 ("backlight: Do not include <linux/fb.h> in header fi=
le")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Daniel Thompson (RISCstar) <danielt@kernel.org>
> Cc: Simona Vetter <simona.vetter@ffwll.ch>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Daniel Thompson <danielt@kernel.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> ---
> This is fallout from a recent cleanup of the backlight header file. I don=
't
> have the option of building or testing this change, though.
> ---
>  arch/sh/include/cpu-sh3/cpu/dac.h | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/sh/include/cpu-sh3/cpu/dac.h b/arch/sh/include/cpu-sh3/=
cpu/dac.h
> index fd02331608a8..323ec8570bcd 100644
> --- a/arch/sh/include/cpu-sh3/cpu/dac.h
> +++ b/arch/sh/include/cpu-sh3/cpu/dac.h
> @@ -2,6 +2,8 @@
>  #ifndef __ASM_CPU_SH3_DAC_H
>  #define __ASM_CPU_SH3_DAC_H
> =20
> +#include <linux/io.h>
> +
>  /*
>   * Copyright (C) 2003  Andriy Skulysh
>   */

I'm just looking at this patch again and was wondering where <linux/backlig=
ht.h> is
actually being pulled in on SH3. I assume this is somewhere on the driver s=
ide, no?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
