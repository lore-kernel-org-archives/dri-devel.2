Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A457ACDB47C
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 22:50:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F01E610ED52;
	Tue, 23 Jun 2026 22:49:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LCvXA1iK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0852D10ED52
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 22:49:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C5FED404A8;
 Tue, 23 Jun 2026 22:49:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB771F000E9;
 Tue, 23 Jun 2026 22:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782254997;
 bh=DVlmj7qPBLJGzI2aGZSBy519jog0BE/WE3kAaICuLyg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LCvXA1iKA6xODTMQksi6qhAlTsTVs4gg4vjanj75hS0EWWmBUhTKYjrkw8KZdq2tK
 dYsJ2qOHLB7fEmp5XQ5+IirZkSfxtW6i40noJmlubsHutsHJ0oPn0W0vu3GGp8Qczk
 xH5TcbSiKfzyLBRor6uOOEV64YejoElt+pevpZ/aFemqcM0b6JwhmEq/EKlIjfu9SA
 QHJtKftIEp3H2sPlS5E7Lwwpa7EaJ1MWv2pCt0eAb8NrSqWdxWPsH/K5KpEMvfxRh2
 kdQYAF5GobH3N9s24kEn//gGGgv//m48DNU5GyxVeawMbh2k9zQuXet8Qz0bjNh6ZX
 +RnG9j5EV4nLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] nouveau/instmem: use iomapping interface for instmem
 handling
To: "Dave Airlie" <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260623223320.3837840-1-airlied@gmail.com>
References: <20260623223320.3837840-1-airlied@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 22:49:57 +0000
Message-Id: <20260623224957.8FB771F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Passing `iobj->bar->addr` to `io_mapping_map_wc` without trunc=
ating the VMM base address causes an out-of-bounds pointer calculation on 6=
4-bit systems.
- [High] Unconditional io_mapping_init_wc() of the entire NVKM_BAR2_INST br=
eaks driver probe on constrained architectures and completely bypasses the =
existing graceful BAR0 fallback when BAR2 is missing or unmappable.
- [High] The patch introduces a type confusion vulnerability and potential =
resource leak in `nv50_instmem_dtor` due to structural assumptions.
--

commit f429f6c462c04142327023f718eaa2eb0469d838
Author: Dave Airlie <airlied@redhat.com>

nouveau/instmem: use iomapping interface for instmem handling

This patch transitions the nouveau driver's instmem handling to use the
io_mapping API. Instead of individually mapping and unmapping instobjs
with ioremap_wc(), it maps the entire BAR2 region upfront during
initialization and maps offsets as needed.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c b/drivers=
/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c
> index 6fbaa1e5876dc..929246bde72d5 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c

[ ... ]

> @@ -172,8 +175,7 @@ nv50_instobj_kmap(struct nv50_instobj *iobj, struct n=
vkm_vmm *vmm)
> =20
>  	/* Make the mapping visible to the host. */
>  	iobj->bar =3D bar;
> -	iobj->map =3D ioremap_wc(device->func->resource_addr(device, NVKM_BAR2_=
INST) +
> -			       (u32)iobj->bar->addr, size);
> +	iobj->map =3D io_mapping_map_wc(&imem->iomap, iobj->bar->addr, size);

[Severity: Critical]
Is it possible this leads to an out-of-bounds pointer calculation on 64-bit
systems?

The bar2 VMM is initialized with a starting address of 0x0100000000ULL (4GB=
),
meaning iobj->bar->addr returns an address >=3D 4GB. Before this patch, the
u32 cast implicitly truncated the 4GB base to extract just the internal off=
set.

Since io_mapping_map_wc() takes an unsigned long offset, passing the full
64-bit u64 value will preserve the 4GB base, resulting in a pointer that is
out of bounds by at least 4GB.

>  	if (!iobj->map) {
>  		nvkm_warn(subdev, "PRAMIN ioremap failed\n");
>  		nvkm_vmm_put(vmm, &iobj->bar);

[ ... ]

> @@ -409,7 +411,10 @@ nv50_instmem_fini(struct nvkm_instmem *base)
>  static void *
>  nv50_instmem_dtor(struct nvkm_instmem *base)
>  {
> -	return nv50_instmem(base);
> +	struct nv50_instmem *imem =3D nv50_instmem(base);
> +
> +	io_mapping_fini(&imem->iomap);
> +	return imem;

[Severity: High]
What happens when this destructor is called for derived classes?

In nv50_instmem_new(), if nvkm_gsp_rm() is enabled, the creation is delegat=
ed
to r535_instmem_new(&nv50_instmem, ...). This reuses the nv50_instmem
function table (which contains this destructor) but allocates a different
structure.

If the base pointer does not belong to a struct nv50_instmem, won't calling
io_mapping_fini(&imem->iomap) result in type confusion and cause iounmap()
to operate on garbage memory?

>  }

[ ... ]

> @@ -433,8 +438,16 @@ nv50_instmem_new_(const struct nvkm_instmem_func *fu=
nc,
> =20
>  	if (!(imem =3D kzalloc_obj(*imem)))
>  		return -ENOMEM;
> +
> +	if (!io_mapping_init_wc(&imem->iomap, device->func->resource_addr(devic=
e, NVKM_BAR2_INST),
> +				device->func->resource_size(device, NVKM_BAR2_INST))) {
> +		kfree(imem);
> +		return -ENOMEM;
> +	}
> +

[Severity: High]
Will this unconditional initialization break driver probe on systems where =
the
full BAR2 region cannot be mapped?

Previously, small ioremap_wc() allocations were made on demand, and if they
failed, the driver gracefully fell back to accessing memory safely via the
BAR0 window.

By attempting to map the entire NVKM_BAR2_INST resource upfront and aborting
on failure, it seems the fallback mechanism is bypassed entirely, which cou=
ld
cause initialization failures on 32-bit architectures or if BAR2 is
exceptionally large.

>  	nvkm_instmem_ctor(func, device, type, inst, &imem->base);
>  	INIT_LIST_HEAD(&imem->lru);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623223320.3837=
840-1-airlied@gmail.com?part=3D1
