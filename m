Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C86C44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 14:35:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E468610EE14;
	Wed, 22 Jul 2026 14:35:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Z27DqI8S";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE8CB10E46D;
 Wed, 22 Jul 2026 14:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784730939; x=1816266939;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=cuuS2K1rarlAAXzm8HhvZedTvKwRUk8jHPM376mGeR0=;
 b=Z27DqI8SP2VbszU39k1a8lN9XWsQEUndB7W4NfR8Rw0UBPfFW+xHBzVO
 ZCI5LliKKVSHe3uzO6aP+c05zK04UfDm11QbZqgXFbOUsjlz8xTteIVV5
 okIJ28Dq8p7150TQMKeQHUfgPa75mxf0C+mbYa7jIuRgIDh1qXNjxCGsJ
 hfVQUJPsaS8OnJl4vEg0GfjV8VAldzlaMDW37WhfLAVqeEihn4ISVbkkf
 L0n9ZDgMC0BVSKDbZXLpVKccbkCVi/JbFxDHjabwIGGoEQjdwjK5m71M+
 jnK94a29p2Mru+4he0UIZAh0UgCNGSv5xdkCIVatmi4ubMHKUKs8W71Bg w==;
X-CSE-ConnectionGUID: mInbrCwuShm9+yq/yp1DvQ==
X-CSE-MsgGUID: SV4eguOiQkOaMy6mEtJ+6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85411383"
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; d="scan'208";a="85411383"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2026 07:34:58 -0700
X-CSE-ConnectionGUID: gp72/Q08QL+uNvwsr+Hzgg==
X-CSE-MsgGUID: zMZkebbUQE+TAhMc6dZ9OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; d="scan'208";a="288101513"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.245.180])
 ([10.245.245.180])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2026 07:34:55 -0700
Message-ID: <02ba25604e746fefa1a0ba54a76ad486154954ef.camel@linux.intel.com>
Subject: Re: drm/ttm/memcg/lru: enable memcg tracking for ttm, xe and amdgpu
 driver (part 2) (v2).
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Dave Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org, 
 tj@kernel.org, christian.koenig@amd.com, Johannes Weiner
 <hannes@cmpxchg.org>,  Michal Hocko <mhocko@kernel.org>, Roman Gushchin
 <roman.gushchin@linux.dev>, Shakeel Butt	 <shakeel.butt@linux.dev>, Muchun
 Song <muchun.song@linux.dev>
Cc: cgroups@vger.kernel.org, Waiman Long <longman@redhat.com>,
 simona@ffwll.ch, 	intel-xe@lists.freedesktop.org
Date: Wed, 22 Jul 2026 16:34:51 +0200
In-Reply-To: <20260706052330.1110909-1-airlied@gmail.com>
References: <20260706052330.1110909-1-airlied@gmail.com>
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

Hi, Dave,

On Mon, 2026-07-06 at 15:22 +1000, Dave Airlie wrote:
> This is just a repost with a number of sashiko identified problems
> that I fixed.
>=20
> I committed the vmstat counters and list lru changes, and they are
> now in tree.
>=20
> This is the remainder of this series. Intel have expressed interest
> in getting
> this landed for xe, we can drop the amdgpu changes for now if they
> can't get
> across the line.
>=20
> I've dropped all previous acks/reviews.
>=20
> This series adds the memcg counters for GPU active and GPU reclaim to
> align
> with the two global vmstats. It adds an accounting flag to TTM
> alloc/populate,
> and enables memcg tracking and shrinker support in TTM.
>=20
> Then it adds amdgpu and xe support.
>=20
> I think for this to land, Christian holds the main objection which I
> still fail
> to fully understand beyond it doesn't solve all the problems we ever
> have had
> with cgroups and drm, so we shouldn't even bother, and maybe we could
> do it at
> the object level, and integrated with dmem, and android cross process
> accounting,
> but I still feel this is a good baseline.
>=20
> I think this is the right layer to hook this into TTM, where we
> allocate memory
> and I think accounting for this memory in a proper way should be
> done.
>=20
> Intel folks (Thomas/Maarten) please review and express concerns as
> well.

Some questions about the design that might belong in the cover-letter.

- First, Since from my understanding gpu shmem allocations are charged
against memcg, (i915 igfx and to some extent dgfx), I think this makes
sense, although it would be good to have an outlook:

1) What about system memory allocations targeting suspend / hibernate
evictions, will they be charged against the root cgroup?

2) Plan for limits on total gpu pages / pinned gpu pages? Is dmemcg a
fit for such limits (coexisting with memcg) or should such limits be
implemented in memcg?

3) IIRC I noticed a patch for dma-heaps where dmemcg was suggested for
android, since it separates GPU memory and system memory. Do we plan
simething similar here, based on config options?

Thanks,
Thomas


>=20
> Regards,
> Dave.
