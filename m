Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDEF9C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 03:08:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4614810E2AF;
	Sat, 11 Jul 2026 03:08:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A3jMjVs3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4745610E2AF
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 03:08:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E9007411EE;
 Sat, 11 Jul 2026 03:08:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13311F000E9;
 Sat, 11 Jul 2026 03:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783739315;
 bh=1O59mSFXPko9uK3H9cRuLMl2HGuI1k9J/UKZKpkrAXo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=A3jMjVs3s1/vk/Epg74fk9ffnKe6j5zuhVzdyd/lDeaC0UbvuGEzH3SqQEfknjbyH
 zoRIh5mYEJlupxYJCcQfBTu1mfjs6YBvUXiSg2rwLOYpq5wt9bSNXsasq12a3jEeD4
 CiAfbRKRpdjTp2Rij5+/PDFRwvPGGheaYsCeASWdid1OIvdrhgMKGPkJi1L+ym9gb/
 jabv5CxDxDQrGNyTEzOZm4QsLW8tyhHV5sDWcpLiEUT2D3fRRC/Q9SEJMai/Ze3ZYo
 6YNVI037aPuCzeRzkoOzOve467aiDlmrU8+5FLOQRlfLclUkzTE1S70SiWqaQf7bgd
 V4112Dy3X3Prw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/33] drm/ttm: Preallocate beneficial-order defrag
 pages outside the lock
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260711025619.2540575-10-matthew.brost@intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-10-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 03:08:34 +0000
Message-Id: <20260711030835.A13311F000E9@smtp.kernel.org>
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
- [High] An empty preallocation bag causes a defrag move to perform all all=
ocations in-line under the dma-resv lock, causing severe reclaim/compaction=
 stalls and defeating the design goal.
--

--- Patch [9]: [PATCH v3 09/33] drm/ttm: Preallocate beneficial-order defra=
g pages outside the lock ---
commit a99093b0428c713eac3edfaabcb993852aeabdbd
Author: Matthew Brost <matthew.brost@intel.com>

drm/ttm: Preallocate beneficial-order defrag pages outside the lock

This commit introduces a preallocation bag for TTM pool allocations to
hoist expensive high-order allocations out of the dma-resv critical
section. It records suboptimal pages during populate so a defragmentation
pass can appropriately size its out-of-lock preallocation, and harvests the
remainder of the old tt if the preallocation runs out.

> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_poo=
l.c
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c

[ ... ]

> @@ -990,16 +1168,20 @@ struct ttm_pool_alloc_iter {
>  };
> =20
>  /*
> - * Defrag move budget exhausted: the upgrade can make no further progres=
s this
> - * pass. Snapshot @defrag_capped is set only when a byte budget was in f=
orce at
> - * entry.
> + * Defrag move budget exhausted, or the out-of-lock prealloc bag ran dry=
: the
> + * upgrade can make no further progress this pass. Snapshot @defrag_capp=
ed is
> + * set only when a byte budget was in force at entry.
>   */
>  static bool ttm_pool_iter_defrag_exhausted(const struct ttm_pool_alloc_i=
ter *it)
>  {
> +	const struct ttm_pool_prealloc *pp =3D it->prealloc;
> +
>  	if (!it->defrag_old_tt)
>  		return false;
> +	if (it->defrag_capped && it->alloc->defrag_bytes_remaining <=3D 0)
> +		return true;
> =20
> -	return it->defrag_capped && it->alloc->defrag_bytes_remaining <=3D 0;
> +	return pp && pp->count && pp->used >=3D pp->count;

[Severity: High]
If the out-of-lock preallocation fails to allocate any pages due to memory
pressure, pp->count will be 0. Does the && pp->count condition cause this
function to return false in that scenario?

If this returns false for an empty preallocation bag, __ttm_pool_alloc()
will bypass the exhaustion check. The allocator would then proceed with
in-line system page allocations while holding the dma-resv lock.

Because an empty bag is most likely on a fragmented system, these in-line
allocations could stall aggressively in direct reclaim and compaction,
which seems to bypass the goal of hoisting these allocations out of the
critical section.

Could this check be updated to return pp && pp->used >=3D pp->count; so
that an empty bag correctly aborts the defrag move?

>  }
> =20
>  /*

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711025619.2540=
575-1-matthew.brost@intel.com?part=3D9
