Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3254DC5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 20:09:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A52A10E34A;
	Wed, 26 Aug 2026 20:09:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W7LtdEoM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3455910E34A
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 20:09:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2352A60254;
 Wed, 26 Aug 2026 20:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B561F000E9;
 Wed, 26 Aug 2026 20:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787774992;
 bh=+/3Z+qxwFQD9XeQkMZpPtE93DIhsN+xi0ZRERUW/+48=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=W7LtdEoM8NXxVjHyMnElWNGpm8faqw5Ja9iGYPW9e4EI5VbflojK+TeJULZcSC/lB
 sMmKfUUIHOKaFPxP/ajA0nsC2oZGqRIepNOH1UKYzRAkhriIyWvEQ2mCbg97NWlK3S
 TByRX0Ak3im+gbiAYUqMC6W+eYXDXV5SGTH1b2kxbu75XqI4L5bG+SGJUJAsPZM4I+
 vZGwBhBAjETBWpcpP8MWdI7Z7Z5R3yjMwc1jn2mksVREj4h+e8AZ1LOQ5Wyljv4lfF
 8ilw0yqQz2OBugGm58pcOvrBHXFTS5EtZS3FIWKLxdbrOGUrufq1sFJongHkAJjzd8
 iOLFolw4wXMgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/amdxdna: Bound the page count of a user supplied
 buffer
To: "Taimuraz Kaitmazov" <taimuraz@kaitmazov.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260826195736.358579-1-taimuraz@kaitmazov.com>
References: <20260826195736.358579-1-taimuraz@kaitmazov.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 20:09:52 +0000
Message-Id: <20260826200952.B0B561F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] Unhandled zero-size user buffer bypasses constraints and leads=
 to a fatal kernel panic due to ZERO_SIZE_PTR dereference.
--

commit 0ce5a2a6bc3b9a95a5dd641e22f058018b729ead
Author: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>

accel/amdxdna: Bound the page count of a user supplied buffer

amdxdna_get_ubuf() puts a per-entry page count derived from a __u64
va_ent[i].len into a u32, then passes it to pin_user_pages_fast().
This patch rejects a total that does not fit in an int to prevent
truncation and unbound memory operations.

> diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.c b/drivers/accel/amdxdna=
/amdxdna_ubuf.c
> index 0e0cd69cd1fbf..da8e32566ae0a 100644
> --- a/drivers/accel/amdxdna/amdxdna_ubuf.c
> +++ b/drivers/accel/amdxdna/amdxdna_ubuf.c
> @@ -125,6 +125,12 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *=
dev,
>  	}
> =20
>  	ubuf->nr_pages =3D exp_info.size >> PAGE_SHIFT;
> +	if (ubuf->nr_pages > INT_MAX) {
> +		XDNA_ERR(xdna, "Too many pages %lld", ubuf->nr_pages);
> +		ret =3D -EINVAL;
> +		goto free_ent;
> +	}
> +

[Severity: Critical]
This isn't a bug introduced by this patch, but is it possible for
ubuf->nr_pages to be 0 here, leading to a kernel panic later?

If a user calls the AMDXDNA_DRM_CREATE_BO ioctl with a virtual address
table containing at least one entry but with lengths set to 0,
exp_info.size becomes 0 and ubuf->nr_pages becomes 0. This bypasses the
bounds check above.

Then kvmalloc_objs() allocates ubuf->pages with size 0, which returns
ZERO_SIZE_PTR (0x10) instead of NULL. Later, pin_user_pages_fast() handles
npages =3D 0 by returning 0, allowing the zero-length dma-buf to be
exported.

When the buffer is eventually mapped in amdxdna_ubuf_map() in
amdxdna_ubuf.c:

ret =3D sg_alloc_table_from_pages(sg, ubuf->pages, ubuf->nr_pages, 0,
                                ubuf->nr_pages << PAGE_SHIFT, GFP_KERNEL);

sg_alloc_table_from_pages() delegates to sg_alloc_append_table_from_pages(),
which computes chunks =3D 1 and evaluates pages[0] in its first iteration
since the nested loop bounds check is skipped when n_pages =3D=3D 0.

Dereferencing ZERO_SIZE_PTR (0x10) will cause a fatal kernel page fault.

Could we add a check for ubuf->nr_pages =3D=3D 0 here as well?

>  	lock_limit =3D rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>  	new_pinned =3D atomic64_add_return(ubuf->nr_pages, &ubuf->mm->pinned_vm=
);
>  	if (new_pinned > lock_limit && !capable(CAP_IPC_LOCK)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826195736.3585=
79-1-taimuraz@kaitmazov.com?part=3D1
