Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDF2C531C7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 10:21:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9537D10E3BC;
	Thu, 23 Jul 2026 10:21:24 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64F7710E3BC
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 10:21:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1CC5A42AB9;
 Thu, 23 Jul 2026 10:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3B21F000E9;
 Thu, 23 Jul 2026 10:21:22 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/6] cgroup/dmem: Add reclaim callback for lowering
 max below current usage
To: =?utf-8?b?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260723100350.16895-4-thomas.hellstrom@linux.intel.com>
References: <20260723100350.16895-1-thomas.hellstrom@linux.intel.com>
 <20260723100350.16895-4-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 10:21:21 +0000
Message-Id: <20260723102122.AB3B21F000E9@smtp.kernel.org>
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
- [High] Unbounded SRCU read lock hold time in set_resource_max() can stall=
 unregistration indefinitely

Pre-existing issues:
- [High] 32-bit integer overflow and truncation in dmem cgroup limits and a=
ccounting
--

--- Patch [3]: [PATCH v8 3/6] cgroup/dmem: Add reclaim callback for lowerin=
g max below current usage ---
commit 1477e3308e9932d9b9ab70b4c6666ef7191157d5
Author: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

cgroup/dmem: Add reclaim callback for lowering max below current usage

This commit adds an optional reclaim callback to dmem_cgroup_region. When
dmem.max is lowered below current usage, the driver is asked to evict memor=
y,
and concurrent allocations are throttled. It introduces an SRCU domain to
serialize these reclaim callbacks against region unregistration.

> diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
> index eb46e99b73666..7e427895f23ea 100644
> --- a/kernel/cgroup/dmem.c
> +++ b/kernel/cgroup/dmem.c

[ ... ]

> @@ -145,21 +161,52 @@ static void free_cg_pool(struct dmem_cgroup_pool_st=
ate *pool)
>  }
> =20
>  static void
> -set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val)
> +set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val, bool nonb=
lock)
>  {
> -	page_counter_set_max(&pool->cnt, val);
> +	struct dmem_cgroup_region *region =3D pool->region;
> +	unsigned long limit =3D (unsigned long)val;

[Severity: High]
This isn't a bug introduced by this patch, but does this truncation break
cgroup limits on 32-bit systems?

The dmem subsystem appears to be tracking bytes rather than pages using the
page_counter API. On 32-bit kernels, an unsigned long is 32 bits, which
means any limit or usage exceeding 4GB will be silently truncated when a
u64 is cast to unsigned long in set_resource_max().

This same issue seems to apply in dmem_cgroup_try_charge() where the u64
size argument is passed to page_counter_try_charge():

kernel/cgroup/dmem.c:dmem_cgroup_try_charge() {
    ...
    if (!page_counter_try_charge(&pool->cnt, size, &fail)) {
    ...
}

If the allocation exceeds 4GB, or if the total usage tracked in the
atomic_long_t exceeds 4GB, would this cause the counter to wrap and
silently bypass the limits?

> +
> +	/* Apply the new limit immediately so concurrent allocations are thrott=
led. */
> +	xchg(&pool->cnt.max, limit);
> +
> +	if (nonblock)
> +		return;
> +
> +	int srcu_idx =3D srcu_read_lock(&dmemcg_srcu);
> +
> +	if (!READ_ONCE(region->unregistered) && region->ops && region->ops->rec=
laim) {
> +		for (int retries =3D DMEM_MAX_RECLAIM_RETRIES; ; ) {
> +			u64 usage =3D page_counter_read(&pool->cnt);
> +			int ret;
> +
> +			if (usage <=3D limit)
> +				break;
> +
> +			if (signal_pending(current))
> +				break;
> +
> +			ret =3D region->ops->reclaim(pool, usage - limit, region->reclaim_pri=
v);
> +
> +			/* -ENOSPC means no progress; other errors are fatal. */
> +			if (ret && (ret !=3D -ENOSPC || !retries--))
> +				break;
> +
> +			cond_resched();
> +		}
> +	}
> +	srcu_read_unlock(&dmemcg_srcu, srcu_idx);
>  }

[Severity: High]
Can this loop stall indefinitely and block region unregistration?

In set_resource_max(), if region->ops->reclaim() continually successfully
frees some memory but not enough to fall below the limit, it returns 0.
When it returns 0, the retries counter is not decremented:

    if (ret && (ret !=3D -ENOSPC || !retries--))
        break;

Since srcu_read_lock(&dmemcg_srcu) is held for the entire duration of this
retry loop, an infinite loop here would indefinitely hold the SRCU read
lock.

If a cgroup administrator sets dmem.max below current usage while
concurrent processes continually allocate memory, could this block the
synchronize_srcu() call in dmem_cgroup_unregister_region() forever,
hanging the system during device hot-unplug or module unload?

Would it be safer to periodically drop and reacquire the SRCU read lock
inside the loop, or limit the total number of retries regardless of the
return code?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723100350.1689=
5-1-thomas.hellstrom@linux.intel.com?part=3D3
