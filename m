Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2DC606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=quDvWSPp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7090110E3A6;
	Thu, 26 Nov 2026 15:42:09 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EBC110E3A6;
 Thu, 26 Nov 2026 15:42:03 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.12/8.18.1.12) with ESMTP id
 6AQ601L7207786; Thu, 26 Nov 2026 15:41:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=R
 0vk9Xr0GAeNMLaj1AyxWvtgdsYa2pacID3HohZ4fAY=; b=quDvWSPpQHwtg9jo/
 ie39tlZQqn+pKlEZ7RiOuR4NHeSA1JGZ3aCHlRtCbvS0+EWqt9nxQPJ9Dj+KTWD9
 OHnYBaNj4zqT8xpY1CbK1shxdgTeeVFW5ve+lE4d6CntpTeRXPURBxvnIxi6rmmI
 Pwj8ogy9w6qnb8zNHje+g7ftvaxIm8wyb72w9TJep5qDuZhN/a5gC/w0O5TEE7mg
 Kt4So1+sGZ2OkPma4Ee6EtullmTq5DnW7zCXfOlzmi8EtSqb8s4n7NYUs6DVj9bj
 aS29v02dGfCP+gwznnYgY3rPbmf4wOpA+wHyX+D6HnWHk2s+JKy3SUkygXNx+0uL
 4Ec1Q==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4j3491mf0e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT
 key_exchange=secp384r1); Thu, 26 Nov 2026 15:41:44 +0000 (GMT)
Received: from np-a-belle.kl.imgtec.org (172.25.6.177) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 26 Nov 2026 15:41:42 +0000
Message-ID: <2a2762cc2a4ec785a8b390b2b01900a8fcd18bc4.camel@imgtec.com>
Subject: Re: [PATCH v2 1/2] drm/imagination: Switch the GPUVM to immediate mode
From: Luigi Santivetti <luigi.santivetti@imgtec.com>
To: Gyeyoung Baek <gye976@gmail.com>, Alessio Belle <alessio.belle@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Alexandru Dadu <alexandru.dadu@imgtec.com>, Brajesh Gupta
 <brajesh.gupta@imgtec.com>, Frank Binns <frank.binns@imgtec.com>,
 <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Date: Thu, 26 Nov 2026 15:41:37 +0000
In-Reply-To: <20261011-pvr-gpuvm-immediate-v2-1-744ddc6644c3@gmail.com>
References: <20261011-pvr-gpuvm-immediate-v2-0-744ddc6644c3@gmail.com>
 <20261011-pvr-gpuvm-immediate-v2-1-744ddc6644c3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA2MSBTYWx0ZWRfXzvp3Ldqltkq6
 ObbEXMrgnOM5TVwUQzVhFnnuI33AUZMvYXFI+mFX++4GCtrmFM0Q2mGeGMWr4+k2KbjAeI2s6F9
 AmX6x3v6x2Ja9ZCp5tZAbt0zbHj9rewOFrgCUFp0VsfJvTwT/uRD/OrPBvNMrJE8ahd1COjLW69
 sT1K9HJtwHkuyjTKB9Q8Xj4yHKSAb8Cf5pwdkqYi4iLHHDeffXyTdhEXpKGC103Tk5O6XHVAb7+
 Bdp9BjwHOKVrafT5H5PGC7JgFjp/cFyjQ1YCythOiz2/dlVhqhayhUqaxSeTMs3VPVfqPZUIm+J
 Smqj1OGeivyDiyNPZXRGB/94DEgrGlbfbwfXowraoi1WrUUoFtrGlT3T5s/Zd/U0RAahw8B3g0f
 miZ0KKnr3cewkCKs0qlvt+DE1OI3qt3onq5bFgyvXnQ+yyYa0fMurL7om4Qc0a0HsXNTUJ34OGk
 WgkJyLh9pM4Pppauz0A==
X-Authority-Analysis: v=2.4 cv=OaENnRTY c=1 sm=1 tr=0 ts=6b085338 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=2JH569OHYJkA:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=pGLkceISAAAA:8 a=r_1tXGB3AAAA:8 a=tVqdclijkGfU5qPxdxoA:9 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA2MSBTYWx0ZWRfXzZOZdfU3lIpm
 p3Vu1lQ3tAKoE3dS/fjQ/7HKTbHq8fdbnHZabNoZ0CbTu7RPqmxZn971e7KX5F+/oc7wowbfeSM
 KB/3fatClfJ/skaIXdEqMrJnJC/WfOI=
X-Proofpoint-GUID: DGfp3y2LbSSuiq_8Bj_yk8GrEEZVuo9y
X-Proofpoint-ORIG-GUID: DGfp3y2LbSSuiq_8Bj_yk8GrEEZVuo9y
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Gyeyoung,

this patch (and the next) was tested with a CTS cycle and results showed no
regressions.

On Sun, 2026-10-11 at 18:45 +0900, Gyeyoung Baek wrote:
> Use DRM_GPUVM_IMMEDIATE_MODE so that each GEM's GPUVA list is protected
> by its gpuva.lock instead of its dma_resv. This prepares for
> asynchronous VM_BIND, whose run_job() will update the GPUVA lists
> before signalling its fence. That section imposes three rules:
>=20
> 1. No dma_resv: another thread may hold it while waiting for the job's
>    fence, directly or through a dependency.
>    -> Protect the lists with gpuva.lock, and take it around
>       drm_gpuva_link().
>=20
> 2. No allocation under a lock run_job() takes: reclaim may wait for a
>    fence that depends on the job.
>    -> Allocate the vm_bo before taking gpuva.lock:
>       drm_gpuvm_bo_obtain_locked() becomes drm_gpuvm_bo_create() +
>       drm_gpuvm_bo_obtain_prealloc().
>=20
> 3. No freeing of GEM objects: that takes their dma_resv, and under
>    gpuva.lock would free the held lock too.
>    -> Defer it: drm_gpuva_unlink() and drm_gpuvm_bo_put() become
>       drm_gpuva_unlink_defer() and drm_gpuvm_bo_put_deferred(), and
>       drm_gpuvm_bo_deferred_cleanup() frees once the locks are dropped.
>=20
> This also fixes an unlocked GPUVA list update: when a map fails,
> pvr_vm_bind_op_fini() drops the last vm_bo reference without holding
> the object's dma_resv.
>=20
> Failing VM_MAP allocations with fail-nth shows
> it on a lockdep kernel (real allocation failures under memory pressure
> take the same path):
>=20
>   WARNING: drivers/gpu/drm/drm_gpuvm.c:1661 at drm_gpuvm_bo_put+0x2ec/0x6=
60 [drm_gpuvm]
>   Call trace:
>    drm_gpuvm_bo_put
>    pvr_vm_bind_op_fini
>    pvr_vm_map
>    pvr_ioctl_vm_map
>=20
> Fixes: ff5f643de0bf ("drm/imagination: Add GEM and VM related code")
> Signed-off-by: Gyeyoung Baek <gye976@gmail.com>

Reviewed-by: Luigi Santivetti <luigi.santivetti@imgtec.com>

> ---
>  drivers/gpu/drm/imagination/pvr_vm.c | 39 +++++++++++++++++++++++++++---=
------
>  1 file changed, 30 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagi=
nation/pvr_vm.c
> index cbdd15ed74f..807a01aab1d 100644
> --- a/drivers/gpu/drm/imagination/pvr_vm.c
> +++ b/drivers/gpu/drm/imagination/pvr_vm.c
> @@ -214,7 +214,7 @@ static int pvr_vm_bind_op_exec(struct pvr_vm_bind_op =
*bind_op)
> =20
>  static void pvr_vm_bind_op_fini(struct pvr_vm_bind_op *bind_op)
>  {
> -	drm_gpuvm_bo_put(bind_op->gpuvm_bo);
> +	drm_gpuvm_bo_put_deferred(bind_op->gpuvm_bo);
> =20
>  	kfree(bind_op->new_va);
>  	kfree(bind_op->prev_va);
> @@ -255,11 +255,11 @@ pvr_vm_bind_op_map_init(struct pvr_vm_bind_op *bind=
_op,
> =20
>  	bind_op->type =3D PVR_VM_BIND_TYPE_MAP;
> =20
> -	dma_resv_lock(obj->resv, NULL);
> -	bind_op->gpuvm_bo =3D drm_gpuvm_bo_obtain_locked(&vm_ctx->gpuvm_mgr, ob=
j);
> -	dma_resv_unlock(obj->resv);
> -	if (IS_ERR(bind_op->gpuvm_bo))
> -		return PTR_ERR(bind_op->gpuvm_bo);
> +	bind_op->gpuvm_bo =3D drm_gpuvm_bo_create(&vm_ctx->gpuvm_mgr, obj);
> +	if (!bind_op->gpuvm_bo)
> +		return -ENOMEM;
> +
> +	bind_op->gpuvm_bo =3D drm_gpuvm_bo_obtain_prealloc(bind_op->gpuvm_bo);
> =20
>  	bind_op->new_va =3D kzalloc_obj(*bind_op->new_va);
>  	bind_op->prev_va =3D kzalloc_obj(*bind_op->prev_va);
> @@ -293,6 +293,8 @@ pvr_vm_bind_op_map_init(struct pvr_vm_bind_op *bind_o=
p,
> =20
>  err_bind_op_fini:
>  	pvr_vm_bind_op_fini(bind_op);
> +	/* Drain what fini() deferred. */
> +	drm_gpuvm_bo_deferred_cleanup(&vm_ctx->gpuvm_mgr);
> =20
>  	return err;
>  }
> @@ -366,7 +368,11 @@ pvr_vm_gpuva_map(struct drm_gpuva_op *op, void *op_c=
tx)
>  		return err;
> =20
>  	drm_gpuva_map(&ctx->vm_ctx->gpuvm_mgr, &ctx->new_va->base, &op->map);
> +
> +	mutex_lock(&op->map.gem.obj->gpuva.lock);
>  	drm_gpuva_link(&ctx->new_va->base, ctx->gpuvm_bo);
> +	mutex_unlock(&op->map.gem.obj->gpuva.lock);
> +
>  	ctx->new_va =3D NULL;
> =20
>  	return 0;
> @@ -396,7 +402,7 @@ pvr_vm_gpuva_unmap(struct drm_gpuva_op *op, void *op_=
ctx)
>  		return err;
> =20
>  	drm_gpuva_unmap(&op->unmap);
> -	drm_gpuva_unlink(op->unmap.va);
> +	drm_gpuva_unlink_defer(op->unmap.va);
>  	kfree(to_pvr_vm_gpuva(op->unmap.va));
> =20
>  	return 0;
> @@ -418,6 +424,7 @@ pvr_vm_gpuva_unmap(struct drm_gpuva_op *op, void *op_=
ctx)
>  static int
>  pvr_vm_gpuva_remap(struct drm_gpuva_op *op, void *op_ctx)
>  {
> +	struct drm_gem_object *obj =3D op->remap.unmap->va->gem.obj;
>  	/* The split parts belong to the object of the mapping being split. */
>  	struct drm_gpuvm_bo *vm_bo =3D op->remap.unmap->va->vm_bo;
>  	struct pvr_vm_bind_op *ctx =3D op_ctx;
> @@ -435,16 +442,20 @@ pvr_vm_gpuva_remap(struct drm_gpuva_op *op, void *o=
p_ctx)
>  	drm_gpuva_remap(&ctx->prev_va->base, &ctx->next_va->base, &op->remap);
> =20
>  	if (op->remap.prev) {
> +		mutex_lock(&obj->gpuva.lock);
>  		drm_gpuva_link(&ctx->prev_va->base, vm_bo);
> +		mutex_unlock(&obj->gpuva.lock);
>  		ctx->prev_va =3D NULL;
>  	}
> =20
>  	if (op->remap.next) {
> +		mutex_lock(&obj->gpuva.lock);
>  		drm_gpuva_link(&ctx->next_va->base, vm_bo);
> +		mutex_unlock(&obj->gpuva.lock);
>  		ctx->next_va =3D NULL;
>  	}
> =20
> -	drm_gpuva_unlink(op->remap.unmap->va);
> +	drm_gpuva_unlink_defer(op->remap.unmap->va);
>  	kfree(to_pvr_vm_gpuva(op->remap.unmap->va));
> =20
>  	return 0;
> @@ -588,7 +599,8 @@ pvr_vm_create_context(struct pvr_device *pvr_dev, boo=
l is_userspace_context)
>  	drm_gem_private_object_init(&pvr_dev->base, &vm_ctx->dummy_gem, 0);
>  	drm_gpuvm_init(&vm_ctx->gpuvm_mgr,
>  		       is_userspace_context ? "PowerVR-user-VM" : "PowerVR-FW-VM",
> -		       0, &pvr_dev->base, &vm_ctx->dummy_gem,
> +		       DRM_GPUVM_IMMEDIATE_MODE, &pvr_dev->base,
> +		       &vm_ctx->dummy_gem,
>  		       0, 1ULL << device_addr_bits, 0, 0, &pvr_vm_gpuva_ops);
> =20
>  	mutex_init(&vm_ctx->lock);
> @@ -622,6 +634,7 @@ pvr_vm_context_release(struct kref *ref_count)
>  		pvr_fw_object_destroy(vm_ctx->fw_mem_ctx_obj);
> =20
>  	pvr_vm_unmap_all(vm_ctx);
> +	drm_gpuvm_bo_deferred_cleanup(&vm_ctx->gpuvm_mgr);
> =20
>  	pvr_mmu_context_destroy(vm_ctx->mmu_ctx);
>  	drm_gem_private_object_fini(&vm_ctx->dummy_gem);
> @@ -758,7 +771,9 @@ pvr_vm_map(struct pvr_vm_context *vm_ctx, struct pvr_=
gem_object *pvr_obj,
> =20
>  err_cleanup:
>  	mutex_unlock(&vm_ctx->lock);
> +
>  	pvr_vm_bind_op_fini(&bind_op);
> +	drm_gpuvm_bo_deferred_cleanup(&vm_ctx->gpuvm_mgr);
> =20
>  	return err;
>  }
> @@ -840,6 +855,8 @@ pvr_vm_unmap_obj(struct pvr_vm_context *vm_ctx, struc=
t pvr_gem_object *pvr_obj,
>  	err =3D pvr_vm_unmap_obj_locked(vm_ctx, pvr_obj, device_addr, size);
>  	mutex_unlock(&vm_ctx->lock);
> =20
> +	drm_gpuvm_bo_deferred_cleanup(&vm_ctx->gpuvm_mgr);
> +
>  	return err;
>  }
> =20
> @@ -874,6 +891,8 @@ pvr_vm_unmap(struct pvr_vm_context *vm_ctx, u64 devic=
e_addr, u64 size)
> =20
>  	mutex_unlock(&vm_ctx->lock);
> =20
> +	drm_gpuvm_bo_deferred_cleanup(&vm_ctx->gpuvm_mgr);
> +
>  	return err;
>  }
> =20
> @@ -906,6 +925,8 @@ pvr_vm_unmap_all(struct pvr_vm_context *vm_ctx)
>  	}
> =20
>  	mutex_unlock(&vm_ctx->lock);
> +
> +	drm_gpuvm_bo_deferred_cleanup(&vm_ctx->gpuvm_mgr);
>  }
> =20
>  /* Static data areas are determined by firmware. */
>=20

