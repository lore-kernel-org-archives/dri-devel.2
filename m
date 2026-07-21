Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCF3C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 16:49:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4D7710EAB1;
	Tue, 21 Jul 2026 16:49:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lGWQr+TC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83F3A10EAB1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 16:49:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AD3EE601EC;
 Tue, 21 Jul 2026 16:49:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374031F000E9;
 Tue, 21 Jul 2026 16:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784652582;
 bh=FukYcIY/H7zd5+Mq6JZMHY86+Pa8o8aSGNrQjxO6vg0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lGWQr+TCcvxDmxg/H/tjoXXvOgpNcAsILfnnvNYbm17ArAP/YeXClELSeb6gdo/ip
 YevTD8EIsbNMo9RYFp63UTw1tyO9pEuiHjGT1zQyQOCIbQne4zwioCTRloiX6Ci82F
 uz3dpmNGUdxj0qNkMc9wf0+jHjd7EwbHDC+Zazp8ibE1HnukVsBV7rF/jCQZ7mI2Er
 hVM5JdAXFjywSDcD6uKzjQ900P9HuJwzYRah25liriMXyHYMfxkI3lGfq5HuG/bDyC
 nBggdUhUYtTYXE7eAYJbpDf7UaTPf5o/NhWBzXbDUtPAwRubUKxmcmojhuTKWFTnBa
 9cl5wvO5HMaRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/gpusvm: Zero HMM PFNs before scanning ranges
To: "Stanislav Kinsburskii" <skinsburskii@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <178465137297.1335238.13264315601290244705.stgit@skinsburskii>
References: <178465137297.1335238.13264315601290244705.stgit@skinsburskii>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 16:49:41 +0000
Message-Id: <20260721164942.374031F000E9@smtp.kernel.org>
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
- [Medium] The patch replaces `kvmalloc_array()` with `kvcalloc()` for the =
HMM PFN array to prevent uninitialized memory usage in `drm_gpusvm_check_pa=
ges()` and `drm_gpusvm_scan_mm()`. However, the exact same uninitialized ar=
ray pattern remains in `drm_gpusvm_get_pages()` and `drm_gpusvm_range_evict=
()`. These functions allocate the `pfns` array without initialization and p=
ass it to `hmm_range_fault()`. HMM reads the array elements during its page=
 table walks (e.g., `*hmm_pfn =3D (*hmm_pfn & HMM_PFN_INOUT_FLAGS) | new_pf=
n_flags`) to preserve sticky flags. This will trigger the same KMSAN use-of=
-uninitialized-value warnings that the patch aimed to fix.
--

--- Patch [1]: [PATCH v2] drm/gpusvm: Zero HMM PFNs before scanning ranges =
---
commit 3702dcda240b677c2eef39c33354c98311c2dfef
Author: Stanislav Kinsburskii <skinsburskii@gmail.com>

drm/gpusvm: Zero HMM PFNs before scanning ranges

This commit replaces kvmalloc_array() with kvcalloc() for the HMM PFN array
in drm_gpusvm_check_pages() and drm_gpusvm_scan_mm() to prevent uninitializ=
ed
memory from being interpreted as HMM PFN flags or values.

Cc: stable@vger.kernel.org

> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index 9a06ff7d2608e..3a2fe9e780c8f 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -708,7 +708,7 @@ static bool drm_gpusvm_check_pages(struct drm_gpusvm =
*gpusvm,
> =20
>  	mmap_assert_locked(gpusvm->mm);
> =20
> -	pfns =3D kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
> +	pfns =3D kvcalloc(npages, sizeof(*pfns), GFP_KERNEL);

[Severity: Medium]
This is a pre-existing issue, but does this same uninitialized array pattern
remain in drm_gpusvm_get_pages() and drm_gpusvm_range_evict()?

Both of those functions appear to still allocate the pfns array using
kvmalloc_array() without initialization before passing it to
hmm_range_fault().

Since HMM reads the array elements during its page table walks to preserve
sticky flags (e.g. *hmm_pfn =3D (*hmm_pfn & HMM_PFN_INOUT_FLAGS) | new_pfn),
passing an uninitialized array in these functions could trigger the same
KMSAN uninitialized memory warnings this patch aims to fix.

Should drm_gpusvm_get_pages() and drm_gpusvm_range_evict() also be updated
to use kvcalloc()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178465137297.133523=
8.13264315601290244705.stgit@skinsburskii?part=3D1
