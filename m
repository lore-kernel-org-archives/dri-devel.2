Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E94FFF885D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 10:02:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E085C10EAE7;
	Tue, 28 Apr 2026 10:02:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Qanm2UHm";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF4DB10EAE7;
 Tue, 28 Apr 2026 10:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777370563; x=1808906563;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=O/fX+/fwObLkLagIKKIXphtPD052eF9ODtQPNirPNA4=;
 b=Qanm2UHm798g8zlTJ0quh04VdDYKcHH6U/7qjnsW5GtMN0bJR4bCdDY9
 7d917Dah+OVWHv57ieqqJpRqVWiAW3zPOEuMRPzJaX7giIMfCulNG9SRo
 jsLElrMQabZN+xAR2SPzia9v96L+XlFGtHFqYSNo0XPuJ+1UsHDdkR/M9
 1fxAp/3XDAf64+6kHQYOPst60QIvqz+T7kFyf/fITxx+o9ZUE0eeWCw/S
 /Z7vbZ+1DeWfdKP94+lPHc0ogRyrg3ZrxmZ1vHG5Pn1ivIXxPM3mqi9SV
 Eh5E4fWe8kMxhKav4x9eeDBRnnDRcoBigRPPZ0HjrwKyyAJyI16B7P+qV g==;
X-CSE-ConnectionGUID: yjSq9uIpRY6AuB9hoyFfNg==
X-CSE-MsgGUID: QWiSH3wzTIem6jFoD/4nmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="89654111"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="89654111"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 03:02:40 -0700
X-CSE-ConnectionGUID: 0QLQBZ8kQU2MR6y1L+2CLQ==
X-CSE-MsgGUID: zz6QLTN/RV2NA1bgXxOy0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="257222117"
Received: from abityuts-desk.ger.corp.intel.com (HELO [10.245.245.33])
 ([10.245.245.33])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 03:02:36 -0700
Message-ID: <5d36326b1b9c009cd544fe5ca195ae484dbbc915.camel@linux.intel.com>
Subject: Re: [PATCH v2 3/4] drm/xe: Wire up dmem cgroup reclaim for VRAM
 manager
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 intel-xe@lists.freedesktop.org
Cc: Natalie Vock <natalie.vock@gmx.de>, Johannes Weiner
 <hannes@cmpxchg.org>,  Tejun Heo <tj@kernel.org>, Michal
 =?ISO-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, 	cgroups@vger.kernel.org,
 Huang Rui <ray.huang@amd.com>, Matthew Brost	 <matthew.brost@intel.com>,
 Matthew Auld <matthew.auld@intel.com>, Maxime Ripard	 <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter	 <simona@ffwll.ch>,
 David Airlie <airlied@gmail.com>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, 	linux-kernel@vger.kernel.org
Date: Tue, 28 Apr 2026 12:02:31 +0200
In-Reply-To: <84473cbe-79ad-421e-8c8a-171e5784105f@linux.intel.com>
References: <20260428073116.15687-1-thomas.hellstrom@linux.intel.com>
 <20260428073116.15687-4-thomas.hellstrom@linux.intel.com>
 <84473cbe-79ad-421e-8c8a-171e5784105f@linux.intel.com>
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

On Tue, 2026-04-28 at 11:50 +0200, Maarten Lankhorst wrote:
>=20
>=20
> Den 2026-04-28 kl. 09:31, skrev Thomas Hellstr=C3=B6m:
> > Register the VRAM manager with the dmem cgroup reclaim
> > infrastructure
> > so that lowering dmem.max below current VRAM usage triggers TTM
> > eviction rather than failing with -EBUSY.
> >=20
> > Assisted-by: GitHub Copilot:claude-sonnet-4.6
> > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > ---
> > =C2=A0drivers/gpu/drm/xe/xe_ttm_vram_mgr.c | 19 ++++++++++++-------
> > =C2=A01 file changed, 12 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
> > b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
> > index 5fd0d5506a7e..1bdcb3fee901 100644
> > --- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
> > +++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
> > @@ -303,13 +303,6 @@ int __xe_ttm_vram_mgr_init(struct xe_device
> > *xe, struct xe_ttm_vram_mgr *mgr,
> > =C2=A0	struct ttm_resource_manager *man =3D &mgr->manager;
> > =C2=A0	int err;
> > =C2=A0
> > -	if (mem_type !=3D XE_PL_STOLEN) {
> > -		const char *name =3D mem_type =3D=3D XE_PL_VRAM0 ?
> > "vram0" : "vram1";
> > -		man->cg =3D drmm_cgroup_register_region(&xe->drm,
> > name, size);
> > -		if (IS_ERR(man->cg))
> > -			return PTR_ERR(man->cg);
> > -	}
> > -
> > =C2=A0	man->func =3D &xe_ttm_vram_mgr_func;
> > =C2=A0	mgr->mem_type =3D mem_type;
> > =C2=A0	mutex_init(&mgr->lock);
> > @@ -318,6 +311,18 @@ int __xe_ttm_vram_mgr_init(struct xe_device
> > *xe, struct xe_ttm_vram_mgr *mgr,
> > =C2=A0	mgr->visible_avail =3D io_size;
> > =C2=A0
> > =C2=A0	ttm_resource_manager_init(man, &xe->ttm, size);
> > +
> > +	if (mem_type !=3D XE_PL_STOLEN) {
> > +		const char *name =3D mem_type =3D=3D XE_PL_VRAM0 ?
> > "vram0" : "vram1";
> > +		struct dmem_cgroup_region *cg =3D
> > +			drmm_cgroup_register_region(&xe->drm,
> > name, size);
> > +
> > +		if (IS_ERR(cg))
> > +			return PTR_ERR(cg);
> > +
> > +		ttm_resource_manager_set_dmem_region(man, cg);
> > +	}
> > +
> > =C2=A0	err =3D gpu_buddy_init(&mgr->mm, man->size,
> > default_page_size);
> > =C2=A0	if (err)
> > =C2=A0		return err;
>=20
> This patch will conflict with=20
> https://patchwork.freedesktop.org/series/164694/=C2=A0which removes
> stolen support, can we merge that patch first while we wait for AMD
> acks?

Sure, np.

>=20
> Do I need an ack to get the series through drm-misc?

Which series? The stolen support or this cgroup series?

Thanks,
Thomas


>=20
> Kind regards,
> ~Maarten Lankhorst
