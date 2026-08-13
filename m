Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904C1C5CFEB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 12:57:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E208310E1C4;
	Thu, 13 Aug 2026 12:57:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dx0Kn/HI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E29D10E1C4
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 12:57:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B1C6B439AF;
 Thu, 13 Aug 2026 12:57:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A0A21F000E9;
 Thu, 13 Aug 2026 12:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786625865;
 bh=13P+MIVoJpPP/g+bE9IBr2XwkZKSxe+YiW6woZbB8pE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dx0Kn/HIg9WD5Zj8AAWW+1KxElX02JZ8ZeYqE4UZIQKTUtRd7aiuAk7KZoATjSOW+
 I5B5FaOEAgclv9FsT27O7uNuQiQsTuxISllbS2U2jGQrjE/NZxHDDRBC9GuKc3dAM0
 dbFTMWe0Moo3Y3SqsRotBit4cEOO3JGCL8mou9pGFpvQ80wS1c8QfLI9YhDvVz8hWM
 ggWqrdiC2z7zs5lJW3Hgkl9Y4uW2HVEFOeHcADV5nIf0JLMdAAftqBeowVLPgI2JQI
 bwLYUrMZRwvPasTMvGgjR7TYmzyV25ixTEuBg6eXfTer8E7pEWDv0Q1Tj851zXzChs
 3xLT6WKFy7uKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] fbdev: aty128fb: Convert to managed PCI and ioremap
 API
To: oushixiong1025@163.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260813125015.1097301-1-oushixiong1025@163.com>
References: <20260813125015.1097301-1-oushixiong1025@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 12:57:44 +0000
Message-Id: <20260813125745.6A0A21F000E9@smtp.kernel.org>
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
- [High] Incorrect check of pcim_request_region() return value treats succe=
ss as failure.
- [High] The error path for a failed MMIO region request jumps to a cleanup=
 label that calls `framebuffer_release()` with an uninitialized `info` poin=
ter.
--

--- Patch [1]: [PATCH 1/5] fbdev: aty128fb: Convert to managed PCI and iore=
map API ---
commit 1e12b2171d8c5fcb82cbff1de0aa1745b4062be0
Author: Shixiong Ou <oushixiong@kylinos.cn>

fbdev: aty128fb: Convert to managed PCI and ioremap API

Fix missing pci_disable_device() in probe and remove.
Use pcim_enable_device(), pcim_request_region(), devm_ioremap()
and devm_ioremap_wc() to replace manual resource management.

> diff --git a/drivers/video/fbdev/aty/aty128fb.c b/drivers/video/fbdev/aty=
/aty128fb.c
> index bcb10e66221c8..b76bfe014f41b 100644
> --- a/drivers/video/fbdev/aty/aty128fb.c
> +++ b/drivers/video/fbdev/aty/aty128fb.c

[ ... ]

>  	fb_addr =3D pci_resource_start(pdev, 0);
> -	if (!request_mem_region(fb_addr, pci_resource_len(pdev, 0),
> -				"aty128fb FB")) {
> +	if (!pcim_request_region(pdev, 0, "aty128fb FB")) {

[Severity: High]
Since pcim_request_region() returns 0 on success and a negative error code
on failure, does checking it with '!' cause the driver to fail probe when
the region is actually successfully requested?

>  		printk(KERN_ERR "aty128fb: cannot reserve frame "
>  				"buffer memory\n");
>  		return -ENODEV;
>  	}
> =20
>  	reg_addr =3D pci_resource_start(pdev, 2);
> -	if (!request_mem_region(reg_addr, pci_resource_len(pdev, 2),
> -				"aty128fb MMIO")) {
> +	if (!pcim_request_region(pdev, 2, "aty128fb MMIO")) {

[Severity: High]
Does this have the same pcim_request_region() return value check issue as
the previous block?

>  		printk(KERN_ERR "aty128fb: cannot reserve MMIO region\n");
> -		goto err_free_fb;
> +		goto err_free_info;
>  	}
> =20
>  	/* We have the resources. Now virtualize them */
>  	info =3D framebuffer_alloc(sizeof(struct aty128fb_par), &pdev->dev);

[Severity: High]
If the above goto is taken, the code jumps to err_free_info which calls
framebuffer_release(info). Since info hasn't been allocated or initialized
yet at that point, will this dereference an uninitialized pointer during
the cleanup path?

[ ... ]

> err_free_info:
>  	framebuffer_release(info);
> -err_free_mmio:
> -	release_mem_region(pci_resource_start(pdev, 2),
> -			pci_resource_len(pdev, 2));
> -err_free_fb:
> -	release_mem_region(pci_resource_start(pdev, 0),
> -			pci_resource_len(pdev, 0));
>  	return -ENODEV;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813125015.1097=
301-1-oushixiong1025@163.com?part=3D1
