Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54FF9C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 17:40:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF99010E16C;
	Tue,  7 Jul 2026 17:40:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="l+LcCOJI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D6DE10E16C
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 17:40:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D3B2440D52;
 Tue,  7 Jul 2026 17:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9181F000E9;
 Tue,  7 Jul 2026 17:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783446048;
 bh=aihV7OIvcKwdQ7LBgfixZKep87r5LadU33w5YAXhF28=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=l+LcCOJItvtSRTL4W4Y5qDAwPaxjE19yv0ES8kuV09djonC23oyOY/OweHsllQ70U
 UL7MEGuPPnb+aZYE+Kt0dqMmJ4+GEAswQU07P34GIomF4h+wiXDOw5i4VFHOaqnCDQ
 5avIFP9Tuor6LIGLH6sRtIZkucRrf0SfxicsTHkxt7JqJtHN3I8vE1syZ8LMRzQFOi
 3UaGL/2vKNysJWePIFq1rZaWHWJJBixt0f8OBIDO0q9wOrPUV82lWu/uWe6nvZF+cR
 mbilHAHfX305wJkEyDT93NwRGkUOwT1qL8epCUE4jFeYMxQVC2xk2RHONCjlc3SCIX
 zf8VyJSJFX/hA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1] accel/amdxdna: Fix potential NULL pointer access in
 amdxdna_gem_vmap()
To: "Lizhi Hou" <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260707172316.539699-1-lizhi.hou@amd.com>
References: <20260707172316.539699-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 17:40:48 +0000
Message-Id: <20260707174048.8B9181F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The patch fixes a NULL pointer dereference in `amdxdna_gem_vma=
p()` caused by `abo->client` being prematurely set to NULL, but misses iden=
tical vulnerabilities in other asynchronous and internal execution paths.
- [High] Use-after-free of `amdxdna_client` when a GEM object is shared bet=
ween processes via PRIME export/import.
- [High] IOVA and IOMMU pagetable leak when a GEM object handle is closed a=
nd re-opened via PRIME.
- [Medium] Data Race / Missing Memory Barriers in `amdxdna_gem_vmap`
--

--- Patch [1]: [PATCH V1] accel/amdxdna: Fix potential NULL pointer access =
in amdxdna_gem_vmap() ---
commit 6ad0ad0bac54f532a4aacd997b6204c5f05a71e3
Author: Lizhi Hou <lizhi.hou@amd.com>
Date:   Tue Jul 7 17:23:16 2026 +0000

accel/amdxdna: Fix potential NULL pointer access in amdxdna_gem_vmap()

If the heap BO was never vmapped before its handle was closed and the
user then vmaps the dev BO (which triggers amdxdna_gem_vmap(heap_bo)),
and drm_gem_vmap fails =E2=80=94 NULL pointer dereference at abo->client->x=
dna.

Fix it by get xdna pointer through to_xdna_dev(to_gobj(abo)->dev).

> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/=
amdxdna_gem.c
> index 1f190b319bb6e..e7566cbe3da76 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -198,6 +198,7 @@ amdxdna_gem_destroy_obj(struct amdxdna_gem_obj *abo)
>   */
>  void *amdxdna_gem_vmap(struct amdxdna_gem_obj *abo)
>  {
> +	struct amdxdna_dev *xdna =3D to_xdna_dev(to_gobj(abo)->dev);
>  	struct iosys_map map =3D IOSYS_MAP_INIT_VADDR(NULL);
>  	int ret;
> =20
> @@ -210,7 +211,7 @@ void *amdxdna_gem_vmap(struct amdxdna_gem_obj *abo)

[Severity: Medium]
This isn't a bug introduced by this patch, but does the double-checked lock=
ing
pattern in amdxdna_gem_vmap() need memory barriers?

The code leading up to this block reads abo->mem.kva locklessly:

	if (abo->mem.kva)
		return abo->mem.kva;

	/* The first call to get the kva, taking slow path. */
	guard(mutex)(&abo->lock);

Without smp_load_acquire() on the read and smp_store_release() on the write
(when assigning abo->mem.kva =3D map.vaddr), could the compiler or CPU reor=
der
instructions such that a concurrent reader sees a non-NULL pointer before t=
he
effects of drm_gem_vmap() are fully visible?

>  	if (!abo->mem.kva) {
>  		ret =3D drm_gem_vmap(to_gobj(abo), &map);
>  		if (ret)
> -			XDNA_ERR(abo->client->xdna, "Vmap bo failed, ret %d", ret);
> +			XDNA_ERR(xdna, "Vmap bo failed, ret %d", ret);

[Severity: Critical]
This isn't a bug introduced by this patch, but while fixing the NULL pointer
dereference here, are there other identical vulnerabilities in asynchronous
and internal execution paths?

When userspace closes a GEM handle, amdxdna_gem_obj_close() drops open_ref =
and
sets abo->client =3D NULL. However, the GEM object can remain alive due to
internal kernel references.

For example, in drivers/accel/amdxdna/aie2_message.c:aie2_init_exec_req():

	struct amdxdna_dev *xdna =3D cmd_abo->client->xdna;

If a user submits a job using a command BO and immediately closes its handl=
e,
the scheduler job holds a GEM reference keeping the object alive, but
cmd_abo->client becomes NULL. When the scheduler thread executes
aie2_init_exec_req(), will this dereference NULL?

Similarly, in drivers/accel/amdxdna/amdxdna_gem.h:amdxdna_obj_dma_addr():

	return amdxdna_pasid_on(abo->client) ? amdxdna_gem_uva(abo) : abo->mem.dma=
_addr;

If the user allocates a new DEV BO, and amdxdna_init_dev_bo() invokes
amdxdna_obj_dma_addr(heap), will it evaluate amdxdna_pasid_on(heap->client)
which evaluates NULL->pasid?

[Severity: High]
This is a pre-existing issue, but how does the driver handle the
abo->client pointer when a GEM object is shared between processes via
PRIME export/import?

Looking at drivers/accel/amdxdna/amdxdna_gem.c:amdxdna_gem_obj_open():

	if (abo->open_ref > 1)
		return 0;

If Process A creates a BO and exports it to Process B, amdxdna_gem_obj_open=
()
is called for Process B. Since open_ref > 0, it simply increments open_ref
and returns, leaving abo->client pointing to Process A's client structure.

If Process A subsequently closes its handle and exits, its amdxdna_client
structure is kfree'd. Later, when Process B closes its handle, open_ref
reaches 0 and amdxdna_gem_obj_close() invokes amdxdna_gem_del_bo_usage(abo):

	struct amdxdna_client *client =3D abo->client;
	...
	guard(mutex)(&client->mm_lock);

Will this dereference the dangling client pointer and trigger a
use-after-free?

[Severity: High]
This is a pre-existing issue, but does closing and re-opening a GEM object
handle via PRIME leak IOVA and IOMMU pagetables?

When a GEM object's handle is closed and open_ref drops to 0,
amdxdna_gem_obj_close() does not unmap the DMA/IOVA mapping.

If userspace retains the PRIME dmabuf FD and re-imports it, a new handle
is created and amdxdna_gem_obj_open() is called:

	if (!amdxdna_pasid_on(abo->client)) {
		ret =3D amdxdna_dma_map_bo(xdna, abo);

This unconditionally maps the BO when open_ref transitions from 0 to 1,
regardless of existing mappings.

Then in drivers/accel/amdxdna/amdxdna_iommu.c:amdxdna_dma_map_bo():

	iova =3D amdxdna_iommu_alloc_iova(xdna, abo->mem.size, &dma_addr, ...);
	...
	abo->mem.dma_addr =3D dma_addr;

If IOVA is enabled, this allocates a new IOVA and overwrites abo->mem.dma_a=
ddr
without checking if a mapping already exists. Are the previous IOVA and its
IOMMU mappings permanently leaked?

>  		else
>  			abo->mem.kva =3D map.vaddr;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707172316.5396=
99-1-lizhi.hou@amd.com?part=3D1
