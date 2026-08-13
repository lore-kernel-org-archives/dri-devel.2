Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E6D4C5CFEB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 13:02:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E663B10F317;
	Thu, 13 Aug 2026 13:02:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LCbpI8N1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44DF410F323
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 13:02:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 15BFC4031D;
 Thu, 13 Aug 2026 13:02:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F8E1F000E9;
 Thu, 13 Aug 2026 13:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786626128;
 bh=QiQv54C+CIjPDI2+lGeoSzjqq5XH3knJHomkwwfLZ54=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LCbpI8N1J/lVkTQaAtPOJvHn5mT+k/ukQfdIcJAAweY9lGRXgHl/Vd7Kitp4xbPFp
 5EMJfZZBsO8yp71LSa+aRoXKtU8ZU7cAOwwGT6bmm1Sks6Dw5RtMETcUJMnBDWraih
 WAB3u4fMYiicZz/QNDbACfo7XsZlMyylDRGwNYm89SxvQeqLUwfc6vbAdQcZ6iK0VQ
 vbHUTWBxlv58k9NI1WWFfL+6bWJin1Ap+kEucrtAHHShE7xxmr5NJvmGIN6wE39S/x
 /lH9HYR7bP7WJ/DMoLGeyi69yVgAg4JNlgeDv3oVnsgk/QyE9epdK/Kwp92ZP44e64
 fbrD5ab8jDIzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] fbdev: matrox: Convert to managed PCI and ioremap API
To: oushixiong1025@163.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260813125015.1097301-4-oushixiong1025@163.com>
References: <20260813125015.1097301-1-oushixiong1025@163.com>
 <20260813125015.1097301-4-oushixiong1025@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 13:02:07 +0000
Message-Id: <20260813130207.C1F8E1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Crash/UAF due to premature devres cleanup during deferred driver t=
eardown.
--

--- Patch [4]: [PATCH 4/5] fbdev: matrox: Convert to managed PCI and iorema=
p API ---
commit 3f4d09fdf1478a2c901bd635a21ab3e200899c5a
Author: Shixiong Ou <oushixiong@kylinos.cn>

fbdev: matrox: Convert to managed PCI and ioremap API

This commit converts the matroxfb driver to use managed device resource
APIs such as pcim_enable_device, devm_request_mem_region, and devm_ioremap.
It removes the manual release_mem_region and iounmap calls from the remove
path and error handling.

> diff --git a/drivers/video/fbdev/matrox/matroxfb_base.c b/drivers/video/f=
bdev/matrox/matroxfb_base.c
> index ac04a19b68492..24d312c29fb64 100644
> --- a/drivers/video/fbdev/matrox/matroxfb_base.c
> +++ b/drivers/video/fbdev/matrox/matroxfb_base.c
> @@ -374,10 +374,6 @@ static void matroxfb_remove(struct matrox_fb_info *m=
info, int dummy)
>  	unregister_framebuffer(&minfo->fbcon);
>  	matroxfb_g450_shutdown(minfo);
>  	arch_phys_wc_del(minfo->wc_cookie);
> -	iounmap(minfo->mmio.vbase.vaddr);
> -	iounmap(minfo->video.vbase.vaddr);
> -	release_mem_region(minfo->video.base, minfo->video.len_maximum);
> -	release_mem_region(minfo->mmio.base, 16384);
>  	kfree(minfo);
>  }

[Severity: High]
Will this cause a crash if the device is removed while still in use?

Looking earlier in matroxfb_remove(), there is an early return that defers
cleanup if the device is busy:

static void matroxfb_remove(struct matrox_fb_info *minfo, int dummy)
{
	...
	minfo->dead =3D 1;
	if (minfo->usecount) {
		/* destroy it later */
		return;
	}
	...
}

By converting the allocations to the devm_ and pcim_ APIs, the resources
like the MMIO mappings and the PCI enable state will be automatically freed
as soon as matroxfb_remove() returns to the driver core.

If minfo->usecount is non-zero, won't this unmap and disable the device
while userspace or other subsystems are still actively interacting with the
framebuffer, leading to a memory fault?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813125015.1097=
301-1-oushixiong1025@163.com?part=3D4
