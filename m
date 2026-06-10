Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B3ECD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 06:14:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7670810E726;
	Wed, 10 Jun 2026 06:14:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A1THewnx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B124A10E726
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 06:14:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 55CF543BF0;
 Wed, 10 Jun 2026 06:14:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E101F00893;
 Wed, 10 Jun 2026 06:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781072090;
 bh=LwEtjbt+fVZRH2irA1fywaLkHi+Gxek9gTc8ICn3QkU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=A1THewnxeew30+mYSKn1fy5Gx1I3UQmfDVHvhaqSDq32QtsMN4TXS5o5qo9TqzuWW
 OwixwCP3tmMeVd4uGV5RNe7eycQ384mcvE5RtsDElDPvg+B9rqEQdWaSll4dezQCUo
 ZCWMmDCfie6WikH7fo/oLJxuBNLAl5noUw7q0zIxqqgp2hKNqsZC5nTlMT4gZF1aup
 HV4Q3/HQ8D/yo02KOFf5n0nEt+oqKipfdx7Ficw6aR2N4VVzCMV5FiAZZDzOJ16VRl
 24fwA0K01jN8MyBrQ24V5fy1naKmDgBs4mHlaU4qjTfebC3z2ONjLm7RNGt24MVC8z
 y3Mbh3mmezulA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915/gem: Fix phys BO pread/pwrite with offset
To: "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260610060314.26111-1-joonas.lahtinen@linux.intel.com>
References: <20260610060314.26111-1-joonas.lahtinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 06:14:49 +0000
Message-Id: <20260610061450.13E101F00893@smtp.kernel.org>
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
- [Critical] Integer overflow in `roundup_pow_of_two` on 32-bit systems cau=
ses a massive heap buffer overflow when allocating physically contiguous pa=
ges for large objects.
--

commit bdaf5470cc890b63dd50b4ef6b0bd2b13dcdaa7b
Author: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

drm/i915/gem: Fix phys BO pread/pwrite with offset

This commit fixes a scaling issue in phys BO pread/pwrite when using
non-zero offsets. It updates the code to correctly access the struct
page pointers via scatterlist abstractions instead of void pointers.

> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_phys.c b/drivers/gpu/drm/i=
915/gem/i915_gem_phys.c
> index e375afbf458ee..d53129eb56030 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_phys.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_phys.c

[ ... ]

> @@ -58,7 +69,7 @@ static int i915_gem_object_get_pages_phys(struct drm_i9=
15_gem_object *obj)
>  	sg->offset =3D 0;
>  	sg->length =3D obj->base.size;
> =20
> -	sg_assign_page(sg, (struct page *)vaddr);
> +	__set_phys_vaddr(sg, vaddr);

[Severity: Critical]
This is a pre-existing issue, but does the dma_alloc_coherent() allocation
earlier in this function overflow on 32-bit systems?

Looking at i915_gem_object_get_pages_phys(), we allocate memory using:

    vaddr =3D dma_alloc_coherent(obj->base.dev->dev,
                               roundup_pow_of_two(obj->base.size),
                               &dma, GFP_KERNEL);

If a user allocates a GEM object larger than 2GB (e.g., 0x80001000),
roundup_pow_of_two() calculates 1UL << fls_long(n - 1). On x86 32-bit,
shift amounts are masked to 5 bits, so 32 & 31 =3D 0, resulting in an
allocation size of 1 byte (which the allocator rounds up to PAGE_SIZE).

Later in the same function, a loop writes obj->base.size bytes into this
undersized buffer:

    for (i =3D 0; i < obj->base.size / PAGE_SIZE; i++) {
        struct page *page;

        page =3D shmem_read_mapping_page(mapping, i);
        if (IS_ERR(page))
            goto err_st;

        memcpy_from_page(dst, page, 0, PAGE_SIZE);
        drm_clflush_virt_range(dst, PAGE_SIZE);

        put_page(page);
        dst +=3D PAGE_SIZE;
    }

Can this cause a massive buffer overflow and corrupt physical memory when
handling large objects?

>  	sg_dma_address(sg) =3D dma;
>  	sg_dma_len(sg) =3D obj->base.size;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610060314.2611=
1-1-joonas.lahtinen@linux.intel.com?part=3D1
