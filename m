Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD949CA5FFC
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 01:57:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E0F210F45D;
	Wed,  7 Oct 2026 01:57:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MeKU+q/g";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 369B610F45D
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 01:57:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E68CA403B8;
 Wed,  7 Oct 2026 01:57:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C991F0089B;
 Wed,  7 Oct 2026 01:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791338254;
 bh=eifVgm4ytfYK0sv6mqf6YknrU2n3zXTOOimBFm/L9Hg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MeKU+q/gcOR9mbbd2NnrNv2w5mFEAlfb2O+mLTrdiB23sfh5wloZl8uTpqzCx1eYq
 kDGn/Q30wlBJe/kuB787Zsu43VT44Qyn5ro1rzdyWOIk6wRpuk5kz3T/diO4/0Ceut
 4fB7BqZXYgRc3BbCMF+rrCOnbnOgPDWGB4+zmncOcuYAfg5jGumVRF6PaKZAwPQyVi
 o1kCdeDBTmQG40bngC83I2PkFa7XfLdlDaUYom3o8eJcFDQyqyvVmc4+B0z4Q88ATs
 4jvuHdVdXBm8wa/0R7NcOcqsrnrnaTOA8NFf5gLoMcrYne3VhfuocHdzzuKmge7myo
 xgsKfiVEMMOtQ==
Message-ID: <sashiko-outbox-162575@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 02/13] iov_iter: add iterator type for dmabuf maps
To: "Pavel Begunkov" <asml.silence@gmail.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <c6259482b609b9c98c74cedcc2d600774e2ac3a4.1791336930.git.asml.silence@gmail.com>
References: <cover.1791336930.git.asml.silence@gmail.com>
 <c6259482b609b9c98c74cedcc2d600774e2ac3a4.1791336930.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 01:57:34 +0000
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
- [High] lib: iov_iter_dmabuf_map 64-bit offset truncation and revert under=
flow
--

commit 51412f5d857b723775fa3b8143fbc7dfc3a8a633
Author: Pavel Begunkov <asml.silence@gmail.com>

iov_iter: add iterator type for dmabuf maps
   =20
This commit introduces a new iterator type, ITER_DMABUF_MAP, for dmabuf map=
s.
The map is an opaque object specific to the subsystem or driver, and the
iterator is used by the middle layers to pass the map further down for IO
operations.

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

[Severity: High]
Because ITER_DMABUF_MAP sets iov_offset to the absolute file offset in
iov_iter_dmabuf_map(), does this break the safety invariant here?

For iterators validated by this BUG() check (such as ITER_XARRAY and
ITER_UBUF), iov_offset is normally strictly initialized to 0 to track the
relative number of bytes advanced. Since iov_offset starts at the absolute
offset for ITER_DMABUF_MAP, the condition if (unroll <=3D i->iov_offset) ju=
st
above this hunk could evaluate to true even if the caller attempts to unroll
more bytes than were actually advanced, potentially allowing silent
out-of-bounds iteration.

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

[Severity: High]
Does this silently truncate the 64-bit offset?

The off argument is a 64-bit loff_t, but iov_offset is a size_t (which is 32
bits on 32-bit platforms). Any offset >=3D 4GB will be silently truncated h=
ere.
Unlike ITER_XARRAY which uses a separate 64-bit xarray_start union field,
ITER_DMABUF_MAP doesn't store this absolute offset anywhere else.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791336930.gi=
t.asml.silence@gmail.com?part=3D2
