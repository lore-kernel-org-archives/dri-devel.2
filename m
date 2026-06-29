Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780C7C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 20:34:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D82F210EA6A;
	Mon, 29 Jun 2026 20:34:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IzF69g/u";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC7F510EA4E
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 20:34:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0E1F560008;
 Mon, 29 Jun 2026 20:34:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A70B1F000E9;
 Mon, 29 Jun 2026 20:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782765271;
 bh=TCZUoHwQirLwA3PRhajBnH0XhqB634TiaM/cAPgwukY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IzF69g/udCGCw/2vaB4+XuRSh34Rbn2zJrGcy3F3GEfyMRyXLtHK9qayh9kmZ14N4
 r68CkIPU00fnJgRffOP2VpQgpv3D55ou0uUdzkfndxWznLimwCbWnLrYH6mhPWtGe3
 NoY5OVEml7AvyoVL+BjuS5e8ETXaFl4sdxbmzgn72KDndn6IF8CNNOGrMm165cPFok
 5GF0zkWOCGoANY+6otb7x3yNJc9Zg2WbbSWn06oDbNv+rlmQSIPKn/vGAtopxt/d14
 bZmNxsPPzN1rYRuR0n9ex/XJVIJ5Ev+uo4phmTVdWyhaJrKzlexDrllOJuIeGXZJVb
 NF/xBkmXwPEyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] drm/panthor: Add vm_bind region with kbo range
 overlap check
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260629-vm_bind_checks-v3-1-85e6740f6c2e@collabora.com>
References: <20260629-vm_bind_checks-v3-0-85e6740f6c2e@collabora.com>
 <20260629-vm_bind_checks-v3-1-85e6740f6c2e@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 20:34:31 +0000
Message-Id: <20260629203431.8A70B1F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Page table bulk allocations for VM bindings are not accounted to t=
he requesting process's memcg, allowing an unprivileged user to easily exha=
ust system memory and trigger an Out-Of-Memory (OOM) panic via huge sparse =
mappings.
--

commit 4e78b0100b6b8317cc7157628ece362a9c968f70
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panthor: Add vm_bind region with kbo range overlap check

When a VM is created, caller has to specify the range of the address space
carve-out set aside for mapping kernel BO's. This patch ensures that vm_bind
mappings of UM-exposed BO's do not intersect with that region. It stores the
end of the user VA range at VM creation time and performs a quick check in
the vm_bind ioctl path.

> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/pant=
hor/panthor_mmu.c
> index 31cc57029c12c..94789777aac48 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c

[ ... ]

> @@ -2981,6 +2986,10 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *fi=
le,
>  	if (!IS_ALIGNED(op->va | op->size | op->bo_offset, vm_pgsz))
>  		return -EINVAL;
> =20
> +	/* We don't allow mappings that overlap with kbo's reserved range */
> +	if (op->va + op->size > vm->user_va_range)
> +		return -EINVAL;
> +
>  	switch (op->flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) {
>  	case DRM_PANTHOR_VM_BIND_OP_TYPE_MAP:
>  		if (!(op->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE)) {

[Severity: High]
This is a pre-existing issue, but I noticed a potential memory exhaustion i=
ssue
with sparse mappings here.

When an unprivileged user submits a DRM_IOCTL_PANTHOR_VM_BIND ioctl with the
DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE flag and an extremely large op->size (e.g=
.,
1TB), it appears it can exhaust system memory.

In panthor_vm_op_ctx_prealloc_pts(), a massive pt_count is derived from this
size and allocations are made using GFP_KERNEL:

panthor_mmu.c:panthor_vm_op_ctx_prealloc_pts() {
    ...
	op_ctx->rsvd_page_tables.pages =3D kzalloc_objs(*op_ctx->rsvd_page_tables.=
pages,
						      pt_count);
	if (!op_ctx->rsvd_page_tables.pages)
		return -ENOMEM;

	ret =3D kmem_cache_alloc_bulk(pt_cache, GFP_KERNEL, pt_count,
				    op_ctx->rsvd_page_tables.pages);
    ...
}

Since pt_cache was created in panthor_mmu_pt_cache_init() without the
SLAB_ACCOUNT flag:

panthor_mmu.c:panthor_mmu_pt_cache_init() {
    ...
	pt_cache =3D kmem_cache_create("panthor-mmu-pt", SZ_4K, SZ_4K, 0, NULL);
    ...
}

Should pt_cache be created with SLAB_ACCOUNT to ensure these massive alloca=
tions
are charged to the requesting process's memory control group (memcg) and pr=
event
Out-Of-Memory panics?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-vm_bind_ch=
ecks-v3-0-85e6740f6c2e@collabora.com?part=3D1
