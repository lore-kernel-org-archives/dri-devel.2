Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A99C531C7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 06:54:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C27310E53A;
	Thu, 23 Jul 2026 06:54:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZMxbPK9S";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8182410E53A
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 06:54:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0CAC5429D5;
 Thu, 23 Jul 2026 06:54:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B010B1F00A3A;
 Thu, 23 Jul 2026 06:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784789662;
 bh=q0RtO5IgaHSjvkCtf0A+Tiz5g8fHKKHi1rEdz2tz7Xg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZMxbPK9Soi8mbjTQXDoxvuz+jfnx/l4xqYX35Vsaas/AxOTcuy6D/UTJS52xJq3qM
 JHPID38b0lMHSaZi65Trd6FWbSiH0162KNz+M2Z/jG48zV1ZB4eXe36hYi3BrWn9cF
 NaTq53OiveJBHEKhgcipbC6zGoC1xbSFnyTqnzbIWKr4hPPcbEdyYATl663I7FfYiX
 qwfqsdAl1z4HzBXAkWBmJ27xbMMubRGKBHGPbORxSlwBIWQxtvgtJZGWcI95rt/3k5
 6iCA0QEZsBvdk1RpYuCnlMgQK+L6nQ8Nrtb3oEEv1bvhNjJY0skGA1edEs5GIHRTMx
 HNuveGhNu/3cQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915/userptr: Convert page APIs to folio
 equivalents in put_pages
To: "Hongfu Li" <hongfu.li@linux.dev>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260723064651.4100-1-hongfu.li@linux.dev>
References: <20260723064651.4100-1-hongfu.li@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 06:54:22 +0000
Message-Id: <20260723065422.B010B1F00A3A@smtp.kernel.org>
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
- [High] Unconditional PAGE_SIZE stepping over a scatterlist performs non-i=
dempotent folio operations multiple times for large folios.
--

--- Patch [1]: [PATCH] drm/i915/userptr: Convert page APIs to folio equival=
ents in put_pages ---
commit a2440a520ca40b971ab3143efb8ecac51e56d073
Author: Hongfu Li <lihongfu@kylinos.cn>

drm/i915/userptr: Convert page APIs to folio equivalents in put_pages

This commit replaces page-based APIs with folio equivalents in
i915_gem_userptr_put_pages(). It caches the folio at the start of the loop
to avoid repeated compound head lookups inside page API wrappers.

> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/dr=
m/i915/gem/i915_gem_userptr.c
> index 043095f93ac60..bd91782f4bbc7 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
[ ... ]
> @@ -177,7 +178,9 @@ i915_gem_userptr_put_pages(struct drm_i915_gem_object=
 *obj,
>  		obj->mm.dirty =3D false;
> =20
>  	for_each_sgt_page(page, sgt_iter, pages) {
> -		if (obj->mm.dirty && trylock_page(page)) {
> +		folio =3D page_folio(page);
> +
> +		if (obj->mm.dirty && folio_trylock(folio)) {

[Severity: High]
This isn't a bug introduced by this patch, but does this loop process the s=
ame
folio multiple times for large folios?

In i915_gem_userptr_put_pages(), the for_each_sgt_page() macro unconditiona=
lly
steps by PAGE_SIZE. This causes page_folio() to repeatedly return the same =
folio
for the tail pages of a large folio.

For non-idempotent operations, this causes the folio to be processed redund=
antly.
If the scatterlist is backed by a 2MB THP, the same folio is processed 512
times. This means the code unnecessarily locks and unlocks the folio 512 ti=
mes,
and folio_mark_accessed() causes the folio to repeatedly toggle between
referenced and active states.

Because large folios bypass per-CPU LRU batches, this hammers the global zo=
ne
LRU spinlock repeatedly per THP, causing severe system-wide lock contention.

Could we track the last processed folio to avoid duplicate processing of ta=
il
pages in this loop?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723064651.4100=
-1-hongfu.li@linux.dev?part=3D1
