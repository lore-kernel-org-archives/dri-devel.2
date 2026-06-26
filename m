Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3B8CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 11:40:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ABDD10E36E;
	Fri, 26 Jun 2026 11:40:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O/EquRBg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F33CD10E36E
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 11:40:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 349A760145;
 Fri, 26 Jun 2026 11:40:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9D21F00A3E;
 Fri, 26 Jun 2026 11:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782474043;
 bh=P6QYw1ftRkk88jxrnsEdoc5dsC32AZ29NF4eXPzq7Jg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=O/EquRBgSJUOaa3Td9INgfICKb3cuMbOIuX+VQvZAl3fOq0vX0ehU2vqbRkHT4oo0
 3V5WSJmHNA+zGuy7BZBnG6s2bPI7jq1yF8nvJ9Q1nYMGiDPYqJEDMadbuXBUPllGnE
 wB0wm4vUxhVmU3SoaM0wqyrpO56OilT5qIlli29b5Tq4kEnr3c4iaAqgVIFAkOr2Ot
 56cQJRWw8Gpr8uF20nAqQ5twe5D4cUJrK92PBLRzgk93cqZYMFX5WrSpHNsPRNgsB8
 OIIgbmXRPzykhZW2+QM/tl1jfl6rHSmTmzmvO8fIm+2fzYNNbC0jiV/C6xgDf/mCUl
 fqVZQjUnlyteA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/xe: count UMA shrinkable BOs as reclaimable
 without swap
To: aquiles <achillezongo07@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260626112638.2042298-1-achillezongo07@gmail.com>
References: <20260626112638.2042298-1-achillezongo07@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 11:40:43 +0000
Message-Id: <20260626114043.8F9D21F00A3E@smtp.kernel.org>
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
- [High] xe_shrinker_count() reports shrinkable UMA BOs regardless of __GFP=
_FS, but xe_shrinker_scan() bails out without scanning them when __GFP_FS i=
s missing.
- [High] Bypassing ttm_backup_bytes_avail() for UMA shrinkable BOs falsely =
assumes they can be freed without swap space, causing useless CPU overhead =
yielding zero net memory reclamation.
--

commit eb93ae097c20ae5f357e41557ba0c3d785cb142c
Author: aquiles <achillezongo07@gmail.com>

drm/xe: count UMA shrinkable BOs as reclaimable without swap

This commit modifies the xe shrinker count logic to unconditionally report
UMA shrinkable buffer objects as reclaimable, even without swap space. It
subtracts UMA shrinkable pages from the ttm backup limit check and adds
them back unconditionally.

> diff --git a/drivers/gpu/drm/xe/xe_shrinker.c b/drivers/gpu/drm/xe/xe_shr=
inker.c
> index 83374cd576608..3ca2de342dcd6 100644
> --- a/drivers/gpu/drm/xe/xe_shrinker.c
> +++ b/drivers/gpu/drm/xe/xe_shrinker.c
[ ... ]
> @@ -140,16 +140,22 @@ xe_shrinker_count(struct shrinker *shrink, struct s=
hrink_control *sc)
>  {
>  	struct xe_shrinker *shrinker =3D to_xe_shrinker(shrink);
>  	unsigned long num_pages;
> +	long uma_reclaimable_pages;
>  	bool can_backup =3D !!(sc->gfp_mask & __GFP_FS);
> +	bool is_uma =3D !IS_DGFX(shrinker->xe);
> =20
>  	num_pages =3D ttm_backup_bytes_avail() >> PAGE_SHIFT;
>  	read_lock(&shrinker->lock);
> =20
> +	uma_reclaimable_pages =3D is_uma ? shrinker->shrinkable_pages : 0;
> +
>  	if (can_backup)
> -		num_pages =3D min_t(unsigned long, num_pages, shrinker->shrinkable_pag=
es);
> +		num_pages =3D min_t(unsigned long, num_pages,
> +				  shrinker->shrinkable_pages - uma_reclaimable_pages);

[Severity: High]
Does bypassing the ttm_backup_bytes_avail() limit for UMA shrinkable BOs
result in zero net memory reclamation without swap?

On UMA systems without swap, the shrinker uses ttm_bo_shrink() which
backs up the BO by copying its pages to a shmem file. Because no swap space
is available, the newly allocated shmem backup pages cannot be swapped to
disk and remain permanently pinned in physical memory.

This deceives the core MM into trying to reclaim these pages, burning CPU
cycles on copying memory that yields zero net free physical memory.

>  	else
>  		num_pages =3D 0;
> =20
> +	num_pages +=3D uma_reclaimable_pages;

[Severity: High]
Can unconditionally returning uma_reclaimable_pages cause an infinite
reclaim retry loop when __GFP_FS is missing?

When the shrinker is invoked with __GFP_FS missing (e.g., direct reclaim in
the filesystem or block layer), can_backup is false, but this code adds
uma_reclaimable_pages to the returned count anyway.

Looking at xe_shrinker_scan() in the same file, the scan loop explicitly
bails out if !can_backup before it ever attempts to scan non-purgeable
(shrinkable) pages:

	if (nr_scanned >=3D nr_to_scan || !can_backup)
		goto out;

	/* ... */
	shrink_flags.purge =3D false;

The shrinker API strictly requires the count to accurately reflect only the
objects that the scan function will attempt to free under the given gfp_mas=
k.
Returning a falsely high count for objects that the scan function explicitly
skips breaks the VM reclaim feedback loop, causing infinite reclaim loops.

>  	num_pages +=3D shrinker->purgeable_pages;
>  	read_unlock(&shrinker->lock);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626112638.2042=
298-1-achillezongo07@gmail.com?part=3D1
