Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BE8C44500
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:42:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64C2710E4B3;
	Tue,  7 Jul 2026 12:42:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Ls3K45+T";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FD9789226;
 Tue,  7 Jul 2026 12:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783428120; x=1814964120;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=oLxyLktYGNMszk3W/9KmRAP6Lv0GJ8nHgtRDf5wsq7Q=;
 b=Ls3K45+TD4se66v4g7vQW+pVBZLuSCXhNMHcO1/x7JYg/ZJGxdW+Wr2L
 ioDnVEmPAC9QeLOoiHb6JBKV6jZFcSnBZIvypw26G1sVqkzXxYb2Gv0sP
 RkD3irW2cQ15o9gjgxKEmn8LuZ+pU917H7Cf+3EgVpxzXUqZ9tAWEnvtS
 DnbpGewLgLCRzGsB4VZWWmcgZ2AGuCxzbVEDMuGhY9r7daby+2+Op0MO7
 vYF5meT6WG1iJOMCoOKoV2sbNmpAPeBR6br3G5UOJUT0Nd77VlLd8OEAh
 97hPW0mGuMNxeS+b9pzDQBNWtwiKcpLxxzlVl8DiyD1N3yevRg2whD/EM w==;
X-CSE-ConnectionGUID: 5zJbvexJQHKOf0izA32bZw==
X-CSE-MsgGUID: NCIU4sCgSPuHGOUnuKXu7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="95452012"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="95452012"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2026 05:41:59 -0700
X-CSE-ConnectionGUID: mPdUbNyyRx+oyuNH9e3/dw==
X-CSE-MsgGUID: XEnS8VB2QBa4q5tY8f8zYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="258299506"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.199])
 ([10.245.244.199])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2026 05:41:54 -0700
Message-ID: <6fac8343dc71b1dbf17e77390cc878cfaeb6d650.camel@linux.intel.com>
Subject: Re: [PATCH 01/10] drm/exec: Add helper to bypass IGNORE_DUPLICATES
 flag
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Natalie
 Vock <natalie.vock@gmx.de>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen	 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>,  Tvrtko Ursulin <tursulin@ursulin.net>, Huang Rui
 <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,  Matthew Brost
 <matthew.brost@intel.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
Date: Tue, 07 Jul 2026 14:41:52 +0200
In-Reply-To: <0f85e12e-7d34-40a8-9efc-0d1a00b7c24c@amd.com>
References: <20260703-ttm_2_drm_exec-v1-0-43685ac1286b@gmx.de>
 <20260703-ttm_2_drm_exec-v1-1-43685ac1286b@gmx.de>
 <673ae71a1fc4dcce0e6a1655985a141d6f08c06f.camel@linux.intel.com>
 <0f85e12e-7d34-40a8-9efc-0d1a00b7c24c@amd.com>
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

On Tue, 2026-07-07 at 14:28 +0200, Christian K=C3=B6nig wrote:
> On 7/7/26 14:09, Thomas Hellstr=C3=B6m wrote:
> > On Fri, 2026-07-03 at 18:31 +0200, Natalie Vock wrote:
> > > TTM is about to switch to drm_exec for locking objects
> > > in the LRU list. When we're done processing the object, we want
> > > to
> > > unlock it only if the caller doesn't already hold that lock. If
> > > DRM_EXEC_IGNORE_DUPLICATES is set on the exec object (which
> > > callers
> > > may
> > > require for unrelated reasons), we have no way of knowing whether
> > > the
> > > lock is already held.
> > >=20
> > > To remedy this, add a separate helper that forcefully bypasses
> > > the
> > > IGNORE_DUPLICATES flag for only a single locking operation.
> > >=20
> > > Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
> >=20
> > The first, more complete attempt to try to tackle the exhaustive
> > eviction introduced a drm_exec snapshot ability instead.
> >=20
> > https://lists.freedesktop.org/archives/intel-xe/2024-May/035820.html
> >=20
> > The idea was that one would want to incrementally lock more buffer
> > objects until the validation succeeded, rather than dropping each
> > single lock after processing the eviction. That's actually what
> > guarantees forward progress. Restoring the snapshot unlocked all
> > locks
> > that we grabbed in the process, and would work also for single
> > locks.
>=20
> That's actually not what this patch here tries to solve.
>=20
> The problem is rather since we don't remove the BOs from the LRU list
> that we try to evict some which are actually part of our working set.
>=20
> So when we lock for eviction we can't ignore duplicates no matter
> what the global flag says.

Ah yes, I see that now when I've gotten to patch 9. But then I think
the commit message is a bit misleading. It talks about unlocking an
already processed object?

Thanks,
Thomas


>=20
> Regards,
> Christian.
>=20
> >=20
> > Thanks,
> > Thomas
> >=20
> >=20
> > > ---
> > > =C2=A0drivers/gpu/drm/drm_exec.c | 52
> > > ++++++++++++++++++++++++++++++++++--
> > > ----------
> > > =C2=A0include/drm/drm_exec.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
> > > =C2=A02 files changed, 41 insertions(+), 13 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/drm_exec.c
> > > b/drivers/gpu/drm/drm_exec.c
> > > index 7988f5e7d56a3..91de6b4d29df8 100644
> > > --- a/drivers/gpu/drm/drm_exec.c
> > > +++ b/drivers/gpu/drm/drm_exec.c
> > > @@ -190,18 +190,9 @@ static int drm_exec_lock_contended(struct
> > > drm_exec *exec)
> > > =C2=A0	return ret;
> > > =C2=A0}
> > > =C2=A0
> > > -/**
> > > - * drm_exec_lock_obj - lock a GEM object for use
> > > - * @exec: the drm_exec object with the state
> > > - * @obj: the GEM object to lock
> > > - *
> > > - * Lock a GEM object for use and grab a reference to it.
> > > - *
> > > - * Returns: -EDEADLK if a contention is detected, -EALREADY when
> > > object is
> > > - * already locked (can be suppressed by setting the
> > > DRM_EXEC_IGNORE_DUPLICATES
> > > - * flag), -ENOMEM when memory allocation failed and zero for
> > > success.
> > > - */
> > > -int drm_exec_lock_obj(struct drm_exec *exec, struct
> > > drm_gem_object
> > > *obj)
> > > +static int __drm_exec_lock_obj(struct drm_exec *exec,
> > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_gem_object *obj,
> > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool always_report_duplicate=
s)
> > > =C2=A0{
> > > =C2=A0	int ret;
> > > =C2=A0
> > > @@ -226,7 +217,7 @@ int drm_exec_lock_obj(struct drm_exec *exec,
> > > struct drm_gem_object *obj)
> > > =C2=A0		return -EDEADLK;
> > > =C2=A0	}
> > > =C2=A0
> > > -	if (unlikely(ret =3D=3D -EALREADY) &&
> > > +	if (unlikely(ret =3D=3D -EALREADY) &&
> > > !always_report_duplicates
> > > &&
> > > =C2=A0	=C2=A0=C2=A0=C2=A0 exec->flags & DRM_EXEC_IGNORE_DUPLICATES)
> > > =C2=A0		return 0;
> > > =C2=A0
> > > @@ -243,8 +234,43 @@ int drm_exec_lock_obj(struct drm_exec *exec,
> > > struct drm_gem_object *obj)
> > > =C2=A0	dma_resv_unlock(obj->resv);
> > > =C2=A0	return ret;
> > > =C2=A0}
> > > +
> > > +/**
> > > + * drm_exec_lock_obj - lock a GEM object for use
> > > + * @exec: the drm_exec object with the state
> > > + * @obj: the GEM object to lock
> > > + *
> > > + * Lock a GEM object for use and grab a reference to it.
> > > + *
> > > + * Returns: -EDEADLK if a contention is detected, -EALREADY when
> > > object is
> > > + * already locked (can be suppressed by setting the
> > > DRM_EXEC_IGNORE_DUPLICATES
> > > + * flag), -ENOMEM when memory allocation failed and zero for
> > > success.
> > > + */
> > > +int drm_exec_lock_obj(struct drm_exec *exec, struct
> > > drm_gem_object
> > > *obj)
> > > +{
> > > +	return __drm_exec_lock_obj(exec, obj, false);
> > > +}
> > > =C2=A0EXPORT_SYMBOL(drm_exec_lock_obj);
> > > =C2=A0
> > > +/**
> > > + * drm_exec_lock_obj_report_dup - lock a GEM object for use, but
> > > always report duplicates
> > > + * @exec: the drm_exec object with the state
> > > + * @obj: the GEM object to lock
> > > + *
> > > + * Like drm_exec_lock_obj, lock a GEM object for use and grab a
> > > reference to it.
> > > + * Unlike drm_exec_lock_obj, DRM_EXEC_IGNORE_DUPLICATES is
> > > ignored
> > > and duplicates are
> > > + * always reported.
> > > + *
> > > + * Returns: -EDEADLK if a contention is detected, -EALREADY when
> > > object is
> > > + * already locked, -ENOMEM when memory allocation failed and
> > > zero
> > > for success.
> > > + */
> > > +int drm_exec_lock_obj_report_dup(struct drm_exec *exec,
> > > +				 struct drm_gem_object *obj)
> > > +{
> > > +	return __drm_exec_lock_obj(exec, obj, false);
> > > +}
> > > +EXPORT_SYMBOL(drm_exec_lock_obj_report_dup);
> > > +
> > > =C2=A0/**
> > > =C2=A0 * drm_exec_unlock_obj - unlock a GEM object in this exec
> > > context
> > > =C2=A0 * @exec: the drm_exec object with the state
> > > diff --git a/include/drm/drm_exec.h b/include/drm/drm_exec.h
> > > index 8725ba92ff916..ff80dd2b72240 100644
> > > --- a/include/drm/drm_exec.h
> > > +++ b/include/drm/drm_exec.h
> > > @@ -176,6 +176,8 @@ void drm_exec_init(struct drm_exec *exec, u32
> > > flags, unsigned nr);
> > > =C2=A0void drm_exec_fini(struct drm_exec *exec);
> > > =C2=A0bool drm_exec_cleanup(struct drm_exec *exec);
> > > =C2=A0int drm_exec_lock_obj(struct drm_exec *exec, struct
> > > drm_gem_object
> > > *obj);
> > > +int drm_exec_lock_obj_report_dup(struct drm_exec *exec,
> > > +				 struct drm_gem_object *obj);
> > > =C2=A0void drm_exec_unlock_obj(struct drm_exec *exec, struct
> > > drm_gem_object *obj);
> > > =C2=A0int drm_exec_prepare_obj(struct drm_exec *exec, struct
> > > drm_gem_object *obj,
> > > =C2=A0			 unsigned int num_fences);
