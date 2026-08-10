Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DEBC5AD5A
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 00:02:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B863610E121;
	Mon, 10 Aug 2026 00:02:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Rh0lHWRj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B974A10E121
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 00:02:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C8B01600AB;
 Mon, 10 Aug 2026 00:02:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55AD61F000E9;
 Mon, 10 Aug 2026 00:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786320171;
 bh=lyUorfBuJ36cRuFvnWvJpr5HvDuPzOnRSA5gofYev98=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Rh0lHWRjsQX5NXi1xr3+D51Jkb+h2esHucnvHQ0IOqJaKW2uAxum94IafDqs9aTQu
 6GALT2fWxwh2GPgKchxVNtFja7Y9SQbJYdcoC2aJy0eflc9SZIkqMUwEEFtIQI0fvh
 W0PpBzqVzcQK6pCpiOlEoNdZxJC+KcabrgGCqHpmYrQ8motxeef++tgAUNqeGvvgC+
 tN3u0a/l6vxIBzzJNtLc6NI1E5le+GleLgWD0J1VSMGmg4YGBlRFxrw2KGBSz7dwUa
 MCbb/JMTOlWVxy7REAB6WQaSUCgo7U/HVp7TRA7QCbz47errXRNf9t8s+vR3Lv76ED
 KtvQClzHBTNVg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] fbdev: maxinefb: fix build issues
To: "Randy Dunlap" <rdunlap@infradead.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260809234810.982500-1-rdunlap@infradead.org>
References: <20260809234810.982500-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 00:02:50 +0000
Message-Id: <20260810000251.55AD61F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Initialization function returns positive value `1` on failure, bre=
aking module load semantics and causing subsequent `registered_fb` array co=
rruption on unload.
- [High] `maxinefb_fix.smem_start` is initialized with a virtual address (`=
CKSEG1ADDR`) instead of the hardware physical address, breaking user-space =
`mmap()`.
--

--- Patch [1]: [RFC PATCH] fbdev: maxinefb: fix build issues ---
commit e391418fa2f21f8c420eccb513c031674ef184c6
Author: Randy Dunlap <rdunlap@infradead.org>

fbdev: maxinefb: fix build issues

This commit fixes build errors and warnings for the maxinefb driver on
32-bit and 64-bit MACH_DECSTATION. It updates KSEG1ADDR to CKSEG1ADDR and
adds the static keyword to missing prototypes.

> diff --git a/drivers/video/fbdev/maxinefb.c b/drivers/video/fbdev/maxinef=
b.c
> index 52528eb4dfb41..8aa1389e2d4c8 100644
> --- a/drivers/video/fbdev/maxinefb.c
> +++ b/drivers/video/fbdev/maxinefb.c
[ ... ]
> @@ -111,7 +98,7 @@ static const struct fb_ops maxinefb_ops =3D {
>  	.fb_setcolreg	=3D maxinefb_setcolreg,
>  };
> =20
> -int __init maxinefb_init(void)
> +static int __init maxinefb_init(void)

[Severity: High]
This is a pre-existing issue, but does returning 1 on failure in this funct=
ion
cause issues with module load semantics?

In maxinefb_init():

        if (register_framebuffer(&fb_info) < 0)
                return 1;

If register_framebuffer() fails, returning a positive integer causes the ke=
rnel
to treat the module as successfully loaded because the module init framework
expects negative error codes for failure.

Later, when the module is unloaded, maxinefb_exit() calls
unregister_framebuffer() on the unregistered fb_info. Since it was never
successfully registered, its node field is 0.

Does this cause the generic do_unregister_framebuffer() to blindly execute
registered_fb[0] =3D NULL, corrupting the kernel's framebuffer state by del=
eting
the reference to whatever valid framebuffer occupied node 0?

> diff --git a/include/video/maxinefb.h b/include/video/maxinefb.h
> index 6aeb4acca2bdb..2b66b32f355cf 100644
> --- a/include/video/maxinefb.h
> +++ b/include/video/maxinefb.h
[ ... ]
> @@ -13,13 +13,13 @@
>  /*
>   * IMS332 video controller register base address
>   */
> -#define MAXINEFB_IMS332_ADDRESS		KSEG1ADDR(0x1c140000)
> +#define MAXINEFB_IMS332_ADDRESS		CKSEG1ADDR(0x1c140000)
> =20
>  /*
>   * Begin of DECstation 5000/xx onboard framebuffer memory, default resol=
ution
>   * is 1024x768x8
>   */
> -#define DS5000_xx_ONBOARD_FBMEM_START	KSEG1ADDR(0x0a000000)
> +#define DS5000_xx_ONBOARD_FBMEM_START	CKSEG1ADDR(0x0a000000)

[Severity: High]
This is a pre-existing issue, but does assigning a virtual address to
maxinefb_fix.smem_start break user-space mmap()?

In maxinefb_init():

        fb_start =3D DS5000_xx_ONBOARD_FBMEM_START;
        ...
        maxinefb_fix.smem_start =3D fb_start;

The smem_start field is passed to vm_iomap_memory() by the generic framebuf=
fer
mmap handler (fb_mmap()). Because vm_iomap_memory() strictly expects a phys=
ical
address, does passing a KSEG1 virtual address set up user-space page tables
pointing to an invalid physical address?

This could trigger an invalid physical memory access and a kernel panic when
user-space accesses the mapped memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809234810.9825=
00-1-rdunlap@infradead.org?part=3D1
