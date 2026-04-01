Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D8AD35153
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 07:35:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D78210ECB2;
	Wed,  1 Apr 2026 07:35:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="h/efW/6A";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D6E610EC14;
 Wed,  1 Apr 2026 07:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775028919; x=1806564919;
 h=message-id:subject:from:to:date:in-reply-to:references:
 content-transfer-encoding:mime-version;
 bh=UShkxGbZBvCAklGuAw6grxLarMRD/zVv8+t4PIEnxp0=;
 b=h/efW/6AnBmhOqeZq+p8N+izbhdRaBJ9u6mt9FZxnLebTR3hE5z8aLJa
 b1NZraADAPs1h0Ye+q2kAHDCvOY2Yl8jhOB1szdTYU54uWT2m7iuFyD+4
 G5JqeAEs4ZEhi48SLUeMTQyEdo17ip8oeW+sjcUtAWLAesIW8ytU7OwtF
 3dPOmelqRzqKKaao2H9CqUaoJoqp5PM4ApdHDJHOfh/Cx06OpGtSWiXbt
 bahsmxDYRmsAK5+0OKrRUnjznL6TM5ZgSDymNPNrA0vaiYdtMtKcVvO9i
 ccqrHVfF9beb1s+xT3UdLk58MaqOWumfT4SHYgMpyRxYjVCv3RRnw/cSx A==;
X-CSE-ConnectionGUID: 7HGjprlVSt62AzT8tvKyCw==
X-CSE-MsgGUID: ji/AmQvNRdi4Q1dW7z+usA==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="63609985"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; d="scan'208";a="63609985"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2026 00:35:18 -0700
X-CSE-ConnectionGUID: eP86OlHwQ6iJeRVCW6/85Q==
X-CSE-MsgGUID: 3WO6hVcfT86c0k0wFVLwvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; d="scan'208";a="226472662"
Received: from abityuts-desk.ger.corp.intel.com (HELO [10.245.244.137])
 ([10.245.244.137])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2026 00:35:14 -0700
Message-ID: <b8c138314252a31ab6f88ebc824c7c9cf22b3d52.camel@linux.intel.com>
Subject: Re: [RFC PATCH] Limit reclaim to avoid TTM desktop stutter under
 mem pressure
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Daniel Colascione <dancol@dancol.org>, dri-devel@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, Christian Koenig
 <christian.koenig@amd.com>,  Huang Rui <ray.huang@amd.com>, Matthew Auld
 <matthew.auld@intel.com>, Matthew Brost	 <matthew.brost@intel.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>,  Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>,  Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Date: Wed, 01 Apr 2026 09:35:12 +0200
In-Reply-To: <87341fsa85.fsf@dancol.org>
References: <87341fsa85.fsf@dancol.org>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
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

On Tue, 2026-03-31 at 22:08 -0400, Daniel Colascione wrote:
> TTM seems to be too eager to kick off reclaim while kwin is drawing
>=20
> I've noticed that in 7.0-rc6, and since at least 6.17, kwin_wayland
> stalls in DRM ioctls to xe when the system is under memory pressure,
> causing missed frames, cursor-movement stutter, and general
> sluggishness. The root cause seems to be synchronous and asynchronous
> reclaim in ttm_pool_alloc_page as TTM tries, and fails, to allocate
> progressively lower-order pages in response to pool-cache misses when
> allocating graphics buffers.
>=20
> Memory is fragmented enough that the compaction fails (as I can see
> in
> compact_fail and compact_stall in /proc/vmstat; extfrag says the
> normal
> pool is unusable for large allocations too). Additionally, compaction
> seems to be emptying the ttm pool, since page_pool in TTM debugfs
> reports all the buckets are empty while I'm seeing the
> kwin_wayland sluggishness.
>=20
> In profiles, I see time dominated by copy_pages and clear_pages in
> the
> TTM paging code. kswapd runs constantly despite the system as a whole
> having plenty of free memory.
>=20
> I can reproduce the problem on my 32GB-RAM X1C Gen 13 by booting with
> kernelcore=3D8G (not needed, but makes the repro happen sooner),
> running a
> find / >/dev/null (to fragment memory), and doing general web
> browsing. The stalls seem self-perpetuating once it gets started; it
> persists even after killing the find. I've noticed this stall in
> ordinary use too, even without the kernelcore=3D zone tweak, but
> without
> kernelcore, it usually takes a while (hours?) after boot for memory
> to
> become fragmented enough that higher-order allocations fail.
>=20
> The patch below fixes the issue for me. TBC, I'm not sure it's the
> _right_ fix, but it works for me. I'm guessing that even if the
> approach
> is right, a new module parameter isn't warranted.
>=20
> With the patch below, when I set my new max_reclaim_order ttm module
> parameter to zero, the kwin_wayland stalls under memory pressure
> stop. (TBC, this setting inhibits sync or async reclaim except for
> order-zero pages.)=C2=A0 TTM allocation occurs in latency-critical paths
> (e.g. Wayland frame commit): do you think we _should_ reclaim here?

Could you elaborate on what exactly fixes this. You say that if you set
max_reclaim_order to 0 kwin_wayland stalls, but OTOH the default is 0
and you also say it fixes the issue?


>=20
> BTW, I also tried having xe pass a beneficial order of 9, but it
> didn't
> help: we end up doing a lot of compaction work below this order
> anyway.
>=20
> Signed-off-by: Daniel Colascione <dancol@dancol.org>

Interesting. The xe bo shrinker is actually splitting pages to avoid
dipping too far into the kernel reserves when swapping stuff out,
perhaps contributing to the fragmentation. Could you check what happens
if you turn that shrinker off by disabling swap? Does that improve on
the situation?

sudo /sbin/swapoff -a

Another thing that appears bad is that if compaction fails, and starts
shrinking the lower order pools, we might end up in a pathological
situation where lower-order WC allocation split higher order pages and
those are immediately reclaimed.

It sounds like we also need to investigate why buffer object
allocations are made in latency-critical paths.

Thanks,
Thomas



>=20
> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c
> b/drivers/gpu/drm/ttm/ttm_pool.c
> index c0d95559197c..fd255914c0d3 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -115,9 +115,13 @@ struct ttm_pool_tt_restore {
> =C2=A0};
> =C2=A0
> =C2=A0static unsigned long page_pool_size;
> +static unsigned int max_reclaim_order;
> =C2=A0
> =C2=A0MODULE_PARM_DESC(page_pool_size, "Number of pages in the WC/UC/DMA
> pool");
> =C2=A0module_param(page_pool_size, ulong, 0644);
> +MODULE_PARM_DESC(max_reclaim_order,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 "Maximum order that keeps upstream reclaim
> behavior");
> +module_param(max_reclaim_order, uint, 0644);
> =C2=A0
> =C2=A0static atomic_long_t allocated_pages;
> =C2=A0
> @@ -146,16 +150,14 @@ static struct page *ttm_pool_alloc_page(struct
> ttm_pool *pool, gfp_t gfp_flags,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Mapping pages directly=
 into an userspace process and
> calling
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * put_page() on a TTM al=
located page is illegal.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (order)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (order) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 gfp_flags |=3D __GFP_NOMEMALLOC | __GFP_NORETRY |
> __GFP_NOWARN |
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __GFP_TH=
ISNODE;
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Do not add latency to the a=
llocation path for allocations
> orders
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * device tolds us do not brin=
g them additional performance
> gains.
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (beneficial_order && order > ben=
eficial_order)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 gfp_flags &=3D ~__GFP_DIRECT_RECLAIM;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if (beneficial_order && order > beneficial_order)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gfp_flags &=3D=
 ~__GFP_DIRECT_RECLAIM;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if (order > max_reclaim_order)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gfp_flags &=3D=
 ~__GFP_RECLAIM;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ttm_pool_uses_dma_alloc(p=
ool)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 p =3D alloc_pages_node(pool->nid, gfp_flags, order);
