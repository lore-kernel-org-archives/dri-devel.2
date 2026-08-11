Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A54C5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 21:03:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E72BA10E37C;
	Tue, 11 Aug 2026 21:03:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A+2gaVvY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14CF010E37C
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 21:03:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0B2CB600AE;
 Tue, 11 Aug 2026 21:03:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A581F00A3A;
 Tue, 11 Aug 2026 21:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786482181;
 bh=GaD8PdfVKIWgqkosbNjq6eAwDvlIxEiMuhVCLrZvkk4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=A+2gaVvYDl8IO2tMN9hFJjRRzQZzzT05G5FlESgG1KRlssUBYNXGQ94ubr8ulUsFd
 wrDcNFJ71AAVPiISdr2VtvOrKPIxouvZlM4XTubudKXC81T5oz6VxBrfxA8evmhmUG
 u1UwBJt2OoHwhFFo6HnvjqpFY3PqzdlgZhaMQ6o3GpGdErt0JMG/7t56S7wSBNmfPi
 6vNIdMKMG25zEsqkd+PmLtCdZHrKlHugavkOucy1KwIO/7kmYt8P1inKxG2siz+Ltq
 QXBKQqI+1ddYmaQwWP7QFLvg+RA8Stf0L5zYbpCeduckI5mJDY643KgTczrFJ6s4ue
 qnJlG81issyzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] accel/amdxdna: flush only the requested range in
 amdxdna_flush_bo
To: "Taimuraz Kaitmazov" <taimuraz@kaitmazov.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260811204556.875037-4-taimuraz@kaitmazov.com>
References: <20260811204556.875037-1-taimuraz@kaitmazov.com>
 <20260811204556.875037-4-taimuraz@kaitmazov.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 21:03:01 +0000
Message-Id: <20260811210301.87A581F00A3A@smtp.kernel.org>
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

New issues:
- [High] Holding a vmap mapping for the lifetime of an imported DMA-buf vio=
lates the dma-buf API and permanently pins the buffer in the exporter.

Pre-existing issues:
- [High] Userspace can trigger a kernel page fault (DoS) by passing size=3D=
0 to the AMDXDNA_DRM_SYNC_BO ioctl.
- [High] CPU cache flushes on imported DMA-BUFs are performed without dma_b=
uf_begin_cpu_access() and dma_buf_end_cpu_access().
--

--- Patch [3]: [PATCH 3/3] accel/amdxdna: flush only the requested range in=
 amdxdna_flush_bo ---
commit b478fba210b28db0ebe941498872d630befd0f64
Author: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>

accel/amdxdna: flush only the requested range in amdxdna_flush_bo

This commit updates amdxdna_flush_bo() to only flush the requested range of=
 a
buffer object instead of the entire buffer. It tries the vmap path first for
imported BOs, falling back to other flush methods. This reduces the time
spent syncing large BOs.

> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/=
amdxdna_gem.c
> index d0c846b02694b..4886f7c082da1 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
[ ... ]
> @@ -1243,12 +1245,16 @@ static int amdxdna_flush_bo(struct amdxdna_gem_ob=
j *abo, u64 offset, u64 size)
>  		return -EINVAL;
> =20
>  	size =3D min(abo->mem.size, end) - offset;
> -	if (is_import_bo(abo))
> +	first =3D offset >> PAGE_SHIFT;
> +	nr_pages =3D (PAGE_ALIGN(offset + size) >> PAGE_SHIFT) - first;
> +
> +	kva =3D __amdxdna_gem_vmap(abo);

[Severity: High]
Does this code pin the imported buffer in the exporter indefinitely?

When __amdxdna_gem_vmap() is called on an imported BO in
drivers/accel/amdxdna/amdxdna_gem.c, it uses dma_buf_vmap() which establish=
es a
persistent mapping stored in abo->mem.kva.

According to the dma-buf API, mappings must not be held for the lifetime of=
 the
buffer because they prevent the exporter (like AMDGPU) from migrating the
buffer. By replacing the transient drm_clflush_sg() fallback with a persist=
ent
vmap, userspace can intentionally or unintentionally pin VRAM in the export=
er,
potentially leading to GPU memory exhaustion or eviction failures.

> +	if (!IS_ERR(kva))
> +		drm_clflush_virt_range(kva + offset, size);

[Severity: High]
This is a pre-existing issue, but can this cause a kernel page fault if
userspace passes size=3D0 to the AMDXDNA_DRM_SYNC_BO ioctl?

In amdxdna_drm_sync_bo_ioctl(), if args->size is 0, it gets passed to
amdxdna_flush_bo(). This calculates size =3D 0 and calls drm_clflush_virt_r=
ange()
with a length of 0.

In drm_clflush_virt_range() on x86, if length is 0, the for loop is skipped,
but it unconditionally executes:

    clflushopt(end - 1);

Since vmap allocations are often preceded by unmapped guard pages, accessing
kva - 1 can trigger an unhandled kernel page fault, potentially allowing a
local denial of service.

[Severity: High]
This isn't a bug introduced by this patch, but does this perform CPU cache
flushes on imported DMA-BUFs without invoking dma_buf_begin_cpu_access() and
dma_buf_end_cpu_access()?

The dma-buf API mandates that importers must bracket any CPU access to impo=
rted
buffers with these hooks. Bypassing the exporter's specific cache maintenan=
ce
requirements can potentially lead to cache coherency issues or data corrupt=
ion.

> +	else if (is_import_bo(abo))
>  		drm_clflush_sg(abo->base.sgt);
> -	else if (amdxdna_gem_vmap(abo))
> -		drm_clflush_virt_range(amdxdna_gem_vmap(abo) + offset, size);
>  	else if (abo->base.pages)
> -		drm_clflush_pages(abo->base.pages, abo->mem.size >> PAGE_SHIFT);
> +		drm_clflush_pages(&abo->base.pages[first], nr_pages);
>  	else
>  		return -EINVAL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811204556.8750=
37-1-taimuraz@kaitmazov.com?part=3D3
