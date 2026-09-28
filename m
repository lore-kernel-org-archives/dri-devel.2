Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9371CC9833F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:49:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA90D10EA89;
	Mon, 28 Sep 2026 13:49:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MOL12LoW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E22C310EA89
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 13:49:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C6DA042E45;
 Mon, 28 Sep 2026 13:49:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74FB61F000FF;
 Mon, 28 Sep 2026 13:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790603392;
 bh=8JWR4sywE4y7qJ2RXRRDIcrT/PT8u5sy0uD7eF6wIm4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MOL12LoW7byV2SEkLDOe1Xc8U8LIxjivIPXA4ozyuOhygBgEYA7vA/Op0xZAypF9m
 ll+U6eqt082EPx/t4mg4OTQjdxmj+8h+TfKzV+B5r1+0tPtAEyM9kwKWFLqRd4+LAl
 PS+xEQprhk+FvJx/G2TFgVEvg2UJxzJP6bqBCvQuIifdsB9UVoc1lrTCqXc+OQpkgM
 FDEYF4sO/ZqGmKfCW3j8drBWRmkjg5jIyXUwoz+J3HPyt1T/QZgUtpQ9KCrg3QtRLr
 y7qbm6srXfP29lpdkNC7pSNVgn4OvWMaiMW2upyGgtUchV4Px5wss2q6eS0u08Rg5d
 +mrucdCCsH2jw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/13] iov_iter: add iterator type for dmabuf maps
To: "Pavel Begunkov" <asml.silence@gmail.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <74a9d65f5c4f9acce5f57ad5921a9fadc6eda712.1790602223.git.asml.silence@gmail.com>
References: <cover.1790602223.git.asml.silence@gmail.com>
 <74a9d65f5c4f9acce5f57ad5921a9fadc6eda712.1790602223.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 13:49:51 +0000
Message-Id: <20260928134952.74FB61F000FF@smtp.kernel.org>
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
- [High] iov_iter: silent data discard for ITER_DMABUF_MAP in iterate_and_a=
dvance_kernel
- [Medium] iov_iter: iov_iter_revert() fails to prevent ITER_DMABUF_MAP fro=
m reverting past start
--

commit 592c6072da9af2f29c973e9a7808406da6345041
Author: Pavel Begunkov <asml.silence@gmail.com>
iov_iter: add iterator type for dmabuf maps

Introduce a new iterator type for dmabuf maps. The map in an opaque
object with internals and format specific to the subsystem / driver, and
only it can use that subsystem / driver for issuing IO.

> diff --git a/include/linux/iov_iter.h b/include/linux/iov_iter.h
> index f9a17fbbd3980..2f91884d733bf 100644
> --- a/include/linux/iov_iter.h
> +++ b/include/linux/iov_iter.h
> @@ -310,6 +310,8 @@ size_t iterate_and_advance2(struct iov_iter *iter, si=
ze_t len, void *priv,
>  		return iterate_folioq(iter, len, priv, priv2, step);
>  	if (iov_iter_is_xarray(iter))
>  		return iterate_xarray(iter, len, priv, priv2, step);
> +	if (WARN_ON_ONCE(iov_iter_is_dmabuf_map(iter)))
> +		return 0;
>  	return iterate_discard(iter, len, priv, priv2, step);
>  }

[Severity: High]
This safely rejects ITER_DMABUF_MAP by returning 0, but is there a missing
guard in iterate_and_advance_kernel() which is defined later in this file?

If a kernel subsystem uses iterate_and_advance_kernel() on an
ITER_DMABUF_MAP, it will unconditionally fall through to iterate_discard():

	if (iov_iter_is_xarray(iter))
		return iterate_xarray(iter, len, priv, priv2, step);
	return iterate_discard(iter, len, priv, priv2, step);

iterate_discard() decrements count and returns the requested len, falsely
indicating that the data was successfully processed without actually calling
the step function.

Can this lead to silent data discard or corruption (such as hashing missing
data) without any warning or error propagation?

> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 2072c04e99d05..6831a5d9396e1 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c

[ ... ]

> @@ -631,7 +632,8 @@ void iov_iter_revert(struct iov_iter *i, size_t unrol=
l)
>  		return;
>  	}
>  	unroll -=3D i->iov_offset;
> -	if (iov_iter_is_xarray(i) || iter_is_ubuf(i)) {
> +	if (iov_iter_is_xarray(i) || iter_is_ubuf(i) ||
> +	    iov_iter_is_dmabuf_map(i)) {
>  		BUG(); /* We should never go beyond the start of the specified
>  			* range since we might then be straying into pages that
>  			* aren't pinned.

[Severity: Medium]
Does this safely prevent ITER_DMABUF_MAP from reverting past its start?

iov_iter_dmabuf_map() initializes i->iov_offset to the absolute offset (off)
rather than 0.

Earlier in iov_iter_revert(), the boundary check compares the revert amount
against this absolute offset rather than the amount advanced:

	if (unroll <=3D i->iov_offset) {
		i->iov_offset -=3D unroll;
		return;
	}

Because of this early return, the revert can rewind the iterator by up to
off + advanced bytes without triggering the BUG() safeguard shown in this
hunk.

Can this allow a caller to silently rewind the iterator to an out-of-bounds
offset before the mapped range?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790602223.gi=
t.asml.silence@gmail.com?part=3D2
