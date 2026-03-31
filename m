Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A06E1061B26
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 10:19:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB87A10E8E2;
	Tue, 31 Mar 2026 10:19:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OTL/A8Zu";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B144E10E8E0;
 Tue, 31 Mar 2026 10:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774952345; x=1806488345;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=blz/jUK8AtcaMi8EKklPzfx4JUx4Tdr61s7OVRw3Rl0=;
 b=OTL/A8ZuPCfypViYy4TGQq+4C0d6O8gdM7/SqO1u9Mo1bfPD9zOprnZx
 7/3XO8uhgaSRK0LuLow1zYDDs5ipjq/489Nnaba7n475wQAv9HnkJki5Z
 hhrpgj30MweDPTcZMFjRhrYLrX48SkluwcNVwIvox6R3FxaGp/5sGQrMz
 W9VAKx8JD7Of+jslRANbg4B41hYddkr7kIysPVc/co/Hh/YhPHpdCAQ0b
 tDgr43a+nPAImIHaPVicWeYgcsGZJ3s3DwxPBib5BLoMGulG4OqQg5clX
 sVUkUqJFBpkTV0ELnA4gNoNEGzp8iBc5WPPqndj8yb5kdD3uF0LQkucNk g==;
X-CSE-ConnectionGUID: uYsSETx9TlG8CLXs0Ub8+g==
X-CSE-MsgGUID: 6j/hPR+ITU6v+N+dI0SR7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="101416702"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="101416702"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 03:19:04 -0700
X-CSE-ConnectionGUID: d5Zw98KhQpm13p8szeFkBw==
X-CSE-MsgGUID: gyJmIAwEQLWN0YQkUMVi4Q==
X-ExtLoop1: 1
Received: from smoticic-mobl1.ger.corp.intel.com (HELO [10.245.244.28])
 ([10.245.244.28])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 03:18:59 -0700
Message-ID: <7971009f03546a98f6137b18195b135e5e2eeee8.camel@linux.intel.com>
Subject: Re: [PATCH 5/5] drm/exec, drm/xe, drm/amdgpu: Add an accessor for
 struct drm_exec::ticket
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 intel-xe@lists.freedesktop.org
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher	
 <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>, Simona
 Vetter	 <simona@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Danilo Krummrich
 <dakr@kernel.org>,  Matthew Brost <matthew.brost@intel.com>, Alice Ryhl
 <aliceryhl@google.com>, Rob Clark	 <robin.clark@oss.qualcomm.com>, Dmitry
 Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul	 <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Date: Tue, 31 Mar 2026 12:18:56 +0200
In-Reply-To: <ac68886e-d4f0-408b-9ddc-909cda18c6f5@amd.com>
References: <20260331092023.81616-1-thomas.hellstrom@linux.intel.com>
 <20260331092023.81616-6-thomas.hellstrom@linux.intel.com>
 <ac68886e-d4f0-408b-9ddc-909cda18c6f5@amd.com>
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

Hi,

On Tue, 2026-03-31 at 11:46 +0200, Christian K=C3=B6nig wrote:
> On 3/31/26 11:20, Thomas Hellstr=C3=B6m wrote:
> > Drivers were accessing this drm_exec member directly.
>=20
> I don't see a problem with that as long as we have documented that
> this is allowed.

It's more of forward-looking for the case I mentioned in the cover-
letter. If drm_exec becomes a subclass of a drm_transaction or
whatever, then this would likely be &exec->txn.ticket;

Could ofc postpone that to any such refactor, but since the patch is up
for review...

Thanks,
Thomas


>=20
> Regards,
> Christian.
>=20
> > Provide an accessor, drm_exec_ticket() to avoid that.
> >=20
> > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > ---
> > =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++--
> > =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 6 +++---
> > =C2=A0drivers/gpu/drm/xe/xe_validation.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
> > =C2=A0include/drm/drm_exec.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 5 +++++
> > =C2=A04 files changed, 12 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > index 29b400cdd6d5..8a4fb9a62485 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > @@ -2998,7 +2998,7 @@ int
> > amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct
> > dma_fence __rcu *
> > =C2=A0	/* Validate PDs, PTs and evicted DMABuf imports last.
> > Otherwise BO
> > =C2=A0	 * validations above would invalidate DMABuf imports
> > again.
> > =C2=A0	 */
> > -	ret =3D process_validate_vms(process_info, &exec.ticket);
> > +	ret =3D process_validate_vms(process_info,
> > drm_exec_ticket(exec));
> > =C2=A0	if (ret) {
> > =C2=A0		pr_debug("Validating VMs failed, ret: %d\n", ret);
> > =C2=A0		goto validate_map_fail;
> > @@ -3039,7 +3039,7 @@ int
> > amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct
> > dma_fence __rcu *
> > =C2=A0			goto validate_map_fail;
> > =C2=A0		}
> > =C2=A0
> > -		ret =3D amdgpu_vm_handle_moved(adev, peer_vm,
> > &exec.ticket);
> > +		ret =3D amdgpu_vm_handle_moved(adev, peer_vm,
> > drm_exec_ticket(exec));
> > =C2=A0		if (ret) {
> > =C2=A0			dev_dbg(adev->dev,
> > =C2=A0				"Memory eviction: handle moved
> > failed, pid %8d. Try again.\n",
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > index c4ee19603460..c725a7976c63 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > @@ -1157,7 +1157,7 @@ static int amdgpu_cs_vm_handling(struct
> > amdgpu_cs_parser *p)
> > =C2=A0			return r;
> > =C2=A0	}
> > =C2=A0
> > -	r =3D amdgpu_vm_handle_moved(adev, vm, &p->exec.ticket);
> > +	r =3D amdgpu_vm_handle_moved(adev, vm, drm_exec_ticket(&p-
> > >exec));
> > =C2=A0	if (r)
> > =C2=A0		return r;
> > =C2=A0
> > @@ -1358,7 +1358,7 @@ static int amdgpu_cs_submit(struct
> > amdgpu_cs_parser *p,
> > =C2=A0	cs->out.handle =3D seq;
> > =C2=A0	leader->uf_sequence =3D seq;
> > =C2=A0
> > -	amdgpu_vm_bo_trace_cs(&fpriv->vm, &p->exec.ticket);
> > +	amdgpu_vm_bo_trace_cs(&fpriv->vm, drm_exec_ticket(&p-
> > >exec));
> > =C2=A0	for (i =3D 0; i < p->gang_size; ++i) {
> > =C2=A0		amdgpu_job_free_resources(p->jobs[i]);
> > =C2=A0		trace_amdgpu_cs_ioctl(p->jobs[i]);
> > @@ -1793,7 +1793,7 @@ int amdgpu_cs_find_mapping(struct
> > amdgpu_cs_parser *parser,
> > =C2=A0	*map =3D mapping;
> > =C2=A0
> > =C2=A0	/* Double check that the BO is reserved by this CS */
> > -	if (dma_resv_locking_ctx((*bo)->tbo.base.resv) !=3D &parser-
> > >exec.ticket)
> > +	if (dma_resv_locking_ctx((*bo)->tbo.base.resv) !=3D
> > drm_exec_ticket(&parser->exec))
> > =C2=A0		return -EINVAL;
> > =C2=A0
> > =C2=A0	/* Make sure VRAM is allocated contigiously */
> > diff --git a/drivers/gpu/drm/xe/xe_validation.c
> > b/drivers/gpu/drm/xe/xe_validation.c
> > index a611438eaafe..8dff4d0ec895 100644
> > --- a/drivers/gpu/drm/xe/xe_validation.c
> > +++ b/drivers/gpu/drm/xe/xe_validation.c
> > @@ -156,7 +156,7 @@ int xe_validation_ctx_init(struct
> > xe_validation_ctx *ctx, struct xe_validation_d
> > =C2=A0
> > =C2=A0#ifdef CONFIG_DEBUG_WW_MUTEX_SLOWPATH
> > =C2=A0/*
> > - * This abuses both drm_exec and ww_mutex internals and should be
> > + * This abuses ww_mutex internals and should be
> > =C2=A0 * replaced by checking for -EDEADLK when we can make TTM
> > =C2=A0 * stop converting -EDEADLK to -ENOMEM.
> > =C2=A0 * An alternative is to not have exhaustive eviction with
> > @@ -164,7 +164,7 @@ int xe_validation_ctx_init(struct
> > xe_validation_ctx *ctx, struct xe_validation_d
> > =C2=A0 */
> > =C2=A0static bool xe_validation_contention_injected(struct drm_exec
> > *exec)
> > =C2=A0{
> > -	return !!exec->ticket.contending_lock;
> > +	return !!drm_exec_ticket(exec)->contending_lock;
> > =C2=A0}
> > =C2=A0
> > =C2=A0#else
> > diff --git a/include/drm/drm_exec.h b/include/drm/drm_exec.h
> > index 5ed5be1f8244..50d056a87de0 100644
> > --- a/include/drm/drm_exec.h
> > +++ b/include/drm/drm_exec.h
> > @@ -151,6 +151,11 @@ static inline bool
> > drm_exec_is_contended(struct drm_exec *exec)
> > =C2=A0		goto *__drm_exec_retry_ptr;		\
> > =C2=A0	} while (0)
> > =C2=A0
> > +static inline struct ww_acquire_ctx *drm_exec_ticket(struct
> > drm_exec *exec)
> > +{
> > +	return &exec->ticket;
> > +}
> > +
> > =C2=A0void drm_exec_init(struct drm_exec *exec, u32 flags, unsigned nr)=
;
> > =C2=A0void drm_exec_fini(struct drm_exec *exec);
> > =C2=A0bool drm_exec_cleanup(struct drm_exec *exec);
