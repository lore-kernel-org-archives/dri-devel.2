Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD143C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 10:19:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0562610F435;
	Thu, 24 Sep 2026 10:19:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UzlCm7eL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA88410F432
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 10:19:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CEFDC601EF;
 Thu, 24 Sep 2026 10:19:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380661F000FF;
 Thu, 24 Sep 2026 10:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790245168;
 bh=nuSQK0KGrBiN3Zx6hqBuheOEmTM+OywKkeE2rJ4Sths=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UzlCm7eLR/7fDo6d96CbFSSPOpI9GYYaO9jP7fGbbVAj41YB6bo3t0vnIVJwjK6EQ
 C0ykvNy2DqfaAsHK1fUjxbr+ywt4vvlaNcePdMT2A0YZ0rL3xjces8WlbWm6wb/OUs
 hwvf3Xc+X4tcpu5Nh1Uc4UgM77de4HAjpgpX2x4hE1tmTRQSCWbA44xsZul9NQwsnU
 7cppybhuQLUvvxJOJR0OBDzNg1IDG+Njvk/4HEY313b2BaWovrf5rPNuwqzzufe4Hu
 kCgwtZMpaokzPrjlSjxXzFPzBSygCD5MbwEfnxFTvY+0V07dSYn6IONyVs9gW70qgU
 KOizQW0HHtpHg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v8 04/14] irqchip/gic-v3-its: Allocate shared tables
 using CoCo shared memory allocator
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: "Oliver Upton" <oupton@kernel.org>, "Marc Zyngier" <maz@kernel.org>,
 kvmarm@lists.linux.dev, dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260924100529.1398790-5-aneesh.kumar@kernel.org>
References: <20260924100529.1398790-1-aneesh.kumar@kernel.org>
 <20260924100529.1398790-5-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 10:19:27 +0000
Message-Id: <20260924101928.380661F000FF@smtp.kernel.org>
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
- [High] irqchip/gic-v3-its: buddy allocator corruption due to discarded sh=
ared_size
--

commit d897529703a71c914b0334abcb563ffb37979469
Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

irqchip/gic-v3-its: Allocate shared tables using CoCo shared memory allocat=
or

This commit updates the ITS allocator to route page allocations through
alloc_cc_shared_pages_node(). It reconstructs common allocation metadata
from the original ITS order and the architecture granule size on release.

> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v=
3-its.c
> index ac5507acb1a0c..4814161df02ed 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c

[ ... ]

> @@ -214,25 +213,13 @@ static gfp_t gfp_flags_quirk;
>  static struct page *its_alloc_pages_node(int node, gfp_t gfp,
>  					 unsigned int order)
>  {
> -	struct page *page;
> -	int ret =3D 0;
> -
> -	page =3D alloc_pages_node(node, gfp | gfp_flags_quirk, order);
> -
> -	if (!page)
> -		return NULL;
> +	struct cc_shared_pages mem;
> =20
> -	ret =3D set_memory_decrypted((unsigned long)page_address(page),
> -				   1 << order);
> -	/*
> -	 * If set_memory_decrypted() fails then we don't know what state the
> -	 * page is in, so we can't free it. Instead we leak it.
> -	 * set_memory_decrypted() will already have WARNed.
> -	 */
> -	if (ret)
> +	if (alloc_cc_shared_pages_node(node, gfp | gfp_flags_quirk,
> +				       PAGE_SIZE << order, &mem))
>  		return NULL;
> =20
> -	return page;
> +	return mem.page;
>  }

[Severity: High]
Is it safe to discard mem.shared_size here? The API contract seems to requi=
re
callers to retain the true allocated size so it can be passed back when
freeing the pages.

>  static struct page *its_alloc_pages(gfp_t gfp, unsigned int order)
> @@ -242,13 +229,15 @@ static struct page *its_alloc_pages(gfp_t gfp, unsi=
gned int order)
> =20
>  static void its_free_pages(void *addr, unsigned int order)
>  {
> -	/*
> -	 * If the memory cannot be encrypted again then we must leak the pages.
> -	 * set_memory_encrypted() will already have WARNed.
> -	 */
> -	if (set_memory_encrypted((unsigned long)addr, 1 << order))
> +	struct cc_shared_layout layout;
> +	struct cc_shared_pages mem;
> +
> +	if (WARN_ON(cc_shared_calc_layout(PAGE_SIZE << order, &layout)))
>  		return;
> -	free_pages((unsigned long)addr, order);
> +
> +	mem.page =3D virt_to_page(addr);
> +	mem.shared_size =3D layout.shared_size;
> +	free_cc_shared_pages(&mem);
>  }

[Severity: High]
Does recalculating the size here cause a mismatch on non-CC platforms?

When memory encryption is disabled, alloc_cc_shared_pages_node() does not
round up the allocation to the granule size; it simply allocates the
requested order.

However, cc_shared_calc_layout() unconditionally rounds up to the
architectural granule size. If the granule size exceeds the requested
allocation size, free_cc_shared_pages() will call __free_pages() with a
higher order than was actually allocated. Can this corrupt the buddy
allocator by freeing unallocated pages?

>  static struct gen_pool *itt_pool;
> @@ -273,7 +262,8 @@ static void *itt_alloc_pool(int node, int size)
>  		if (!page)
>  			break;
> =20
> -		gen_pool_add(itt_pool, (unsigned long)page_address(page), PAGE_SIZE, n=
ode);
> +		gen_pool_add(itt_pool, (unsigned long)page_address(page),
> +			     cc_shared_granule_size(), node);
>  	} while (!addr);
> =20
>  	return (void *)addr;

[Severity: High]
Will adding a hardcoded granule size to the generic pool advertise unalloca=
ted
out-of-bounds memory to consumers?

On non-CC platforms, the underlying allocation size is just a single page,
but this adds the full cc_shared_granule_size() bytes to the pool. Could
this lead to pool consumers accessing memory beyond what was actually
allocated?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924100529.1398=
790-1-aneesh.kumar@kernel.org?part=3D4
