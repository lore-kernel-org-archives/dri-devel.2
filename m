Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB96C44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 07:31:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42B5A10E2EF;
	Tue, 21 Jul 2026 07:31:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bnf3FRJM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F045C10E2EF
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 07:31:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BFECA40332;
 Tue, 21 Jul 2026 07:31:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A121F000E9;
 Tue, 21 Jul 2026 07:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784619069;
 bh=/Yne6L3SmwDoSSZsIZM4lzGxQIY7TvUySWoPkA/SvrI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bnf3FRJMO9FgNQjqEHWhffLmFk5dVhoms8DMVGYZt+x4OGvrpFXMnQ1yMc0NoDdEe
 6/ocq/IGVygGXPKw6+cMCLkSOrvdoZVy1EpSQ1Wc+TJM4eD/VmcK6pyg3YUgufNCCw
 OO1grVdGpvphbv5O+2aIqBE8uWqDs0BmwnhcO9Rdrr9eiLFlPVtLCs4tetgQ3+eFgV
 sTst1Sg9wc/IyenLJDh2xaMiJ1uxRJ1Zv94scmdBkdktXeane06C9tZqXaTwWBOemM
 bjEXPuCZr6SOYDVMv+GsGMHl7PnaA/LoDZ1MQSZ0sPixFbz6DpCHQwGwC69PN9XpWo
 XmQSa4LqfGw4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] fbdev: core: Clamp total_size to smem_len in
 read/write functions
To: "Mingyu Wang" <25181214217@stu.xidian.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260721071522.106306-1-25181214217@stu.xidian.edu.cn>
References: <20260721071522.106306-1-25181214217@stu.xidian.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 07:31:09 +0000
Message-Id: <20260721073109.81A121F000E9@smtp.kernel.org>
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
- [High] Partial copy to user space in `fb_io_read` causes silent skipping =
of framebuffer data and loop state desynchronization, leading to out-of-bou=
nds I/O reads.
- [High] Missing locking in fb_io and fb_sys operations allows concurrent m=
ode switches to cause Use-After-Free and Out-Of-Bounds accesses.
--

--- Patch [1]: [PATCH v2] fbdev: core: Clamp total_size to smem_len in read=
/write functions ---
commit 18031b5da874491bcb50306ae03282ff2763384b
Author: Mingyu Wang <25181214217@stu.xidian.edu.cn>

fbdev: core: Clamp total_size to smem_len in read/write functions

This patch clamps the total_size of framebuffers to info->fix.smem_len in r=
ead
and write functions when smem_len is non-zero. This aims to prevent
out-of-bounds accesses for legacy drivers that set screen_size larger than =
the
actual mapped framebuffer size. Virtual framebuffers remain unaffected.

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

[Severity: High]
This isn't a bug introduced by this patch, but can partial copies to user s=
pace
cause out-of-bounds I/O reads later in this function?

Looking at the copy loop further down in fb_io_read():

	while (count) {
		c  =3D (count > PAGE_SIZE) ? PAGE_SIZE : count;
		dst =3D buffer;
		fb_memcpy_fromio(dst, src, c);
		dst +=3D c;
		src +=3D c;

		trailing =3D copy_to_user(buf, buffer, c);
		if (trailing =3D=3D c) {
			err =3D -EFAULT;
			break;
		}
		c -=3D trailing;

		*ppos +=3D c;
		buf +=3D c;
		cnt +=3D c;
		count -=3D c;
	}

The src pointer is eagerly advanced by the full chunk size before the result
of copy_to_user() is known. If a partial copy occurs, trailing is greater
than 0 but less than c. The loop adjusts c -=3D trailing and count -=3D c, =
but
src is not rewound.

On the next iteration, does the read resume from an over-advanced src offse=
t?
Because count is only decremented by the successful bytes, the loop may
execute more iterations than originally bounded by total_size, potentially
causing fb_memcpy_fromio() to read beyond the end of the hardware-mapped
framebuffer.

[ ... ]

> diff --git a/drivers/video/fbdev/core/fb_sys_fops.c b/drivers/video/fbdev=
/core/fb_sys_fops.c
> index be96b3b3942ed..e97cf02f7c70f 100644
> --- a/drivers/video/fbdev/core/fb_sys_fops.c
> +++ b/drivers/video/fbdev/core/fb_sys_fops.c
> @@ -35,6 +35,14 @@ ssize_t fb_sys_read(struct fb_info *info, char __user =
*buf, size_t count,
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

[Severity: High]
This is a pre-existing issue, but does this function lack locking to prevent
concurrent mode switches from causing use-after-free or out-of-bounds
accesses?

Bounds checking is performed locklessly on total_size, and later
info->screen_buffer is accessed. If a concurrent user calls
ioctl(FBIOPUT_VSCREENINFO), which takes info->lock and invokes fb_set_var(),
could it free info->screen_buffer via vfree() and allocate a new one while
this read is in progress?

A concurrent read might then either dereference the freed screen_buffer, or
use the newly allocated smaller buffer with the previously fetched, larger
total_size.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721071522.1063=
06-1-25181214217@stu.xidian.edu.cn?part=3D1
