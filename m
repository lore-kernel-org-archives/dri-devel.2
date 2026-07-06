Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C78C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 03:16:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E2F310E2D9;
	Mon,  6 Jul 2026 03:16:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="krSDRfqy";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8311010E2D9
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 03:16:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2469340833;
 Mon,  6 Jul 2026 03:16:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6FD1F000E9;
 Mon,  6 Jul 2026 03:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783307770;
 bh=ECQCj7esbwlnfZJWLSmjfy2vM0OTQO0rkBKv90TYI8M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=krSDRfqyf4JiAvLplwWcK6elrXs3sphxpmQV5g74zhPsd4jpHleReU9w2Yo18Q38Y
 NqGjxiZ8/4DEyXuhNdoQfjxj+DiDNe2KZakYJAmg1Au+R/eb/2X2pPo+pxE4utImXf
 S3KSTRM68oR/MrRrzVrxOZR41O7VbPQWzT9TqSlH0+RDFHR1Qc9zPkbGTG8zydj6hl
 /AbuyN4+ThQyBfEfvq67D3Axgb/qW7kWpONREWoT99joEG/cQVfGUoGT0gpeRHLeGI
 hqvXVI4LCdfBikkCdAdJztiuMLRhHkH6LD1bXcDz3yICXw/s3Cjg5JlZDYhEB57qEM
 hiKb1D6Ju231A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] nouveau/instmem: use iomapping interface for instmem
 handling (v3)
To: "Dave Airlie" <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260706030520.857104-1-airlied@gmail.com>
References: <20260706030520.857104-1-airlied@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 03:16:08 +0000
Message-Id: <20260706031609.4A6FD1F000E9@smtp.kernel.org>
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
- [High] Unconditional execution of io_mapping_init_wc() in check_io_mappin=
g() causes severe ioremap_wc memory leaks during BAR2 bootstrapping.
--

commit 17419e048ef493385192b9b14726d1e9ad616fed
Author: Dave Airlie <airlied@redhat.com>

nouveau/instmem: use iomapping interface for instmem handling (v3)

This replaces constant ioremapping with the io_mapping interface to avoid
the constant need to ioremap when instobjs move. It delays creating the
mapping until first use to avoid resource mapping errors with simpledrm.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c b/drivers=
/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c
> index 6fbaa1e5876dc..f4489efc94a79 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c

[ ... ]

> @@ -188,6 +190,16 @@ nv50_instobj_map(struct nvkm_memory *memory, u64 off=
set, struct nvkm_vmm *vmm,
>  	return nvkm_memory_map(memory, offset, vmm, vma, argv, argc);
>  }
> =20
> +static bool
> +check_io_mapping(struct nv50_instmem *imem)
> +{
> +	struct nvkm_device *device =3D imem->base.subdev.device;
> +
> +	return io_mapping_init_wc(&imem->iomap,
> +				  device->func->resource_addr(device, NVKM_BAR2_INST),
> +				  device->func->resource_size(device, NVKM_BAR2_INST)) !=3D NULL;
> +}
> +

[Severity: High]
Does this unconditionally initialize the mapping and leak the previous
ioremap_wc allocation if called more than once?

Since nv50_instobj_boot() acts as the .boot callback for BAR2 page tables,
it is invoked for every leaf page table during VMM bootstrap. Because BAR2
typically spans multiple page tables, check_io_mapping() gets executed
multiple times in a loop.

Should this check if the mapping is already initialized (e.g., checking if
imem->iomap.size is non-zero) before calling io_mapping_init_wc() to avoid
leaking the vmalloc space?

>  static void
>  nv50_instobj_release(struct nvkm_memory *memory)
>  {

[ ... ]

> @@ -277,7 +289,12 @@ nv50_instobj_boot(struct nvkm_memory *memory, struct=
 nvkm_vmm *vmm)
>  		iobj->lru.next =3D NULL;
>  	}
> =20
> -	nv50_instobj_kmap(iobj, vmm);
> +	/*
> +	 * boot is only called on BAR2, if we can't remap the complete
> +	 * BAR it's unlikely things are functioning well.
> +	 */
> +	if (check_io_mapping(iobj->imem))
> +		nv50_instobj_kmap(iobj, vmm);
>  	nvkm_instmem_boot(imem);
>  	mutex_unlock(&imem->mutex);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706030520.8571=
04-1-airlied@gmail.com?part=3D1
