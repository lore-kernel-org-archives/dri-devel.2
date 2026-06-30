Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0519C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 08:23:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08A0510E189;
	Tue, 30 Jun 2026 08:23:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="GMB3XlrL";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E778F10E189
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 08:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782807822;
 bh=6kzvf6R0zi/yY9WLtMFY9sy8udzLegHFgax/yGVCals=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=GMB3XlrLMsPau4EYXK1+pvjA5yb3tgFx7hM0MFvpVBs9cFwkl5Y5uXoLpzEkGZAXn
 jsDfY6sd/7+a1CMjJrY57sshsiwb7RodcRw4tVw3aGAbzDTp07LYZ1OdFxIUWLTjor
 TNTIDPFIHP6XXwp4TxgJmXMRgbQD3jlDUOsf/NNTg+efRibhgxwVSfapjEcxXHhe+Q
 RVNHc7sPHCJD3OScPzUDt04ZIrNO9vqMg0hwXTskbxEZKeRAEOZ4DGh+mFJK7hD4f1
 LyxwGaB2jfI6mrxXFA4hBznRzdQmbiao2zaSzbKpyIaz9/B0VRD2oqnHIn9q25mgdv
 9J10qzr8TO0Sg==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 8894C17E0C88;
 Tue, 30 Jun 2026 10:23:41 +0200 (CEST)
Date: Tue, 30 Jun 2026 10:23:36 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Heiko Stuebner
 <heiko@sntech.de>, Grant Likely <grant.likely@linaro.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Sashiko
 <noreply@sashiko.dev>
Subject: Re: [PATCH v3 4/4] drm/panthor: Check for sparse binding range
 overflow
Message-ID: <20260630102336.0097aef3@fedora-2.home>
In-Reply-To: <20260629-vm_bind_checks-v3-4-85e6740f6c2e@collabora.com>
References: <20260629-vm_bind_checks-v3-0-85e6740f6c2e@collabora.com>
 <20260629-vm_bind_checks-v3-4-85e6740f6c2e@collabora.com>
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

On Mon, 29 Jun 2026 21:17:08 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> This check is being already carried out further down the call stack inside
> drm_gpuvm_sm_map -> drm_gpuvm_range_valid, but it's best to fail early in
> the driver before GPUVM functions are invoked so that we won't waste time
> allocating vm_bind context resources.
>=20
> Reported-by: Sashiko <noreply@sashiko.dev>
> Closes: https://sashiko.dev/#/message/20260623204220.CDB1B1F000E9%40smtp.=
kernel.org
> Fixes: 12cf826bf1dd ("drm/panthor: Support sparse mappings")
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/pant=
hor/panthor_mmu.c
> index 77fdad4e5166..8bd9b975e5ce 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -1328,6 +1328,7 @@ static int panthor_vm_prepare_map_op_ctx(struct pan=
thor_vm_op_ctx *op_ctx,
>  	struct drm_gpuvm_bo *preallocated_vm_bo;
>  	struct sg_table *sgt =3D NULL;
>  	int ret;
> +	u64 end;
> =20
>  	if (!bo)
>  		return -EINVAL;
> @@ -1353,6 +1354,10 @@ static int panthor_vm_prepare_map_op_ctx(struct pa=
nthor_vm_op_ctx *op_ctx,
>  	if (is_sparse && (op->bo_handle || op->bo_offset))
>  		return -EINVAL;
> =20
> +	/* Protect against sparse VA range overflow */
> +	if (is_sparse && check_add_overflow(op->va, op->size, &end))
> +		return -EINVAL;

Why should we limit this to sparse? Feels like the overflow check is
good to have for non-sparse as well.

> +
>  	/* If the BO has an exclusive VM attached, it can't be mapped to other =
VMs. */
>  	if (bo->exclusive_vm_root_gem &&
>  	    bo->exclusive_vm_root_gem !=3D panthor_vm_root_gem(vm))
> @@ -1418,7 +1423,9 @@ static int panthor_vm_prepare_unmap_op_ctx(struct p=
anthor_vm_op_ctx *op_ctx,
>  					   struct panthor_vm *vm,
>  					   const struct drm_panthor_vm_bind_op *op)
>  {
> +	bool is_sparse =3D op->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE;
>  	u32 pt_count =3D 0;
> +	u64 end;
>  	int ret;
> =20
>  	memset(op_ctx, 0, sizeof(*op_ctx));
> @@ -1432,6 +1439,10 @@ static int panthor_vm_prepare_unmap_op_ctx(struct =
panthor_vm_op_ctx *op_ctx,
>  	if (op->va !=3D ALIGN(op->va, SZ_2M))
>  		pt_count++;
> =20
> +	/* Protect against sparse VA range overflow */
> +	if (is_sparse && check_add_overflow(op->va, op->size, &end))
> +		return -EINVAL;
> +
>  	if (op->va + op->size !=3D ALIGN(op->va + op->size, SZ_2M) &&
>  	    ALIGN(op->va + op->size, SZ_2M) !=3D ALIGN(op->va, SZ_2M))
>  		pt_count++;
>=20

