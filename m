Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D815FC61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 18:28:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A5D510E509;
	Wed,  2 Sep 2026 18:28:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W08FCz+g";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDE4710E509
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 18:28:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 40C6F6022E;
 Wed,  2 Sep 2026 18:28:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24501F00A3A;
 Wed,  2 Sep 2026 18:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788373689;
 bh=xNE83d3xzM3wZJzjYIXYIDG2H/xN/SP93uHMXLxMrbQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=W08FCz+gGQMCP7AvWTWDdZdx/9l+V4dsToHCzBQK1BWRxGn0QywAaOJfGNuVpR0Ou
 CnEvKboJ1N4nxC/JONKlg9pJcs7ea++6LHLon8Ug4c3fOU5D416TcZWNSNyB1OD2Zs
 4YVHQo2ViD0WLjbkax9GlaqHqu1/VMVNUh2z+o2NR4tgZLMgX38sMX2Kk/oJrt7TB7
 U+Lw7tovNp/DWQgCpiRlhwOAqmaqLN4YKuLXgkit65A6melryN5OdLsHA2nCh++e0t
 pPTfDSkJrV1W3yvsp/AvvK/lsmtI31cAV2EM/BDv5Tg/0fgYVtwHFxpp631lJMkb2G
 UzoXH7rSmKZAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1 2/2] accel/amdxdna: Fix potential deadlock in BO open
 and close callbacks
To: "Lizhi Hou" <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260902180955.3999242-2-lizhi.hou@amd.com>
References: <20260902180955.3999242-1-lizhi.hou@amd.com>
 <20260902180955.3999242-2-lizhi.hou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 18:28:08 +0000
Message-Id: <20260902182808.C24501F00A3A@smtp.kernel.org>
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
- [High] Repeated open and close of an exported BO leaks IOVA and IOMMU map=
pings.
--

commit 51f6a251a76d33602344897b8464cf1529e24b2e
Author: Lizhi Hou <lizhi.hou@amd.com>

accel/amdxdna: Fix potential deadlock in BO open and close callbacks

This commit fixes a potential deadlock during BO open and close operations =
by
acquiring client and BO locks in a consistent order. It locally saves the
client pointer before acquiring the BO lock to prevent reverse order lockin=
g.

> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/=
amdxdna_gem.c
> index a12269f1543ee..05332894849cd 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
[ ... ]
> @@ -663,14 +659,20 @@ static int amdxdna_gem_obj_open(struct drm_gem_obje=
ct *gobj, struct drm_file *fi
>  {
>  	struct amdxdna_dev *xdna =3D to_xdna_dev(gobj->dev);
>  	struct amdxdna_gem_obj *abo =3D to_xdna_obj(gobj);
> +	struct amdxdna_client *client;
>  	int ret;
> =20
> -	guard(mutex)(&abo->lock);
> -	if (abo->open_ref > 0 && filp->driver_priv !=3D abo->client)
> +	mutex_lock(&abo->lock);
> +	if (abo->open_ref > 0 && filp->driver_priv !=3D abo->client) {
> +		mutex_unlock(&abo->lock);
>  		return -EPERM;
> +	}
> +
>  	abo->open_ref++;
> -	if (abo->open_ref > 1)
> +	if (abo->open_ref > 1) {
> +		mutex_unlock(&abo->lock);
>  		return 0;
> +	}
> =20
>  	/* Attached to the client when first opened by it. */
>  	abo->client =3D filp->driver_priv;
> @@ -681,26 +683,34 @@ static int amdxdna_gem_obj_open(struct drm_gem_obje=
ct *gobj, struct drm_file *fi
>  		if (ret) {

[Severity: High]
This is a pre-existing issue, but does this repeated open and close of an
exported BO leak IOVA and IOMMU mappings?

A userspace process can create a BO, export it to a DMA-BUF file descriptor,
and then repeatedly close the GEM handle and re-import the same FD to a new
handle.

When the handle is closed, amdxdna_gem_obj_close() drops abo->open_ref to 0
but does not unmap the IOVA. Re-importing the FD calls amdxdna_gem_obj_open=
(),
which sees open_ref transition from 0 to 1 and unconditionally calls
amdxdna_dma_map_bo().

This allocates a new IOVA in amdxdna_iommu.c:amdxdna_dma_map_bo() without
checking if the BO already holds a valid dma_addr:

	iova =3D amdxdna_iommu_alloc_iova(xdna, abo->mem.size, &dma_addr,
					(abo->type =3D=3D AMDXDNA_BO_DEV_HEAP));

Can this overwrite abo->mem.dma_addr without freeing the old one, leading to
a denial of service when IOVA space is exhausted?

>  			abo->open_ref--;
>  			abo->client =3D NULL;
> +			mutex_unlock(&abo->lock);
>  			return ret;
>  		}
>  	}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902180955.3999=
242-1-lizhi.hou@amd.com?part=3D2
