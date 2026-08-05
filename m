Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B08C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 20:50:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A99C710E22B;
	Wed,  5 Aug 2026 20:50:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZcXRtPuR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1A0710E22B
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 20:50:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 03FF060A5A;
 Wed,  5 Aug 2026 20:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E72D1F000E9;
 Wed,  5 Aug 2026 20:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785963013;
 bh=fKXJoH2A6a+XHaraVPwHHFOaYulRcTrI9d7HWt0WAkA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZcXRtPuRskLYBynOJ5rxjbw8lAQZjD9uxvdgno1HjROtxTRiZHadmdAx37H3IMs23
 uAzYed11J/RtTyb4K3mwyhS3lon7l7nGseDUeR9A3Fzuhf09SfissFTef2BcV7Igg3
 35sSGDFswXP1jdan2iYVo6Xx8+tBV4vVhNB/5w5vmF0UWrKF4CSQxGwslQj7pPDJ5q
 jWcAdjVveehNyFA2gR6FFezyWLZGtzJrdK4aN8qWFOFQhcTp5bkbALhf0xbKCuNvhD
 pRRHGVLficwbVzIukb7CnPO0ozlpts+fpYWeRw6oZD0lmJdItgkwNOWmz8Gnl+hLNS
 y4ImrqmXBZlaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] mm/migrate_device: Apply the fault reference to
 the correct folio
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260805193536.3756457-4-matthew.brost@intel.com>
References: <20260805193536.3756457-1-matthew.brost@intel.com>
 <20260805193536.3756457-4-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 20:50:12 +0000
Message-Id: <20260805205013.8E72D1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Buffer overflow and incorrect PFN skipping in migrate_device_range=
() and migrate_device_pfns() when processing unaligned large folios.
- [High] Incomplete swap cache cleanup for tail pages of a split THP when m=
igrating to device memory.
- [High] Unchecked destination/source PFN for sub-folios causes NULL pointe=
r dereference.
--

--- Patch [3]: [PATCH v2 3/5] mm/migrate_device: Apply the fault reference =
to the correct folio ---
commit 8d0ced88bd091cf2d5be9da542139d8ff060a5e1
Author: Matthew Brost <matthew.brost@intel.com>
Subject: mm/migrate_device: Apply the fault reference to the correct folio

This patch fixes an issue where the CPU fault's extra reference count was
incorrectly applied to every sub-folio of a split THP during device migrati=
on.
By computing the extra reference count on a per-sub-folio basis, it ensures
only the specific folio containing the fault page receives the extra count.
It also updates the code to use the sub-folio's specific mapping.

> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index 155a182c528f8..cf1f7a3eb1b90 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
[ ... ]
> @@ -1311,13 +1311,25 @@ static void __migrate_device_pages(unsigned long =
*src_pfns,
> =20
>  		BUG_ON(folio_test_writeback(folio));
> =20
> -		if (migrate && migrate->fault_page =3D=3D page)
> -			extra_cnt =3D 1;
>  		for (j =3D 0; j < nr && i + j < npages; j++) {
> -			folio =3D page_folio(migrate_pfn_to_page(src_pfns[i+j]));
> +			struct page *src_page =3D migrate_pfn_to_page(src_pfns[i+j]);
> +			int extra_cnt =3D 0;
> +
> +			folio =3D page_folio(src_page);
>  			newfolio =3D page_folio(migrate_pfn_to_page(dst_pfns[i+j]));

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for
migrate_pfn_to_page(dst_pfns[i+j]) or src_page to be NULL here?

If a device driver experiences partial allocation failure during a split THP
migration, it might leave some dst_pfns[i+j] entries as 0 (lacking
MIGRATE_PFN_VALID), or clear MIGRATE_PFN_MIGRATE in src_pfns.

Since the loop doesn't check these validity flags for j > 0,
migrate_pfn_to_page() could return NULL. Would calling page_folio() on a
NULL pointer invoke _compound_head(NULL) and lead to a NULL pointer
dereference?

Should we verify that the PFNs are valid before passing them to page_folio(=
)?

[ ... ]

While reviewing this file, I also noticed a couple of other pre-existing
issues.

First, is there an incomplete swap cache cleanup for tail pages of a split =
THP
when migrating to device memory?

mm/migrate_device.c:__migrate_device_pages() {
    ...
				/*
				 * @folio may have been split into @nr folios
				 * above, so clear all of them.
				 */
				if (!folio_test_anon(folio) ||
				    !folio_free_swap(folio)) {
					for (j =3D 0; j < nr && i + j < npages; j++)
						src_pfns[i+j] &=3D ~MIGRATE_PFN_MIGRATE;
					goto next;
				}
    ...
}

[Severity: High]
This is a pre-existing issue, but doesn't this only call folio_free_swap()
once on the head folio?

When migrating to a destination that doesn't support THP, the source THP is
split into independent order-0 folios. The single folio_free_swap() call on=
ly
removes the head page from the swap cache, stranding the remaining nr - 1
tail sub-folios.

When the subsequent loop proceeds to migrate all nr sub-folios, does this
improperly insert device private pages into the swap cache? Does this need
a loop to free swap for all sub-folios?


Second, can we overflow the caller-supplied src_pfns array in
migrate_device_range() and migrate_device_pfns() when processing unaligned
large folios?

mm/migrate_device.c:migrate_device_range() {
    ...
		src_pfns[i] =3D migrate_device_pfn_lock(pfn);
		if (!(src_pfns[i] & MIGRATE_PFN_MIGRATE))
			continue;

		nr =3D folio_nr_pages(folio);
		if (nr > 1) {
			src_pfns[i] |=3D MIGRATE_PFN_COMPOUND;
			for (j =3D 1; j < nr; j++)
				src_pfns[i+j] =3D 0;
			i +=3D j - 1;
			pfn +=3D j - 1;
		}
    ...
}

[Severity: High]
This is also a pre-existing issue, but this loop zeroes out src_pfns
entries without verifying that i + j < npages.

If the starting PFN belongs to a tail page of a large folio, or if the
npages limit ends mid-folio, nr =3D folio_nr_pages(folio) retrieves the full
folio size. Since the loop then writes 0 to src_pfns[i+j] unconditionally,
can this overflow the bounds of the caller's array?

Additionally, for tail pages, wouldn't pfn +=3D j - 1 incorrectly advance
the PFN iterator as if it started from the head page, leading to skipped
pages?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805193536.3756=
457-1-matthew.brost@intel.com?part=3D3
