Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C80C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 05:43:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B22C210E753;
	Mon,  6 Jul 2026 05:43:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="j7eunT3A";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AF2210E753
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 05:43:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7640C43D85;
 Mon,  6 Jul 2026 05:43:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164C31F000E9;
 Mon,  6 Jul 2026 05:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783316606;
 bh=jxOSHUL06lcuziigTirPQQJpSeL/okuN43C5lKCjcIs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=j7eunT3A0nP2uBfocsps0Ewi8/tcilHsqqYXxui359yjnS9J9nl7x4vovfrzY5QZY
 5LAUB0cmRrMG2NjNZPi7tklIFkEf7k8/raWXQKYoq26Fy0FCLQjgGx1I8BgJNlBm/l
 tF6zzwK/jlm0aPQMpf9hKpdH0EpsTJkDUR+SVlM0aRILcEu/LrAvq3CNe3e/BUXc2B
 5EW2Gm9asjvrXBTTWkaULrThS5ZCvDfFYaTOiwh9Mv0ECvX/JfGIfoIJKJ4sfjvEkP
 a5TJ6vaufKqi69hmLcOrUX1Kz0Dnkm7IY8tceOF7CZWlvzmv6tqcH827Htc1HnCsJp
 xVS0kMflxkuiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/10] memcg: add support for GPU page counters. (v5)
To: "Dave Airlie" <airlied@gmail.com>
Cc: tj@kernel.org, mkoutny@suse.com, dri-devel@lists.freedesktop.org,
 hannes@cmpxchg.org
In-Reply-To: <20260706052330.1110909-2-airlied@gmail.com>
References: <20260706052330.1110909-1-airlied@gmail.com>
 <20260706052330.1110909-2-airlied@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 05:43:25 +0000
Message-Id: <20260706054326.164C31F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Faking `MEMCG_DATA_KMEM` without charging the `MEMCG_KMEM` stat ca=
uses state corruption and potential counter underflow.
- [High] `mem_cgroup_move_gpu_page_reclaim` ignores the `to_reclaim` argume=
nt during cross-cgroup moves, corrupting the active/reclaim stats.
- [High] The logic condition in `mem_cgroup_move_gpu_page_reclaim` skips ch=
arge transfers for uncharged pages, bypassing memory limits.
- [High] Charging a GPU page to the root memcg triggers a `VM_WARN_ON_ONCE`=
 and permanently leaks memory usage counters.
--

commit 1761466dad501528141242e7d0630e4e61d30d71
Author: Dave Airlie <airlied@redhat.com>
Date:   Mon Jul 6 05:22:30 2026 +0000

    memcg: add support for GPU page counters. (v5)
   =20
    This introduces 2 new statistics and 3 new memcontrol APIs for dealing
    with GPU system memory allocations.
   =20
    The stats corresponds to the same stats in the global vmstat,
    for number of active GPU pages, and number of pages in pools that
    can be reclaimed.

> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 6dc4888a90f3f..4c682b91cbbee 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c

[ ... ]

> @@ -5508,6 +5512,106 @@ void mem_cgroup_flush_workqueue(void)
>  }
> =20
> +/**
> + * mem_cgroup_charge_gpu_page - charge a page to GPU memory tracking
> + * @objcg: objcg to charge, NULL charges root memcg
> + * @page: page to charge
> + * @order: page allocation order
> + * @gfp_mask: gfp mode
> + * @reclaim: charge the reclaim counter instead of the active one.
> + *
> + * Charge the order sized @page to the objcg. Returns %true if the charg=
e fit within
> + * @objcg's configured limit, %false if it doesn't.
> + */
> +bool mem_cgroup_charge_gpu_page(struct obj_cgroup *objcg, struct page *p=
age,
> +				unsigned int order, gfp_t gfp_mask, bool reclaim)
> +{
> +	unsigned int nr_pages =3D 1 << order;
> +	struct mem_cgroup *memcg =3D NULL;
> +	struct lruvec *lruvec;
> +	int ret;
> +
> +	if (objcg) {
> +		memcg =3D get_mem_cgroup_from_objcg(objcg);
> +
> +		ret =3D try_charge_memcg(memcg, gfp_mask, nr_pages);

[Severity: High]
Does this trigger a kernel warning and counter leak for root processes?

When a root process allocates GPU memory, current_obj_cgroup() can return a
valid obj_cgroup for the root memcg. Calling try_charge_memcg() on the root
memcg succeeds and subsequently calls refill_stock(). Inside refill_stock(),
this triggers VM_WARN_ON_ONCE(mem_cgroup_is_root(memcg)).

Additionally, mem_cgroup_uncharge_gpu_page() explicitly skips refill_stock()
if it is the root memcg. Since the drain mechanism is used to uncharge the
counters in this API, does this permanently leak the root memcg's page
counters?

> +		if (ret) {
> +			mem_cgroup_put(memcg);
> +			return false;
> +		}
> +
> +		obj_cgroup_get(objcg);
> +		page_set_objcg(page, objcg);

[Severity: High]
Will this cause MEMCG_KMEM counter underflow and state corruption?

page_set_objcg() overwrites page->memcg_data with objcg | MEMCG_DATA_KMEM.
However, unlike standard kmem paths using obj_cgroup_charge_pages(), this
function does not charge the MEMCG_KMEM counter.

If a driver leaks the page (failing to uncharge it), the normal page
allocator will eventually process it. free_pages_prepare() sees
PageMemcgKmem(page) is true and calls __memcg_kmem_uncharge_page(), which
decrements MEMCG_KMEM. Since it was never incremented, this causes a
permanent underflow.

Also, if this exported API is mistakenly used on pages that already have
tracking (like shmem), does this silently corrupt their memcg_data invarian=
ts?

> +	}
> +
> +	lruvec =3D mem_cgroup_lruvec(memcg, page_pgdat(page));
> +	mod_lruvec_state(lruvec, reclaim ? NR_GPU_RECLAIM : NR_GPU_ACTIVE, nr_p=
ages);
> +
> +	mem_cgroup_put(memcg);
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(mem_cgroup_charge_gpu_page);

[ ... ]

> +/**
> + * mem_cgroup_move_gpu_reclaim - move pages from gpu to gpu reclaim and =
back
> + * @new_objcg: objcg to move page to, NULL if just stats update.
> + * @nr_pages: number of pages to move
> + * @to_reclaim: true moves pages into reclaim, false moves them back
> + */
> +bool mem_cgroup_move_gpu_page_reclaim(struct obj_cgroup *new_objcg,
> +				      struct page *page,
> +				      unsigned int order,
> +				      bool to_reclaim)
> +{
> +	struct obj_cgroup *objcg =3D page_objcg(page);
> +
> +	if (!objcg || !new_objcg || objcg =3D=3D new_objcg) {

[Severity: High]
Does this skip charge transfers for uncharged pages, allowing memory limit
bypass?

If a page was allocated without memcg accounting (e.g., by a system process
or during early boot), its objcg is NULL.

When a container (with a valid new_objcg) allocates this page from the
global GPU pool, the !objcg condition evaluates to true. The function enters
this block, toggles stats locally, and returns true, skipping the actual
charge transfer to new_objcg.

Does this allow a container to use the GPU page without it being charged
against its memcg memory limit?

> +		struct mem_cgroup *memcg =3D objcg ? get_mem_cgroup_from_objcg(objcg) =
: NULL;
> +		struct lruvec *lruvec;
> +		unsigned long flags;
> +		int nr_pages =3D 1 << order;
> +
> +		lruvec =3D mem_cgroup_lruvec(memcg, page_pgdat(page));
> +		local_irq_save(flags);
> +		mod_lruvec_state(lruvec, to_reclaim ? NR_GPU_RECLAIM : NR_GPU_ACTIVE, =
nr_pages);
> +		mod_lruvec_state(lruvec, to_reclaim ? NR_GPU_ACTIVE : NR_GPU_RECLAIM, =
-nr_pages);
> +		local_irq_restore(flags);
> +		mem_cgroup_put(memcg);
> +		return true;
> +	} else {
> +		mem_cgroup_uncharge_gpu_page(page, order, true);
> +		return mem_cgroup_charge_gpu_page(new_objcg, page, order, 0, false);

[Severity: High]
Does this ignore the to_reclaim argument during cross-cgroup moves?

This unconditionally calls mem_cgroup_uncharge_gpu_page() with reclaim=3Dtr=
ue
and mem_cgroup_charge_gpu_page() with reclaim=3Dfalse. This hardcodes the
transition as moving from the RECLAIM state to the ACTIVE state.

If a caller attempts to move a page between obj_cgroups while keeping its
state as ACTIVE, wouldn't this erroneously uncharge the old cgroup's RECLAIM
state (causing an underflow) and charge the new cgroup's ACTIVE state?

> +	}
> +}
> +EXPORT_SYMBOL_GPL(mem_cgroup_move_gpu_page_reclaim);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706052330.1110=
909-1-airlied@gmail.com?part=3D1
