Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC96ACDE008
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 08:27:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3644310F4E8;
	Fri, 26 Jun 2026 08:27:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="clMmCqWl";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BF5010F4E8
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 08:27:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 63C3F60122;
 Fri, 26 Jun 2026 08:27:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3061F000E9;
 Fri, 26 Jun 2026 08:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782462440;
 bh=BofIx/5j4uIrof++blT/Z+Zb5uLUX52QNfutMP+dBXU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=clMmCqWlihybVTosysVurxS1UVz54kiyFHQIn/lLyMYlCzKtfcDqsgf/iylmKF9Wl
 59qgJt7fpWPlnS6JBGOzDrIR50+VI3xonHDqjHr6Xv2x923g9EcCwroddhJ7/rw/DI
 BiW7vkJAYVlMKuOV4jQDM7zD59sV6w6yKOywm/W0q+DYTGPIyuBnouGW2afMiKWbNM
 +M8Ag4HaLXz8eJfWqN9hKQc60bcroM8ve6dX1+bNTEWmB5OG0Est2Q7JEtAnawLO8Z
 oWhjHB7Ygyi2cVCA3O3IGzQnfK581jvXhgS7WFaqo+xXf9ZuW7URtfu+lFrZV4HGDs
 XEUqatlu4NI3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] cgroup/dmem: Use size_t for try_charge() and uncharge()
 size
To: hongfu.li@linux.dev
Cc: hannes@cmpxchg.org, mkoutny@suse.com, dri-devel@lists.freedesktop.org,
 tj@kernel.org
In-Reply-To: <20260626081231.47464-1-hongfu.li@linux.dev>
References: <20260626081231.47464-1-hongfu.li@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 08:27:19 +0000
Message-Id: <20260626082719.BF3061F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] dmem cgroup controller incorrectly tracks bytes using page_counter=
, causing 2GB limit overflow on 32-bit architectures
- [High] Concurrent limit updates can corrupt page counter limits due to la=
ck of serialization
- [High] Missing release barrier when publishing pool initialization allows=
 bypassing hierarchical limits
--

commit 265d8a6cb2da9910a15e7066ffcacbb4c27c4ff0
Author: Hongfu Li <hongfu.li@linux.dev>
Subject: cgroup/dmem: Use size_t for try_charge() and uncharge() size

This commit changes the charge and uncharge APIs to accept a size_t value
for the allocation size rather than a u64. This prevents potential truncati=
on
on 32-bit architectures when the size is passed to the internal page_counter
functions.

> diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
> index 4753a67d0f0f2..38108536d2d60 100644
> --- a/kernel/cgroup/dmem.c
> +++ b/kernel/cgroup/dmem.c
> @@ -649,7 +649,7 @@ EXPORT_SYMBOL_GPL(dmem_cgroup_uncharge);
>   *
>   * Return: 0 on success, -EAGAIN on hitting a limit, or a negative errno=
 on failure.
>   */
> -int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, u64 size,
> +int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, size_t siz=
e,
>  			  struct dmem_cgroup_pool_state **ret_pool,
>  			  struct dmem_cgroup_pool_state **ret_limit_pool)
>  {

[ ... ]

>  	if (!page_counter_try_charge(&pool->cnt, size, &fail)) {

[Severity: High]
This is a pre-existing issue, but does using page_counter to track device
memory in bytes cause cumulative overflow on 32-bit architectures?

The page_counter API stores counts using unsigned long and internally
accumulates using atomic_long_add_return(). On 32-bit architectures, this
limits the tracking capability to LONG_MAX (2GB).

When cumulative device memory exceeds 2GB, the usage value wraps to negativ=
e,
and the signed bounds check in page_counter_try_charge() consistently fails,
causing valid allocations to be permanently rejected.

Similarly, in set_resource_max() and reset_all_resource_limits(), passing a
64-bit byte limit directly to page_counter_set_max() silently truncates
values above 4GB, and setting the default limit to PAGE_COUNTER_MAX restric=
ts
usage to 2GB on 32-bit systems.

Could we track memory in pages instead of bytes to avoid this overflow?


[Severity: High]
This is a pre-existing issue, but can concurrent limit updates corrupt the
page counter limits?

page_counter_set_max() explicitly requires callers to serialize invocations.
Without serialization, concurrent writes can cause the optimistic
compare-and-swap retry loop to interleave, silently corrupting the maximum
limits and overwriting new limits with stale values.

This happens in dmemcg_limit_write() when applying limits:

kernel/cgroup/dmem.c:dmemcg_limit_write() {
    ...
		/* And commit */
		apply(pool, new_limit);
    ...
}

It also happens during cgroup offline when resetting limits under just an
RCU read lock:

kernel/cgroup/dmem.c:dmemcs_offline() {
    ...
	list_for_each_entry_rcu(pool, &dmemcs->pools, css_node)
		reset_all_resource_limits(pool);
    ...
}

Does this code need a lock to serialize these limit updates?


[Severity: High]
This is a pre-existing issue, but can the lack of memory barriers during po=
ol
initialization allow hierarchical limits to be bypassed?

In alloc_pool_single(), a new pool is linked into the RCU list before it is
fully initialized. Later in get_cg_pool_locked(), pool->inited is set witho=
ut
a release barrier:

kernel/cgroup/dmem.c:get_cg_pool_locked() {
    ...
		pool->cnt.parent =3D &ppool->cnt;
		if (ppool && !pool->parent) {
			pool->parent =3D ppool;
			dmemcg_pool_get(ppool);
		}
		pool->inited =3D true;
    ...
}

A concurrent reader in get_cg_pool_unlocked() uses READ_ONCE(pool->inited)
without an acquire barrier:

kernel/cgroup/dmem.c:get_cg_pool_unlocked() {
    ...
	pool =3D find_cg_pool_locked(cg, region);
	if (pool && !READ_ONCE(pool->inited))
		pool =3D NULL;
    ...
}

Due to memory reordering, the reader can observe pool->inited =3D=3D true b=
ut
still see a NULL parent pointer. Would adding smp_store_release() and
smp_load_acquire() prevent this race?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626081231.4746=
4-1-hongfu.li@linux.dev?part=3D1
