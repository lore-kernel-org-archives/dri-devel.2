Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B429C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 20:34:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3693A10E238;
	Wed,  5 Aug 2026 20:34:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W0oN9/Qa";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A22FD10EFD9
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 20:34:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 58D7941636;
 Wed,  5 Aug 2026 20:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121601F000E9;
 Wed,  5 Aug 2026 20:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785962075;
 bh=7FugTtMhHGKwqeTnwV3XNo8Rg4soyJoPsk2c8xjCVbY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=W0oN9/QaKwXBexZSss1e/w7BPFk54Izz13FfC4uCdGHfvGaI8fJ0LRzlkwLfQJQSf
 iiXuwyIrDxlLMbdQvOQm6r9+fL7fB9FJP1ABQpEZrQTNIFV8wjDqSMVHugKF055EPN
 73czCPq6MXggckoC6+CduBu+hTK3fB3GcB2coyTLI0NDWhBFIz4n92XGxVSuMd7dDM
 S7mGuAokWoQvCWrqcy8G61K4B5R4BBR98w1UrSXkVTj2dLPOMePiakc1tVfEYGnzLD
 SaEX6XMRFw3HRkK90Ec48/Pepq9MyHphql9qTkRvg6JOjmXYrT+YIUZ8Mn0Lz8BzhT
 MTDq3PAeCksLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] mm/migrate_device: Fix THP splitting of a CPU
 faulted device private folio
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260805193536.3756457-3-matthew.brost@intel.com>
References: <20260805193536.3756457-1-matthew.brost@intel.com>
 <20260805193536.3756457-3-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 20:34:34 +0000
Message-Id: <20260805203435.121601F000E9@smtp.kernel.org>
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
- [High] Out-of-bounds write in `migrate_device_range()` and `migrate_devic=
e_pfns()` when processing compound device private folios.
--

--- Patch [2]: [PATCH v2 2/5] mm/migrate_device: Fix THP splitting of a CPU=
 faulted device private folio ---
commit 66cc9eb01f0258173048c3a225ebb9ca65d56410
Author: Matthew Brost <matthew.brost@intel.com>

mm/migrate_device: Fix THP splitting of a CPU faulted device private folio

This commit fixes two issues when splitting a device private THP during a C=
PU
fault: it drops and re-acquires the fault reference across the split to pre=
vent
it from failing, and walks the rmap to demote all PMD sized migration entri=
es=20
before splitting to prevent leaving stale huge PMDs in other VMAs.

[ ... ]

> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index 1e24039f62b33..155a182c528f8 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -1187,8 +1268,7 @@ static void __migrate_device_pages(unsigned long *s=
rc_pfns,
>  					goto next;
>  				}
>  				nr =3D 1 << folio_order(folio);
> -				addr =3D migrate->start + i * PAGE_SIZE;
> -				if (migrate_vma_split_unmapped_folio(migrate, i, addr, folio)) {
> +				if (migrate_vma_split_unmapped_folio(migrate, i, folio)) {
>  					src_pfns[i] &=3D ~(MIGRATE_PFN_MIGRATE |
>  							 MIGRATE_PFN_COMPOUND);
>  					goto next;

[Severity: High]
This is a pre-existing issue, but does migrate_device_range() write out of
bounds when processing a compound device private folio?

Looking at mm/migrate_device.c:migrate_device_range(), the code iterates
through pfns:

	for (pfn =3D start, i =3D 0; i < npages; pfn++, i++) {
		...
		nr =3D folio_nr_pages(folio);
		if (nr > 1) {
			src_pfns[i] |=3D MIGRATE_PFN_COMPOUND;
			for (j =3D 1; j < nr; j++)
				src_pfns[i+j] =3D 0;
			i +=3D j - 1;
			pfn +=3D j - 1;
		}
	}

If npages does not fully cover the compound folio, this loop writes zeroes
into src_pfns without checking if i + j is less than npages. Because
src_pfns is allocated by the caller to exactly npages in size, writing up
to nr - 1 zeroes can overflow the array.

The exact same missing bounds check appears in migrate_device_pfns():

	for (i =3D 0; i < npages; i++) {
		...
		nr =3D folio_nr_pages(folio);
		if (nr > 1) {
			src_pfns[i] |=3D MIGRATE_PFN_COMPOUND;
			for (j =3D 1; j < nr; j++)
				src_pfns[i+j] =3D 0;
			i +=3D j - 1;
		}
	}

Could these loops be updated to check i + j < npages before writing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805193536.3756=
457-1-matthew.brost@intel.com?part=3D2
