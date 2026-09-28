Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 181EBC9833F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:46:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75E1510E0DF;
	Mon, 28 Sep 2026 13:46:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OEAq6jCL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3678010E0DF
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 13:46:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 37B8360052;
 Mon, 28 Sep 2026 13:46:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66EA1F000FF;
 Mon, 28 Sep 2026 13:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790603200;
 bh=RNZuyGk+2KZ2VRL9+55x1dX3R2OQLZmWvnf8Hxb3C20=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OEAq6jCLlWwD1OO3v9aNui1rBKnj5luT5M5QRvQ0xtGjLIuPtfQW3b5Oli4mCkA8G
 V02IYI5RdC9JjzfoxPAbDwErlKsHk8MuaztIYl2IdnCZ7WI+ITHyG+9CeRMWeGqF+i
 t702HEr5MkLJNZoXpoYSghQXWsoCFTE1zzNMFkxL+PEy2QWkgTUF3p4MJMbcZ65j7Z
 bfNfUFHIdQwIwjhS1DTowtdczx8eZ5POlM8Yzt6KU9mcwUsqrPF7zMvCAQcOounxdn
 WmFWESbOKgXG54eacZRIwiwwV8pv4Ya+7NpPchBQxh8P+ah62EPKPqFSBfEVrOeRts
 BPzZS+sq1Lz5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/13] block: add dma-buf support for raw bdev
To: "Pavel Begunkov" <asml.silence@gmail.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <a6b81e65b1f09b6ed1f71f294e5a94896ea1ead7.1790602223.git.asml.silence@gmail.com>
References: <cover.1790602223.git.asml.silence@gmail.com>
 <a6b81e65b1f09b6ed1f71f294e5a94896ea1ead7.1790602223.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 13:46:40 +0000
Message-Id: <20260928134640.C66EA1F000FF@smtp.kernel.org>
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
- [Medium] block: blkdev_write_iter swallows -EBUSY and returns 0 for dmabu=
f direct writes
--

commit afbe81886595b7f9b2e6456a34c387448997c06f
Author: Pavel Begunkov <asml.silence@gmail.com>

block: add dma-buf support for raw bdev

Add a simple proxy implementation of init_dma_buf_io_ctx() forwarding
the call to a new struct block_device_operations operation. Also reject
dma-buf backed iterators for buffered IO.

> diff --git a/block/fops.c b/block/fops.c
> index 40a8ceeec1940..0e5536f05899d 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -788,7 +788,8 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, =
struct iov_iter *from)
> =20
>  	if (iocb->ki_flags & IOCB_DIRECT) {
>  		ret =3D blkdev_direct_write(iocb, from);
> -		if (ret >=3D 0 && iov_iter_count(from)) {
> +		if (ret >=3D 0 && iov_iter_count(from) &&
> +		    !iov_iter_is_dmabuf_map(from)) {

[Severity: Medium]
Could skipping this fallback result in returning a false 0 to userspace
instead of an error code?

If a dmabuf direct write is submitted via io_uring to a block device region
where page cache invalidation fails (e.g., due to an elevated refcount from
mmap), blkdev_direct_write() intentionally translates -EBUSY to a 0 return
value to trigger a fallback to buffered I/O:

block/fops.c:blkdev_direct_write() {
	...
	written =3D kiocb_invalidate_pages(iocb, count);
	if (written) {
		if (written =3D=3D -EBUSY)
			return 0;
		return written;
	}
	...
}

Since the !iov_iter_is_dmabuf_map(from) check skips the
direct_write_fallback() path, ret remains 0. Would this cause userspace to
incorrectly receive 0 (indicating EOF or no bytes written) instead of an
error code like -EOPNOTSUPP or -EBUSY? Applications that retry on 0-byte
writes might enter an infinite retry loop.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790602223.gi=
t.asml.silence@gmail.com?part=3D5
