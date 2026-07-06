Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD5FC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 03:01:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C2C210E719;
	Mon,  6 Jul 2026 03:01:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AIXkFTam";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FD5D10E719
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 03:01:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 68EA740867;
 Mon,  6 Jul 2026 03:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C5C1F000E9;
 Mon,  6 Jul 2026 03:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783306868;
 bh=v1BtOx5cYYQ0SyezWPLNTxSnl5y5jj9NJ89cPXD6WAU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AIXkFTamrS2w8clJ2CBpFhVHcOd2tO/2fOEwdYpZI8Ahft38/3Pf8/gTT9WiRp+fd
 f9tRDP2L4uLQrFhY2n3/4JvxnB6yYs68Xe2mfIr1b325ba0yhexCqTRf3hNUWPBDGz
 Vx3dkWvtup8UySHZLVGlftPLO02bQeXQsMLY/pKnfngLpv5la7H1V91BDwyKSdyRKo
 8u8hn4gc+aV1VldY75cKHRbTqv121UU1rSoS473qGyZXTslz1h7MTW/VGZ0Yzjsu5l
 jdK1E2vyPA6UH/9vMer246+xvC3o6ek0aCWiiL7zgsIR1Q5ErjHuA+ACbyhBZO9Q2+
 bXIrVFSK3eQDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/10] memcg: add support for GPU page counters. (v4)
To: "Dave Airlie" <airlied@gmail.com>
Cc: mkoutny@suse.com, tj@kernel.org, hannes@cmpxchg.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260706024122.853329-2-airlied@gmail.com>
References: <20260706024122.853329-1-airlied@gmail.com>
 <20260706024122.853329-2-airlied@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 03:01:07 +0000
Message-Id: <20260706030107.F2C5C1F000E9@smtp.kernel.org>
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
- [High] mem_cgroup_move_gpu_page_reclaim silently fails to move pages to o=
r from the root cgroup, bypassing memory limits and leaking charges.
- [High] Tagging GPU pages with MEMCG_DATA_KMEM without corresponding kmem =
counter charges causes global kmem underflows on standard page frees.
- [Medium] Cross-cgroup page moves in mem_cgroup_move_gpu_page_reclaim comp=
letely ignore the `to_reclaim` parameter and corrupt stats.
- [Low] Missing static inline stubs for GPU memory tracking APIs when CONFI=
G_MEMCG is disabled.
--

commit 497e4e8b1bbad8552dbc2f2daeb121cd40f196af
Author: Dave Airlie <airlied@redhat.com>

memcg: add support for GPU page counters. (v4)

This introduces new statistics and memcontrol APIs for dealing with GPU sys=
tem
memory allocations. It allows charging, uncharging, and moving pages between
object cgroups and reclaim states.

> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index e1f46a0016fcf..3a968c6be0c84 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1583,6 +1583,17 @@ static inline void mem_cgroup_flush_foreign(struct=
 bdi_writeback *wb)
>  #endif	/* CONFIG_CGROUP_WRITEBACK */
> =20
>  struct sock;
> +bool mem_cgroup_charge_gpu_page(struct obj_cgroup *objcg, struct page *p=
age,
> +			   unsigned int order,
> +			   gfp_t gfp_mask, bool reclaim);
> +void mem_cgroup_uncharge_gpu_page(struct page *page,
> +				  unsigned int order,
> +				  bool reclaim);
> +bool mem_cgroup_move_gpu_page_reclaim(struct obj_cgroup *objcg,
> +				      struct page *page,
> +				      unsigned int order,
> +				      bool to_reclaim);
> +

[Severity: Low]
Are there missing static inline stubs for these APIs when CONFIG_MEMCG is
disabled? Will this cause undefined reference link errors for drivers using
these functions on non-memcg builds, since they are declared globally but
only implemented in mm/memcontrol.c?

>  #ifdef CONFIG_MEMCG
>  extern struct static_key_false memcg_sockets_enabled_key;
>  #define mem_cgroup_sockets_enabled static_branch_unlikely(&memcg_sockets=
_enabled_key)

[ ... ]

> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 6dc4888a90f3f..4c682b91cbbee 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c

[ ... ]

> @@ -5508,6 +5512,106 @@ void mem_cgroup_flush_workqueue(void)
>  	flush_workqueue(memcg_wq);
>  }
> =20
> +/**
> + * mem_cgroup_charge_gpu_page - charge a page to GPU memory tracking
> + * @objcg: objcg to charge, NULL charges root memcg

[ ... ]

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
> +		if (ret) {
> +			mem_cgroup_put(memcg);
> +			return false;
> +		}
> +
> +		obj_cgroup_get(objcg);
> +		page_set_objcg(page, objcg);

[Severity: High]
Since page_set_objcg() embeds the MEMCG_DATA_KMEM flag into the page, if th=
is
GPU page is later freed directly by the kernel rather than through
mem_cgroup_uncharge_gpu_page(), will the VM route the uncharge to
__memcg_kmem_uncharge_page()?

Could this improperly decrement the global kmem counters (which were never
incremented during the GPU page charging) and bypass the decrement of the
NR_GPU_ACTIVE or NR_GPU_RECLAIM stats?

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
Does this conditional unintentionally merge cross-cgroup moves involving the
root cgroup (where objcg or new_objcg is NULL) into the fast-path for
in-place state transitions?

If a page is moved to or from the root cgroup, it looks like this will
silently fail to transfer ownership to the new child cgroup, bypassing memo=
ry
limits or leaving charges stuck in the original cgroup indefinitely.

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

[Severity: Medium]
Does this block ignore the to_reclaim boolean parameter by hardcoding true
for the uncharge and false for the charge?

It looks like this will corrupt the stats by always decrementing the RECLAIM
counter of the old cgroup and always incrementing the ACTIVE counter of the
new cgroup, regardless of the caller's requested state.

> +	}
> +}
> +EXPORT_SYMBOL_GPL(mem_cgroup_move_gpu_page_reclaim);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706024122.8533=
29-1-airlied@gmail.com?part=3D1
