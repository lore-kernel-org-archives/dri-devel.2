Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A111C5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 17:33:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D435D10E8B8;
	Mon, 17 Aug 2026 17:33:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VG5YiIWH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34D5010E8B8
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 17:33:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B6F6641205;
 Mon, 17 Aug 2026 17:33:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B77E1F000E9;
 Mon, 17 Aug 2026 17:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786987992;
 bh=VgJxi+xeab2V5CiuxDKyD/2qlz1/2XuybFewsN6V3QA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VG5YiIWH4SNOTnhsJEVAATXXHcny1a+V2zN7RCYkA8x9IQz69/cYG0EiL+A6x9qZN
 t/Hibz+YBpiPZU+J/GQMGdxj8Qhmyzzel3ty8U8pVajwXj4b9a4pSsuT/9eUNPSmDp
 ejAFrNhKDwj+jn7aLO1stoqe8WKe9pWuG/oePmwKMH4+qt38ke3X8RArGJ6NTMzYp+
 A411yXd0foHPuH50MAFqJYvBNaiM69RmiDI0mBgY+fzRmhiTxOwPcfUSCDD8l8zIco
 dMaHk92eJXA3YA3I9B/LV5ujowzwHbvYvk9lgnVLpKHzf+uX9bIrSSo1Uxz9UljU9x
 z4+Yrsxrxrfzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/9] lib/folio_pool: Introduce Direct-Map Large Folio
 Pool & Scratchpad bump allocators
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, bpf@vger.kernel.org
In-Reply-To: <20260817-folio-pool-v1-v1-1-0c1d230aa3af@gmail.com>
References: <20260817-folio-pool-v1-v1-0-0c1d230aa3af@gmail.com>
 <20260817-folio-pool-v1-v1-1-0c1d230aa3af@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 17:33:11 +0000
Message-Id: <20260817173312.6B77E1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 12 potential issue=
(s) to consider:
- [Critical] Passing ZERO_SIZE_PTR to is_folio_pool_ptr() triggers a kernel=
 Oops.
- [Critical] Integer overflow in aligned_size calculation bypasses bounds c=
hecks and leads to out-of-bounds memset().
- [High] is_folio_pool_ptr() incorrectly identifies large kmalloc() allocat=
ions as pool pointers, causing memory leaks.
- [High] folio_pool_realloc() allocates unmanaged kmalloc objects that esca=
pe O(1) bulk teardown, leaking memory.
- [High] DEFINE_FREE wrapper for folio_scratchpad fails to guard against ER=
R_PTR, risking kernel panics.
- [High] Fallback kvzalloc() allocations are not tracked in the scratchpad,=
 breaking bulk teardown and leaking memory.
- [High] Integer underflow when the requested alignment exceeds the fallbac=
k folio size causes an out-of-bounds memory write.
- [High] Calling krealloc() on vmalloc pointers triggers a kernel panic.
- [Medium] folio_scratchpad_reset() retains the newest (potentially smalles=
t) chunk instead of the primary large chunk.
- [Medium] Requesting an allocation larger than a folio's capacity permanen=
tly leaks a new folio on every attempt.
- [Medium] TOCTOU race condition in folio_scratchpad_alloc() blindly overwr=
ites pool state, abandoning free space.
- [Low] folio_scratchpad_stats() calculates incorrect telemetry metrics whe=
n the allocator falls back to order-0 folios.
--

--- Patch [1]: [PATCH 1/9] lib/folio_pool: Introduce Direct-Map Large Folio=
 Pool & Scratchpad bump allocators ---
commit affebf70d4f5ab8fbcb579b4c9e3058f34859616
Author: Jim Cromie <jim.cromie@gmail.com>
lib/folio_pool: Introduce Direct-Map Large Folio Pool & Scratchpad bump all=
ocators

This commit introduces region-based linear bump allocators backed by
direct-map large folios for kernel subsystems. It provides a core engine
(folio_scratchpad) and a wrapper (folio_pool), with static key controls
for subsystem autonomy.

> diff --git a/include/linux/folio_pool.h b/include/linux/folio_pool.h
> new file mode 100644
> index 0000000000000..5bbca8818877c
> --- /dev/null
> +++ b/include/linux/folio_pool.h

[ ... ]

> +void folio_scratchpad_stats(struct folio_scratchpad *sp, unsigned int *n=
r_chunks,
> +			    size_t *chunk_size, size_t *tail_used);
> +
> +DEFINE_FREE(folio_scratchpad, struct folio_scratchpad *, if (_T) folio_s=
cratchpad_free(_T))

[Severity: High]
Does this wrapper properly handle ERR_PTR returns? If an allocator returns
an ERR_PTR, it evaluates as truthy in the if (_T) check. This would pass the
bogus pointer to folio_scratchpad_free(), which might dereference it while
acquiring the spinlock and cause a kernel crash.

> +
> +/**
> + * is_folio_pool_ptr - Check whether an address resides in a folio pool/=
scratchpad
> + * @ptr: Object pointer to test
> + *
> + * Direct-map large folios allocated via folio_alloc() are not slab page=
s,
> + * unlike objects returned by kmalloc/kzalloc.
> + */
> +static inline bool is_folio_pool_ptr(const void *ptr)
> +{
> +	return ptr && !is_vmalloc_addr(ptr) && !folio_test_slab(virt_to_folio(p=
tr));

[Severity: Critical]
Can this panic if ptr is ZERO_SIZE_PTR? If a caller uses kvzalloc(0), it
returns a ZERO_SIZE_PTR (typically (void *)16). This is truthy and not a
vmalloc address, so it seems virt_to_folio((void *)16) would be called, whi=
ch
could index out of bounds in vmemmap and trigger an unhandled page fault.

[Severity: High]
Will this misidentify large kmalloc() allocations? Since kmalloc_large()
allocations bypass the SLUB allocator and are served directly by the page
allocator, they do not have the PG_slab flag set. It looks like they would =
be
misidentified as folio pool pointers, causing kvfree() to be skipped in
folio_pool_free_elem() and leading to a memory leak.

> +}
> +
> +/**
> + * folio_pool_free_elem - Safely release a pool object or SLUB fallback =
element

[ ... ]

> + * in a direct-map large folio, allocates a fresh @new_size buffer from =
SLUB
> + * and copies @old_size bytes; the original scratchpad slot remains aban=
doned
> + * until the entire scratchpad is released or reset at batch boundary.
> + */
> +static inline void *folio_pool_realloc(void *ptr, size_t old_size,
> +				       size_t new_size, gfp_t gfp)
> +{
> +	void *new_ptr;
> +
> +	if (!ptr)
> +		return kmalloc(new_size, gfp);
> +
> +	if (!is_folio_pool_ptr(ptr))
> +		return krealloc(ptr, new_size, gfp);

[Severity: High]
Can this trigger a kernel panic by passing a vmalloc pointer to krealloc()?
If the fallback allocation was performed by kvzalloc(), it may return a
vmalloc address. If passed here, is_folio_pool_ptr() would return false, and
krealloc() would be called on a vmalloc pointer, which could cause a panic.

> +
> +	new_ptr =3D kmalloc(new_size, gfp);

[Severity: High]
Does this allocate unmanaged kmalloc objects that escape bulk teardown?
The newly allocated buffer does not appear to be added to the scratchpad's
chunks list. Since it is invisible to folio_scratchpad_free(), subsystems
using bulk teardown might permanently leak these reallocated SLUB objects.

> +	if (new_ptr)
> +		memcpy(new_ptr, ptr, min(old_size, new_size));
> +	return new_ptr;
> +}

[ ... ]

> diff --git a/lib/folio_pool.c b/lib/folio_pool.c
> new file mode 100644
> index 0000000000000..07a290db6c506
> --- /dev/null
> +++ b/lib/folio_pool.c

[ ... ]

> +noinline void *folio_scratchpad_alloc(struct folio_scratchpad *sp, size_=
t size,
> +				     size_t align, gfp_t gfp)
> +{
> +	struct folio_pool_chunk *chunk;
> +	struct folio *folio;
> +	void *elem, *base;
> +	size_t chunk_size, aligned_size, pad, header_offset;
> +	unsigned long flags;
> +
> +	if (!folio_scratchpad_is_enabled(sp))
> +		return kvzalloc(size, gfp);

[Severity: High]
Are these fallback allocations tracked for bulk teardown? It looks like they
are never appended to sp->chunks. When folio_scratchpad_free() or
folio_scratchpad_reset() executes, it seems they only iterate over sp->chun=
ks,
meaning all fallback allocations would be permanently leaked.

> +
> +	if (unlikely(!size))
> +		return NULL;
> +
> +	align =3D max_t(size_t, sizeof(void *), align ? align : sizeof(void *));
> +
> +	spin_lock_irqsave(&sp->lock, flags);
> +	pad =3D (uintptr_t)sp->free_ptr & (align - 1);
> +	if (pad)
> +		pad =3D align - pad;
> +	aligned_size =3D size + pad;

[Severity: Critical]
Is it possible for aligned_size to overflow? If size is very large (near
SIZE_MAX), aligned_size could wrap around to a small integer. The capacity
check below might then incorrectly succeed, leading to an out-of-bounds
memset(elem, 0, size) with the original massive size.

> +
> +	if (sp->remaining < aligned_size) {
> +		spin_unlock_irqrestore(&sp->lock, flags);
> +
> +		folio =3D folio_alloc(gfp, sp->chunk_order);
> +		if (!folio && sp->chunk_order > 0)
> +			folio =3D folio_alloc(gfp, 0);
> +		if (!folio)
> +			return NULL;
> +
> +		base =3D folio_address(folio);
> +		chunk =3D (struct folio_pool_chunk *)base;
> +		chunk->folio =3D folio;
> +		chunk_size =3D folio_size(folio);
> +		header_offset =3D ALIGN(sizeof(*chunk), max_t(size_t, sizeof(void *), =
align));
> +
> +		spin_lock_irqsave(&sp->lock, flags);
> +		list_add(&chunk->link, &sp->chunks);
> +		sp->free_ptr =3D base + header_offset;
> +		sp->remaining =3D chunk_size - header_offset;

[Severity: Medium]
Could this overwrite pool state unconditionally in a race condition? Since
sp->lock was dropped to call folio_alloc(), concurrent threads could also
allocate folios. Upon re-acquiring the lock, it looks like threads blindly
overwrite sp->free_ptr and sp->remaining without checking if the pool was
already replenished, potentially abandoning free space.

[Severity: High]
Can chunk_size - header_offset underflow? If the user requests an extremely
large alignment (e.g., page-block alignment) on a small fallback order-0
folio, header_offset might exceed chunk_size. This subtraction would
underflow, producing a massive positive integer, and returning an
out-of-bounds pointer.

> +
> +		pad =3D (uintptr_t)sp->free_ptr & (align - 1);
> +		if (pad)
> +			pad =3D align - pad;
> +		aligned_size =3D size + pad;
> +	}
> +
> +	if (sp->remaining < aligned_size) {
> +		spin_unlock_irqrestore(&sp->lock, flags);
> +		return NULL;

[Severity: Medium]
Does this leak the newly allocated folio if the size is too large? The new
folio was just added to sp->chunks. If the requested size is larger than the
entire folio's capacity, this check fails and returns NULL, but the folio
remains in sp->chunks. Repeatedly requesting an oversized allocation could
rapidly leak folios.

> +	}
> +
> +	elem =3D sp->free_ptr + pad;
> +	sp->free_ptr +=3D aligned_size;
> +	sp->remaining -=3D aligned_size;
> +	spin_unlock_irqrestore(&sp->lock, flags);
> +
> +	memset(elem, 0, size);
> +	return elem;
> +}
> +EXPORT_SYMBOL_GPL(folio_scratchpad_alloc);
> +
> +noinline void folio_scratchpad_reset(struct folio_scratchpad *sp)
> +{
> +	struct folio_pool_chunk *head, *chunk, *tmp;
> +	size_t header_offset;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&sp->lock, flags);
> +	if (list_empty(&sp->chunks)) {
> +		sp->free_ptr =3D NULL;
> +		sp->remaining =3D 0;
> +		spin_unlock_irqrestore(&sp->lock, flags);
> +		return;
> +	}
> +
> +	/* Retain primary head chunk; free overflow chunks */
> +	head =3D list_first_entry(&sp->chunks, struct folio_pool_chunk, link);

[Severity: Medium]
Does list_first_entry() retain the newest chunk instead of the primary large
chunk? Since list_add() is used during allocation, new chunks are prepended
in a LIFO order. If the final chunk was a small fallback order-0 chunk, it
seems this would free the large capacity chunk and retain the tiny chunk for
the next batch.

> +	list_for_each_entry_safe(chunk, tmp, &sp->chunks, link) {
> +		if (chunk =3D=3D head)
> +			continue;
> +		list_del(&chunk->link);
> +		folio_put(chunk->folio);
> +	}

[ ... ]

> +void folio_scratchpad_stats(struct folio_scratchpad *sp, unsigned int *n=
r_chunks,
> +			    size_t *chunk_size, size_t *tail_used)
> +{
> +	unsigned long flags;
> +	size_t csz;
> +
> +	csz =3D (PAGE_SIZE << sp->chunk_order);
> +	if (chunk_size)
> +		*chunk_size =3D csz;
> +
> +	spin_lock_irqsave(&sp->lock, flags);
> +	if (nr_chunks)
> +		*nr_chunks =3D list_count_nodes(&sp->chunks);
> +	if (tail_used)
> +		*tail_used =3D csz > sp->remaining ? csz - sp->remaining : 0;

[Severity: Low]
Does this calculate incorrect telemetry when falling back to order-0 folios?
If the allocator falls back to an order-0 folio, sp->remaining is relative =
to
PAGE_SIZE. Subtracting the smaller order-0 remainder from the theoretical
high-order total (csz) seems to compute an artificially inflated tail_used
metric.

> +	spin_unlock_irqrestore(&sp->lock, flags);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817-folio-pool=
-v1-v1-0-0c1d230aa3af@gmail.com?part=3D1
