Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52134C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 23:25:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A91E810E260;
	Wed,  5 Aug 2026 23:25:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bRconQYU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B3AA10F02A
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 23:25:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C3E2C40B09;
 Wed,  5 Aug 2026 23:25:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7C51F000E9;
 Wed,  5 Aug 2026 23:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785972305;
 bh=eaPZYR+2d7nXJL5wBhFi+nwuzzBJVpXGrBtP/r1BT1k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bRconQYUPmGqBXb/5v82hqlcn5teQAuO/HwVa+lQZpi/bptZeWhPaCnJ0IjyZ0Kip
 LT4BIsgnFju/XBhR4qkMOrtFNgdUwDga2pYdHqwKTSZva08W7H54y/DKhwdapwTqc3
 y+nBVES2AWctu6n6SAUBua892pmpdvSr2prewltI1S0qxUA7GpNUteE1LI6WtgA4ep
 zZI3SFaOrqrcLwNK1POhrPc0NoD+1xgtYu0xWeswkZw48yj165//2tqs8W1+NnUcJd
 7w2Bk4kxk6Z+DApIDb5i88kvOtf8L3GlxMUtq3/id9vw2i26m/lyEiu1H7PbIfKZOP
 Qbr5XDcKWvtCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/6] mm/migrate_device: Do not write past the end of
 the src_pfns array
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260805231041.3791771-3-matthew.brost@intel.com>
References: <20260805231041.3791771-1-matthew.brost@intel.com>
 <20260805231041.3791771-3-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 23:25:04 +0000
Message-Id: <20260805232505.7C7C51F000E9@smtp.kernel.org>
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
- [High] Unsafe speculative read of `folio_nr_pages(folio)` without lock su=
ccess check leads to array corruption and PFN iterator overshoot.
- [High] `migrate_device_pfns()` corrupts non-contiguous caller arrays by i=
ndiscriminately zeroing elements when encountering a compound page.
--

--- Patch [2]: [PATCH v3 2/6] mm/migrate_device: Do not write past the end =
of the src_pfns array ---
commit f29e7afad950b0af66d7edea5f1c3b8203675195
Author: Matthew Brost <matthew.brost@intel.com>

mm/migrate_device: Do not write past the end of the src_pfns array

migrate_device_range() and migrate_device_pfns() zero the tail entries
of a large folio without checking them against @npages. This commit bounds
the loop by @npages to prevent corrupting whatever follows the array.

> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index 9a346162c6881..e1a18d291b9c1 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -1425,7 +1425,7 @@ int migrate_device_range(unsigned long *src_pfns, u=
nsigned long start,

[ ... ]

>  		src_pfns[i] =3D migrate_device_pfn_lock(pfn);
>  		nr =3D folio_nr_pages(folio);
>  		if (nr > 1) {

[Severity: High]
This isn't a bug introduced by this patch, but does this code speculatively
read the folio size even if the lock fails?

If migrate_device_pfn_lock() fails (e.g., due to a concurrent free or split=
),
folio_nr_pages(folio) accesses unstable memory, yielding a garbage nr. This
can cause unbounded iterator advancement and arbitrary zeroing of src_pfns.

Additionally, if the PFN is a tail page, the lock correctly fails, but
folio_nr_pages() reads the head page's size and advances pfn +=3D nr - 1,
overshooting the end of the folio and silently skipping unrelated PFNs in t=
he
migration range.

Should there be a check to ensure src_pfns[i] indicates a successful lock
before reading the folio size?

>  			src_pfns[i] |=3D MIGRATE_PFN_COMPOUND;
> -			for (j =3D 1; j < nr; j++)
> +			for (j =3D 1; j < nr && (i + j) < npages; j++)
>  				src_pfns[i+j] =3D 0;
>  			i +=3D j - 1;
>  			pfn +=3D j - 1;
> @@ -1459,7 +1459,7 @@ int migrate_device_pfns(unsigned long *src_pfns, un=
signed long npages)

[ ... ]

>  		src_pfns[i] =3D migrate_device_pfn_lock(src_pfns[i]);
>  		nr =3D folio_nr_pages(folio);
>  		if (nr > 1) {

[Severity: High]
This is also a pre-existing issue, but is it safe to read the folio size
here without confirming that migrate_device_pfn_lock() succeeded, similar to
the issue in migrate_device_range() above?

>  			src_pfns[i] |=3D MIGRATE_PFN_COMPOUND;
> -			for (j =3D 1; j < nr; j++)
> +			for (j =3D 1; j < nr && (i + j) < npages; j++)
>  				src_pfns[i+j] =3D 0;

[Severity: High]
This is a pre-existing issue, but does this zeroing logic break support for
non-contiguous PFN arrays?

migrate_device_pfns() documents that it supports non-contiguous pre-populat=
ed
arrays of device pages to migrate. However, when it encounters a compound
page, it reuses the large-folio iteration logic and zeroes out the next
nr - 1 elements.

In a non-contiguous array, these subsequent elements are independent,
unrelated PFNs provided by the caller, which would be overwritten
and excluded from migration.

>  			i +=3D j - 1;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805231041.3791=
771-1-matthew.brost@intel.com?part=3D2
