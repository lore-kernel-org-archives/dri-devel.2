Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C548CD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 14:39:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B893510EDC9;
	Wed,  6 May 2026 14:38:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="jMB5ZXjn";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA03110EDC4;
 Wed,  6 May 2026 14:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778078338; x=1809614338;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=3cyqpWM4hY2WHFw6kor77wf8w5w1B47aBYbK7oUub5M=;
 b=jMB5ZXjnxcrnqJ1OcRFWmaupwZE9VD4GbjJ/wCeKQFRFkO4y0qqNEN03
 wB1zQ8wmybFIFhgXxR8xgM+tSGgONwxJ04xF3eKQnohI8OUk2E5z8DsM3
 xyyKmE620T28h3jROCmWDDyyNkb+qXw2VTTgffNJERpm0Do7JctC2PjFc
 CF5L9H35vdMfRLDLMgTFAzGKbONsrurtw9Ju42LT2UMU0jY0CIWVnT8BE
 x19+rL+EsX4QhscTlHbpGQzpKwHxNbAlSqe+G/pWFXg6hOnoMUvrT9BKf
 AoF0Kkvnew73Tm0EFrps8+Itya92O+nHSn5go75NlL0QpMqlc5xz9lTQK Q==;
X-CSE-ConnectionGUID: dGwOZq2ASEa3u3ifQtW9gg==
X-CSE-MsgGUID: GRMYdwItTba3xraMhFNXcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="101685860"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; d="scan'208";a="101685860"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 07:38:57 -0700
X-CSE-ConnectionGUID: MO97WVf1RiKlPmy703qAnA==
X-CSE-MsgGUID: +9Zcu98LQayImxZ/dfr1kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; d="scan'208";a="236074423"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.244.213])
 ([10.245.244.213])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 07:38:52 -0700
Message-ID: <ab7836a9a776c73e96fd296ea8440ca075af5bad.camel@linux.intel.com>
Subject: Re: [PATCH v5 5/5] drm/xe: Make use of
 shrink_control::opportunistic_compaction hint
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Dave Chinner	
 <david@fromorbit.com>, Qi Zheng <zhengqi.arch@bytedance.com>, Roman
 Gushchin	 <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett"	 <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@kernel.org>, Mike Rapoport	 <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko	 <mhocko@suse.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Shakeel Butt	 <shakeel.butt@linux.dev>, Kairui Song
 <kasong@tencent.com>, Barry Song	 <baohua@kernel.org>, Axel Rasmussen
 <axelrasmussen@google.com>, Yuanchu Xie	 <yuanchu@google.com>, Wei Xu
 <weixugc@google.com>, linux-mm@kvack.org, 	linux-kernel@vger.kernel.org
Date: Wed, 06 May 2026 16:38:48 +0200
In-Reply-To: <20260506033300.3534883-6-matthew.brost@intel.com>
References: <20260506033300.3534883-1-matthew.brost@intel.com>
 <20260506033300.3534883-6-matthew.brost@intel.com>
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

On Tue, 2026-05-05 at 20:33 -0700, Matthew Brost wrote:
> Xe/TTM backup reclaim can be extremely expensive under fragmentation
> pressure as reclaim may migrate or destroy actively used GPU working
> sets despite the system still having substantial free memory
> available.
>=20
> Under high-order opportunistic reclaim, repeatedly backing up GPU
> memory can lead to reclaim/rebind ping-pong behavior where active GPU
> working sets are continuously torn down and reconstructed without
> materially improving allocation success.
>=20
> Use the new shrink_control::opportunistic_compaction hint to avoid Xe
> backup reclaim during fragmentation-driven high-order reclaim
> attempts.
> In this mode the shrinker skips advertising backup-backed reclaimable
> memory and avoids initiating backup operations entirely.
>=20
> Order-0 and non-opportunistic reclaim behavior remain unchanged, so
> Xe backup reclaim still participates normally during genuine memory
> pressure.
>=20
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Qi Zheng <zhengqi.arch@bytedance.com>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: Kairui Song <kasong@tencent.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Axel Rasmussen <axelrasmussen@google.com>
> Cc: Yuanchu Xie <yuanchu@google.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

> ---
> =C2=A0drivers/gpu/drm/xe/xe_shrinker.c | 20 +++++++++++++++++---
> =C2=A01 file changed, 17 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/xe/xe_shrinker.c
> b/drivers/gpu/drm/xe/xe_shrinker.c
> index 83374cd57660..4646b0f5b82b 100644
> --- a/drivers/gpu/drm/xe/xe_shrinker.c
> +++ b/drivers/gpu/drm/xe/xe_shrinker.c
> @@ -139,10 +139,17 @@ static unsigned long
> =C2=A0xe_shrinker_count(struct shrinker *shrink, struct shrink_control
> *sc)
> =C2=A0{
> =C2=A0	struct xe_shrinker *shrinker =3D to_xe_shrinker(shrink);
> -	unsigned long num_pages;
> +	unsigned long num_pages =3D 0;
> =C2=A0	bool can_backup =3D !!(sc->gfp_mask & __GFP_FS);
> =C2=A0
> -	num_pages =3D ttm_backup_bytes_avail() >> PAGE_SHIFT;
> +	/*
> +	 * Skip accounting backup-able pages when this is an
> opportunistic
> +	 * high-order pass: TTM backup work shrinks at native page
> granularity
> +	 * and is unlikely to produce the contiguous block the
> caller wants,
> +	 * so don't advertise it as reclaimable for this hint.
> +	 */
> +	if (!sc->order || !sc->opportunistic_compaction)
> +		num_pages =3D ttm_backup_bytes_avail() >> PAGE_SHIFT;
> =C2=A0	read_lock(&shrinker->lock);
> =C2=A0
> =C2=A0	if (can_backup)
> @@ -233,7 +240,14 @@ static unsigned long xe_shrinker_scan(struct
> shrinker *shrink, struct shrink_con
> =C2=A0	}
> =C2=A0
> =C2=A0	sc->nr_scanned =3D nr_scanned;
> -	if (nr_scanned >=3D nr_to_scan || !can_backup)
> +	/*
> +	 * Stop after the purge pass for opportunistic high-order
> reclaim:
> +	 * the subsequent backup/writeback pass works at native page
> order
> +	 * and is unlikely to free a contiguous high-order block, so
> doing
> +	 * it here would just churn working sets for no compaction
> benefit.
> +	 */
> +	if (nr_scanned >=3D nr_to_scan || !can_backup ||
> +	=C2=A0=C2=A0=C2=A0 (sc->order && sc->opportunistic_compaction))
> =C2=A0		goto out;
> =C2=A0
> =C2=A0	/* If we didn't wake before, try to do it now if needed. */
