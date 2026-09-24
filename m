Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B41C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 10:19:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEDD410F439;
	Thu, 24 Sep 2026 10:19:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EQbFilMW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF13110F439
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 10:19:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 41F4A600AA;
 Thu, 24 Sep 2026 10:19:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D7F1F000FF;
 Thu, 24 Sep 2026 10:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790245186;
 bh=/gxa1IwjEcYJPW+usTwOk+STx1BGzePZXC02PrSy/PI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EQbFilMWFOx8gLbcg9xGAHKwo9MLJCRMLa705Fjc0ZhdXcJCxNw2ySTUmTXr7lI1N
 E47/pvNF0y1HkHScYRhdhvT1YNVD7+nK0rQTvGXpeBIyNX7qY2sZYKywLRiPDkyx6A
 uelkjIvzg0XCNuiSlGfPPyuN+yxxuwg+g++hKeHb0k4fVfjYjZTzYyaXHMJZ4NHtrt
 YcfiItbON1TYcdMU7zNwN+0svt/UapQOJoRxEPSRhhhL/5Po8kHBHAC2I4sBxjVE5Z
 neVb+DKdHuGRadn7wh5/W2OXDDh0AwVVW4mnv4yi1taTexgTWK3mk2WPoUiu39S5WA
 nKSNzU+jSxNZg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v8 06/14] dma-pool: Allocate CoCo atomic pools using
 CoCo shared memory allocator
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: "Marc Zyngier" <maz@kernel.org>, dri-devel@lists.freedesktop.org,
 media-ci@linuxtv.org, kvmarm@lists.linux.dev, "Oliver
 Upton" <oupton@kernel.org>
In-Reply-To: <20260924100529.1398790-7-aneesh.kumar@kernel.org>
References: <20260924100529.1398790-1-aneesh.kumar@kernel.org>
 <20260924100529.1398790-7-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 10:19:45 +0000
Message-Id: <20260924101945.95D7F1F000FF@smtp.kernel.org>
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
- [High] dma-pool: atomic_pool_expand() falsely returns success on failure
--

commit 7de8bc3a8ea9e2bbef83e09d72fa88999ce898b9
Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

dma-pool: Allocate CoCo atomic pools using CoCo shared memory allocator

This commit modifies atomic DMA pools to use the CoCo shared memory allocat=
or.
It prevents allocation fallback below the required shared granule size, and
uses the cc_make_shared() helper to transition the backing allocations in a
sleepable context.

> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 70b7f64b17ab5..f059312c15aa5 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
[ ... ]
> @@ -85,6 +85,9 @@ static bool cma_in_zone(gfp_t gfp)
>  static int atomic_pool_expand(struct dma_gen_pool *dma_pool, size_t pool=
_size,
>  			      gfp_t gfp)
>  {
> +	struct cc_shared_layout layout;
> +	unsigned long attrs =3D 0;
> +	unsigned int min_order =3D 0;
>  	unsigned int order;
>  	struct page *page =3D NULL;
>  	bool leak_pages =3D false;
> @@ -92,6 +95,17 @@ static int atomic_pool_expand(struct dma_gen_pool *dma=
_pool, size_t pool_size,
>  	int ret =3D -ENOMEM;
>  	pgprot_t prot __maybe_unused;
> =20
> +	if (dma_pool->cc_shared) {
> +		ret =3D cc_shared_calc_layout(pool_size, &layout);
> +		if (ret)
> +			goto out;

[Severity: High]
If cc_shared_calc_layout() succeeds, it returns 0 and overwrites the initial
ret =3D -ENOMEM. Could this cause the function to falsely return 0 (success=
) on
subsequent failures?

For instance, if page allocation fails below, the function jumps to out and
returns the current value of ret:

    if (!page)
        goto out;

Similarly, if remapping fails later in the function:

    addr =3D dma_common_contiguous_remap(...)
    if (!addr)
        goto free_page;

In both cases, ret will be 0 instead of -ENOMEM. Would it be better to reset
ret back to -ENOMEM when these failures occur, or use a separate variable
for the cc_shared_calc_layout() return value?

> +		pool_size =3D layout.shared_size;
> +		min_order =3D get_order(layout.alignment);
> +		if (min_order > MAX_PAGE_ORDER)
> +			return -E2BIG;
> +		attrs =3D __DMA_ATTR_ALLOC_CC_SHARED;
> +	}
> +
>  	/* Cannot allocate larger than MAX_PAGE_ORDER */
>  	order =3D min(get_order(pool_size), MAX_PAGE_ORDER);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924100529.1398=
790-1-aneesh.kumar@kernel.org?part=3D6
