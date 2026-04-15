Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 602C5F419A4
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 13:12:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C16BA10E6DB;
	Wed, 15 Apr 2026 13:12:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="BMv+oRRG";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BB6810E6DB
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 13:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1776258718;
 bh=Hn7dHbj19hvnNcRyqHlaA81avrusCKypnz1mphNGTZ8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=BMv+oRRGonWkqx2tqSyJCR/iaZ2ZKj4Yp5FSyZORaUanwyGUOFbVxTkzCPVt3vaQH
 KfmslQDhBZXSYIvJzxrYmFL7eglOyOJ7mR0dkDEJt/SoF1Uu4VMeCkSE6d2aD4b3ef
 zh1LEPvzB4l7H/LSFU1xs4VUxsfWyXJbGS34qyqgIOY1ykGRvqokRwNp1BjPDLXtC4
 roxfQsrIjFWRgenFM5S7UR5WMDp1qXMsRAx1UoPW/2FbuKv6YUiO1gxAdM6y75+TMS
 9ShshYCorHw5fV2Lqrz5s8nFWiaTmDaKEqXdKgTgVWr+p8M1/k1MGRYGntt3int1TZ
 0gTQvu4qTM2Pg==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 583D217E1388;
 Wed, 15 Apr 2026 15:11:58 +0200 (CEST)
Date: Wed, 15 Apr 2026 15:11:53 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Steven
 Price <steven.price@arm.com>, kernel@collabora.com, Liviu Dudau
 <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v7 2/6] drm/panthor: Pass vm_bind_op to
 vm_prepare_map_op_ctx
Message-ID: <20260415151153.36c6b125@fedora>
In-Reply-To: <20260415112900.681834-3-adrian.larumbe@collabora.com>
References: <20260415112900.681834-1-adrian.larumbe@collabora.com>
 <20260415112900.681834-3-adrian.larumbe@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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

On Wed, 15 Apr 2026 12:28:46 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Instead of passing its constituent elements, pass the whole struct to
> simplify the function prototype.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/pant=
hor/panthor_mmu.c
> index 01577be88933..d9e2f8afb8fb 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -1275,9 +1275,7 @@ static int panthor_vm_op_ctx_prealloc_pts(struct pa=
nthor_vm_op_ctx *op_ctx)
>  static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ct=
x,
>  					 struct panthor_vm *vm,
>  					 struct panthor_gem_object *bo,
> -					 u64 offset,
> -					 u64 size, u64 va,
> -					 u32 flags)
> +					 const struct drm_panthor_vm_bind_op *op)
>  {
>  	struct drm_gpuvm_bo *preallocated_vm_bo;
>  	struct sg_table *sgt =3D NULL;
> @@ -1286,12 +1284,12 @@ static int panthor_vm_prepare_map_op_ctx(struct p=
anthor_vm_op_ctx *op_ctx,
>  	if (!bo)
>  		return -EINVAL;
> =20
> -	if ((flags & ~PANTHOR_VM_BIND_OP_MAP_FLAGS) ||
> -	    (flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) !=3D DRM_PANTHOR_VM_BIND=
_OP_TYPE_MAP)
> +	if ((op->flags & ~PANTHOR_VM_BIND_OP_MAP_FLAGS) ||
> +	    (op->flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) !=3D DRM_PANTHOR_VM_=
BIND_OP_TYPE_MAP)
>  		return -EINVAL;
> =20
>  	/* Make sure the VA and size are in-bounds. */
> -	if (size > bo->base.size || offset > bo->base.size - size)
> +	if (op->size > bo->base.size || op->bo_offset > bo->base.size - op->siz=
e)
>  		return -EINVAL;
> =20
>  	/* If the BO has an exclusive VM attached, it can't be mapped to other =
VMs. */
> @@ -1299,7 +1297,7 @@ static int panthor_vm_prepare_map_op_ctx(struct pan=
thor_vm_op_ctx *op_ctx,
>  	    bo->exclusive_vm_root_gem !=3D panthor_vm_root_gem(vm))
>  		return -EINVAL;
> =20
> -	panthor_vm_init_op_ctx(op_ctx, size, va, flags);
> +	panthor_vm_init_op_ctx(op_ctx, op->size, op->va, op->flags);
> =20
>  	ret =3D panthor_vm_op_ctx_prealloc_vmas(op_ctx);
>  	if (ret)
> @@ -1328,7 +1326,7 @@ static int panthor_vm_prepare_map_op_ctx(struct pan=
thor_vm_op_ctx *op_ctx,
>  	}
> =20
>  	op_ctx->map.vm_bo =3D drm_gpuvm_bo_obtain_prealloc(preallocated_vm_bo);
> -	op_ctx->map.bo_offset =3D offset;
> +	op_ctx->map.bo_offset =3D op->bo_offset;
> =20
>  	ret =3D panthor_vm_op_ctx_prealloc_pts(op_ctx);
>  	if (ret)
> @@ -2849,10 +2847,7 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *fi=
le,
>  		gem =3D drm_gem_object_lookup(file, op->bo_handle);
>  		ret =3D panthor_vm_prepare_map_op_ctx(op_ctx, vm,
>  						    gem ? to_panthor_bo(gem) : NULL,
> -						    op->bo_offset,
> -						    op->size,
> -						    op->va,
> -						    op->flags);
> +						    op);
>  		drm_gem_object_put(gem);
>  		return ret;
> =20
> @@ -3048,10 +3043,16 @@ int panthor_vm_bind_exec_sync_op(struct drm_file =
*file,
>  int panthor_vm_map_bo_range(struct panthor_vm *vm, struct panthor_gem_ob=
ject *bo,
>  			    u64 offset, u64 size, u64 va, u32 flags)
>  {
> +	struct drm_panthor_vm_bind_op op =3D {

You could even make it const here, but I think you're adjusting some
fields after the initialization in one of the following patches.

> +		.bo_offset =3D offset,
> +		.size =3D size,
> +		.va =3D va,
> +		.flags =3D flags,
> +	};
>  	struct panthor_vm_op_ctx op_ctx;
>  	int ret;
> =20
> -	ret =3D panthor_vm_prepare_map_op_ctx(&op_ctx, vm, bo, offset, size, va=
, flags);
> +	ret =3D panthor_vm_prepare_map_op_ctx(&op_ctx, vm, bo, &op);
>  	if (ret)
>  		return ret;
> =20

