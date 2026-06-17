Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0665CD98F2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 18:50:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39A06892F6;
	Wed, 17 Jun 2026 18:50:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Om7EQosq";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F572892F6
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 18:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1781722209;
 bh=JqP6Ayxchnt99lpk4hwCZubTHdcg/oCBzU2SiXZ3Buw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Om7EQosqRrO6ZmzekHj4urgFzcoU1TY7OJh+gT76fqbsDekF+prX2xy91Qf6d9h77
 yZ/wB5HdauS3pDabLZR8kONDq6UOKscJ/JHdnQt7a1tToq/AHeJFAeNQmIZcNbK7XB
 QrwQc71D5rwz8U6qjwzMRWT4l7OsZhGRvxy4LwHgXP9guukQURxy1QK5+PM1pYT+G/
 X25nssCrfy1XfudZ0jM+IA5rXpJ7wS5FEP3VW8heL6ChgvJkid0S/XDBfRpefw3LGy
 pTztS+jzQH8tETXRdZU6M6scJ4VK/8HHvY91tSWPLWFaMdmj1Cg8ku6G26lec4kWBk
 nkEuJwcH7QnJg==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 67FAC17E03C6;
 Wed, 17 Jun 2026 20:50:09 +0200 (CEST)
Date: Wed, 17 Jun 2026 20:50:03 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/panthor: Add vm_bind region with kbo range
 intersection check
Message-ID: <20260617205003.07e4275e@fedora-2.home>
In-Reply-To: <20260616-vm_bind_checks-v1-1-956198602ae3@collabora.com>
References: <20260616-vm_bind_checks-v1-0-956198602ae3@collabora.com>
 <20260616-vm_bind_checks-v1-1-956198602ae3@collabora.com>
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

On Tue, 16 Jun 2026 15:46:43 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> When a VM is created, caller has to specify the range of the address space
> carve-out set aside for mapping kernel BO's. That means vm_bind mappings =
of
> UM-exposed BO's should not intersect with that region, but at the moment
> we're not checking this.
>=20
> At first, I thought of giving these values to drm_gpuvm_init() through its
> reserve_{offset, range} arguments, but it turns out that is meant for VM
> address spans that are not managed through the usual drm_gpuvm split/merge
> circuit, so I had no choice but to sort of duplicate that functionality in
> Panthor. That means we also need to keep that interval recorded in the VM.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 33 +++++++++++++++++++++++++++++=
++++
>  1 file changed, 33 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/pant=
hor/panthor_mmu.c
> index 31cc57029c12..5625f3d34031 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -301,6 +301,15 @@ struct panthor_vm {
>  	/** @mm_lock: Lock protecting the @mm field. */
>  	struct mutex mm_lock;
> =20
> +	/** @kernel_va: VA-range reserved for kernel BOs. */
> +	struct {
> +		/** @kernel_va.start: Start of the VA-range for kernel BOs. */
> +		u64 start;
> +
> +		/** @kernel_va.range: Size of the automatic VA-range for kernel BOs. */
> +		u64 range;
> +	} kernel_va;

We can do with a single user_va_end.

> +
>  	/** @kernel_auto_va: Automatic VA-range for kernel BOs. */
>  	struct {
>  		/** @kernel_auto_va.start: Start of the automatic VA-range for kernel =
BOs. */
> @@ -1309,6 +1318,24 @@ static int panthor_vm_op_ctx_prealloc_pts(struct p=
anthor_vm_op_ctx *op_ctx)
>  	return 0;
>  }
> =20
> +static bool
> +panthor_vm_is_kernel_address(struct panthor_vm *vm,
> +			     const struct drm_panthor_vm_bind_op *op)

Rather than checking if the VA is not in the kernel range, I'd check
that the VA is in the user range, since that's what we want to enforce,
and if we ever decide to carve out extra sections above the user-range
that the UMD is not supposed to access, we would still catch invalid
map/unmap ops.

> +{
> +	u32 op_type =3D op->flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK;
> +	u64 end, kstart, krange, kend;
> +
> +	if (op_type =3D=3D DRM_PANTHOR_VM_BIND_OP_TYPE_SYNC_ONLY)
> +		return false;

IIRC, we force op->va and op->size to be zero in that case[1], so no
need for this extra check IMHO.

> +
> +	end =3D op->va + op->size;
> +	kstart =3D vm->kernel_va.start;
> +	krange =3D vm->kernel_va.range;
> +	kend =3D kstart + krange;
> +
> +	return krange && op->va < kend && kstart < end;

A single

	op->va + op->size <=3D vm->user_va_end;

would do, at which point I'm not too sure adding a helper makes sense.

> +}
> +
>  #define PANTHOR_VM_BIND_OP_MAP_FLAGS \
>  	(DRM_PANTHOR_VM_BIND_OP_MAP_READONLY | \
>  	 DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC | \
> @@ -2891,6 +2918,8 @@ panthor_vm_create(struct panthor_device *ptdev, boo=
l for_mcu,
>  	} else {
>  		min_va =3D 0;
>  		va_range =3D full_va_range;
> +		vm->kernel_va.start =3D kernel_va_start;
> +		vm->kernel_va.range =3D kernel_va_size;
>  	}
> =20
>  	mutex_init(&vm->mm_lock);
> @@ -2981,6 +3010,10 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *fi=
le,
>  	if (!IS_ALIGNED(op->va | op->size | op->bo_offset, vm_pgsz))
>  		return -EINVAL;
> =20
> +	/* We don't allow mappings that intersect with kbo's reserved range */
> +	if (panthor_vm_is_kernel_address(vm, op))
> +		return -EINVAL;
> +
>  	switch (op->flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) {
>  	case DRM_PANTHOR_VM_BIND_OP_TYPE_MAP:
>  		if (!(op->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE)) {
>=20

[1]https://elixir.bootlin.com/linux/v7.0.11/source/include/uapi/drm/panthor=
_drm.h#L588
