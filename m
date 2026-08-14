Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912CEC5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:21:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8D2310E537;
	Fri, 14 Aug 2026 07:21:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PJCnvHv3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B72AF10E537
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 07:21:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7039941214;
 Fri, 14 Aug 2026 07:21:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4871F000E9;
 Fri, 14 Aug 2026 07:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786692105;
 bh=d9k+FGhbDlUnT91QK/3VVzO1Xg7c9/Qd9h0pUSwQRro=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PJCnvHv31szLtRSUEIqLOWRNBtv6xnb7UEh+lzx08rIWTVtAO1zP+kZPL+mUpV9Yo
 u1FcoAIh+JydKhEtJKz6MFK+6wDm/frp80tFihAgq7VgLlt9z4e0j7iPX9xx3/n4U4
 YD4qYoUrPGynOmzlu8oOVuq9FRImAAe1VfGV8BxEvciJxzoFHsP1wfgrpNhBIDw3aC
 k9JEXJa8QxKLflEqicm3Ki8jSIgJfBWuEt5mC7EAK5qpNWa8iWxgZPF8OOHUCSulif
 74GoSz7oinfVTsqhZiuS4IhFfCQo9wouE+80j/Ab+oggzC8yVRKZCpOKiXf1mIteCM
 mTTtusb013PcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] accel/amdxdna: refuse an I/O memory mapping of
 an imported BO
To: "Taimuraz Kaitmazov" <taimuraz@kaitmazov.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260813164658.bXvSEIIEZ2X0aw3Le2xGmDuQSHzT4D-mWJkyiE086Rk@z>
References: <20260813164700.43960-1-taimuraz@kaitmazov.com>
 <20260813164658.bXvSEIIEZ2X0aw3Le2xGmDuQSHzT4D-mWJkyiE086Rk@z>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 07:21:44 +0000
Message-Id: <20260814072145.1E4871F000E9@smtp.kernel.org>
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
- [High] dma_buf_vmap() is called without holding the required dma_resv loc=
k.
--

--- Patch [1]: [PATCH v3 1/3] accel/amdxdna: refuse an I/O memory mapping o=
f an imported BO ---
commit a77f8bd3c9728d98291116a86706c7b30d341618
Author: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>

accel/amdxdna: refuse an I/O memory mapping of an imported BO

This patch modifies amdxdna_gem_obj_vmap() to refuse I/O memory mappings
from imported buffer objects. If an exporter returns an IOMEM mapping,
the mapping is rejected with -EOPNOTSUPP. This prevents invalid memory
accesses when later code assumes a regular kernel virtual address.

[ ... ]

> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/=
amdxdna_gem.c
> index b01f5d95fac83..d7d36c9523253 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -710,10 +710,16 @@ static int amdxdna_gem_obj_vmap(struct drm_gem_obje=
ct *obj, struct iosys_map *ma
> =20
>  	dma_resv_assert_held(obj->resv);
> =20
> -	if (is_import_bo(abo))
> +	if (is_import_bo(abo)) {
>  		ret =3D dma_buf_vmap(abo->dma_buf, map);

[Severity: High]
This is a pre-existing issue, but while looking at dma_buf_vmap() usage,
I noticed a missing lock in drivers/accel/amdxdna/amdxdna_cbuf.c.

Is dma_buf_vmap() being called without holding the required dma_resv lock
during carveout initialization?

When amdxdna_get_cbuf() exports a new dma_buf, it returns an unlocked buffe=
r.
It then immediately calls amdxdna_cbuf_clear(), which invokes dma_buf_vmap()
on the dbuf without taking its reservation lock:

drivers/accel/amdxdna/amdxdna_cbuf.c:amdxdna_cbuf_clear() {
	...
	struct iosys_map vmap =3D IOSYS_MAP_INIT_VADDR(NULL);

	dma_buf_vmap(dbuf, &vmap);
	if (!vmap.vaddr)
		return -EFAULT;
	...
}

Because dma_buf_vmap() unconditionally asserts that this lock is held
(dma_resv_assert_held(dmabuf->resv)), does this unlocked call violate the
dma-buf API contract and produce kernel warnings?

> -	else
> +		/* Callers use mem.kva as an ordinary kernel address. */
> +		if (!ret && map->is_iomem) {
> +			dma_buf_vunmap(abo->dma_buf, map);
> +			return -EOPNOTSUPP;
> +		}
> +	} else {
>  		ret =3D drm_gem_shmem_object_vmap(obj, map);
> +	}
>  	if (ret)
>  		return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813164700.4396=
0-1-taimuraz@kaitmazov.com?part=3D1
