Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 729E3CDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 06:57:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACB4110E4BC;
	Mon, 22 Jun 2026 06:57:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZkFiQ6+7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2FBB10E4BC
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 06:57:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 301C66008A;
 Mon, 22 Jun 2026 06:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66AC1F000E9;
 Mon, 22 Jun 2026 06:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782111448;
 bh=fN9O59efbfdQd04sAfHSYsYtGwpIqrsVPG6+Vz8MdlE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZkFiQ6+7LNHH9Lu4FZFHghnwt2+jtWiGkqNk2XU/VUe30LvMfYmRVCXDOu8vbFKwB
 J5Y3XTDgJxcJKsiJVXcnVwhZWUvziDf+3FIyuqi6c8fI5EVYqcwd0q8za/Q3yg/mGm
 Ilm0t6+0SxUFN/V9H5c0c2qLv2g+ukxPSFKXy2WtSX3Kc3Hiv1qrzuTR4NwFqAG5cg
 ARSBGO2uv4xmUQLcI7kDgZU8wvHraA675Io3Yyu45bntqg/guTJ57Y/K1IIfK31qjf
 BiLFxvg9pw9dMADlKpGz0as1TGt4Z3ujEb5IBflyhOzIUzTCN1n/jz0WY5AbEyXSm1
 sdons3HOZZSHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] video: hpfb: Unregister DIO driver on init failure
To: "Haoxiang Li" <haoxiang_li2024@163.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260622064915.767194-1-haoxiang_li2024@163.com>
References: <20260622064915.767194-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 06:57:28 +0000
Message-Id: <20260622065728.B66AC1F000E9@smtp.kernel.org>
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
- [High] Module unloading fails to clean up the internal Topcat framebuffer=
, leading to a Use-After-Free.
- [High] Global static structures prevent supporting multiple Topcat device=
s, leading to state and data corruption.
--

commit 27805523b119df6cf717d257600582e127002d74
Author: Haoxiang Li <haoxiang_li2024@163.com>

video: hpfb: Unregister DIO driver on init failure

hpfb_init() registers the DIO driver via dio_register_driver().
If a later error occurs, the function returns directly without
unregistering the DIO driver. Unregister the DIO driver before
returning from these error paths.

> diff --git a/drivers/video/fbdev/hpfb.c b/drivers/video/fbdev/hpfb.c
> index a1144b1509826..1405712e5b4ff 100644
> --- a/drivers/video/fbdev/hpfb.c
> +++ b/drivers/video/fbdev/hpfb.c
> @@ -407,10 +407,13 @@ static int __init hpfb_init(void)
>  	err =3D copy_from_kernel_nofault(&i, (unsigned char *)INTFBVADDR + DIO_=
IDOFF, 1);
> =20
>  	if (!err && (i =3D=3D DIO_ID_FBUFFER) && topcat_sid_ok(sid =3D DIO_SECI=
D(INTFBVADDR))) {
> -		if (!request_mem_region(INTFBPADDR, DIO_DEVSIZE, "Internal Topcat"))
> +		if (!request_mem_region(INTFBPADDR, DIO_DEVSIZE, "Internal Topcat")) {
> +			dio_unregister_driver(&hpfb_driver);
>  			return -EBUSY;
> +		}
>  		printk(KERN_INFO "Internal Topcat found (secondary id %02x)\n", sid);
>  		if (hpfb_init_one(INTFBPADDR, INTFBVADDR)) {

[Severity: High]
This isn't a bug introduced by this patch, but since we are modifying the
initialization path, does hpfb_init_one() safely handle multiple Topcat
devices?

The driver uses statically allocated global variables (fb_info, fb_regs,
fb_bitmask) to manage device state, and lacks safeguards against multiple
device probes.

If a system contains multiple Topcat devices (e.g., an internal Topcat and
a DIO Topcat, or multiple DIO cards), hpfb_init_one() will execute multiple
times:

drivers/video/fbdev/hpfb.c:hpfb_init_one() {
	...
	fb_regs =3D virt_base;
	fboff =3D (in_8(fb_regs + HPFB_FBOMSB) << 8) | in_8(fb_regs + HPFB_FBOLSB);
	...
}

Subsequent calls will blindly overwrite the global fb_regs and call
register_framebuffer() again on the exact same fb_info pointer.

Could this corrupt the kernel's framebuffer linked lists and redirect all
subsequent I/O hardware operations for the first device into the second
device's registers?

> +			dio_unregister_driver(&hpfb_driver);
>  			return -ENOMEM;
>  		}
>  	}

[Severity: High]
This is a pre-existing issue, but related to the internal Topcat initialized
here, what cleans up the internal Topcat when the module is unloaded?

Looking at hpfb_cleanup_module():

drivers/video/fbdev/hpfb.c:hpfb_cleanup_module() {
	dio_unregister_driver(&hpfb_driver);
}

It unregisters the DIO driver but completely neglects the internal Topcat
which is initialized directly in hpfb_init(), bypassing the DIO driver core.
It fails to call unregister_framebuffer(), iounmap(), or fb_dealloc_cmap().

If the internal Topcat was initialized, its fb_info structure remains activ=
ely
registered in the kernel's framebuffer core after module unload. Because
fb_info is a statically allocated global variable within the module, unload=
ing
the module frees its memory.

Will any subsequent access to the framebuffer (e.g., via /dev/fb0 or sysfs)
dereference this freed memory and lead to a Use-After-Free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622064915.7671=
94-1-haoxiang_li2024@163.com?part=3D1
