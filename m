Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62EB2CD98E1
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 02:33:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A75B10E590;
	Wed, 17 Jun 2026 02:33:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bSWFCM80";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1F2D10E590
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 02:33:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BF816600BB;
 Wed, 17 Jun 2026 02:33:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6027B1F000E9;
 Wed, 17 Jun 2026 02:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781663624;
 bh=7bd3sHAyRHpc7cQ0u2Kk3Rqae5o5zvGZCLF0EZt/jx8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bSWFCM80sRzPCT1vXaWJShixineJ7scNVNPttt19Hsadi/USj5Ye3WNmNXMJLfi+K
 NKaxyD0CKDHPeIW59mxTf2c3e2e/HSm590Gq6MXP7krx4ep0EjnZcAUBOmedfOWYBJ
 G7D3qn1RtIrHDeHfIYav7qprDBCZd9BQQrziVaBNdGLt5aC/qD9Zf8E25yfJ/WZtM1
 g2aSKoRRqgauJDBrCikLdaCM+6W8BN0CuVmqH6FKHKfdh4aJIFryJzwz5HRs3yj2Hq
 B+5Z6fnNRvtDTUl1chlVznZQLDV0HOSNgsvIqCN3X3HXBXIMMoZxH6UnLQMjxsa/wD
 Fv2Lb3iCVPWkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] drm/ttm/pool: back up at native page order
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260617021851.1164946-1-matthew.brost@intel.com>
References: <20260617021851.1164946-1-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 02:33:43 +0000
Message-Id: <20260617023344.6027B1F000E9@smtp.kernel.org>
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
- [High] Redundant Writeback IO and Reclaim Degradation due to Missing Dirt=
y Flag Clear
- [Medium] Inaccurate Watermark Check due to Counter Drift
--

commit c4c05c6bea6e7dbeb49a19a207e3cc6b5e0bc762
Author: Matthew Brost <matthew.brost@intel.com>

drm/ttm/pool: back up at native page order

This commit modifies the TTM pool backup process to handle compound pages
at their native order instead of unconditionally splitting them into order-0
pages. It introduces a new folio backup helper to back up contiguous
subpages to shmem, alongside a proactive splitting mechanism to split
pages when under memory pressure.

> diff --git a/drivers/gpu/drm/ttm/ttm_backup.c b/drivers/gpu/drm/ttm/ttm_b=
ackup.c
> index 81df4cb5606b4..e67921393f56c 100644
> --- a/drivers/gpu/drm/ttm/ttm_backup.c
> +++ b/drivers/gpu/drm/ttm/ttm_backup.c
[ ... ]
> @@ -87,53 +93,66 @@ int ttm_backup_copy_page(struct file *backup, struct =
page *dst,
[ ... ]
> +		folio_mark_accessed(to_folio);
> +		folio_lock(to_folio);
> +		folio_mark_dirty(to_folio);
> +
> +		for (j =3D 0; j < to_nr; j++)
> +			copy_highpage(folio_file_page(to_folio, idx + i + j),
> +				      folio_page(folio, i + j));
> +
> +		if (writeback && !folio_mapped(to_folio)) {

[Severity: High]
Does this code skip clearing the dirty flag for IO before calling
shmem_writeout()?

The previous implementation of ttm_backup_backup_page() called
folio_clear_dirty_for_io() and folio_set_reclaim() before starting
the writeback. Without clearing the dirty flag first,
__folio_start_writeback() will not clear the PAGECACHE_TAG_DIRTY mark.

As a result, even if the content is successfully written, the folio
remains marked as dirty, potentially leading to kswapd repeatedly
attempting to write it out again.

> +			ret =3D shmem_writeout(to_folio, NULL, NULL);
> +			if (ret =3D=3D AOP_WRITEPAGE_ACTIVATE)
> +				folio_unlock(to_folio);
> +		} else {
>  			folio_unlock(to_folio);
>  	}
> =20
> -	folio_put(to_folio);
> +		folio_put(to_folio);
> +		i +=3D to_nr;
> +		*nr_pages_backed =3D i;
> +	}
> =20
> -	return handle;
> +	return ttm_backup_shmem_idx_to_handle(idx);
>  }
> =20
> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_poo=
l.c
> index 278bbe7a11add..d76bfe527ac79 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
[ ... ]
> @@ -1010,6 +1010,38 @@ void ttm_pool_drop_backed_up(struct ttm_tt *tt)
>  	ttm_pool_free_range(NULL, tt, ttm_cached, start_page, tt->num_pages);
>  }
> =20
> +static bool ttm_pool_split_for_nearly_oom(struct ttm_pool *pool,
> +					  struct page *page)
> +{
> +	unsigned int order =3D ttm_pool_page_order(pool, page);
> +	int nid =3D pool->nid;
> +	enum zone_type zone_type;
> +
> +	if (!order)
> +		return false;
> +
> +	if (!numa_valid_node(nid))
> +		return false;
> +
> +#if IS_ENABLED(CONFIG_ZONE_DMA32)
> +	zone_type =3D ZONE_DMA32;
> +#else
> +	zone_type =3D ZONE_NORMAL;
> +#endif
> +
> +	for (; zone_type <=3D ZONE_NORMAL; ++zone_type) {
> +		struct zone *zone =3D &NODE_DATA(nid)->node_zones[zone_type];
> +
> +		if (zone_page_state(zone, NR_FREE_PAGES) <

[Severity: Medium]
Can directly reading zone_page_state() miss per-CPU counter drift?

The zone_page_state() function omits per-CPU deltas, and on systems
with many CPUs, this error can exceed the actual watermark gaps.

Using it directly rather than zone_page_state_snapshot() or higher-level
watermark APIs might cause this heuristic to read artificially high
free page counts, delaying the proactive split optimization under
sustained memory pressure.

> +		    low_wmark_pages(zone) / 2) {
> +			ttm_pool_split_for_swap(pool, page);
> +			return true;
> +		}
> +	}
> +
> +	return false;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617021851.1164=
946-1-matthew.brost@intel.com?part=3D1
