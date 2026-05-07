Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD305CD3442
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 11:19:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38E8010E1D3;
	Thu,  7 May 2026 11:19:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="la8rVQPB";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A32CA10E049;
 Thu,  7 May 2026 11:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778152745; x=1809688745;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=cRZ8xZxDQBKCBLucxh+QxCSTByF79kLCv2C9OryZKKE=;
 b=la8rVQPBHijZrVL3aksZqUlmWak8dSLy2d9EKdVj6nVzhbp7Gb+QSmQ7
 EVqB9VAwXZb7+1rdC9IgSCB3RXhjlEBJ9PkB6MVrFL4I5QxQxEPby3std
 xBA++6tVe/w302UwtshOTvt8zQo3aKdN+43wUxJDzDRFDJbu4Fk2IZNAo
 NnNrWsMArpqEn15K3jSpqQ/rBny9O64Oi07GQrkBJgUZupXUeeZiD/Bqo
 o8Qw8jz/2erkM/+oEFt8NUSTJdxcYeYz4YvzlFg8lgVgzFh5VZxvyPPd1
 hKHhezxV4z1sfv90Y1ZmJo2GKqe52HMGvg6HVdOBIKBfGS+VQBGze3cy8 Q==;
X-CSE-ConnectionGUID: SZJzraXJSvOWIAJUxGd26Q==
X-CSE-MsgGUID: voSRP4+6RKmJqD83521mYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="79284819"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="79284819"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 04:19:05 -0700
X-CSE-ConnectionGUID: u1EVoKdtTHywPmK01IfJKA==
X-CSE-MsgGUID: 94HmaLugRCGSOTaDfrcreQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="235437341"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO [10.245.245.94])
 ([10.245.245.94])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 04:18:59 -0700
Message-ID: <334d943c54608568a52409cd342f629bdbdd0e11.camel@linux.intel.com>
Subject: Re: [PATCH v5 4/5] drm/xe: Set TTM device beneficial_order to 9 (2M)
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
 <weixugc@google.com>, linux-mm@kvack.org, 	linux-kernel@vger.kernel.org,
 Carlos Santa <carlos.santa@intel.com>, Matthew Auld
 <matthew.auld@intel.com>, Andi Shyti <andi.shyti@linux.intel.com>
Date: Thu, 07 May 2026 13:18:56 +0200
In-Reply-To: <20260506033300.3534883-5-matthew.brost@intel.com>
References: <20260506033300.3534883-1-matthew.brost@intel.com>
 <20260506033300.3534883-5-matthew.brost@intel.com>
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

On Tue, 2026-05-05 at 20:32 -0700, Matthew Brost wrote:
> Set the TTM device beneficial_order to 9 (2M), which is the sweet
> spot for Xe when attempting reclaim on system memory BOs, as it
> matches
> the large GPU page size. This ensures reclaim is attempted at the
> most
> effective order for the driver.
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
> Cc: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> Cc: Carlos Santa <carlos.santa@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>


> ---
> =C2=A0drivers/gpu/drm/xe/xe_device.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/xe/xe_device.c
> b/drivers/gpu/drm/xe/xe_device.c
> index 4b45b617a039..3f719ab08d1c 100644
> --- a/drivers/gpu/drm/xe/xe_device.c
> +++ b/drivers/gpu/drm/xe/xe_device.c
> @@ -500,7 +500,8 @@ struct xe_device *xe_device_create(struct pci_dev
> *pdev,
> =C2=A0
> =C2=A0	err =3D ttm_device_init(&xe->ttm, &xe_ttm_funcs, xe->drm.dev,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xe->drm.anon_inode->i_mapping,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xe->drm.vma_offset_manager, 0);
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xe->drm.vma_offset_manager,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> TTM_ALLOCATION_POOL_BENEFICIAL_ORDER(get_order(SZ_2M)));
> =C2=A0	if (WARN_ON(err))
> =C2=A0		return ERR_PTR(err);
> =C2=A0
