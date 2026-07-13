Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6826C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 10:10:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09B5A10E5C1;
	Mon, 13 Jul 2026 10:10:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bOV+cvbV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6815810E5C1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 10:10:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1207142ACD;
 Mon, 13 Jul 2026 10:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4071F000E9;
 Mon, 13 Jul 2026 10:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783937416;
 bh=vdzv038uPx+ls31ZghUpbhvnxpvgPMeyodb9zZIlNn0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bOV+cvbVu6OP6FAHv+PYjTAeEXBkYpr04DkpywRv7Rly+EL34VZoclp3xRSR+TYXW
 +AlQsrwRTCpwWnv6GRVdBl/qgt8c1CrFQeNj0LMtpGgQjkbL5nSyABSWYKRuS7BbAh
 LSn0TxKCllRk+DlTObbNs5RtdMeiNjrYFK1EZ0AVOs5sT+VCuckT1AY8QX3ezXrN2i
 L/y8T9coQCGRBS6GKQulbDTMVKBPvkYjaEqx4YDx++hAZHAK5dwNrKMxsk0xyDTDtw
 AlEb2Z3HfYoMBK78o+YlczqlLqjs0H4oqkwk8WbI9L8XULI/10UGo/WqC1+XiofJR4
 g3DxlTAgHmqRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] drm/i915/gem: Read and shrink memory in a
 separate function
To: "Krzysztof Karas" <krzysztof.karas@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260713095812.1014365-5-krzysztof.karas@intel.com>
References: <20260713095812.1014365-1-krzysztof.karas@intel.com>
 <20260713095812.1014365-5-krzysztof.karas@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 10:10:15 +0000
Message-Id: <20260713101015.BF4071F000E9@smtp.kernel.org>
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
- [Medium] Unnecessary double execution of the memory shrinker on the alloc=
ation failure path.
--

--- Patch [4]: [PATCH v3 4/5] drm/i915/gem: Read and shrink memory in a sep=
arate function ---
commit 323006b149f5bd15e61d31522a7aa9cdbf860e09
Author: Krzysztof Karas <krzysztof.karas@intel.com>

drm/i915/gem: Read and shrink memory in a separate function

This commit extracts the memory reading and shrinking logic from
shmem_sg_alloc_table into a new shmem_shrink_get_folio helper. It also
replaces the previous array-based iteration with a do-while loop.

> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/=
i915/gem/i915_gem_shmem.c
> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
[ ... ]
> @@ -78,6 +78,55 @@ static int validate_size(size_t size, unsigned int pag=
e_count,
>  	return 0;
>  }
> =20
> +static struct folio *shmem_shrink_get_folio(struct address_space *mappin=
g,
> +					    unsigned long folio_index,
> +					    gfp_t gfp, unsigned int page_count,
> +					    struct drm_i915_private *i915)
> +{
> +	struct folio *folio =3D NULL;
> +	unsigned int retries =3D 2;
> +
> +	do {
> +		cond_resched();
> +		folio =3D shmem_read_folio_gfp(mapping, folio_index, gfp);
> +		if (IS_ERR(folio)) {
> +			i915_gem_shrink(NULL, i915, 2 * page_count, NULL,
> +					I915_SHRINK_BOUND | I915_SHRINK_UNBOUND);

[Severity: Medium]
Will this result in an unnecessary double execution of the memory shrinker
when allocations fail?

In the original code, the array-based state machine checked the shrink state
and jumped to the error path before calling i915_gem_shrink again on the
final failure. With the refactored do-while loop, if the second
shmem_read_folio_gfp call fails, the loop unconditionally executes the
shrinker a second time before decrementing the retries counter to 0 and
exiting.

Could this waste CPU cycles and increase lock contention on i915->mm.obj_lo=
ck
immediately before returning -ENOMEM to the caller, considering the memory
freed by this second pass is completely ignored?

> +
> +			/*
> +			 * We've tried hard to allocate the memory by reaping
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713095812.1014=
365-1-krzysztof.karas@intel.com?part=3D4
