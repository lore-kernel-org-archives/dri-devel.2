Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B60C61DB4
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 09:44:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 908FC10E9A4;
	Tue, 25 Aug 2026 09:44:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bj11CIik";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC11110E9A0;
 Tue, 25 Aug 2026 09:44:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CE52D6011F;
 Tue, 25 Aug 2026 09:44:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F40A1F000E9;
 Tue, 25 Aug 2026 09:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787651040;
 bh=qlDbenrtidB9/Swr/C29SgEfVeLDeeV6QcTyC/WMrlQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bj11CIikUzj8sPmOKTNewYI5GuCqmc8OhljN/X6/fjRZ47zK1hbMFkYGjQvo9gpDY
 jn0sS5HaB7AjIX60LkY1PM0QilyfJ2NVfVh5sKXlYUv7it9HiHJIvriEPoT7IXA+zO
 ZrYCNoJ4UHjTiZgZRlDHkZ7brpEW74lsQD+F4Tcn0FVCl/LcXDs+rV1uJ9vE9dVvj5
 yERH22BC1uvQzIbFnqSJ/5d+6NJnSOGjrrZhG5eZ834MOsX0q3DpgE8YiHMJDXK4H4
 NM5kOQsgFWgwrLTu3NZmuy3aXCjTWYtnEF6ocYn7EmxAr7Fj4ruxPAibN3bczZfA6k
 yl727e/GwbY1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/1] drm/i915/gem: Use simpler versions of min*()
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
In-Reply-To: <20260825093552.4088094-1-andriy.shevchenko@linux.intel.com>
References: <20260825093552.4088094-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 09:43:59 +0000
Message-Id: <20260825094400.4F40A1F000E9@smtp.kernel.org>
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
- [High] Data corruption when splitting large folios into multiple scatterl=
ist segments due to small max_segment size.
--

--- Patch [1]: [PATCH v1 1/1] drm/i915/gem: Use simpler versions of min*() =
---
commit a3571cfa95156ba739dd7334aec0101cdc3aa63e
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

drm/i915/gem: Use simpler versions of min*()

This commit replaces the harder-to-read min_array() and min_t()=20
with min3() and min() in shmem_sg_alloc_table(). No functional=20
changes are intended.

> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/=
i915/gem/i915_gem_shmem.c
> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> @@ -153,11 +153,8 @@ int shmem_sg_alloc_table(struct drm_i915_private *i9=
15, struct sg_table *st,
>  			}
>  		} while (1);
> =20
> -		nr_pages =3D min_array(((unsigned long[]) {
> -					folio_nr_pages(folio),
> -					page_count - i,
> -					max_segment / PAGE_SIZE,
> -				      }), 3);
> +		nr_pages =3D min3(folio_nr_pages(folio),
> +				page_count - i, max_segment / PAGE_SIZE);

[Severity: High]
This is a pre-existing issue, but does this correctly calculate the availab=
le
pages for a large folio?

It looks like folio_nr_pages(folio) uses the total folio size rather than t=
he
remaining size from the current offset (e.g. folio_nr_pages(folio) - (i -
folio->index)).

> =20
>  		if (!i ||
>  		    sg->length >=3D max_segment ||
> @@ -168,8 +165,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i91=
5, struct sg_table *st,
>  			st->nents++;
>  			sg_set_folio(sg, folio, nr_pages * PAGE_SIZE, 0);

[Severity: High]
This isn't a bug introduced by this patch, but can this hardcoded offset of=
 0
corrupt data when splitting large folios?

When a GEM object backed by shmem memory receives a large folio and the
IOMMU's max_segment is smaller than the large folio size, this restricts
nr_pages to the segment size.=20

In the next iteration, i advances into the middle of the large folio, and
shmem_read_folio_gfp() returns the same head folio. The code evaluates
folio_pfn(folio) !=3D next_pfn as true (since next_pfn advanced but
folio_pfn still points to the head) and calls sg_set_folio() again.=20

Because the offset is hardcoded to 0, it appears the GPU will repeatedly map
the first max_segment bytes of the large folio rather than its subsequent
pages, causing the GPU and CPU memory views to become desynchronized.

>  		} else {
> -			nr_pages =3D min_t(unsigned long, nr_pages,
> -					 (max_segment - sg->length) / PAGE_SIZE);
> +			nr_pages =3D min(nr_pages, (max_segment - sg->length) / PAGE_SIZE);
> =20
>  			sg->length +=3D nr_pages * PAGE_SIZE;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825093552.4088=
094-1-andriy.shevchenko@linux.intel.com?part=3D1
