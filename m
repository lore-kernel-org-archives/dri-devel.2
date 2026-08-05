Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F15BC55ABA
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:54:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B59310EE1E;
	Wed,  5 Aug 2026 11:54:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CCBHroqz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C350210EE1E
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 11:54:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8983140E5C;
 Wed,  5 Aug 2026 11:54:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA2E1F00A3A;
 Wed,  5 Aug 2026 11:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785930882;
 bh=e9sAbhG2PJdFm3FF3n9i1BS9t/hJSG51NvVKx5KHRMc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CCBHroqzqQElr4HpfircDwD2YW767XWL/95S7CFgsHZrYyt71gdqFLr/o6hcVoEDQ
 b3SLEok7SnXPsd6SYG/Taf9XIAlmxaQEwAsTsuhnMiO1+MJ9L0Nn17OsQP0AngqbIc
 b5n4OtNljQ+MDW8QK6k5HihQdVyP4kI9h4eUe73YWqiAhWg3uxS8G/92Ev3h8dTrZ1
 Qs/+m1jJN+s3Qan00atFkrwh/eFpnb6+Pl7SazBLqRaJJh7yXLQRDGsc9UAegqkFKL
 E+33Uu00nAim2zPFZjwpjMnrTax9OkxSmgqfdlSiDpej01qcW03GTzKqp82mCMbiIZ
 BZrj39qZ04Chg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] mm/migrate_device: Apply the fault reference to the
 correct folio
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260805113338.3742178-3-matthew.brost@intel.com>
References: <20260805113338.3742178-1-matthew.brost@intel.com>
 <20260805113338.3742178-3-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 11:54:41 +0000
Message-Id: <20260805115442.4CA2E1F00A3A@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] Error paths in `__migrate_device_pages` after a successful THP=
 split fail to clear `MIGRATE_PFN_MIGRATE` on tail pages, leading to uninit=
ialized device memory being mapped into userspace.
- [High] `folio_free_swap()` is only called on the head folio after splitti=
ng a swap-backed THP, leaving tail folios improperly in the swap cache.
--

--- Patch [2]: [PATCH 2/4] mm/migrate_device: Apply the fault reference to =
the correct folio ---
commit 4d89d00fc35f8db7c498dd86850a797d2e8c3d2b
Author: Matthew Brost <matthew.brost@intel.com>

mm/migrate_device: Apply the fault reference to the correct folio

This commit fixes a bug in __migrate_device_pages() where extra_cnt was
calculated once for the head page and incorrectly applied to all sub-folios
during a THP migration split. It moves the extra_cnt calculation inside the
sub-folio loop so that the CPU fault reference is correctly applied only to
the sub-folio containing the fault page.

> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index bf8d21857d380..5b078fcbec792 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -1201,7 +1201,7 @@ static void __migrate_device_pages(unsigned long *s=
rc_pfns,
>  		struct page *page =3D migrate_pfn_to_page(src_pfns[i]);
>  		struct address_space *mapping;
>  		struct folio *newfolio, *folio;
> -		int r, extra_cnt =3D 0;
> +		int r;
>  		unsigned long nr =3D 1;
> =20
>  		if (!newpage) {

[ ... ]

> @@ -1306,13 +1306,25 @@ static void __migrate_device_pages(unsigned long =
*src_pfns,
> =20
>  		BUG_ON(folio_test_writeback(folio));
> =20

[Severity: High]
This is a pre-existing issue, but does calling folio_free_swap() only on the
head page leave the tail pages in the swap cache?

If a swap-backed THP is split into order-0 folios by
migrate_vma_split_unmapped_folio() in __migrate_device_pages(), the local
"folio" variable still points to the head page. The code just before this
BUG_ON() calls:

			if (mapping) {
				if (!folio_test_anon(folio) ||
				    !folio_free_swap(folio)) {

Because this is outside the subpage loop, it only removes the head page from
the swap cache. Later in the loop, when folio_migrate_mapping() is called
for the tail pages, could they still be marked as swap cache and incorrectly
replace their swap cache entries with device private pages?

[Severity: Critical]
This is a pre-existing issue, but do the error paths after a THP split fail=
 to
clear MIGRATE_PFN_MIGRATE on tail pages?

If the destination only allocates order-0 pages and the THP is successfully
split in __migrate_device_pages(), the MIGRATE_PFN_MIGRATE flag is active on
all tail pages in src_pfns. If a subsequent check fails, the code just befo=
re
this BUG_ON() does:

				if (!folio_test_anon(folio) ||
				    !folio_free_swap(folio)) {
					src_pfns[i] &=3D ~MIGRATE_PFN_MIGRATE;
					goto next;
				}
		} else if (folio_is_zone_device(newfolio)) {
			src_pfns[i] &=3D ~MIGRATE_PFN_MIGRATE;
			goto next;
		}

This clears the flag for the head page (src_pfns[i]), but not the tail page=
s.
Since the loop advances by "nr" at the "next" label, the tail pages keep th=
eir
migration flag. Could __migrate_device_finalize() then mistakenly assume th=
ey
migrated successfully and map uninitialized device memory into userspace?

> -		if (migrate && migrate->fault_page =3D=3D page)
> -			extra_cnt =3D 1;
>  		for (j =3D 0; j < nr && i + j < npages; j++) {
> -			folio =3D page_folio(migrate_pfn_to_page(src_pfns[i+j]));
> +			struct page *src_page =3D migrate_pfn_to_page(src_pfns[i+j]);
> +			int extra_cnt =3D 0;
> +
> +			folio =3D page_folio(src_page);
>  			newfolio =3D page_folio(migrate_pfn_to_page(dst_pfns[i+j]));
> =20
> -			r =3D folio_migrate_mapping(mapping, newfolio, folio, extra_cnt);
> +			/*
> +			 * The CPU fault holds an extra reference on the folio
> +			 * containing the fault page. @folio may have been
> +			 * split above, so the fault page only accounts for an
> +			 * extra reference on the folio it actually ended up
> +			 * in, not on every folio of the original THP.
> +			 */
> +			if (migrate && migrate->fault_page =3D=3D src_page)
> +				extra_cnt =3D 1;
> +
> +			r =3D folio_migrate_mapping(folio_mapping(folio), newfolio,
> +						  folio, extra_cnt);
>  			if (r)
>  				src_pfns[i+j] &=3D ~MIGRATE_PFN_MIGRATE;
>  			else

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805113338.3742=
178-1-matthew.brost@intel.com?part=3D2
