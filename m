Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E86C5518F
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 08:41:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB02310E149;
	Tue,  4 Aug 2026 08:41:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L4rJGvy+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A300210E149
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 08:41:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 21552600AA;
 Tue,  4 Aug 2026 08:41:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5591F000E9;
 Tue,  4 Aug 2026 08:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785832882;
 bh=EtJtE0aRyIXj2dH1ztnuLIqWkMGTh4BW+jkeUkdvjmo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=L4rJGvy+UdAgYOgSPFfWUlTWKeBsFoKICsYpJRZ1w/cB8fe7OU2UN8T9UtONfzZY5
 cZkhvdkHmR/wNjmvGjrL27FDOKqKr0kV6yRnVkW83zr8ZYZpvTypxqAxdZQ5jiTRpY
 V6OqFTRvnDH5r+c5h1r17RoyLW4FRf3RcHcf7ah6TRQzOd4oui2jQiszaW8jhYDi6D
 28WQ3fgmWg0YOFAjmPBN1El9cFyfT3aKj5CT+C9Nfwd36KhobFA1gxxTWg1cRF4Rz7
 KSiA4Hp5YnX9pWDZLS5HEUmcxS4XsGU5M7KAyWrfaYbbjzO5sb8omZsNrc+Nw+FGDn
 XcYrbIW6iMjhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/6] cgroup/dmem: Add queries for protection values
To: "Natalie Vock" <natalie.vock@gmx.de>
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260804-dmemcg-aggressive-protect-v8-1-07af96681bf8@gmx.de>
References: <20260804-dmemcg-aggressive-protect-v8-0-07af96681bf8@gmx.de>
 <20260804-dmemcg-aggressive-protect-v8-1-07af96681bf8@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 08:41:18 +0000
Message-Id: <20260804084122.7B5591F000E9@smtp.kernel.org>
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

New issues:
- [High] Missing ancestry check can result in using stale protection values=
 for non-descendants.

Pre-existing issues:
- [High] O(N) cgroup tree traversal per isolated query causes massive overh=
ead on eviction paths.
--

--- Patch [1]: [PATCH v8 1/6] cgroup/dmem: Add queries for protection value=
s ---
commit def4bae1e53d26c789e6edbd5c551a0f50ade339
Author: Natalie Vock <nat@pixelcluster.dev>

cgroup/dmem: Add queries for protection values
   =20
Callers can use this feedback to be more aggressive in making space for
allocations of a cgroup if they know it is protected.
   =20
These are counterparts to memcg's mem_cgroup_below_{min,low}.

> diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
> index 39930c59cb769..9df3b33c65046 100644
> --- a/kernel/cgroup/dmem.c
> +++ b/kernel/cgroup/dmem.c

[ ... ]

> @@ -700,6 +700,68 @@ int dmem_cgroup_try_charge(struct dmem_cgroup_region=
 *region, u64 size,
>  }
>  EXPORT_SYMBOL_GPL(dmem_cgroup_try_charge);
> =20
> +/**
> + * dmem_cgroup_below_min() - Tests whether current usage is within min l=
imit.
> + *
> + * @root: Root of the subtree to calculate protection for, or NULL to ca=
lculate global protection.
> + * @test: The pool to test the usage/min limit of.
> + *
> + * Return: true if usage is below min and the cgroup is protected, false=
 otherwise.
> + */
> +bool dmem_cgroup_below_min(struct dmem_cgroup_pool_state *root,
> +			   struct dmem_cgroup_pool_state *test)
> +{
> +	if (root =3D=3D test || !pool_parent(test))
> +		return false;
> +
> +	if (!root) {
> +		for (root =3D test; pool_parent(root); root =3D pool_parent(root))
> +			{}
> +	}
> +
> +	/*
> +	 * In mem_cgroup_below_min(), the memcg pendant, this call is missing.
> +	 * mem_cgroup_below_min() gets called during traversal of the cgroup tr=
ee, where
> +	 * protection is already calculated as part of the traversal. dmem cgro=
up eviction
> +	 * does not traverse the cgroup tree, so we need to recalculate effecti=
ve protection
> +	 * here.
> +	 */
> +	dmem_cgroup_calculate_protection(root, test);

[Severity: High]
This isn't a bug introduced by this patch, but does calling=20
dmem_cgroup_calculate_protection() here for isolated per-item queries cause=
=20
massive overhead on eviction paths?

Looking at the pre-existing dmem_cgroup_calculate_protection() implementati=
on:

kernel/cgroup/dmem.c:dmem_cgroup_calculate_protection() {
    ...
    css_for_each_descendant_pre(css, &limit_pool->cs->css) {
        ...
        page_counter_calculate_protection(climit, &found_pool->cnt, true);

        if (found_pool =3D=3D test_pool)
            break;
    }
    ...
}

It performs a top-down pre-order traversal starting from root. When root is=
=20
NULL and falls back to the global root, it forces a traversal over almost t=
he=20
entire system's cgroups. Executing this full subtree walk repeatedly during=
=20
eviction scanning could lead to severe performance degradation.

> +	return page_counter_read(&test->cnt) <=3D READ_ONCE(test->cnt.emin);

[Severity: High]
If the caller passes a root and a test pool where test is not a descendant=
=20
of root, dmem_cgroup_calculate_protection() will iterate only the descendan=
ts=20
of root, never find test, and exit without updating test->cnt.emin.

Could this cause the function to read a stale emin value from a prior=20
calculation and incorrectly return true, incorrectly shielding the cgroup=20
from eviction?

Since dmem uses global lists and doesn't have per-cgroup LRUs, encountering=
=20
non-descendants during eviction seems likely. Would it be safer to verify=20
that test is a descendant of root and return false otherwise?

> +}
> +EXPORT_SYMBOL_GPL(dmem_cgroup_below_min);
> +
> +/**
> + * dmem_cgroup_below_low() - Tests whether current usage is within low l=
imit.
> + *
> + * @root: Root of the subtree to calculate protection for, or NULL to ca=
lculate global protection.
> + * @test: The pool to test the usage/low limit of.
> + *
> + * Return: true if usage is below low and the cgroup is protected, false=
 otherwise.
> + */
> +bool dmem_cgroup_below_low(struct dmem_cgroup_pool_state *root,
> +			   struct dmem_cgroup_pool_state *test)
> +{
> +	if (root =3D=3D test || !pool_parent(test))
> +		return false;
> +
> +	if (!root) {
> +		for (root =3D test; pool_parent(root); root =3D pool_parent(root))
> +			{}
> +	}
> +
> +	/*
> +	 * In mem_cgroup_below_low(), the memcg pendant, this call is missing.
> +	 * mem_cgroup_below_low() gets called during traversal of the cgroup tr=
ee, where
> +	 * protection is already calculated as part of the traversal. dmem cgro=
up eviction
> +	 * does not traverse the cgroup tree, so we need to recalculate effecti=
ve protection
> +	 * here.
> +	 */
> +	dmem_cgroup_calculate_protection(root, test);
> +	return page_counter_read(&test->cnt) <=3D READ_ONCE(test->cnt.elow);

[Severity: High]
Similarly to dmem_cgroup_below_min() above, does this missing ancestry chec=
k=20
also expose dmem_cgroup_below_low() to using stale elow protection values i=
f=20
test is not a descendant of root?

> +}
> +EXPORT_SYMBOL_GPL(dmem_cgroup_below_low);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804-dmemcg-agg=
ressive-protect-v8-0-07af96681bf8@gmx.de?part=3D1
