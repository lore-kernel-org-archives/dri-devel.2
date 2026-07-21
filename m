Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28188C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 19:55:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AF7D10E09D;
	Tue, 21 Jul 2026 19:55:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bXPvp2L/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D9DC10E09D
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 19:55:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5B2DB601D9;
 Tue, 21 Jul 2026 19:55:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41021F00A3D;
 Tue, 21 Jul 2026 19:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784663744;
 bh=77fJnBbxoM3j0kokXx3cUOJACQZCdRbuSCR+Ix+lJns=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bXPvp2L/5uM23Spvo4+aSFqrJHATnn4CDAwAgtGvrGuoHJea2aQv/b46Tc73LLN80
 bdLkPYvtGiruUjm4Zgei5II46wm49BujrNyxMk0jx1HkINkz1u03Cz+XKeA+Tp2IuZ
 sVlicQz5jarrZj6Zn03wdJrdPPYaoFLKaRl8WHKXE3R/gsuPAYdH6VKMlyLQZfaPVS
 7gE46NHm5HLjMJIdMj8Os6QVzXJrWQiEdR4m/V+nrqu3/zeVt+StKXk37fWo26dfgY
 dk5uYpnM0gkB/fzIv69E38ibnn55hM6mKFmqhfJN4HPCqffhXeQPpvVVkTTsMGf5q3
 1X0NfmQfNwN+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/6] cgroup,cgroup/dmem: Add
 (dmem_)cgroup_common_ancestor helper
To: "Natalie Vock" <natalie.vock@gmx.de>
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260721-dmemcg-aggressive-protect-v7-2-97c4b1014315@gmx.de>
References: <20260721-dmemcg-aggressive-protect-v7-0-97c4b1014315@gmx.de>
 <20260721-dmemcg-aggressive-protect-v7-2-97c4b1014315@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 19:55:43 +0000
Message-Id: <20260721195543.C41021F00A3D@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Refcount underflow and use-after-free due to unbalanced css_put() =
when css_tryget() fails.
- [High] Resource leak and poisoned pointer return caused by unhandled ERR_=
PTR from get_cg_pool_unlocked().
- [High] Sleep in atomic context due to GFP_KERNEL allocation inside RCU re=
ad-side critical section.
--

--- Patch [2]: [PATCH v7 2/6] cgroup,cgroup/dmem: Add (dmem_)cgroup_common_=
ancestor helper ---
commit 3298a9853c9a44ceb0e9ae770fc90e67855b6811
Author: Natalie Vock <natalie.vock@gmx.de>

cgroup,cgroup/dmem: Add (dmem_)cgroup_common_ancestor helper

This helps to find a common subtree of two resources, which is important
when determining whether it's helpful to evict one resource in favor of
another.

> diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
> index 9df3b33c65046..edb4c04d09dfe 100644
> --- a/kernel/cgroup/dmem.c
> +++ b/kernel/cgroup/dmem.c

[ ... ]

> @@ -762,6 +762,42 @@ bool dmem_cgroup_below_low(struct dmem_cgroup_pool_s=
tate *root,
>  }
>  EXPORT_SYMBOL_GPL(dmem_cgroup_below_low);
> =20
> +/**
> + * dmem_cgroup_get_common_ancestor(): Find the first common ancestor of =
two pools.
> + * @a: First pool to find the common ancestor of.
> + * @b: First pool to find the common ancestor of.
> + *
> + * Return: The first pool that is a parent of both @a and @b, or NULL if=
 either @a or @b are NULL,
> + * or if such a pool does not exist. A reference to the returned pool is=
 grabbed and must be
> + * released by the caller when it is done using the pool.
> + */
> +struct dmem_cgroup_pool_state *dmem_cgroup_get_common_ancestor(struct dm=
em_cgroup_pool_state *a,
> +							       struct dmem_cgroup_pool_state *b)
> +{
> +	struct cgroup *ancestor_cgroup;
> +	struct cgroup_subsys_state *ancestor_css;
> +	struct dmem_cgroup_pool_state *pool =3D NULL;
> +
> +	if (!a || !b)
> +		return NULL;
> +
> +	ancestor_cgroup =3D cgroup_common_ancestor(a->cs->css.cgroup, b->cs->cs=
s.cgroup);
> +	if (!ancestor_cgroup)
> +		return NULL;
> +
> +	rcu_read_lock();
> +	ancestor_css =3D cgroup_e_css(ancestor_cgroup, &dmem_cgrp_subsys);
> +	if (css_tryget(ancestor_css))
> +		pool =3D get_cg_pool_unlocked(css_to_dmemcs(ancestor_css),
> +					    a->region);

[Severity: High]
Does calling get_cg_pool_unlocked() here sleep while inside an RCU read
section?

The caller holds rcu_read_lock(), but get_cg_pool_unlocked() can perform a
GFP_KERNEL allocation:

get_cg_pool_unlocked()
    ...
    allocpool =3D kzalloc_obj(*allocpool);

This could lead to a sleep in atomic context warning or a deadlock.

> +	if (!pool)
> +		css_put(ancestor_css);

[Severity: High]
If css_tryget() fails, does this code cause a refcount underflow?

When css_tryget() fails, pool remains NULL. The check for if (!pool) will
then evaluate to true, and css_put() will be called on a reference that was
never successfully acquired.

[Severity: High]
Can get_cg_pool_unlocked() return an ERR_PTR here?

If get_cg_pool_unlocked() returns an error pointer like ERR_PTR(-ENOMEM),
the check for if (!pool) will be false. This would skip the css_put()
cleanup, leaking the ancestor_css reference.

Additionally, this would return the poisoned pointer directly to callers
who might only be expecting a valid pool or a NULL pointer.

> +	rcu_read_unlock();
> +
> +	return pool;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-dmemcg-agg=
ressive-protect-v7-0-97c4b1014315@gmx.de?part=3D2
