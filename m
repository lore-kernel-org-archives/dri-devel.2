Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81273CA6007
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 01:43:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB3F410F439;
	Wed,  7 Oct 2026 01:43:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R7VmuL1t";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DACFA10F13C
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 01:43:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BB70D601FA;
 Wed,  7 Oct 2026 01:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550E31F0089F;
 Wed,  7 Oct 2026 01:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791337392;
 bh=zCpT1oYSWOGuEbUgEmNgVp+mzKCkjhi/fOh4r09QWYI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=R7VmuL1tSwpT9+MYznMfYh1EjR/qCMFjnEyU08SkmFfwZQbfR5lSF4zysCGAErc+t
 ADWao41RbKX+5w3BBr+vZhhvM5TA8kpiaxP27FLfTLuoDylYdm/Slv3q/o845GnQnO
 IDxzmh53sa2qy01AsRXPW+daBEms+plS/Y20/RvS+f9xh0M70dqoHfa5YgAkrIqfOT
 PGk/K+6C2+B9n8p16HImAPoLVYzn/PTjOtMNRzziQzpE4/H9K7EPJWWiode0ZHfdDT
 281tMZ17eGXyUMRp9eLbXTggA7nMqCzJcss5i8aE4CRheUknD1unT9dASvdEtLpERi
 4zAKMbdT5e3QQ==
Message-ID: <sashiko-outbox-162564@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 03/13] block: add dma-buf support for raw bdev
To: "Pavel Begunkov" <asml.silence@gmail.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <af2b48a490186edf38f1d4a5dfd9513574f7a350.1791336002.git.asml.silence@gmail.com>
References: <cover.1791336002.git.asml.silence@gmail.com>
 <af2b48a490186edf38f1d4a5dfd9513574f7a350.1791336002.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 01:43:11 +0000
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
- [Low] vfs: build failure due to missing init_dma_buf_io_ctx and iov_iter_=
is_dmabuf_map definitions
--

commit d99a726724959c24584b1b7d60b6cbfd1f565d00
Author: Pavel Begunkov <asml.silence@gmail.com>

block: add dma-buf support for raw bdev

This commit adds a proxy implementation of init_dma_buf_io_ctx() that forwa=
rds
the call to a new block_device_operations operation. It also rejects dma-buf
backed iterators for buffered IO.

> diff --git a/block/fops.c b/block/fops.c
> index 40a8ceeec1940..79aee87c66010 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -731,6 +731,9 @@ blkdev_direct_write(struct kiocb *iocb, struct iov_it=
er *from)
> =20
>  static ssize_t blkdev_buffered_write(struct kiocb *iocb, struct iov_iter=
 *from)
>  {
> +	if (unlikely(iov_iter_is_dmabuf_map(from)))

[Severity: Low]
Is this regression caused by a missing prerequisite patch? The function
iov_iter_is_dmabuf_map() appears to be undeclared in the kernel headers,
which results in an implicit declaration error during the build.

> +		return -EOPNOTSUPP;
> +
>  	return iomap_file_buffered_write(iocb, from, &blkdev_iomap_ops, NULL,
>  			NULL);
>  }

[ ... ]

> @@ -977,6 +998,7 @@ const struct file_operations def_blk_fops =3D {
>  	.fallocate	=3D blkdev_fallocate,
>  	.uring_cmd	=3D blkdev_uring_cmd,
>  	.fop_flags	=3D FOP_BUFFER_RASYNC | FOP_DONTCACHE,
> +	.init_dma_buf_io_ctx =3D blkdev_init_dma_buf_io_ctx,

[Severity: Low]
Does struct file_operations include init_dma_buf_io_ctx in this tree? It
seems this member does not exist, which causes a build regression due to
the initialization of a non-existent member.

>  };
> =20
>  static __init int blkdev_init(void)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791336002.gi=
t.asml.silence@gmail.com?part=3D3
