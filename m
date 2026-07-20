Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985B3C4452A
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 14:16:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C570710E198;
	Mon, 20 Jul 2026 14:16:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WegsdEQD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF10010E198
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 14:15:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 46D4A429DB;
 Mon, 20 Jul 2026 14:15:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0912D1F00A3A;
 Mon, 20 Jul 2026 14:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784556959;
 bh=yJqUjZWhDoS4+1CK8rmP72NiO+UPfeeckHFKrFh57nA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WegsdEQDU0k6p2/LEru2zXSfD3tX4mLoxz9JpdaylJoI0yBbk8cFplP9xfk+f3P91
 lkzeaLfl0KCZipfWkUurCIaOjusENTB6xbRHcv2RNVwmhyCQG100Y+DRfXXz5anGIg
 jhM/OMHEO2ZuxvitwVr1vkO48uSBt8UlW8SecnGix7/dHzVE2ln8jdJssjT7WtbOh+
 NWOwtCr3leuC4Gsra67wfMrmNu5ORjL0+YcbRw53oLE5OCFAYZ686uBia0+07AGpmq
 LoRQLGnUEVcaX1Z5gyDQjY+fsaCmP/njAvb73/WneNUrn7mTKQU8TqcT/3PHcZgLPc
 D4B8wUHZqWc2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fbdev: core: Clamp total_size to smem_len in
 fb_io_read/write
To: "Mingyu Wang" <25181214217@stu.xidian.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260720135534.103599-1-25181214217@stu.xidian.edu.cn>
References: <20260720135534.103599-1-25181214217@stu.xidian.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 14:15:58 +0000
Message-Id: <20260720141559.0912D1F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Incomplete Fix: Missing `total_size` clamp in `fb_sys_read` an=
d `fb_sys_write` allows Out-Of-Bounds kernel memory access.
- [High] Missing Locking in `fb_io_read` and `fb_io_write` leads to Use-Aft=
er-Free during concurrent mode switches.
- [High] Out-of-bounds IO Memory Read in `fb_io_read` caused by partial `co=
py_to_user` failure.
--

--- Patch [1]: [PATCH] fbdev: core: Clamp total_size to smem_len in fb_io_r=
ead/write ---
commit 34ebcfca778c16b156ef4c2fa6a81b75c5b5adb4
Author: Mingyu Wang <25181214217@stu.xidian.edu.cn>

fbdev: core: Clamp total_size to smem_len in fb_io_read/write

This patch prevents out-of-bounds I/O accesses in fb_io_read() and
fb_io_write() by clamping total_size to smem_len during mode switches
when legacy drivers incorrectly set screen_size. Virtual framebuffers
remain unaffected.

> diff --git a/drivers/video/fbdev/core/fb_io_fops.c b/drivers/video/fbdev/=
core/fb_io_fops.c
> index 6ab60fcd00501..335f16d2cc23b 100644
> --- a/drivers/video/fbdev/core/fb_io_fops.c
> +++ b/drivers/video/fbdev/core/fb_io_fops.c
> @@ -24,6 +24,14 @@ ssize_t fb_io_read(struct fb_info *info, char __user *=
buf, size_t count, loff_t
>  	if (total_size =3D=3D 0)
>  		total_size =3D info->fix.smem_len;
> =20
> +	/*
> +	 * Security Hardening: Defend against buggy legacy drivers that may
> +	 * calculate a malformed screen_size. Clamp total_size to the actual
> +	 * hardware mapped memory limit (smem_len) to prevent OOB access.
> +	 */
> +	if (info->fix.smem_len && total_size > info->fix.smem_len)
> +		total_size =3D info->fix.smem_len;
> +

[Severity: Critical]
This is a pre-existing issue, but I noticed that fb_sys_read() and=20
fb_sys_write() in drivers/video/fbdev/core/fb_sys_fops.c have the exact=20
same trust boundary issue with info->screen_size.

Because those sys functions access kernel system memory rather than I/O=20
memory, an oversized screen_size without this clamp could allow userspace=20
to perform out-of-bounds reads and writes directly to system RAM. Should=20
this fix be applied to fb_sys_read() and fb_sys_write() as well to prevent=
=20
kernel memory corruption?

[ ... ]
> 	if (info->fbops->fb_sync)
> 		info->fbops->fb_sync(info);
>=20
> 	while (count) {
> 		c  =3D (count > PAGE_SIZE) ? PAGE_SIZE : count;
> 		dst =3D buffer;
> 		fb_memcpy_fromio(dst, src, c);

[Severity: High]
This is a pre-existing issue, but is it safe to access src (which is derive=
d=20
from info->screen_base) without holding info->lock during this loop?=20

If another thread concurrently issues an ioctl(FBIOPUT_VSCREENINFO) to swit=
ch=20
modes, and the driver's fb_set_par() implementation unmaps or frees=20
screen_base, could this lockless memory access in fb_io_read() and=20
fb_io_write() result in a use-after-free or out-of-bounds crash?

> 		dst +=3D c;
> 		src +=3D c;
>=20
> 		trailing =3D copy_to_user(buf, buffer, c);
> 		if (trailing =3D=3D c) {
> 			err =3D -EFAULT;
> 			break;
> 		}
> 		c -=3D trailing;

[Severity: High]
This is also a pre-existing issue, but what happens to the src pointer if=20
copy_to_user() partially fails?

If copy_to_user() returns a trailing value between 0 and c, the loop does n=
ot=20
break, and c is reduced by trailing. However, the src pointer was already=20
unconditionally advanced by the original unreduced c.=20

In the next loop iteration, src will be misaligned and advanced further tha=
n=20
accounted for by count. Could this cause subsequent fb_memcpy_fromio() call=
s=20
to read past the end of the hardware framebuffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720135534.1035=
99-1-25181214217@stu.xidian.edu.cn?part=3D1
