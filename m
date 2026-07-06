Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C2CC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 02:37:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC91910E2E6;
	Mon,  6 Jul 2026 02:37:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="osziF2Bz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06B1810E2E6
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 02:37:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4E02160018;
 Mon,  6 Jul 2026 02:37:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805AC1F000E9;
 Mon,  6 Jul 2026 02:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783305451;
 bh=yLhe0wh5cEzmXDQTRAKMUsPop64Tyw1knAkoLFqyVAk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=osziF2Bz5YjQCn+asTpUMPmaSEs7KKBMeDHkvUpQU00WgikPMi+ydwV6dtEFS7bII
 BxjMzj1vVv1dfHUFtTSquAhVxhhCagZzNAhaLFOb6AJ2pzUVTAeKdu7Gb7p5iGVLfq
 HbgqU1vkPiwPOe/HVzX2oRKHQViPpm8bkSLQttcUkgx65ulX4SPdsGWvYl/dheHKj9
 54vRftKoeITsTw5xpS3cKlngLV4VnP+0DHcNoaddvLXNT+7gx252Ke2T6RiuE9VHg8
 tsMbTjzRIBJjvmU8vmG7oKExP5wNdN5VZJMorRbK4zRlYaBWFmW5aPOfAnow2X8Y8v
 hVAYW5qVsmBHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] nouveau/instmem: use iomapping interface for instmem
 handling (v2)
To: "Dave Airlie" <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260706022812.834677-1-airlied@gmail.com>
References: <20260706022812.834677-1-airlied@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 02:37:29 +0000
Message-Id: <20260706023730.805AC1F000E9@smtp.kernel.org>
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
- [High] Unchecked failure in `check_io_mapping` leads to bogus pointer gen=
eration in `nv50_instobj_boot`, causing a kernel panic on dereference.
- [Medium] Unconditional call to `io_mapping_fini` during teardown can pass=
 a NULL pointer to `iounmap`, leading to architecture-specific panics or wa=
rnings.
- [Medium] Unbounded retries of `ioremap_wc` on hot paths if `check_io_mapp=
ing` fails, leading to severe performance degradation.
--

commit 96779776b5649805dcd1602bcce1a5916b4e55a8
Author: Dave Airlie <airlied@redhat.com>

nouveau/instmem: use iomapping interface for instmem handling (v2)

This patch modifies the nouveau driver to use the iomapping interface for
instmem handling. It delays creating the IO mapping until the first use to
avoid resource mapping conflicts with simpledrm during initialization.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c b/drivers=
/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c
> index 6fbaa1e5876dc..7314650f6d230 100644
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
> +	iobj->map =3D io_mapping_map_wc(&imem->iomap, (u32)iobj->bar->addr, siz=
e);
>  	if (!iobj->map) {

[Severity: High]
If check_io_mapping() fails to initialize the mapping, imem->iomap.iomem wi=
ll=20
be NULL. io_mapping_map_wc() computes mapping->iomem + offset, which means =
it
will return NULL + (u32)iobj->bar->addr.

If the offset is greater than 0, this results in a non-NULL but invalid=20
pointer. The check if (!iobj->map) will fail to catch it. Can this lead=20
to a kernel panic when the bogus pointer is later dereferenced?

>  		nvkm_warn(subdev, "PRAMIN ioremap failed\n");
>  		nvkm_vmm_put(vmm, &iobj->bar);
> @@ -188,6 +190,17 @@ nv50_instobj_map(struct nvkm_memory *memory, u64 off=
set, struct nvkm_vmm *vmm,
>  	return nvkm_memory_map(memory, offset, vmm, vma, argv, argc);
>  }
> =20
> +static void
> +check_io_mapping(struct nv50_instmem *imem)
> +{
> +	if (imem->iomap.size =3D=3D 0) {
> +		struct nvkm_device *device =3D imem->base.subdev.device;
> +		io_mapping_init_wc(&imem->iomap,
> +				   device->func->resource_addr(device, NVKM_BAR2_INST),
> +				   device->func->resource_size(device, NVKM_BAR2_INST));

[Severity: Medium]
If io_mapping_init_wc() fails, it returns NULL and leaves imem->iomap.size=
=20
as 0.=20

Since check_io_mapping() doesn't record the failure or return an error code=
,=20
will the driver endlessly retry this expensive ioremap_wc() operation on=20
subsequent calls in hot paths (like nv50_instobj_acquire()) because=20
imem->iomap.size is still 0?

> +	}
> +}
> +
[ ... ]
> @@ -277,6 +292,7 @@ nv50_instobj_boot(struct nvkm_memory *memory, struct =
nvkm_vmm *vmm)
>  		iobj->lru.next =3D NULL;
>  	}
> =20
> +	check_io_mapping(iobj->imem);
>  	nv50_instobj_kmap(iobj, vmm);

[Severity: High]
Since check_io_mapping() does not return an error status, we unconditionally
call nv50_instobj_kmap() here even if the lazy initialization failed.=20
Should this verify that the mapping initialization actually succeeded before
proceeding, to prevent generating the bogus pointer mentioned above?

>  	nvkm_instmem_boot(imem);
>  	mutex_unlock(&imem->mutex);
[ ... ]
> @@ -406,10 +422,13 @@ nv50_instmem_fini(struct nvkm_instmem *base)
>  	nv50_instmem(base)->addr =3D ~0ULL;
>  }
> =20
> -static void *
> +void *
>  nv50_instmem_dtor(struct nvkm_instmem *base)
>  {
> -	return nv50_instmem(base);
> +	struct nv50_instmem *imem =3D nv50_instmem(base);
> +
> +	io_mapping_fini(&imem->iomap);

[Severity: Medium]
Is it safe to call this unconditionally? If the IO mapping was never=20
initialized (e.g., if probe failed early, or check_io_mapping() was never=20
called), imem->iomap.iomem will be NULL.=20

Calling io_mapping_fini() will invoke iounmap(NULL), which can trigger=20
warnings or panics on some architectures.

> +	return imem;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706022812.8346=
77-1-airlied@gmail.com?part=3D1
