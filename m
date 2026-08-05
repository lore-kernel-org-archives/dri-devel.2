Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A18C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 23:22:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C21C10F051;
	Wed,  5 Aug 2026 23:22:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IHALR4vD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E580B10F04B
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 23:22:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 97CAA439B1;
 Wed,  5 Aug 2026 23:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7F31F000E9;
 Wed,  5 Aug 2026 23:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785972171;
 bh=lptXXMIBFREfBs7mBqSzJgiG933N8qrL9UVqL15v2ek=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IHALR4vDPV+PwJrWIz73C5OpXY0R4q2bgSRslxU2bm3QO8K3y0uHmwtr5hxslk/aC
 3i63+DWqzSjQF3gesesceCfewMmdflBGsHSME97JjXsZ8ZPUgM7bJEEkpKhpxR58J3
 p4TKSWvNResD2I1vtpd+6cH7rOzGcIfrMmmiK/RiBJiJkf8W116oXh1qIkHuIKF2K6
 fhgBhvvdRh/ZX1ocM19vahmdYYxRKFt6lT1cik2KKuMipDSv+xRKklGIR4SrskHS5I
 iVD16yKNhWudy6En57eNumftOwHrMdOkWETfyv4y+Sz9PsAATY9HYxmyLJjQ5vfkCB
 sr3UEngnXAGXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/6] mm/migrate_device: Clear stale mapping after
 freeing swapcache
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260805231041.3791771-2-matthew.brost@intel.com>
References: <20260805231041.3791771-1-matthew.brost@intel.com>
 <20260805231041.3791771-2-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 23:22:50 +0000
Message-Id: <20260805232251.4F7F31F000E9@smtp.kernel.org>
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
- [High] Missing `goto next;` causes aborted migration to corrupt page cach=
e and page tables.
--

--- Patch [1]: [PATCH v3 1/6] mm/migrate_device: Clear stale mapping after =
freeing swapcache ---
commit 36bc19904d5fb8100fc812248c9247ad225d6ebe
Author: Arvind Yadav <arvind.yadav@intel.com>

mm/migrate_device: Clear stale mapping after freeing swapcache

This commit fixes a bug in __migrate_device_pages() where a stale mapping
is used after a folio is removed from the swap cache. It refreshes the
mapping via folio_mapping() and resets 'nr' to 1 after a successful folio
split to process the resulting order-0 folios independently.

> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -1193,6 +1193,13 @@ static void __migrate_device_pages(unsigned long *=
src_pfns,
>  							 MIGRATE_PFN_COMPOUND);
>  					goto next;
>  				}
> +
> +				/*
> +				 * reset nr so that only first after-split folio
> +				 * is processed below
> +				 */
> +				VM_WARN_ON_ONCE(folio_test_large(folio));
> +				nr =3D 1;
>  			} else if ((src_pfns[i] & MIGRATE_PFN_MIGRATE) &&
>  				(dst_pfns[i] & MIGRATE_PFN_COMPOUND) &&
>  				!(src_pfns[i] & MIGRATE_PFN_COMPOUND)) {
>  				src_pfns[i] &=3D ~MIGRATE_PFN_MIGRATE;

[Severity: High]
This is a pre-existing issue, but does this error path in
__migrate_device_pages() miss a goto next statement?

When a non-compound source page is paired with a compound destination page,
the code correctly clears the MIGRATE_PFN_MIGRATE flag to abort the
migration, but it falls through instead of skipping to the next iteration.

Without a goto next, execution continues to the unconditional page cache
migration loop at the bottom of the function. This calls
folio_migrate_mapping(), which moves the page cache state to the new folio.

Later, because MIGRATE_PFN_MIGRATE was cleared, migrate_vma_finalize() will
restore the CPU page tables to map the old source page. Will this cause data
corruption by desynchronizing the CPU page tables from the page cache?

>  			}
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805231041.3791=
771-1-matthew.brost@intel.com?part=3D1
