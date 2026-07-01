Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95852C43602
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 14:38:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9521510E4C1;
	Wed,  1 Jul 2026 14:38:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B6xyVSEr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E740A10E3B1;
 Wed,  1 Jul 2026 14:38:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2464D60138;
 Wed,  1 Jul 2026 14:38:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9A51F000E9;
 Wed,  1 Jul 2026 14:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782916703;
 bh=FCJc8Y4JmEOreL4L+vTlFLlPE/nMLhzyI1DM8YdqDxY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=B6xyVSErGQCC8QTMJYXKkOjLc7Mv9Rv2B6Ifr7ClnfKg36JsUPDYDajR/pLRNaXuJ
 8DIyBokdUdMBU6UbRRrEdjbUWCytV2AxOQuI6NViO5B4xKkDxo7+9Qi0Iu4MCoqBH2
 Nkew2CpAno/k2fyqTTt57p8FX+zsY0EWkxmv6+Gz5+BZOkiCytNHyIWS9xPtXj2CO6
 pKKfgW0Fg4Yr+G9SlUm2vb5zyzayQ2C+Xb1OI4EjEKGu6z3hqR2aWEFDQZ7DopzOUW
 bGTNsAD8D6mgksC/d2TZbjZG97hJH+jsP67CDPe6n7TARhzTc/YcrL9t6o5K9WNTsN
 OL/pwav2TNtSg==
Date: Wed, 1 Jul 2026 16:38:11 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 iommu@lists.linux.dev, Andi Shyti <andi.shyti@linux.intel.com>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 =?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, 
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v2 1/3] drm/i915/gem: split shared memory allocation
 table logic
Message-ID: <akUibf3NyThHnXco@zenone.zhora.eu>
References: <20260701104437.236979-1-krzysztof.karas@intel.com>
 <20260701104437.236979-2-krzysztof.karas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701104437.236979-2-krzysztof.karas@intel.com>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi Krzysztof,

On Wed, Jul 01, 2026 at 10:44:35AM +0000, Krzysztof Karas wrote:
> shmem_sg_alloc_table is a complex and hard to read function.
> Split its logic into smaller pieces to improve readability and
> reduce indentation. Change the main "for" loop into "while" to
> get rid of obscure iterator "i" and be more explicit in
> traversing scatterlist.

any chance we can split this cleanup into smaller pieces?

> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>

...

> +static struct folio *shmem_shrink_get_folio(struct address_space *mapping,
> +					    unsigned long folio_index,
> +					    gfp_t gfp, unsigned int pages_left,
> +					    struct drm_i915_private *i915)
> +{
> +#define MAX_READS 2

This MAX_READS here is very ugly! Just use 2 and explain it in a
comment. In the 'if' below you can check out of "if (... || i)"
and still explain it in a comment.

> +	struct folio *folio;
> +	unsigned int i;
> +
> +	for (i = 0; i < MAX_READS; i++) {
> +		cond_resched();
> +		folio = shmem_read_folio_gfp(mapping, folio_index, gfp);
> +		if (!IS_ERR(folio) || i == MAX_READS - 1)
> +			return folio;
> +
> +		i915_gem_shrink(NULL, i915, 2 * pages_left, NULL,

/pages_left/page_count/

> +				I915_SHRINK_BOUND | I915_SHRINK_UNBOUND);
> +

...

> +	}
> +
> +	/* Should never happen */
> +	WARN_ON_ONCE(1);

no need.

Thanks,
Andi

> +	return ERR_PTR(-EINVAL);
> +}
