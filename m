Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A26EFEA82E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 08:13:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E288810E813;
	Wed, 25 Mar 2026 08:13:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="C0i/W6Vs";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA3F710E813
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 08:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1774426404;
 bh=WydoKhH3XEj/QD1Z+s7HfeJNuR5uklS9W1mX1UN0rcw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=C0i/W6VsqGcEc/EnVHxyoh9Jz3t1+TYDfM0Spx8AUwXeZvFe+myDBR2szadil2f71
 2BBf9Emt0nPEJPpj3qUkd6DmgXbgHLc+1pdcxahTLC5PapdOBWYhCHBlY6dYTs1/Vb
 /lVGKhYj86fCLNSMxj1DaLr+r8nR5TJZ1EBAJAjvDvbVvaBwOHK5n5R2NPmhlFB/46
 7XOzs7mXb1VVp6X+B26TH7VmSU/dYciGssb2pHtig4uwZf6tJ+1FrFS50A8XEjlLkk
 i1eUWqM7phoSjytDqeFjaghc0So/HtAxrtT7tKRd/elzKO3fqkkzLYtzKDzxeeESEq
 hehnEKB52Tugg==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id B961917E51F7;
 Wed, 25 Mar 2026 09:13:23 +0100 (CET)
Date: Wed, 25 Mar 2026 09:13:19 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Akash Goel <akash.goel@arm.com>, Rob Clark
 <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, Konrad Dybcio
 <konradybcio@kernel.org>, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Dmitry
 Osipenko <dmitry.osipenko@collabora.com>, Chris Diamand
 <chris.diamand@arm.com>, Danilo Krummrich <dakr@kernel.org>, Matthew Brost
 <matthew.brost@intel.com>, Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?=
 <thomas.hellstrom@linux.intel.com>, Alice Ryhl <aliceryhl@google.com>,
 Chia-I Wu <olvaffe@gmail.com>, kernel@collabora.com
Subject: Re: [PATCH v5 9/9] drm/panthor: Add a GEM shrinker
Message-ID: <20260325091319.4a08dada@fedora>
In-Reply-To: <acMahMlSFs1ym-rU@sobremesa>
References: <20260309151119.290217-1-boris.brezillon@collabora.com>
 <20260309151119.290217-10-boris.brezillon@collabora.com>
 <acMahMlSFs1ym-rU@sobremesa>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Tue, 24 Mar 2026 23:52:32 +0000
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> > @@ -2178,8 +2222,10 @@ static int panthor_gpuva_sm_step_remap(struct dr=
m_gpuva_op *op,
> >  	 * atomicity. panthor_vm_lock_region() bails out early if the new reg=
ion
> >  	 * is already part of the locked region, so no need to do this check =
here.
> >  	 */
> > -	panthor_vm_lock_region(vm, unmap_start, unmap_range);
> > -	panthor_vm_unmap_pages(vm, unmap_start, unmap_range);
> > +	if (!unmap_vma->evicted) {
> > +		panthor_vm_lock_region(vm, unmap_start, unmap_range);
> > +		panthor_vm_unmap_pages(vm, unmap_start, unmap_range);
> > +	}
> >
> >  	if (op->remap.prev) { =20
>=20
> I think we'd want to make sure we don't map the pages for 'prev' when the=
 original unmap
> vma is evicted, but we still want to create a new vma for it.

Absolutely. I'll fix that in v6.

>=20
> >  		struct panthor_gem_object *bo =3D to_panthor_bo(op->remap.prev->gem.=
obj);
> > @@ -2193,6 +2239,7 @@ static int panthor_gpuva_sm_step_remap(struct drm=
_gpuva_op *op,
> >
> >  		prev_vma =3D panthor_vm_op_ctx_get_vma(op_ctx);
> >  		panthor_vma_init(prev_vma, unmap_vma->flags);
> > +		prev_vma->evicted =3D unmap_vma->evicted;
> >  	}
> >
> >  	if (op->remap.next) { =20
>=20
> Same as above.

Yep, will be fixed in v6.

> > +void panthor_vm_update_bo_reclaim_lru_locked(struct panthor_gem_object=
 *bo)
> > +{
> > +	struct panthor_device *ptdev =3D container_of(bo->base.dev, struct pa=
nthor_device, base);
> > +	struct panthor_vm *vm =3D NULL;
> > +	struct drm_gpuvm_bo *vm_bo;
> > +
> > +	dma_resv_assert_held(bo->base.resv);
> > +	lockdep_assert_held(&bo->base.gpuva.lock);
> > +
> > +	drm_gem_for_each_gpuvm_bo(vm_bo, &bo->base) {
> > +		if (vm_bo->evicted)
> > +			continue; =20
>=20
> I found this a bit confusing, because this function is called for objects=
 whose state is
> PANTHOR_GEM_GPU_MAPPED_PRIVATE, described as 'GEM is GPU mapped to only o=
ne VM'. So that
> made me think it was synonymous to panthor_gem_object::exclusive_vm_root_=
gem being set, but
> according to this code, a BO is shrinker-private if only one of its VM_BO=
's isn't evicted
> at any given time. I guess this definition is what matters wrt the shrink=
er, because it can
> go straight pick it up from the VM's reclaim.lru list. Maybe it'd be less=
 confusing if
> the uAPI header file's description of PANTHOR_GEM_GPU_MAPPED_PRIVATE refl=
ected this too?

I'll rename PANTHOR_GEM_GPU_MAPPED_PRIVATE into
PANTHOR_GEM_GPU_MAPPED_SINGLE_VM and PANTHOR_GEM_GPU_MAPPED_SHARED into
PANTHOR_GEM_GPU_MAPPED_MULTI_VM to clear the confusion.

>=20
> > +		/* We're only supposed to have one non-evicted vm_bo in the list if =
we get
> > +		 * there.
> > +		 */
> > +		drm_WARN_ON(&ptdev->base, vm);
> > +		vm =3D container_of(vm_bo->vm, struct panthor_vm, base);
> > +
> > +		mutex_lock(&ptdev->reclaim.lock);
> > +		drm_gem_lru_move_tail_locked(&vm->reclaim.lru, &bo->base);
> > +		if (list_empty(&vm->reclaim.lru_node))
> > +			list_move(&vm->reclaim.lru_node, &ptdev->reclaim.vms);
> > +		mutex_unlock(&ptdev->reclaim.lock);
> > +	}
> > +}
