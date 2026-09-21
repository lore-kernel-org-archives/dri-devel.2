Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 414C2C982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:53:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42FD010E0C7;
	Mon, 21 Sep 2026 13:53:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OEAE+tHa";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF79C10E0C7
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 13:53:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DDADC600C8;
 Mon, 21 Sep 2026 13:53:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B591F000FF;
 Mon, 21 Sep 2026 13:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789998792;
 bh=FD/KVAs3j3UCY4l3pKDtYfQ0rDY2bI4dxQ+grUK7i+Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OEAE+tHaNmTAtNqbMKrIt5xps41+cXIkejdQey6Z7FyVSz9fuY6frjQXsBHqPcM5K
 xR7mAT7zEA5X7mgHmJSewx/WBjpfQlpoEDpUvjQ1fsMn5M4YQ+7kIaEy7f1anhTpQO
 ks34kiXCIjNqgWWviktLkoZkBYgyeo8RMNA8DsKTZ0xN3WLwXq2rQ4GQ4SaOJaa+KG
 V0yCVo6o54n0PzHNCAFpbpV/ZdjXbjZeHx/yOsKwxEFaZC/XoCpfHeVKKJp335nckI
 aCRegp1YwRkE668xP9kpBIk11+77YSeInHZO5OX+z7MgK2Oqw7HU6qB1vj81vSvfJW
 /m7FXW0ANq4kw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/13] io_uring/rsrc: add uncloneable regbuf flag
To: "Pavel Begunkov" <asml.silence@gmail.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <9b71636a03f2345bcc09127d77eb6b294a1d0938.1789997898.git.asml.silence@gmail.com>
References: <cover.1789997898.git.asml.silence@gmail.com>
 <9b71636a03f2345bcc09127d77eb6b294a1d0938.1789997898.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 13:53:11 +0000
Message-Id: <20260921135312.69B591F000FF@smtp.kernel.org>
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
- [Medium] io_uring: incorrect error code -ENOMEM for uncloneable buffers
--

commit 09226c4686b3c73a879519b5ef4315732d82b7f5
Author: Pavel Begunkov <asml.silence@gmail.com>

io_uring/rsrc: add uncloneable regbuf flag

It's hard to implement cloning if the internal structure needs to be
mutable and/or relies on other ring resources. In preparation to such
buffer types, add a flag indicating that the buffer can't be cloned.

> diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
> index 83a7ad9f5bc78..0b526b094dc9e 100644
> --- a/io_uring/rsrc.c
> +++ b/io_uring/rsrc.c
> @@ -1434,6 +1434,11 @@ static int io_clone_buffers(struct io_ring_ctx *ct=
x, struct io_ring_ctx *src_ctx
>  		if (!src_node) {
>  			dst_node =3D NULL;
>  		} else {
> +			if (src_node->buf->flags & IO_REGBUF_F_UNCLONEABLE) {
> +				io_rsrc_data_free(ctx, &data);
> +				return -ENOMEM;

[Severity: Medium]
Is -ENOMEM the correct error code to return from io_clone_buffers() for this
case? Returning -ENOMEM for an unsupported operation (cloning an explicitly
uncloneable buffer) might be misleading, as it usually signifies a transient
out-of-memory condition.

If a user registers an uncloneable buffer and subsequently attempts to clone
the buffer table via the IORING_REGISTER_CLONE_BUFFERS operation, robust
userspace applications encountering -ENOMEM might enter a back-off and retry
loop. This could potentially lead to infinite stalls rather than aborting t=
he
unsupported operation. Would an error code like -EOPNOTSUPP or -EINVAL be
more appropriate to indicate that the buffer type simply doesn't support
cloning?

> +			}
> +
>  			dst_node =3D io_rsrc_node_alloc(ctx, IORING_RSRC_BUFFER);
>  			if (!dst_node) {
>  				io_rsrc_data_free(ctx, &data);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789997898.gi=
t.asml.silence@gmail.com?part=3D11
