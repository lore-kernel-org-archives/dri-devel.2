Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFBD9FF885A
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 07:03:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3199710E30C;
	Tue, 28 Apr 2026 07:03:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="kq03j4xr";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95DA110E303;
 Tue, 28 Apr 2026 07:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777359797; x=1808895797;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=WyJCW1gt7DH9BkO9eT9ZXl9Bfu7+u1hAr923tLpgiI0=;
 b=kq03j4xrOw4UzmSBLw3XVF1MaVJHXvB5zjZQzk6FO0CVCWzfPVz9UYaD
 P4XlhIjYo4UC+K0v6X22S88hbZcP9aJg5TRGQdHgnLAFHBNvhqHo6IIQs
 uFeYZVJqOafg5hjIoz6TTCzeR1jrA/LRfT4oTjw9kq25ULU2RgL2YD+jS
 KGEK/lG6r0o+RnrflCgMJ/4qu8eGvTyJSngU4wuXD35l3y6ogOjKRXutW
 WoYdm10F8Kcbyz8nvSJvVr16wcGQwmt1s+lAxSEZxY94EXd6oaM0CHo2m
 kyavVCZTdKkD+OgHSvNGiU+ahqyWHjao+bqngWSOv+XTFx/oZDWEImS7n w==;
X-CSE-ConnectionGUID: 1TpwfaxpRVCfbsrlWtCBtg==
X-CSE-MsgGUID: r10qXzyCSmuWG6wOf4qF6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="100917985"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="100917985"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 00:03:16 -0700
X-CSE-ConnectionGUID: zuujafHuSgOZ9TgvKwObHw==
X-CSE-MsgGUID: 2A720/AMQKeKSRPTIbZeIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="257399326"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.161])
 ([10.245.244.161])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 00:02:41 -0700
Message-ID: <4ab1f9215e06ebd730fcff6aeba06c753b105667.camel@linux.intel.com>
Subject: Re: [PATCH 2/5] cgroup/dmem: Add reclaim callback for lowering max
 below current usage
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Chen Ridong <chenridong@huaweicloud.com>, intel-xe@lists.freedesktop.org
Cc: Natalie Vock <natalie.vock@gmx.de>, Johannes Weiner
 <hannes@cmpxchg.org>,  Tejun Heo <tj@kernel.org>, Michal
 =?ISO-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, 	cgroups@vger.kernel.org,
 Huang Rui <ray.huang@amd.com>, Matthew Brost	 <matthew.brost@intel.com>,
 Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann	 <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 David Airlie	 <airlied@gmail.com>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, 	linux-kernel@vger.kernel.org
Date: Tue, 28 Apr 2026 09:02:26 +0200
In-Reply-To: <220aadd9-0d92-44ce-8a70-bd30030defa9@huaweicloud.com>
References: <20260327081600.4885-1-thomas.hellstrom@linux.intel.com>
 <20260327081600.4885-3-thomas.hellstrom@linux.intel.com>
 <220aadd9-0d92-44ce-8a70-bd30030defa9@huaweicloud.com>
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

On Sat, 2026-04-25 at 14:42 +0800, Chen Ridong wrote:
>=20
>=20
> On 2026/3/27 16:15, Thomas Hellstr=C3=B6m wrote:
> > Add an optional reclaim callback to struct dmem_cgroup_region.=C2=A0
> > When
> > dmem.max is set below current usage, invoke the callback to evict
> > memory
> > and retry setting the limit rather than failing immediately.=C2=A0
> > Signal
> > interruptions propagate back to the write() caller.
> >=20
> > RFC:
> > Due to us updating the max limit _after_ the usage has been
> > sufficiently lowered, this should be prone to failures if there are
> > aggressive allocators running in parallel to the reclaim.
> > So can we somehow enforce the new limit while the eviction is
> > happening?
> >=20
> > Assisted-by: GitHub Copilot:claude-sonnet-4.6
> > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > ---
> > =C2=A0 include/linux/cgroup_dmem.h | 11 +++++
> > =C2=A0 kernel/cgroup/dmem.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
 94
> > +++++++++++++++++++++++++++++++++----
> > =C2=A0 2 files changed, 96 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/include/linux/cgroup_dmem.h
> > b/include/linux/cgroup_dmem.h
> > index dd4869f1d736..61520a431740 100644
> > --- a/include/linux/cgroup_dmem.h
> > +++ b/include/linux/cgroup_dmem.h
> > @@ -26,6 +26,10 @@ bool dmem_cgroup_state_evict_valuable(struct
> > dmem_cgroup_pool_state *limit_pool,
> > =C2=A0=C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool ignore_low, bool
> > *ret_hit_low);
> > =C2=A0=20
> > =C2=A0 void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state
> > *pool);
> > +void dmem_cgroup_region_set_reclaim(struct dmem_cgroup_region
> > *region,
> > +				=C2=A0=C2=A0=C2=A0 int (*reclaim)(struct
> > dmem_cgroup_pool_state *pool,
> > +						=C2=A0=C2=A0 u64
> > target_bytes, void *priv),
> > +				=C2=A0=C2=A0=C2=A0 void *priv);
> > =C2=A0 #else
> > =C2=A0 static inline __printf(2,3) struct dmem_cgroup_region *
> > =C2=A0 dmem_cgroup_register_region(u64 size, const char *name_fmt, ...)
> > @@ -62,5 +66,12 @@ bool dmem_cgroup_state_evict_valuable(struct
> > dmem_cgroup_pool_state *limit_pool,
> > =C2=A0 static inline void dmem_cgroup_pool_state_put(struct
> > dmem_cgroup_pool_state *pool)
> > =C2=A0 { }
> > =C2=A0=20
> > +static inline void
> > +dmem_cgroup_region_set_reclaim(struct dmem_cgroup_region *region,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*reclaim)(struct
> > dmem_cgroup_pool_state *pool,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 target_bytes,
> > void *priv),
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *priv)
> > +{ }
> > +
> > =C2=A0 #endif
> > =C2=A0 #endif	/* _CGROUP_DMEM_H */
> > diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
> > index 3e6d4c0b26a1..f993fb058b74 100644
> > --- a/kernel/cgroup/dmem.c
> > +++ b/kernel/cgroup/dmem.c
> > @@ -51,6 +51,18 @@ struct dmem_cgroup_region {
> > =C2=A0=C2=A0	 * No new pools should be added to the region afterwards.
> > =C2=A0=C2=A0	 */
> > =C2=A0=C2=A0	bool unregistered;
> > +
> > +	/**
> > +	 * @reclaim: Optional callback invoked when dmem.max is
> > set below the
> > +	 * current usage of a pool. The driver should attempt to
> > free at least
> > +	 * @target_bytes from @pool. May be called multiple times
> > if usage
> > +	 * remains above the limit after returning.
> > +	 */
> > +	int (*reclaim)(struct dmem_cgroup_pool_state *pool, u64
> > target_bytes,
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *priv);
> > +
> > +	/** @reclaim_priv: Private data passed to @reclaim. */
> > +	void *reclaim_priv;
> > =C2=A0 };
> > =C2=A0=20
> > =C2=A0 struct dmemcg_state {
> > @@ -145,23 +157,59 @@ static void free_cg_pool(struct
> > dmem_cgroup_pool_state *pool)
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 static int
> > -set_resource_min(struct dmem_cgroup_pool_state *pool, u64 val)
> > +set_resource_min(struct dmem_cgroup_pool_state *pool, u64 val,
> > +		 struct dmem_cgroup_region *region)
> > =C2=A0 {
> > =C2=A0=C2=A0	page_counter_set_min(&pool->cnt, val);
> > =C2=A0=C2=A0	return 0;
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 static int
> > -set_resource_low(struct dmem_cgroup_pool_state *pool, u64 val)
> > +set_resource_low(struct dmem_cgroup_pool_state *pool, u64 val,
> > +		 struct dmem_cgroup_region *region)
> > =C2=A0 {
> > =C2=A0=C2=A0	page_counter_set_low(&pool->cnt, val);
> > =C2=A0=C2=A0	return 0;
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 static int
> > -set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val)
> > +set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val,
>=20
> Though we are discussing how to set the maximum, renaming 'val' to
> 'max' would
> improve readability in the next version.


Since all the set_resource_xxx() functions are using @val, that'd be an
unrelated change. Possibly in a follow-up patch?

Thanks,
Thomas
