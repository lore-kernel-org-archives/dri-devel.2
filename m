Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF81C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 20:15:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5487710E22E;
	Wed,  5 Aug 2026 20:15:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K/hKOjak";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FF2910E22E
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 20:15:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5DFF46001D;
 Wed,  5 Aug 2026 20:15:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80801F000E9;
 Wed,  5 Aug 2026 20:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785960939;
 bh=mtPTQ4EXzJyvjQFz8AqfhsLYnzmlWBbbAZvxliVCUcc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=K/hKOjakU7tQyC0PMwPJrGeDBxKr9PBXvqomdqzKgect9XuxsQk0fwm13/N3Gs7Oi
 PKPJulubR0lIlRsC9jnL/S+MYhfXaFWm1pWAWsqOpDoEjJSojfoHdpbXpi7z9u52vP
 cDPtU0Y/6yQXMs2HdmSxWNbsvUvsfRW+v9E74ugdhQf3BZrBnJoEQK4r37bfL+s9VV
 +7PKe4B4Azv7COy7FzmnidQ0BpTHKjtJDa7gLi00h3rSdZZQ35Ksx1Yh3wcMHhRDHi
 VYy03o6GwY5NBu/e68mrOwlifqpGMWygcGTiE+C9/e+C7of8ajdhfjIBlRRkx/Oqmm
 yafGOQRImG+0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] mm/migrate_device: Clear MIGRATE_PFN_MIGRATE on
 all sub-folios of a split THP
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260805193536.3756457-2-matthew.brost@intel.com>
References: <20260805193536.3756457-1-matthew.brost@intel.com>
 <20260805193536.3756457-2-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 20:15:38 +0000
Message-Id: <20260805201538.E80801F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Buffer overflow and incorrect PFN advancement in `migrate_devi=
ce_range()` and `migrate_device_pfns()` when iterating over large folios.
- [Critical] Missing `goto next;` in mismatched THP migration error path le=
ads to a Use-After-Free in the page cache.
- [High] When splitting a THP during device migration, `folio_free_swap()` =
is only called on the head sub-folio, leaving tail sub-folios incorrectly r=
esiding in the swap cache and causing device private folios to be inserted =
into the swap cache.
- [High] Unconditional folio reference leak in `migrate_vma_split_unmapped_=
folio()` when `split_huge_pmd_address()` fails.
--

--- Patch [1]: [PATCH v2 1/5] mm/migrate_device: Clear MIGRATE_PFN_MIGRATE =
on all sub-folios of a split THP ---
commit 5f556994219f3e728aa37333e780844be8000edb
Author: Matthew Brost <matthew.brost@intel.com>

mm/migrate_device: Clear MIGRATE_PFN_MIGRATE on all sub-folios of a split T=
HP

This commit updates both bailouts in __migrate_device_pages() to clear
the MIGRATE_PFN_MIGRATE flag across all sub-folios of a split THP. This
ensures the tail pages are properly handled when migration fails.

> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index 18d097c388530..1e24039f62b33 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -1209,10 +1209,14 @@ static void __migrate_device_pages(unsigned long =
*src_pfns,
>  				 * device private or coherent memory.
>  				 *
>  				 * Try to get rid of swap cache if possible.
> +				 *
> +				 * @folio may have been split into @nr folios
> +				 * above, so clear all of them.
>  				 */
>  				if (!folio_test_anon(folio) ||
>  				    !folio_free_swap(folio)) {

[Severity: High]
This isn't a bug introduced by this patch, but does this conditional only
evaluate the head folio?

When migrate_vma_split_unmapped_folio() splits a THP into nr independent
order-0 folios, this bailout condition succeeds for the head folio. However,
it seems we might proceed without freeing the tail folios from the swap
cache.

Could this cause the subsequent loop to replace the tail folios with device
private folios in the swap cache via __swap_cache_replace_folio(),
potentially causing a panic when the swap subsystem interacts with them?

> -					src_pfns[i] &=3D ~MIGRATE_PFN_MIGRATE;
> +					for (j =3D 0; j < nr && i + j < npages; j++)
> +						src_pfns[i+j] &=3D ~MIGRATE_PFN_MIGRATE;
>  					goto next;
>  				}
>  			}

[ ... ]

[Severity: Critical]
This is a pre-existing issue, but is there a missing goto next in
__migrate_device_pages() during a mismatched THP migration?

mm/migrate_device.c:__migrate_device_pages() {
...
		if (thp_migration_supported()) {
...
			} else if ((src_pfns[i] & MIGRATE_PFN_MIGRATE) &&
				(dst_pfns[i] & MIGRATE_PFN_COMPOUND) &&
				!(src_pfns[i] & MIGRATE_PFN_COMPOUND)) {
				src_pfns[i] &=3D ~MIGRATE_PFN_MIGRATE;
			}
		}
...

By clearing the migration flag without jumping to next, execution appears to
fall through into the mapping migration loop. Could folio_migrate_mapping()
successfully replace the source folio with the destination folio in the page
cache, and then migrate_vma_finalize() free the destination folio because
the flag was cleared? This looks like it might leave a Use-After-Free in the
page cache.

[Severity: Critical]
This isn't a bug introduced by this patch, but does iterating over large
folios lack bounds checking in migrate_device_range()?

mm/migrate_device.c:migrate_device_range() {
...
		for (j =3D 1; j < nr; j++)
			src_pfns[i+j] =3D 0;
...

When reading nr =3D folio_nr_pages(folio) for a large folio, there does not
appear to be a check against npages. If the large folio extends beyond the
requested migration range, could i+j exceed the src_pfns array bounds and
corrupt memory?

Additionally, advancing the pfn by adding the full folio size seems to
bypass the subpage offset. Can this skip unrelated pages? This same
pattern appears to exist in migrate_device_pfns().

[Severity: High]
This is a pre-existing issue, but does migrate_vma_split_unmapped_folio()
leak a folio reference if split_huge_pmd_address() returns early?

mm/migrate_device.c:migrate_vma_split_unmapped_folio() {
...
	folio_get(folio);
	split_huge_pmd_address(migrate->vma, addr, true);
	ret =3D folio_split_unmapped(folio, 0);
...

If split_huge_pmd_address() returns early, for instance if the PMD was
concurrently unmapped and mm_find_pmd returns NULL, the reference taken by
folio_get() does not seem to be dropped. When folio_split_unmapped() later
fails with -EAGAIN due to the elevated refcount, does this result in a
permanent leak of the large folio?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805193536.3756=
457-1-matthew.brost@intel.com?part=3D1
