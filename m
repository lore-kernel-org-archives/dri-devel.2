Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39278CD37B5
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 08:02:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C3AB10E185;
	Mon, 11 May 2026 08:02:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bRTkpXfZ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DD0710E185;
 Mon, 11 May 2026 08:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778486546; x=1810022546;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=xRZd89/2Cf/SyjbXMCN+xfbG4F9Wl1sZpFpdFn3/fl0=;
 b=bRTkpXfZipYYEvwPBfQq+6W45rh7Ujik26R2sUIBZaFrSov60LdhKaCG
 VEfmPxkKgtEFgr+Y7WfbKzYJ+0VxoM/KJhcutFJ9V6eIZgGmIIpLw02fC
 oYdrhf+cpZcFqbQ5ucKVKct8SNp4cqQGPaqumu2nimXdwpRyg6DIIWEpU
 LFSX9BQcG5+2WEgQQ5QMe+FoITevkO0FywFLGACs1XHQLtom83R3VUw+j
 MGkr4Njfu6+O5a5rNmrfHNF17H83KsQtZVyyIt2LreJNgT9epCjxQbFHX
 3CFuTdyaTDKV8IlRGNJErl5qxeh6M4TmlUYmzgAtrbWOF+jlFkH5JaWx7 g==;
X-CSE-ConnectionGUID: Yf7mPaYVRmq81UOrl5PRWQ==
X-CSE-MsgGUID: qd/Wh1nVRterzFb0bsp1LA==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="90469017"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; d="scan'208";a="90469017"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2026 01:02:22 -0700
X-CSE-ConnectionGUID: MkZCFCAYTlWHMvWT2AN/1A==
X-CSE-MsgGUID: 8PdQqgaOT/63IhSweIzyAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; d="scan'208";a="232903163"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.248])
 ([10.245.244.248])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2026 01:02:19 -0700
Message-ID: <ebc6a1f60e180e20eb5f599603c087e952c427e1.camel@linux.intel.com>
Subject: Re: [PATCH] drm/ttm: Convert -EAGAIN from dmem_cgroup_try_charge to
 -ENOSPC
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Maarten Lankhorst <dev@lankhorst.se>, intel-xe@lists.freedesktop.org
Cc: Friedrich Vock <friedrich.vock@gmx.de>, Tejun Heo <tj@kernel.org>, 
 Maxime Ripard <mripard@kernel.org>, Christian Koenig
 <christian.koenig@amd.com>, 	dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org
Date: Mon, 11 May 2026 10:02:17 +0200
In-Reply-To: <433c0bbd-6c47-4011-8551-d1cfd0b4e17c@lankhorst.se>
References: <20260508160920.230339-1-thomas.hellstrom@linux.intel.com>
 <433c0bbd-6c47-4011-8551-d1cfd0b4e17c@lankhorst.se>
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

On Fri, 2026-05-08 at 19:03 +0200, Maarten Lankhorst wrote:
> Hey,
>=20
> Den 2026-05-08 kl. 18:09, skrev Thomas Hellstr=C3=B6m:
> > dmem_cgroup_try_charge() returns -EAGAIN when the cgroup limit is
> > hit and the charge fails. TTM has no concept of -EAGAIN from
> > resource
> > allocation; -ENOSPC is the canonical error meaning "no space, try
> > eviction". Convert at the source in ttm_resource_alloc() so no
> > caller
> > needs to handle an unexpected error code, and clean up the now-
> > redundant
> > -EAGAIN check in ttm_bo_alloc_resource().
> >=20
> > Without this, -EAGAIN escaping ttm_resource_alloc() during an
> > eviction
> > walk causes the walk to terminate early instead of continuing to
> > the
> > next candidate.
> >=20
> > Cc: Friedrich Vock <friedrich.vock@gmx.de>
> > Cc: Maarten Lankhorst <dev@lankhorst.se>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: <stable@vger.kernel.org> # v6.14+
> > Fixes: 2b624a2c1865 ("drm/ttm: Handle cgroup based eviction in
> > TTM")
> > Assisted-by: GitHub_Copilot:claude-sonnet-4.6
> > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > ---
> > =C2=A0drivers/gpu/drm/ttm/ttm_bo.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 2 +-
> > =C2=A0drivers/gpu/drm/ttm/ttm_resource.c | 5 ++++-
> > =C2=A02 files changed, 5 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/ttm/ttm_bo.c
> > b/drivers/gpu/drm/ttm/ttm_bo.c
> > index d85f0a37ac35..cee3828df655 100644
> > --- a/drivers/gpu/drm/ttm/ttm_bo.c
> > +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> > @@ -739,7 +739,7 @@ static int ttm_bo_alloc_resource(struct
> > ttm_buffer_object *bo,
> > =C2=A0		may_evict =3D (force_space && place->mem_type !=3D
> > TTM_PL_SYSTEM);
> > =C2=A0		ret =3D ttm_resource_alloc(bo, place, res,
> > force_space ? &limit_pool : NULL);
> > =C2=A0		if (ret) {
> > -			if (ret !=3D -ENOSPC && ret !=3D -EAGAIN) {
> > +			if (ret !=3D -ENOSPC) {
> > =C2=A0				dmem_cgroup_pool_state_put(limit_p
> > ool);
> > =C2=A0				return ret;
> > =C2=A0			}
> > diff --git a/drivers/gpu/drm/ttm/ttm_resource.c
> > b/drivers/gpu/drm/ttm/ttm_resource.c
> > index 9f36631d48b6..b0efffe5a526 100644
> > --- a/drivers/gpu/drm/ttm/ttm_resource.c
> > +++ b/drivers/gpu/drm/ttm/ttm_resource.c
> > @@ -385,8 +385,11 @@ int ttm_resource_alloc(struct
> > ttm_buffer_object *bo,
> > =C2=A0
> > =C2=A0	if (man->cg) {
> > =C2=A0		ret =3D dmem_cgroup_try_charge(man->cg, bo-
> > >base.size, &pool, ret_limit_pool);
> > -		if (ret)
> > +		if (ret) {
> > +			if (ret =3D=3D -EAGAIN)
> > +				ret =3D -ENOSPC;
> > =C2=A0			return ret;
> > +		}
> > =C2=A0	}
> > =C2=A0
> > =C2=A0	ret =3D man->func->alloc(man, bo, place, res_ptr);
>=20
> Yeah looks reasonable with the conversion to callbacks.
>=20
> Reviewed-by: Maarten Lankhorst <dev@lankhrost.se>

Thanks for reviewing, Maarten!=C2=A0

@Christian, any concerns?

/Thomas
