Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F8BCDE000
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 13:54:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 592D810F2C5;
	Thu, 25 Jun 2026 13:54:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gjOopAek";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B548310F2C5
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 13:54:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8B793444BB;
 Thu, 25 Jun 2026 13:54:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486191F000E9;
 Thu, 25 Jun 2026 13:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782395666;
 bh=ErZmuu3/Q6K8n89RALBsr2PeZG3zvpcZxP2fNszgbcw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gjOopAek99Gjh2PXPBXAw648Pig2VYPwqIsMaiZ3LMkSXOyVmt/qoZVU8dgG7SrLP
 SN6OKanKrmMYsPSqw1U0KUqEly1AtUJQl9AbLhd1ke3qR7fDx099gUufOcuWn9tiNe
 7DhtDIEjJBNksitn6rYp20T/tB3UOD2F/BV8RbE+xaNa+SptUshwuiZXnwxEZSKCsG
 ddvJxrGYMVOhSijUsybmRYVkCioKkD8mPMWGnK3sO+T6cn9g6N2/SG+NMJdtV9pG65
 ty3WCdCEvgUPxbvdsEaNvD++tUCHGQ+3suhg+v8NPYrQhRaEctYfKMKbTJp/uiGh8W
 ySHxgRs1pxSoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] drm/i915/gem: split shared memory allocation table
 logic
To: "Krzysztof Karas" <krzysztof.karas@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625134342.1102921-3-krzysztof.karas@intel.com>
References: <20260625134342.1102921-1-krzysztof.karas@intel.com>
 <20260625134342.1102921-3-krzysztof.karas@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 13:54:25 +0000
Message-Id: <20260625135426.486191F000E9@smtp.kernel.org>
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
- [Low] Unreachable WARN_ON_ONCE and error return in `shmem_shrink_get_foli=
o`.
--

commit fe135bc87bdc96f8bc699495fde11dd752239633
Author: Krzysztof Karas <krzysztof.karas@intel.com>

drm/i915/gem: split shared memory allocation table logic

This commit factors out the scatterlist allocation logic in
shmem_sg_alloc_table into smaller helper functions. It introduces
shmem_shrink_get_folio and validate_size, while changing the main loop
structure to improve readability.

> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/=
i915/gem/i915_gem_shmem.c
> index 06543ae60706e..b5ae7e5f80a06 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
[ ... ]
> +static struct folio *shmem_shrink_get_folio(struct address_space *mappin=
g,
> +					    unsigned long folio_index,
> +					    gfp_t gfp, unsigned int pages_left,
> +					    struct drm_i915_private *i915)
> +{
> +#define MAX_READS 2
> +	struct folio *folio;
> +	unsigned int i;
> +
> +	for (i =3D 0; i < MAX_READS; i++) {
> +		cond_resched();
> +		folio =3D shmem_read_folio_gfp(mapping, folio_index, gfp);
> +		if (!IS_ERR(folio) || i =3D=3D MAX_READS - 1)
> +			return folio;
[ ... ]
> +		gfp |=3D __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
> +	}
> +
> +	/* Should never happen */
> +	WARN_ON_ONCE(1);
> +	return ERR_PTR(-EINVAL);
> +}

[Severity: Low]
Is this code unreachable?

Looking at the loop termination logic above, the for loop will either exit
early when !IS_ERR(folio) is true, or it will return directly on the final
iteration when i =3D=3D MAX_READS - 1. Because it always returns from withi=
n the
loop body, it never falls through to the end of the function.

Does this WARN_ON_ONCE and error return serve an intended purpose, or can it
be safely removed as dead code?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625134342.1102=
921-1-krzysztof.karas@intel.com?part=3D2
