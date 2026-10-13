Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0BACC6B0F
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 21:13:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CB1A10F9C5;
	Tue, 13 Oct 2026 21:13:13 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C62A810EA38
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 21:13:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F204A6022B;
 Tue, 13 Oct 2026 21:13:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBB91F000FF;
 Tue, 13 Oct 2026 21:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791925984;
 bh=aekYN+rMoYIqyS3nb/QKC2HbzIQVxm5HHKW4K9SBzXM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bIA9R8fwQ7YhmDIYuLMVPKGUOcIwITod18ZueJY9CWzTIL1xQZJi6qrEDgTSgHQJD
 EgB/XfLKHV5Wp37AIUhXjMuNYfjR8hgtKlZ9HWd3gw/8TZH1nlb7IG5IPtMgmUlUMl
 jpqs+liYayd3fR4i9p23TTvZ5SQ19K7Akg/8W8298zq7sciP5BDsD/qo8VI/tNRku6
 eqNRiqkg43KOsdHFiahNCpsPwywo5Zm7Q5kjK6xQRHiXJWFVJyb0pgfkTN4Fyde7sl
 6xCpA03khDPECTM7U7uX6o3k6eEmcz+0l7fCxaRjTWC/GuVoSeMtW++9r9xM1jjuRm
 BgEphOLGTzwzw==
Message-ID: <sashiko-outbox-170523@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 02/13] iov_iter: add iterator type for dmabuf maps
To: "Pavel Begunkov" <asml.silence@gmail.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20b8e9c900c7656e43e039a0d97213a2a781ba4f.1791924581.git.asml.silence@gmail.com>
References: <cover.1791924581.git.asml.silence@gmail.com>
 <20b8e9c900c7656e43e039a0d97213a2a781ba4f.1791924581.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 21:13:04 +0000
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
- [High] iov_iter: iterate_and_advance_kernel() silently discards ITER_DMAB=
UF_MAP data
- [High] iov_iter: dmabuf absolute offset truncation and revert bounds bypa=
ss
--

commit 190aa53efd62f0f61a9121fb6b0b02899d01272d
Author: Pavel Begunkov <asml.silence@gmail.com>

iov_iter: add iterator type for dmabuf maps

Introduce a new iterator type for dmabuf maps. The map in an opaque
object with internals and format specific to the subsystem / driver, and
only it can use that subsystem / driver for issuing IO. The task of the
middle layers is to pass the map / iterator further down, maybe doing
basic splitting and length checking.

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
This patch explicitly rejects ITER_DMABUF_MAP in iterate_and_advance2(), but
does iterate_and_advance_kernel() also need this check?

If an ITER_DMABUF_MAP iterator is passed to iterate_and_advance_kernel(), it
looks like execution will fall through directly to iterate_discard(), which
silently subtracts the requested length from iter->count and returns the
length.

Could this cause internal kernel components to silently bypass data process=
ing
instead of failing loudly?

[ ... ]
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

[Severity: High]
Does setting iov_offset to the absolute file offset in iov_iter_dmabuf_map()
break the bounds check in iov_iter_revert() prior to this BUG() guard?

In iov_iter_revert(), the check is:

	if (unroll <=3D i->iov_offset) {
		i->iov_offset -=3D unroll;
		return;
	}

If iov_offset contains an absolute offset rather than relative progress (0),
does this evaluate the relative unroll amount against the absolute offset,
allowing the iterator to rewind completely out of bounds without hitting
the BUG() safety check?

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

[Severity: High]
Since iov_offset is defined as a size_t, does assigning the loff_t off
truncate the offset on 32-bit architectures?

Additionally, when this iterator is mapped into a bio in subsequent patches,
iter->iov_offset is copied into bio->bi_iter.bi_offset (an unsigned int).

Does this cause truncation on 64-bit architectures as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791924581.gi=
t.asml.silence@gmail.com?part=3D2
