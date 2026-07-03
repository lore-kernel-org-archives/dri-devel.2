Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDF5C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 08:17:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0340010F6D1;
	Fri,  3 Jul 2026 08:17:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nRcnqmR7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0353310F6D1
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 08:17:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8D80440420;
 Fri,  3 Jul 2026 08:17:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACE11F00A3A;
 Fri,  3 Jul 2026 08:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783066675;
 bh=1GUCaoRVPAvYoEwrsE4i3EgcHPyF115aiOuBpy22NSE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nRcnqmR7hvF1k+k5BoglQtmuhodpQWDxtKZl1ELbRUNeYTfqInH8sNVgx4g4ubLIm
 CbrdqN7KanHa4RG11yqSPy8E7HSvVQcxofdpEPjT0zsH+jrmFtsiBonqy9TuhrWg3G
 VJkabBmljp8EznjKjxR4FKNMu3CrKdE00UDrWy1Hug8y5+fBtpz52CLoUXRr5JG0jC
 BNnvSHebUneN0qpZSR8q8HbIMm2VIDFpkc9aTz8x4mJWsqX398quidNpmGm1Bz8OQM
 5WTBn9Lxpl0KnSKqVK/44bMpn18dn+2VlGxBg4WhdhlhYRF/3Sl8SvWfl+kLKK5Es/
 D1fbzUNR9knkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dma-buf: dma-heap: close installed fd when
 copy_to_user() fails
To: "Baineng Shou" <shoubaineng@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260703080922.1838362-1-shoubaineng@gmail.com>
References: <20260703080922.1838362-1-shoubaineng@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 08:17:54 +0000
Message-Id: <20260703081755.5ACE11F00A3A@smtp.kernel.org>
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
- [High] Calling close_fd() on an installed file descriptor creates a race =
condition that can inadvertently close an unrelated file descriptor belongi=
ng to the process.
--

commit 61669c0c051aa2c310121591ca8897cc10b33840
Author: Baineng Shou <shoubaineng@gmail.com>

dma-buf: dma-heap: close installed fd when copy_to_user() fails

This patch attempts to fix a file descriptor leak when copy_to_user()
fails after allocating a DMA heap buffer. It tries to clean up the
leaked file descriptor by calling close_fd() if the copy to userspace
is unsuccessful.

> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> index a76bf3f8b071a..0dd7a84b06bf4 100644
> --- a/drivers/dma-buf/dma-heap.c
> +++ b/drivers/dma-buf/dma-heap.c
[ ... ]
> @@ -181,8 +182,16 @@ static long dma_heap_ioctl(struct file *file, unsign=
ed int ucmd,
>  		goto err;
>  	}
> =20
> -	if (copy_to_user((void __user *)arg, kdata, out_size) !=3D 0)
> +	if (copy_to_user((void __user *)arg, kdata, out_size) !=3D 0) {
> +		if (kcmd =3D=3D DMA_HEAP_IOCTL_ALLOC && ret =3D=3D 0) {
> +			struct dma_heap_allocation_data *h =3D (void *)kdata;
> +
> +			close_fd(h->fd);

[Severity: High]
Does calling close_fd() on an installed file descriptor create a race
condition here in dma_heap_ioctl()?

By the time the execution reaches this error path, the file descriptor
has already been published to the process's file descriptor table via
fd_install() inside dma_heap_ioctl_allocate(). This means userspace
can already access it.

A concurrent thread could close the newly allocated file descriptor and
open a new file, reusing the same file descriptor number before the
copy_to_user() completes and fails.

If that happens, wouldn't this close_fd() inadvertently close an unrelated
file descriptor belonging to the process?

> +			h->fd =3D -1;
> +		}
>  		ret =3D -EFAULT;
> +	}
> +
>  err:
>  	if (kdata !=3D stack_kdata)
>  		kfree(kdata);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703080922.1838=
362-1-shoubaineng@gmail.com?part=3D1
