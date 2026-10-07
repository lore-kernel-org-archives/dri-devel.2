Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD10CA5FED
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 01:51:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F7C810E4DB;
	Wed,  7 Oct 2026 01:51:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LjlYmmVJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C291410E4DB
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 01:51:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F2F0F600C8;
 Wed,  7 Oct 2026 01:51:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73DD21F0089B;
 Wed,  7 Oct 2026 01:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791337882;
 bh=HPEE5uYrbRq2HrP/zmgzEgN/rvBoEHQafgiUnxdsRGI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LjlYmmVJ79Or4F8fz504Xge9P09D5isNJrWwPogywDxx/fYeHqEQw6eOGpEakg81c
 iC/73EF3UplrfkVZW8Qfc8SGxed00hQdDwNlJg2JsIA5IXeK2rBhJUfoCm3Ss6qfUv
 N/1+lNXXgVb+zIQXiegyxnc76MIuCzy8W3T3/QbRPE44Wq6QevuzlRXrQQAmy/IVyJ
 YRKDkokCTCiQe3DcK8aF8yiVeMVlcST9CDbVl9oaKquThbhUND5W1OY5I1Z0dSU90e
 ODr4MG+9stV2lTyk21yeb4J8SB/Er91sZUour+1EF0e8z3XDh3k2NaA6818GNrt09e
 XvBCx0aVtSgmw==
Message-ID: <sashiko-outbox-162571@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 10/13] io_uring/rsrc: extend buffer update
To: "Pavel Begunkov" <asml.silence@gmail.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <5c4d7c45c9bbf29b7b1b14a0ef1ef3bb12f903cf.1791336930.git.asml.silence@gmail.com>
References: <cover.1791336930.git.asml.silence@gmail.com>
 <5c4d7c45c9bbf29b7b1b14a0ef1ef3bb12f903cf.1791336930.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 01:51:21 +0000
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
- [Medium] io_uring: silent 32-bit truncation of __u64 uaddr and size in io=
_sqe_buffer_register
--

commit a910d9c1c59f845e8a642099135fc16862f3fe7d
Author: Pavel Begunkov <asml.silence@gmail.com>

io_uring/rsrc: extend buffer update

We need to pass more information to buffer registration than we can fit
into a single struct iovec. This patch allows users to optionally pass
struct io_uring_regbuf_desc, introducing an extended registration format
with a new flags field and types.

> diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
> index da767b34eb553..83a7ad9f5bc78 100644
> --- a/io_uring/rsrc.c
> +++ b/io_uring/rsrc.c

[ ... ]

> @@ -882,8 +894,13 @@ static struct io_rsrc_node *io_sqe_buffer_register(s=
truct io_ring_ctx *ctx,
>  	struct io_imu_folio_data data;
>  	bool coalesced =3D false;
> =20
> -	if (!uaddr) {
> -		if (size)
> +	if (desc->type >=3D __IO_REGBUF_TYPE_MAX)
> +		return ERR_PTR(-EINVAL);
> +	if (!mem_is_zero(&desc->__resv, sizeof(desc->__resv)) || desc->flags)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (desc->type =3D=3D IO_REGBUF_TYPE_EMPTY) {
> +		if (uaddr || size)

[Severity: Medium]
Does this code silently truncate 64-bit user input on 32-bit platforms?

The new struct io_uring_regbuf_desc defines uaddr and size as __u64:

struct io_uring_regbuf_desc {
...
	__u64 size;
	__u64 uaddr;
};

At the start of io_sqe_buffer_register(), these fields are immediately cast=
=20
to unsigned long and size_t:

static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
						   struct io_uring_regbuf_desc *desc)
{
	unsigned long uaddr =3D (unsigned long)desc->uaddr;
	size_t size =3D desc->size;

On 32-bit platforms, this drops the upper 32 bits before any validation
occurs.

If userspace passes 0x100000000 alongside IO_REGBUF_TYPE_EMPTY, the
truncated uaddr and size evaluate to 0.

Would this allow an invalid 64-bit address to pass the emptiness check
and incorrectly bypass the -EFAULT error path?

>  			return ERR_PTR(-EFAULT);
>  		/* remove the buffer without installing a new one */
>  		return NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791336930.gi=
t.asml.silence@gmail.com?part=3D10
