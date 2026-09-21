Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D778AC982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:53:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0256E10E0FA;
	Mon, 21 Sep 2026 13:53:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z3oBWU0m";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA6B010E0FA
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 13:53:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7803842B21;
 Mon, 21 Sep 2026 13:53:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241751F000FF;
 Mon, 21 Sep 2026 13:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789998818;
 bh=A46samLKn7Y4Jz5xvGCfhSHW6/nW71hZ3Dh12bv4sUI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Z3oBWU0mzSjVN5mhlnlIjlluEZlg295Y8eh+BJuJ+ILYo8DGgAeS0IsdAAK0KJgPh
 8SI33k++C+VzYZR5pSNukbruHDsT1Y1eH1wkSm8elgSoxN4ftOovcTub04retaAYLt
 r7tqUb6ReifQ5sNpKxqT9BpIGbJCm5ty4F5zYJu4zvOMlZEnlhb+fYLgTqIhPF1GxX
 QGq60jMS/5eM7kFdeut2E5/NjQQtKgQRvrf/nyOAFf+CC6KJt/CFAA/G/hGq3EDyYH
 WtM29Fh4glv9wqYDiiGEJ8J/FZGSaEvwuetMfe4+GIufDt0/iz0TC+/mquMqKi5B8E
 OuUMTZieVIFCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/13] iov_iter: add iterator type for dmabuf maps
To: "Pavel Begunkov" <asml.silence@gmail.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <6b78003332b57ec3a4552d7393464636793aff76.1789997898.git.asml.silence@gmail.com>
References: <cover.1789997898.git.asml.silence@gmail.com>
 <6b78003332b57ec3a4552d7393464636793aff76.1789997898.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 13:53:37 +0000
Message-Id: <20260921135338.241751F000FF@smtp.kernel.org>
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
- [Medium] iov_iter: silent fallback to iterate_discard() for dmabuf maps
- [Medium] iov_iter: bounds check bypass in iov_iter_revert() for dmabuf ma=
ps
--

commit 8e47b333dea94c1451175bac8e284adfbbf175cc
Author: Pavel Begunkov <asml.silence@gmail.com>
Subject: iov_iter: add iterator type for dmabuf maps

Introduce a new ITER_DMABUF_MAP iterator type for dmabuf maps. The patch=20
adds the new iterator type, updates struct iov_iter to hold dmabuf maps,=20
and wires up basic iterator operations like advance, revert, and alignment.

> diff --git a/include/linux/uio.h b/include/linux/uio.h
> index fe2e985d74d24..638c1116e912e 100644
> --- a/include/linux/uio.h
> +++ b/include/linux/uio.h
[ ... ]
> @@ -29,6 +30,7 @@ enum iter_type {
>  	ITER_FOLIOQ,
>  	ITER_XARRAY,
>  	ITER_DISCARD,
> +	ITER_DMABUF_MAP,
>  };

[Severity: Medium]
With the addition of ITER_DMABUF_MAP here, do iterate_and_advance2() and=20
iterate_and_advance_kernel() in include/linux/iov_iter.h also need to be=20
updated?

It appears they currently lack a type check for ITER_DMABUF_MAP, which=20
might cause operations like copy_to_iter() or copy_from_iter() to silently=
=20
fall through to iterate_discard(). If any middle layer attempts to read or=
=20
write using this iterator type, the operation would drop data and return=20
success without reporting an error.

[ ... ]
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 2072c04e99d05..6831a5d9396e1 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
[ ... ]
> @@ -775,6 +777,20 @@ void iov_iter_xarray(struct iov_iter *i, unsigned in=
t direction,
>  }
>  EXPORT_SYMBOL(iov_iter_xarray);
> =20
> +void iov_iter_dmabuf_map(struct iov_iter *i, unsigned int direction,
> +			 struct dma_buf_io_map *map,
> +			 loff_t off, size_t count)
> +{
> +	WARN_ON(direction & ~(READ | WRITE));
> +	*i =3D (struct iov_iter){
> +		.iter_type =3D ITER_DMABUF_MAP,
> +		.data_source =3D direction,
> +		.dmabuf_map =3D map,
> +		.count =3D count,
> +		.iov_offset =3D off,
> +	};
> +}

[Severity: Medium]
Since iov_offset is initialized here to the absolute starting offset (off)=
=20
rather than a relative zero, does this cause an issue with the tracking=20
logic in iov_iter_revert()?

In iov_iter_revert(), the unroll size is checked against i->iov_offset=20
like this:

	if (unroll <=3D i->iov_offset) {
		i->iov_offset -=3D unroll;
		return;
	}

Because iov_offset starts at the absolute offset rather than 0, couldn't a=
=20
caller successfully revert an ITER_DMABUF_MAP iterator beyond its initial=20
starting offset? This would bypass the BUG() safety net intended to catch=20
invalid unrolls, potentially leading to an out-of-bounds DMA access if the=
=20
reverted iterator is used again.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789997898.gi=
t.asml.silence@gmail.com?part=3D2
