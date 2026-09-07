Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B1BC79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 05:48:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A45710E45A;
	Mon,  7 Sep 2026 05:48:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hqEFYItL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F6E310E45A
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 05:48:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E6C0641B60;
 Mon,  7 Sep 2026 05:48:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5FE1F00A3A;
 Mon,  7 Sep 2026 05:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788760121;
 bh=tQ4B68Pd61JDl8lAFjTDq+dgzygEhY0Q57O/StFod7o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hqEFYItLgLDepZ4KRQjYfn0UzkqbL90mCapwkV6BSjEk3rhGy190hLM/n0+Wpq4yM
 iwSG1hsZv1vo4zQ/fnFqUm7hicQXowuahq0kgfuIlAeSQpgnOoP9MVlM7cVdLOgK5M
 gJzKM1xOmBpBfgnV1N7hTv4ubuP+bHYoUozT/5pyfMYlJlkIG4SzpJOd43KP45PLfC
 mDEi7GSJaK/Y3Kp32m5Mlnii7XX50uJ5QCYXbgdTteSUJr1p2EPzUC+/IpKMZR5Fjz
 o1mpJ3jAu8rpz/QZKzhv6QuUqULgRAhHzVwoCL3ZmeFcthUHpC6zUpMzHuPAXpj/12
 BTrlUs8UZvPFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/nouveau/uvmm: fix UAF in nouveau_uvmm_sm when BO is
 in TTM_PL_SYSTEM
To: "Peiyang He" <peiyang_he@smail.nju.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <0D77BEC410CE0129+20260907052204.1431488-1-peiyang_he@smail.nju.edu.cn>
References: <0D77BEC410CE0129+20260907052204.1431488-1-peiyang_he@smail.nju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 05:48:41 +0000
Message-Id: <20260907054841.AA5FE1F00A3A@smtp.kernel.org>
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
- [Critical] Out-of-bounds read in select_page_shift when casting an unvali=
dated system memory ttm_resource to a nouveau_mem.
--

commit 8ed661946ba828428c6f1b90d485fe67aede8ca7
Author: Peiyang He <peiyang_he@smail.nju.edu.cn>

drm/nouveau/uvmm: fix UAF in nouveau_uvmm_sm when BO is in TTM_PL_SYSTEM

This commit attempts to fix a KASAN slab-use-after-free issue when a BO is
left in TTM_PL_SYSTEM. It does so by rejecting BOs that cannot reside in
VRAM or GART and by resetting the BO's valid domains during
bind_lock_validate().

> diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nou=
veau/nouveau_uvmm.c
> index f5e4756b4de4a..8eb9afc17cfab 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
[ ... ]
> @@ -1246,8 +1250,13 @@ bind_lock_validate(struct nouveau_job *job, struct=
 drm_exec *exec,
>  			if (va_op->op =3D=3D DRM_GPUVA_OP_UNMAP)
>  				continue;
> =20
> -			ret =3D nouveau_bo_validate(nouveau_gem_object(obj),
> -						  true, false);
> +			nvbo =3D nouveau_gem_object(obj);
> +			if (!(nvbo->valid_domains &
> +			      (NOUVEAU_GEM_DOMAIN_VRAM | NOUVEAU_GEM_DOMAIN_GART)))
> +				return -EINVAL;
> +
> +			nouveau_bo_placement_set(nvbo, nvbo->valid_domains, 0);
> +			ret =3D nouveau_bo_validate(nvbo, true, false);

[Severity: Critical]
This is a pre-existing issue, but does this validation occur too late to
prevent the out-of-bounds read?

When a VM map operation is submitted, nouveau_uvmm_bind_job_submit() first
calls nouveau_uvmm_sm_map_prepare(), which internally calls
select_page_shift(). If the operation has a smaller alignment,
select_page_shift() falls back and accesses mem->mem.type:

drivers/gpu/drm/nouveau/nouveau_uvmm.c:select_page_shift() {
    ...
    struct nouveau_mem *mem =3D nouveau_mem(nvbo->bo.resource);
    ...
    if ((mem->mem.type & NVIF_MEM_VRAM) && !vmm->page[i].vram)
        continue;
    ...
}

Since select_page_shift() executes before bind_lock_validate() is called, if
the BO is currently in TTM_PL_SYSTEM, bo->resource is still just a small
struct ttm_resource. Casting it to struct nouveau_mem and reading
mem->mem.type results in a KASAN slab-use-after-free.

Could the validation and placement update be performed earlier to ensure the
BO is backed by a nouveau_mem before select_page_shift() accesses it?

>  			if (ret)
>  				return ret;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0D77BEC410CE0129+20=
260907052204.1431488-1-peiyang_he@smail.nju.edu.cn?part=3D1
