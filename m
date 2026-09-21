Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9DD1C982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:50:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E35710E550;
	Mon, 21 Sep 2026 13:50:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="g23cqlN+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13D9E10E550
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 13:50:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0BECE600C8;
 Mon, 21 Sep 2026 13:50:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828441F000FF;
 Mon, 21 Sep 2026 13:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789998606;
 bh=P4NUHOxH2aeSHDVJqGsUr0BE+Jo/nTG/+xG9c4sXpK4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=g23cqlN+Hi7G3gA8YRnTOEkP7rajyIhMMCWHCvPO7BQUBi/rwD0WDWhe0zMUDAbXt
 ymBGx93ULF0mwGXIg3IHEtfMb8idjBx6AXPuFBmaDCrx0+IzHRRKmUEK3vaZDJvlBg
 IVuOzR2rmicrXQd5elktRvvjTiwKZcavK+8EAd3u+f+43DUYvKHPx16mJkSpmVy4ut
 rlucug4ED5SiTFeWmmaIHx5Xx/INGv/pGsIr9bsT80OjEUn3sxNubKMvTM0wPTfT18
 /3fIs1NSN1w/RF91QoR8xxv1NPFu2me++ZaYbWhhb1tuI/8V3M7RgB9kDrZn3JEe/y
 ir9G2m+NywP5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/13] block: add dma-buf support for raw bdev
To: "Pavel Begunkov" <asml.silence@gmail.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <eafcbbf7e75e75e98d0791b843fae0f2423a4ecd.1789997898.git.asml.silence@gmail.com>
References: <cover.1789997898.git.asml.silence@gmail.com>
 <eafcbbf7e75e75e98d0791b843fae0f2423a4ecd.1789997898.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 13:50:06 +0000
Message-Id: <20260921135006.828441F000FF@smtp.kernel.org>
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
- [Medium] block: blkdev_read_iter() discards partial direct read success f=
or dma-bufs
- [Low] block: dmabuf error paths skip iov_iter_reexpand() teardown
--

commit 1ef88ba1be9691ca9af0098196766a3034d434e9
Author: Pavel Begunkov <asml.silence@gmail.com>

    block: add dma-buf support for raw bdev
   =20
    Add a simple proxy implementation of init_dma_buf_io_ctx() forwarding
    the call to a new struct block_device_operations operation. Also reject
    dma-buf backed iterators for buffered IO.

> diff --git a/block/fops.c b/block/fops.c
> index 641621db700f8..15fe5e39c68aa 100644
> --- a/block/fops.c
> +++ b/block/fops.c

[ ... ]

> @@ -783,7 +783,8 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, =
struct iov_iter *from)
> =20
>  	if (iocb->ki_flags & IOCB_DIRECT) {
>  		ret =3D blkdev_direct_write(iocb, from);
> -		if (ret >=3D 0 && iov_iter_count(from)) {
> +		if (ret >=3D 0 && iov_iter_count(from) &&
> +		    !iov_iter_is_dmabuf_map(from)) {
>  			ret =3D direct_write_fallback(iocb, from, ret,
>  					blkdev_buffered_write(iocb, from));
>  			need_sync =3D true;
> @@ -796,6 +797,9 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, =
struct iov_iter *from)
>  			need_sync =3D true;
>  		}
>  	} else {
> +		if (unlikely(iov_iter_is_dmabuf_map(from)))
> +			return -EOPNOTSUPP;
                        ^^^^^^^^^^^^^^^^^^

[Severity: Low]
At the start of blkdev_write_iter(), iov_iter_truncate() restricts the I/O
length and tracks the truncated amount in shorted. By returning directly he=
re,
does this bypass the iov_iter_reexpand() call at the end of the function,
leaving the iterator incorrectly truncated?

> +
>  		/*
>  		 * Take i_rwsem and invalidate_lock to avoid racing with
>  		 * set_blocksize changing i_blkbits/folio order and punching

[ ... ]

> @@ -851,6 +855,8 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, s=
truct iov_iter *to)
>  		if (ret < 0 || !count)
>  			goto reexpand;
>  	}
> +	if (unlikely(iov_iter_is_dmabuf_map(to)))
> +		return -EOPNOTSUPP;
                ^^^^^^^^^^^^^^^^^^

[Severity: Medium]
If a partial O_DIRECT read using a dma-buf iterator successfully reads data=
 and
advances ki_pos in the preceding direct I/O path, could this check
unconditionally return -EOPNOTSUPP? Does this overwrite the successful byte
count (ret > 0) with an error and hide the read data from userspace?

[Severity: Low]
Similar to blkdev_write_iter(), if this returns directly, does it bypass the
goto reexpand path, leaving the iterator incorrectly truncated if
iov_iter_truncate() was called earlier in blkdev_read_iter()?

> =20
>  	/*
>  	 * Take i_rwsem and invalidate_lock to avoid racing with set_blocksize

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789997898.gi=
t.asml.silence@gmail.com?part=3D5
